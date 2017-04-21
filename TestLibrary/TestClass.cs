
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
namespace TestLibrary
{
  public class TestClass
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
      public void SetEventReceiver(IStandardCommunication communication, string fullFilename, UInt32 readSize)
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
    public object GeneratedClass;
    static private IStandardCommunication communication;
    static public string appPath;

    public void SetEventReceiver(UInt16 cmdId, UInt32 readSize, string filename)
    {
      FileStream stream = null;
      RealTimeHandler realtimeHandler = new RealTimeHandler(interpreter.GetCommandDefinition(cmdId), stream);
      realtimeHandler.SetEventReceiver(communication, filename, readSize); 
    }

    public bool Connect()
    {
      if (communication != null)
        return communication.Connect(0);
      else
        return false;
    }

    public void Disconnect()
    {
      communication?.Disconnect();
    }

    ~TestClass()
    {
      communication?.Disconnect();
    } //end of Destructor
    public TestClass(UInt16 id, string pidFilePath)
    {
      communication = new UsbCommunication(id);
      string pidFile = File.ReadAllText(pidFilePath);
      interpreter = new CommandInterpreter(pidFile);
      string code = CreateClasses(ref interpreter);
      appPath = new Uri(System.IO.Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetName().CodeBase)).LocalPath;
      string debugFile = appPath + @"\debugFile.cs";
      File.WriteAllText(debugFile, code);

      CSharpCodeProvider provider = new CSharpCodeProvider();
      CompilerParameters para = new CompilerParameters();

      para.ReferencedAssemblies.Add(appPath + @"\CommonTools.dll");
      para.ReferencedAssemblies.Add(appPath + @"\StandardCommunication.dll");
      para.ReferencedAssemblies.Add(appPath + @"\CommunicationTools.dll");
      para.ReferencedAssemblies.Add(appPath + @"\UsbCommunication.dll");

      para.OutputAssembly = appPath + @"\GeneratedClass0x" + id.ToString("X4") + ".dll";

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

