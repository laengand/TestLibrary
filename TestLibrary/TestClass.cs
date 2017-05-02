
using Microsoft.CSharp;
using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

using System.Text.RegularExpressions;
using IA.Common.StandardCommunication;
using IA.Common.StandardCommunication.Tools;
using IA.Common.UsbCommunication;
using System.Security.Policy;

namespace TestLibrary
{
  public class CommunicatorGenerator
  {
    public class RealTimeHandler
    {
      FileStream stream;
      CommandDefinition cmdDef;
      byte[] realtimeData;
      public RealTimeHandler(CommandDefinition cmdDef, FileStream stream)
      {
        this.cmdDef = cmdDef;
        this.stream = stream;
      }
      void Handler(ushort command, ref Parameters parameters, Stream data, int inBulkLength)
      {
        if (cmdDef.CommandType != CommandStatus.BulkReceived)
          return;
        int readBytes = stream.Read(realtimeData, 0, realtimeData.Length);
        if (readBytes < realtimeData.Length)
        {
          stream.Seek(0, SeekOrigin.Begin);
          stream.Read(realtimeData, readBytes, realtimeData.Length - readBytes);
        }
        data.Write(realtimeData, 0, realtimeData.Length);
      }
      public void SetRealTimeEventReceiver(IStandardCommunication communication, string fullFilename, UInt32 readSize)
      {
        communication.SetEventReceiver(cmdDef.CommandId, (NewRealtimeEventDelegate)Handler);
        stream = new FileStream(fullFilename, FileMode.Open, FileAccess.Read);
        if (readSize == 0)
          realtimeData = new byte[stream.Length];
        else
          realtimeData = new byte[readSize];
      }
    }

    public readonly CommandInterpreter interpreter;
    public Assembly assembly;
    public string[] eventHandlerNames;
    public object generatedCommunicator;
    static private IStandardCommunication communication;
    static public string appPath;
    private AppDomain appDom;
    
    public void SetRealTimeEventReceiver(UInt16 cmdId, string filename, UInt32 readSize)
    {
      FileStream stream = null;
      RealTimeHandler realtimeHandler = new RealTimeHandler(interpreter.GetCommandDefinition(cmdId), stream);
      realtimeHandler.SetRealTimeEventReceiver(communication, filename, readSize); 
    }

    ~CommunicatorGenerator()
    {
      
    } 
    public void Dispose()
    {
      //AppDomain.Unload(appDom);
    }

    public CommunicatorGenerator(UInt16 id, string pidFilePath)
    {
      communication = new UsbCommunication(id);
      string pidFile = File.ReadAllText(pidFilePath);
      interpreter = new CommandInterpreter(pidFile);
      
      CSharpCodeProvider provider = new CSharpCodeProvider();
      CompilerParameters para = new CompilerParameters();
      appPath = new Uri(System.IO.Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetName().CodeBase)).LocalPath;

      para.ReferencedAssemblies.Add(appPath + @"\CommonTools.dll");
      para.ReferencedAssemblies.Add(appPath + @"\StandardCommunication.dll");
      para.ReferencedAssemblies.Add(appPath + @"\CommunicationTools.dll");
      para.ReferencedAssemblies.Add(appPath + @"\UsbCommunication.dll");

      para.OutputAssembly = appPath + @"\GeneratedCommunicator0x" + id.ToString("X4") + ".dll";

      string code = CreateClasses(ref interpreter);
      string debugFile = appPath + @"\debugFile.cs";
      File.WriteAllText(debugFile, code);