      assembly = Assembly.LoadFrom(para.OutputAssembly);
      if (assembly != null)
      {
        Type t = assembly.GetType("TestLibrary.GeneratedClass");
        GeneratedClass = Activator.CreateInstance(t, communication);
        t.GetMethod("SetupEventReceivers").Invoke(GeneratedClass, new object[] { });
      }
    }

    private string CreateClasses(ref CommandInterpreter interpreter)
    {
      System.Text.StringBuilder generatedClass = new System.Text.StringBuilder();
      generatedClass.Append(@"using System;using IA.Common.StandardCommunication;
      using IA.Common.StandardCommunication.Tools;
      using IA.Common.UsbCommunication;
      using System.IO; ");
      generatedClass.Append("namespace TestLibrary{ public class GeneratedClass{");
      generatedClass.Append("IStandardCommunication communication;");
      generatedClass.Append("public GeneratedClass(){this.communication = null;}\r\n");
      generatedClass.Append("public GeneratedClass(IStandardCommunication communication){this.communication = communication;}\r\n");

      System.Text.StringBuilder generatedCode = new System.Text.StringBuilder();
      System.Text.StringBuilder setupEventReceivers = new System.Text.StringBuilder();

      setupEventReceivers.Append("public void SetupEventReceivers(){");

      int eventHandlerNameIndex = 0;
      eventHandlerNames = new string[interpreter.CommandList.Count];
      foreach (CommandDefinition cmdDef in interpreter.CommandList)
      {
        string cmdName = cmdDef.AutoFileNameHeader;
        cmdName = cmdName.Remove(0, 5);
        cmdName = formatCmd(cmdName);

        string className;
        string classDataName;
        if (cmdDef.EventType == EventType.NotEvent)
          className = cmdName;
        else
          className = "Event" + cmdName;

        classDataName = className + "Data";
        generatedCode.Append("\r\n/* -------------------- 0x" + cmdDef.CommandId.ToString("X4") + "-------------------- */\r\n");
        generatedCode.Append(CreateEnums(cmdDef));
        // DATA CLASS START
        System.Text.StringBuilder dataclass = new System.Text.StringBuilder();

        dataclass.Append("public class " + classDataName + "\r\n{\r\n");
        for (int i = 0; i < cmdDef.Parameters.Count; i++)
        {
          ParameterDefinition para = cmdDef.Parameters[i];
          string parameterName = formatParameter(para.Discription, "", "_p" + i.ToString());
          string enumName = cmdName + "_" + parameterName;
          dataclass.Append("public " + (para.IsEnum ? enumName : para.Type.ToString()) + " " + parameterName + ";\r\n");

        }
        for (int i = 0; i < cmdDef.ReplyParameters.Count; i++)
        {
          ParameterDefinition para = cmdDef.ReplyParameters[i];
          string parameterName = formatParameter(para.Discription, "r", "_p" + i.ToString());
          string enumName = cmdName + "_" + parameterName;
          dataclass.Append("public " + (para.IsEnum ? enumName : para.Type.ToString()) + " " + parameterName + ";\r\n");
        }

        if ((cmdDef.CommandId >= 0x4000) && (cmdDef.CommandId <= 0xBFFF))
        {
          dataclass.Append("public byte[] bulk;");
        }
        dataclass.Append("} ");

        generatedCode.Append(dataclass);
        // DATA CLASS END

        if (cmdDef.EventType != EventType.NotEvent)
        {
          // ARGS CLASS START
          string classNameArgs = className + "Args";
          generatedCode.Append("public class " + classNameArgs + " : EventArgs{");
          generatedCode.Append("private readonly " + classDataName + " _i;\r\n");
          generatedCode.Append("public " + classDataName + " Data{ get { return _i; } }\r\n");
          generatedCode.Append("public " + classNameArgs + " (" + classDataName + " t) { _i = t; }\r\n");
          generatedCode.Append("} ");
          // ARGS CLASS END

          generatedCode.Append("public event EventHandler<" + classNameArgs + "> " + className + ";\r\n");
          eventHandlerNames[eventHandlerNameIndex++] = className;

          // EVENT CALLBACKS START
          System.Text.StringBuilder eventCallback = new System.Text.StringBuilder();
          System.Text.StringBuilder code = new System.Text.StringBuilder();

          code.Append(classDataName + " d = new " + classDataName + "();\r\n");

          for (int i = 0; i < cmdDef.Parameters.Count; i++)
          {
            ParameterDefinition para = cmdDef.Parameters[i];
            string parameterName = formatParameter(para.ToString(), "", "_p" + i.ToString());
            string enumName = cmdName + "_" + parameterName;
            code.Append("d." + parameterName + " = " + (para.IsEnum ? "(" + enumName + ")" : "") + "parameters." + GetParameterReadString(para) + ";\r\n");
          }


          if ((cmdDef.CommandId >= 0x6000) && (cmdDef.CommandId <= 0x7FFF))
          {
            code.Append("d.bulk = new byte[bulkLength];\r\n");
          }
          else if ((cmdDef.CommandId >= 0xA000) && (cmdDef.CommandId <= 0xBFFF))
          {
            code.Append("d.bulk = new byte[bulkLength];\r\n");
            code.Append("bulk.Position = 0;\r\n");
            code.Append("bulk.Read(d.bulk, 0, bulkLength);\r\n");
          }

          code.Append("if(" + className + " != null)");
          code.Append("{");
          code.Append(className + ".Invoke(this, new " + classNameArgs + "(d));\r\n");
          code.Append("}");

          string onEvent = "OnEvent0x" + cmdDef.CommandId.ToString("X");
          eventCallback.Append("private void " + onEvent + "(UInt16 command, Parameters parameters, Stream bulk, int bulkLength)");
          eventCallback.Append("{");
          eventCallback.Append(code);
          eventCallback.Append("}");

          generatedCode.Append(eventCallback);
          // EVENT CALLBACKS END
          setupEventReceivers.Append("communication.SetEventReceiver(0x" + cmdDef.CommandId.ToString("X") + ", new NewEventDelegate(" + onEvent + "));\r\n");
        }
        else
        {
          // COMMAND WRAPPERS START
          StringBuilder inputParameters = new StringBuilder();
          StringBuilder wrapper = new StringBuilder();
          StringBuilder code = new StringBuilder();
          code.Append("Parameters p = new Parameters();\r\n");
          code.Append(classDataName + " d = new " + classDataName + "();\r\n");

          for (int i = 0; i < cmdDef.Parameters.Count; i++)
          {
            string parameterName = formatParameter(cmdDef.Parameters[i].ToString(), "", "_p" + i.ToString());
            string enumName = cmdName + "_" + parameterName;
            inputParameters.Append((cmdDef.Parameters[i].IsEnum ? enumName : cmdDef.Parameters[i].Type.ToString()) + " " + parameterName + ((i < (cmdDef.Parameters.Count - 1)) ? "," : ""));
            code.Append("p.Write(" + parameterName + ");" + "d." + parameterName + " = " + parameterName + ";\r\n");
          }


          if ((cmdDef.CommandId >= 0x4000) && (cmdDef.CommandId <= 0x5FFF))
          {
            code.Append("Stream bulk = new MemoryStream();\r\n");
            code.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p, bulk);\r\n");
            code.Append("d.bulk = new byte[bulk.Length];\r\n");
            code.Append("bulk.Position = 0;\r\n");
            code.Append("bulk.Read(d.bulk, 0, (int)bulk.Length);\r\n");
          }
          else if ((cmdDef.CommandId >= 0x8000) && (cmdDef.CommandId <= 0xBFFF))
          {
            inputParameters.Append((cmdDef.Parameters.Count > 0 ? "," : "") + "System.String bulkPath");
            code.Append("Stream bulk = null;\r\n");
            code.Append("if (bulkPath != null)");
            code.Append("{");
            code.Append("bulk = File.Open(bulkPath, FileMode.Open);\r\n");
            code.Append("}");
            code.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p, bulk, (int)bulk.Length);\r\n");
          }
          else
          {
            code.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p);\r\n");
          }


          for (int i = 0; i < cmdDef.ReplyParameters.Count; i++)
          {
            string parameterName = formatParameter(cmdDef.ReplyParameters[i].ToString(), "r", "_p" + i.ToString());

            string enumName = cmdName + "_" + parameterName;
            code.Append("d." + parameterName + " = " + (cmdDef.ReplyParameters[i].IsEnum ? "(" + enumName + ")" : "") + "p." + GetParameterReadString(cmdDef.ReplyParameters[i]) + ";\r\n");
          }

          code.Append("return d;");
          wrapper.Append("public " + classDataName + " " + className);
          wrapper.Append("(" + inputParameters + ")");
          wrapper.Append("{");
          wrapper.Append(code);
          wrapper.Append("}");
          generatedCode.Append(wrapper);

          // COMMAND WRAPPERS END
        }
      }

      setupEventReceivers.Append("} ");
      string rtn = generatedClass.ToString() + generatedCode.ToString() + setupEventReceivers.ToString() + "}}";
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
      //parameterString = parameterString.Replace(".", "_").Replace(" ", "").Replace("(", "").Replace(")", "").Replace("[", "").Replace("]", "").Replace(";", "").Replace("/", "_").Replace("\\", "_");
      if (parameterString == "")
        return prefix + "_" + suffix;
      if (Char.IsDigit(parameterString.ElementAt(0)))
        parameterString = "n" + parameterString;
      return prefix + parameterString + suffix;
    }
    private string formatEnum(string enumString)
    {
      enumString = enumString.Replace(" ", "");
      enumString = Regex.Replace(enumString, @"[^0-9a-zA-Z]+", "");
      //enumString = enumString.ToString().Replace(" ", "_").Replace("&", "and").Replace("-", "_").Replace("/", "_").Replace(".", "_").Replace("(", "").Replace(")", "");
      if (enumString == "")
        return "_";

      if (Char.IsDigit(enumString.ElementAt(0)))
        enumString = "n" + enumString;
      return enumString;
    }
    private string formatCmd(string cmd)
    {
      cmd = cmd.Replace(" ", "");
      cmd = Regex.Replace(cmd, @"[^0-9a-zA-Z]+", "_");
      //cmd = cmd.Replace(" ", "").Replace(".", "").Replace("(", "").Replace(")", "").Replace("[", "").Replace("]", "").Replace("/", "_").Replace("\\", "_");
      if (cmd == "")
        return "_";

      return cmd;
    }
    private string CreateEnum(string prefix, IList<ParameterDefinition> parameters)
    {
      System.Text.StringBuilder code = new System.Text.StringBuilder();
      for (int i = 0; i < parameters.Count; i++)
      {

        ParameterDefinition para = parameters[i];
        if (!para.IsEnum)
          continue;

        string parameterName = formatParameter(para.Discription, "", "_p" + i.ToString());

        code.Append("public enum " + prefix + parameterName + ":" + GetParameterType(para) + "{");

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

          string enumName = formatEnum(e.ToString()) + "_e" + j;


          code.Append(enumName + " = " + enumValue + ((j != para.Enums.Count - 1) ? ", " : ""));
        }
        code.Append("}\r\n");
      }
      return code.ToString();
    }
    private string CreateEnums(CommandDefinition cmdDef)
    {
      System.Text.StringBuilder code = new System.Text.StringBuilder();
      string cmdName = cmdDef.AutoFileNameHeader;
      cmdName = cmdName.Remove(0, 5);
      cmdName = formatCmd(cmdName);

      code.Append(CreateEnum(cmdName + "_", cmdDef.Parameters));
      code.Append(CreateEnum(cmdName + "_r", cmdDef.ReplyParameters));

      return code.ToString();
    }

  }
}