      CompilerResults results = null;
      if (!File.Exists(para.OutputAssembly))
      {
        //results = provider.CompileAssemblyFromSource(para, code);
        results = provider.CompileAssemblyFromFile(para, debugFile);
        if (results.Errors.HasErrors || results.Errors.HasWarnings)
        {
          System.Text.StringBuilder errors = new System.Text.StringBuilder();
          System.Text.StringBuilder warnings = new System.Text.StringBuilder();
          foreach (CompilerError e in results.Errors)
          {
            if (e.IsWarning)
              warnings.Append(e.ErrorText + "\r\n");
            else
              errors.Append(e.ErrorText + "\r\n");
          }
          throw new System.InvalidOperationException("Errors during compilation: " + errors + "\r\nWarnings: " + warnings);
        }
      }
      
      if (false) // attempt to load generated dll in separate appdomain
      {
        AppDomainSetup domaininfo = new AppDomainSetup();
        domaininfo.ApplicationBase = System.Environment.CurrentDirectory;
        Evidence adevidence = AppDomain.CurrentDomain.Evidence;
        appDom = AppDomain.CreateDomain("CommDomain", adevidence, domaininfo);

        Type t = typeof(Proxy);
        Proxy p = (Proxy)appDom.CreateInstanceAndUnwrap(t.Assembly.Location, t.FullName);

        assembly = p.GetAssembly(para.OutputAssembly);
        t = assembly.GetType("TestLibrary.Communicator");
        generatedCommunicator = Activator.CreateInstance(t, id, pidFile);
        t.GetMethod("SetupEventReceivers").Invoke(generatedCommunicator, new object[] { });

      }
      else
      {
        assembly = Assembly.LoadFrom(para.OutputAssembly);
        if (assembly != null)
        {
          Type t = assembly.GetType("TestLibrary.Communicator");
          generatedCommunicator = Activator.CreateInstance(t, id, pidFile);
          t.GetMethod("SetupEventReceivers").Invoke(generatedCommunicator, new object[] { });
        }
      }
    }
    public class Proxy : MarshalByRefObject
    {
      public Assembly GetAssembly(string assemblyPath)
      {
        try
        {
          return Assembly.LoadFrom(assemblyPath);
        }
        catch (Exception ex)
        {
          throw new InvalidOperationException(ex.Message);
        }
      }
    }
    private string CreateClasses(ref CommandInterpreter interpreter)
    {
      System.Text.StringBuilder generatedClass = new System.Text.StringBuilder();
      generatedClass.Append(@"using System;
      using System.Collections.Generic;
      using IA.Common.StandardCommunication;
      using IA.Common.StandardCommunication.Tools;
      using IA.Common.UsbCommunication;
      using System.IO; ");
      generatedClass.Append("namespace TestLibrary{ ");
      generatedClass.Append("public class Communicator : MarshalByRefObject{");
      generatedClass.Append("IStandardCommunication communication;");
      
      System.Text.StringBuilder generatedCode = new System.Text.StringBuilder();
      System.Text.StringBuilder setupEventReceivers = new System.Text.StringBuilder();
      System.Text.StringBuilder dataclassDescription = new System.Text.StringBuilder();
      System.Text.StringBuilder cmdNames = new System.Text.StringBuilder();
      System.Text.StringBuilder classInstances = new System.Text.StringBuilder();
      System.Text.StringBuilder classDefinitions = new System.Text.StringBuilder();
      setupEventReceivers.Append("public void SetupEventReceivers(){");

      int eventHandlerNameIndex = 0;
      eventHandlerNames = new string[interpreter.CommandList.Count];
      foreach (CommandDefinition cmdDef in interpreter.CommandList)
      {
        string className;
        string classDataName;
        if (cmdDef.EventType == EventType.NotEvent)
          className = formatCmd(cmdDef);
        else
          className = formatEvent(cmdDef);

        string cmdName = className.Remove(0, 5);
        className = className.Substring(0, 5);

        string classInstanceName = cmdDef.EventType == EventType.NotEvent ? className + cmdName : className;
        
        classDefinitions.Append("public " + className + "." + className + " " + classInstanceName + ";\r\n");
        classInstances.Append(classInstanceName + " = new " + className + "." + className + "(communication); \r\n");

        cmdNames.Append(@"@""" + cmdName + @"""");
        cmdNames.Append(",\r\n");
        classDataName = "Data";
        generatedCode.Append("\r\n/* -------------------- 0x" + cmdDef.CommandId.ToString("X4") + "-------------------- */\r\n");

        System.Text.StringBuilder cmdNameSpace = new System.Text.StringBuilder();
        System.Text.StringBuilder cmdClass = new System.Text.StringBuilder();
        // DATA CLASS START
        System.Text.StringBuilder dataclass = new System.Text.StringBuilder();

        dataclass.Append("public class " + classDataName + "\r\n{\r\n");

        dataclassDescription.Append(@"@""");
        dataclassDescription.Append("Parameters\r\n");
        for (int i = 0; i < cmdDef.Parameters.Count; i++)
        {
          ParameterDefinition para = cmdDef.Parameters[i];
          string parameterName = formatParameter(para.Discription, "p" + i.ToString(), "");
          string enumName = "e" + parameterName;
          dataclass.Append("public " + (para.IsEnum ? enumName : para.Type.ToString()) + " " + parameterName + ";\r\n");
          dataclassDescription.Append(parameterName + "\r\n");
        }
        dataclassDescription.Append("Reply\r\n");
        for (int i = 0; i < cmdDef.ReplyParameters.Count; i++)
        {
          ParameterDefinition para = cmdDef.ReplyParameters[i];
          string parameterName = formatReplyParameter(para.Discription, "p" + i.ToString(), "");
          string enumName = "e" + parameterName;
          dataclass.Append("public " + (para.IsEnum ? enumName : para.Type.ToString()) + " " + parameterName + ";\r\n");
          dataclassDescription.Append(parameterName + "\r\n");
        }

        if (cmdDef.CommandType == CommandStatus.BulkSent || cmdDef.CommandType == CommandStatus.BulkReceived)
        {
          dataclass.Append("public byte[] bulk;");
        }
        dataclass.Append("} ");
        dataclassDescription.Append(@"""" + ",\r\n");
        cmdNameSpace.Append("namespace " + className + "\r\n{\r\n");
        
        cmdClass.Append(CreateEnums(cmdDef));
        cmdClass.Append("public class " + className + "\r\n{\r\n");
        cmdClass.Append("public " + className + "(){communication = null;}\r\n");
        cmdClass.Append("public " + className + "(IStandardCommunication comm){communication = comm;}\r\n");
        cmdClass.Append("private IStandardCommunication communication;\r\n");
        
        cmdNameSpace.Append(dataclass);

        //generatedCode.Append(cmdClass);
        // DATA CLASS END

        if (cmdDef.EventType != EventType.NotEvent)
        {
          System.Text.StringBuilder eventArgs = new System.Text.StringBuilder();
          // ARGS CLASS START

          string classNameArgs = "Args";
          eventArgs.Append("public class " + classNameArgs + " : EventArgs{");
          eventArgs.Append("private readonly " + classDataName + " _i;\r\n");
          eventArgs.Append("public " + classDataName + " Data{ get { return _i; } }\r\n");
          eventArgs.Append("public " + classNameArgs + " (" + classDataName + " t) { _i = t; }\r\n");
          eventArgs.Append("} ");
          // ARGS CLASS END

          // EVENT CALLBACKS START
          System.Text.StringBuilder eventCallback = new System.Text.StringBuilder();
          System.Text.StringBuilder code = new System.Text.StringBuilder();

          code.Append(classDataName + " d = new " + classDataName + "();\r\n");

          for (int i = 0; i < cmdDef.Parameters.Count; i++)
          {
            ParameterDefinition para = cmdDef.Parameters[i];
            string parameterName = formatParameter(para.ToString(), "p" + i.ToString() + "", "");
            string enumName = "e" + parameterName;
            code.Append("d." + parameterName + " = " + (para.IsEnum ? "(" + enumName + ")" : "") + "parameters." + GetParameterReadString(para) + ";\r\n");
          }

          //if ((cmdDef.CommandId >= 0x6000) && (cmdDef.CommandId <= 0x7FFF))
          if(cmdDef.CommandType == CommandStatus.BulkReceived)
          {
            code.Append("d.bulk = new byte[bulkLength];\r\n");
          }
          //else if ((cmdDef.CommandId >= 0xA000) && (cmdDef.CommandId <= 0xBFFF))
          else if (cmdDef.CommandType == CommandStatus.BulkSent)
          {
            code.Append("d.bulk = new byte[bulkLength];\r\n");
            code.Append("bulk.Position = 0;\r\n");
            code.Append("bulk.Read(d.bulk, 0, bulkLength);\r\n");
          }
          string eventHandlerName = "Handler";
          code.Append("if(" + eventHandlerName + " != null)");
          code.Append("{");
          code.Append(eventHandlerName + ".Invoke(this, new " + classNameArgs + "(d));\r\n");
          code.Append("}");

          string onEvent = "OnEvent";
          eventCallback.Append("public void " + onEvent + "(UInt16 command, Parameters parameters, Stream bulk, int bulkLength)");
          eventCallback.Append("{");
          eventCallback.Append(code);
          eventCallback.Append("}");

          cmdClass.Append("public event EventHandler<" + classNameArgs + "> " + eventHandlerName + ";\r\n");
          eventHandlerNames[eventHandlerNameIndex++] = className;
          cmdNameSpace.Append(eventArgs);


          cmdClass.Append(eventCallback);
          //cmdClass.Append("\r\n}\r\n");
          //generatedCode.Append(cmdClass);
          // EVENT CALLBACKS END
          setupEventReceivers.Append("communication.SetEventReceiver(0x" + cmdDef.CommandId.ToString("X4") + ", new NewEventDelegate(" + "this." + classInstanceName + "." + onEvent + "));\r\n");
        }
        else
        {
          // COMMAND WRAPPERS START
          StringBuilder inputParameters = new StringBuilder();
          StringBuilder rawInputParameters = new StringBuilder();
          StringBuilder passedInputParameters = new StringBuilder();
          StringBuilder cmdWrapper = new StringBuilder();
          StringBuilder rawWrapper = new StringBuilder();
          StringBuilder code = new StringBuilder();
          code.Append("Parameters p = new Parameters();\r\n");
          code.Append(classDataName + " d = new " + classDataName + "();\r\n");

          for (int i = 0; i < cmdDef.Parameters.Count; i++)
          {
            string parameterName = formatParameter(cmdDef.Parameters[i].ToString(), "p" + i.ToString() + "", "");
            string enumName = "e" + parameterName;
            inputParameters.Append((cmdDef.Parameters[i].IsEnum ? enumName : cmdDef.Parameters[i].Type.ToString()) + " " + parameterName + ((i < (cmdDef.Parameters.Count - 1)) ? "," : ""));
            rawInputParameters.Append(cmdDef.Parameters[i].Type.ToString() + " " + parameterName + ((i < (cmdDef.Parameters.Count - 1)) ? "," : ""));
            passedInputParameters.Append((cmdDef.Parameters[i].IsEnum ? "(" + enumName + ")" : "") + parameterName + ((i < (cmdDef.Parameters.Count - 1)) ? "," : ""));
            code.Append("p.Write(" + parameterName + ");" + "d." + parameterName + " = " + parameterName + ";\r\n");
          }
          
            //if ((cmdDef.CommandId >= 0x4000) && (cmdDef.CommandId <= 0x5FFF))
          if (cmdDef.CommandType == CommandStatus.BulkReceived)
          {
            code.Append("Stream bulk = new MemoryStream();\r\n");
            code.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p, bulk);\r\n");
            code.Append("d.bulk = new byte[bulk.Length];\r\n");
            code.Append("bulk.Position = 0;\r\n");
            code.Append("bulk.Read(d.bulk, 0, (int)bulk.Length);\r\n");
          }
          //else if ((cmdDef.CommandId >= 0x8000) && (cmdDef.CommandId <= 0xBFFF))
          else if (cmdDef.CommandType == CommandStatus.BulkSent)
          {
            inputParameters.Append((cmdDef.Parameters.Count > 0 ? "," : "") + "System.String bulkPath");
            rawInputParameters.Append((cmdDef.Parameters.Count > 0 ? "," : "") + "System.String bulkPath");
            passedInputParameters.Append((cmdDef.Parameters.Count > 0 ? "," : "") + "bulkPath");
            code.Append("Stream bulk = null;\r\n");
            code.Append("if (bulkPath != null)");
            code.Append("{");
            code.Append("bulk = File.Open(bulkPath, FileMode.Open);\r\n");
            code.Append("}");
            code.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p, bulk, (int)bulk.Length);\r\n");
            code.Append("if (bulk != null)");
            code.Append("{");
            code.Append("bulk.Close();\r\n");
            code.Append("}");
          }
          else
          {
            code.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p);\r\n");
          }


          for (int i = 0; i < cmdDef.ReplyParameters.Count; i++)
          {
            string parameterName = formatReplyParameter(cmdDef.ReplyParameters[i].ToString(), "p" + i.ToString(), "");

            string enumName = "e" + parameterName;
            code.Append("d." + parameterName + " = " + (cmdDef.ReplyParameters[i].IsEnum ? "(" + enumName + ")" : "") + "p." + GetParameterReadString(cmdDef.ReplyParameters[i]) + ";\r\n");
          }

          code.Append("return d;");
          cmdWrapper.Append("public " + classDataName + " Send");
          cmdWrapper.Append("(" + inputParameters + ")");
          cmdWrapper.Append("{");
          cmdWrapper.Append(code);
          cmdWrapper.Append("}");

          if (inputParameters.ToString() != "" && inputParameters.ToString() != rawInputParameters.ToString())
          {
            rawWrapper.Append("public " + classDataName + " Send");
            rawWrapper.Append("(" + rawInputParameters + ")");
            rawWrapper.Append("{");
            rawWrapper.Append("return Send (" + passedInputParameters + ");\r\n");
            rawWrapper.Append("}");
            cmdClass.Append(rawWrapper);
          }
          cmdClass.Append(cmdWrapper);
          
          // COMMAND WRAPPERS END
        }
        cmdClass.Append("\r\n}\r\n"); // class
        cmdNameSpace.Append(cmdClass);
        cmdNameSpace.Append("\r\n}\r\n");
        
        generatedCode.Append(cmdNameSpace);

      }

      setupEventReceivers.Append("} ");
      generatedClass.Append(classDefinitions);
      generatedClass.Append("public List<CommandDefinition> commandList;\r\n");
      generatedClass.Append("private CommandInterpreter interpreter;\r\n");
      generatedClass.Append("public Communicator(){communication = null; commandList = null;}\r\n");
      generatedClass.Append("public Communicator(UInt16 id, string pidFile){");
      generatedClass.Append(@"this.communication = new UsbCommunication(id);
      interpreter = new CommandInterpreter(pidFile);
      this.commandList = interpreter.CommandList;");
      
      generatedClass.Append(classInstances);
      generatedClass.Append("}\r\n");
      generatedClass.Append(@"public bool Connect()
      {
      if (communication != null)
        return communication.Connect(0);
      else
        return false;
      }");

      generatedClass.Append(@"public void Disconnect()
      {
        if (communication != null)
          communication.Disconnect();
      }");

      generatedClass.Append(@"
      private class RealTimeHandler
      {
        FileStream stream;
        CommandDefinition cmdDef;
        byte[] realtimeData;
        public RealTimeHandler(CommandDefinition cmdDef, FileStream stream)
        {
          this.cmdDef = cmdDef;
          this.stream = stream;
        }
        void Handler(ushort command, ref Parameters parameters, Stream data, int inBulkLength)
        {
          if (cmdDef.CommandType != CommandStatus.BulkReceived)
            return;
          int readBytes = stream.Read(realtimeData, 0, realtimeData.Length);
          if (readBytes < realtimeData.Length)
          {
            stream.Seek(0, SeekOrigin.Begin);
            stream.Read(realtimeData, readBytes, realtimeData.Length - readBytes);
          }
          data.Write(realtimeData, 0, realtimeData.Length);
        }
        public void SetRealTimeEventReceiver(IStandardCommunication communication, string fullFilename, UInt32 readSize)
        {
          communication.SetEventReceiver(cmdDef.CommandId, (NewRealtimeEventDelegate)Handler);
          stream = new FileStream(fullFilename, FileMode.Open, FileAccess.Read);
          if (readSize == 0)
            realtimeData = new byte[stream.Length];
          else
            realtimeData = new byte[readSize];
        }
      }"
      );
      generatedClass.Append(@"
      public void SetRealTimeEventReceiver(UInt16 cmdId, string filename, UInt32 readSize)
      {
        FileStream stream = null;
        RealTimeHandler realtimeHandler = new RealTimeHandler(interpreter.GetCommandDefinition(cmdId), stream);
        realtimeHandler.SetRealTimeEventReceiver(communication, filename, readSize); 
      }"
      );
      string cmdDes = "public string[] cmdDescriptions = new string[] {\r\n" + dataclassDescription + "\r\n};";
      string cmdN = "public string[] cmdNames = new string[] {\r\n" + cmdNames + "\r\n};";
      generatedClass.Append(setupEventReceivers.ToString());
      
      generatedClass.Append(cmdN + cmdDes);
      generatedClass.Append("}\r\n");
      generatedClass.Append("}\r\n");
      //generatedClass.Append("namespace TestLibrary{\r\n");
      generatedClass.Append(generatedCode.ToString());
      //generatedClass.Append("}\r\n");

      string rtn = generatedClass.ToString();
      return rtn;
    }
    private string GetParameterType(ParameterDefinition para)
    {
      string rtn = "";
      TypeCode t = Type.GetTypeCode(para.Type);
      switch (t)
      {
        case TypeCode.Byte:
          rtn = "byte";
          break;
        case TypeCode.Int16:
          rtn = "short";
          break;
        case TypeCode.Int32:
          rtn = "int";
          break;
        case TypeCode.Int64:
          rtn = "long";
          break;
        case TypeCode.SByte:
          rtn = "sbyte";
          break;
        case TypeCode.UInt16:
          rtn = "ushort";
          break;
        case TypeCode.UInt32:
          rtn = "uint";
          break;
        case TypeCode.UInt64:
          rtn = "ulong";
          break;
        case TypeCode.Single:
          rtn = "float";
          break;
      }
      return rtn;
    }
    private string GetParameterReadString(ParameterDefinition para)
    {
      string rtn = "";

      TypeCode t = Type.GetTypeCode(para.Type);
      switch (t)
      {
        case TypeCode.Byte:
          rtn = "ReadByte()";
          break;
        case TypeCode.Int16:
          rtn = "ReadInt16()";
          break;
        case TypeCode.Int32:
          rtn = "ReadInt32()";
          break;
        case TypeCode.Int64:
          rtn = "ReadInt64()";
          break;
        case TypeCode.SByte:
          rtn = "ReadSByte()";
          break;
        case TypeCode.UInt16:
          rtn = "ReadUInt16()";
          break;
        case TypeCode.UInt32:
          rtn = "ReadUInt32()";
          break;
        case TypeCode.UInt64:
          rtn = "ReadUInt64()";
          break;
        case TypeCode.Single:
          rtn = "ReadSingle()";
          break;
      }
      return rtn;
    }

    private string formatParameter(string parameterString, string prefix = "", string suffix = "")
    {
      parameterString = parameterString.Replace(" ", "");
      parameterString = Regex.Replace(parameterString, @"[^0-9a-zA-Z]+", "_");
      
      if (parameterString == "")
        return prefix + "_" + suffix;
      if (Char.IsDigit(parameterString.ElementAt(0)))
        parameterString = "n" + parameterString;
      return prefix + parameterString + suffix;
    }

    private string formatReplyParameter(string parameterString, string prefix = "", string suffix = "")
    {
      parameterString = parameterString.Replace(" ", "");
      parameterString = Regex.Replace(parameterString, @"[^0-9a-zA-Z]+", "_");

      if (parameterString == "")
        return prefix + "r_" + suffix;
      if (Char.IsDigit(parameterString.ElementAt(0)))
        parameterString = "n" + parameterString;
      return prefix + "r" + parameterString + suffix;
    }

    private string formatEnum(string enumString)
    {
      enumString = enumString.Replace(" ", "");
      enumString = Regex.Replace(enumString, @"[^0-9a-zA-Z]+", "");
      
      if (enumString == "")
        return "_";

      if (Char.IsDigit(enumString.ElementAt(0)))
        enumString = "n" + enumString;
      return enumString;
    }

    private string formatCmd(CommandDefinition cmdDef)
    { 
      return "C" + formatCmd(cmdDef.AutoFileNameHeader);
    }

    private string formatCmd(string cmd)
    {
      cmd = cmd.Replace(" ", "");
      cmd = Regex.Replace(cmd, @"[^0-9a-zA-Z]+", "_");
      
      if (cmd == "")
        return "_";

      return cmd;
    }
    private string formatEvent(CommandDefinition cmdDef)
    {
      return "E" + formatCmd(cmdDef.AutoFileNameHeader);
    }

    private string CreateEnum(IList<ParameterDefinition> parameters, string prefix, string suffix)
    {
      System.Text.StringBuilder code = new System.Text.StringBuilder();
      for (int i = 0; i < parameters.Count; i++)
      {

        ParameterDefinition para = parameters[i];
        if (!para.IsEnum)
          continue;

        string parameterName = formatParameter(para.Discription, prefix + "p" + i.ToString() + suffix, ""); // the names prefix and suffix does not make much sense when both are used as prefix together with the paramters number

        code.Append("public enum " + "e" + parameterName + ":" + GetParameterType(para) + "{");

        for (int j = 0; j < para.Enums.Count; j++)
        {
          EnumValue e = para.Enums[j];
          TypeCode t = Type.GetTypeCode(para.Type);
          string enumValue;
          Int64 temp = (Int64)e.Value;
          switch (t)
          {
            case TypeCode.SByte:
              enumValue = ((sbyte)temp).ToString();
              break;
            case TypeCode.Int16:
              enumValue = ((short)temp).ToString();
              break;

            case TypeCode.Int32:
              enumValue = ((int)temp).ToString();
              break;

            default:
              enumValue = e.Value.ToString();
              break;
          }

          string enumValueName = "e" + j + "" + formatEnum(e.ToString());


          code.Append(enumValueName + " = " + enumValue + ((j != para.Enums.Count - 1) ? ", " : ""));
        }
        code.Append("}\r\n");
      }
      return code.ToString();
    }
    private string CreateEnums(CommandDefinition cmdDef)
    {
      System.Text.StringBuilder code = new System.Text.StringBuilder();

      string name;

      if (cmdDef.EventType == EventType.NotEvent)
        name = formatCmd(cmdDef);
      else
        name = formatEvent(cmdDef);

      code.Append(CreateEnum(cmdDef.Parameters, "",""));
      code.Append(CreateEnum(cmdDef.ReplyParameters, "", "r"));

      return code.ToString();
    }

  }
}