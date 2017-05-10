
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
   
    public readonly CommandInterpreter interpreter;
    public Assembly assembly;
    public string[] eventHandlerNames;
    public object generatedCommunicator;
    static private IStandardCommunication communication;
    static public string appPath;
    private AppDomain appDom;
   
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

      var providerOptions = new Dictionary<string, string>();
      providerOptions.Add("CompilerVersion", "v4.0");

      CSharpCodeProvider provider = new CSharpCodeProvider(providerOptions);
      CompilerParameters para = new CompilerParameters();
      appPath = new Uri(System.IO.Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetName().CodeBase)).LocalPath;

      
      para.ReferencedAssemblies.Add(@"C:\Windows\Microsoft.NET\Framework\v4.0.30319\System.Core.dll");
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
          if (false)
          {
            Type p0_t = assembly.GetType("C0012.ep0Output");
            Type p1_t = assembly.GetType("C0012.ep1Status");
            t.GetMethod("Connect").Invoke(generatedCommunicator, new object[] { });

            Type t2 = assembly.GetType("C0012.C0012");
            object C0012SetGPIOOutput = Activator.CreateInstance(t2, communication);

            object p0 = p0_t.GetEnumValues().GetValue(4);
            object p1 = p1_t.GetEnumValues().GetValue(1);

            //t.GetMethod("C0012SetGPIOOutput.Send").Invoke(generatedCommunicator, new object[] { p0.GetEnumValues().GetValue(4), p1.GetEnumValues().GetValue(1) });
            t2.GetMethod("Send").Invoke(C0012SetGPIOOutput, new object[] { p0, p1 });
            short p0s = 4;
            short p1s = 1;
            //t2.GetMethod("Send").Invoke(C0012SetGPIOOutput, new object[] { p0s, p1s });
            //t2.GetMethod("Send").Invoke(C0012SetGPIOOutput, new object[] { 4, 1 });
            //t.GetMethod("C0012SetGPIOOutput.Send").Invoke(generatedCommunicator, new object[] { 4, 1 });
          }
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
      using System.IO;
      using System.Linq;
      ");
      generatedClass.Append("namespace TestLibrary{ ");
      generatedClass.Append("public class Communicator : MarshalByRefObject{");
      generatedClass.Append("IStandardCommunication communication;");

      System.Text.StringBuilder generatedCode = new System.Text.StringBuilder();
      System.Text.StringBuilder setupEventReceivers = new System.Text.StringBuilder();
      System.Text.StringBuilder dataclassDescription = new System.Text.StringBuilder();
      System.Text.StringBuilder cmdNames = new System.Text.StringBuilder();
      System.Text.StringBuilder classInstances = new System.Text.StringBuilder();
      System.Text.StringBuilder classDefinitions = new System.Text.StringBuilder();
      System.Text.StringBuilder bulkNameSpace = new System.Text.StringBuilder();
      System.Text.StringBuilder bulkClass= new System.Text.StringBuilder();

      
      bulkNameSpace.Append("namespace Bulk{");
      bulkClass.Append("public class Bulk");
      bulkClass.Append("{\r\n");
      bulkClass.Append("private Stream bulkStream;\r\n");
      bulkClass.Append("private byte[] bulk;\r\n");

      bulkClass.Append("public Bulk()");
      bulkClass.Append("{\r\n");
      bulkClass.Append("this.bulk = null;\r\n");
      bulkClass.Append("this.bulkStream = null;\r\n");
      bulkClass.Append("\r\n}\r\n");

      bulkClass.Append("public Bulk(Stream bulkStream)");
      bulkClass.Append("{\r\n");
      bulkClass.Append("this.FromStream(bulkStream);\r\n");
      bulkClass.Append("\r\n}\r\n");



      bulkClass.Append("public void FromStream(Stream bulkStream)");
      bulkClass.Append("{\r\n");
      bulkClass.Append("if(bulkStream == null)");
      bulkClass.Append(@"throw new System.InvalidOperationException(@""" + "Stream = null is not allowed" +  @""");");
      bulkClass.Append("this.bulk = new byte[bulkStream.Length];");
      bulkClass.Append("this.bulkStream = bulkStream;");
      bulkClass.Append("this.bulkStream.Position = 0;\r\n");
      bulkClass.Append("this.bulkStream.Read(this.bulk, 0, this.GetStreamLength());");
      bulkClass.Append("\r\n}\r\n");

      string[] bulkParameterTypes = { "byte", "sbyte", "ushort", "short", "uint", "int", "ulong", "long", "float", "double" };
      string[] bulkParameterTypeNames = { "UInt8", "Int8", "UInt16", "Int16", "UInt32", "Int32", "UInt64", "Int64", "Single", "Double" };


      bulkClass.Append("private byte[] GetBytes(byte[] values)");
      bulkClass.Append("{");
      bulkClass.Append("return values;");
      bulkClass.Append("}\r\n");

      bulkClass.Append("private byte[] GetBytes(sbyte[] values)");
      bulkClass.Append("{");
      bulkClass.Append("return this.bulk.Select(value => (byte)value).ToArray();");
      bulkClass.Append("}\r\n");

      for (int i = 2; i < bulkParameterTypes.Length; i++)
      {
        bulkClass.Append("private byte[] GetBytes(" + bulkParameterTypes[i] + "[] values)");
        bulkClass.Append("{");
        bulkClass.Append("return values.SelectMany(value => BitConverter.GetBytes(value)).ToArray();");
        bulkClass.Append("}\r\n");
      }

      //  foreach (string s in bulkParameterTypes)
      //{
      //  bulkClass.Append("private byte[] GetBytes("+ s +"[] values)");
      //  bulkClass.Append("{");
      //  bulkClass.Append("return values.SelectMany(value => BitConverter.GetBytes(value)).ToArray();");
      //  bulkClass.Append("}\r\n");
      //}

      bulkClass.Append("public byte[] ToUInt8()");
      bulkClass.Append("{");
      bulkClass.Append("return this.bulk;");
      bulkClass.Append("}\r\n");

      bulkClass.Append("public sbyte[] ToInt8()");
      bulkClass.Append("{");
      bulkClass.Append("return this.bulk.Select(value => (sbyte)value).ToArray();");
      bulkClass.Append("}\r\n");

      for (int i = 2; i < bulkParameterTypes.Length; i++)
      {
        string type = bulkParameterTypes[i];
        string name = bulkParameterTypeNames[i];
        bulkClass.Append("public " + type + "[] To" + name+ "()");
        bulkClass.Append("{");
        bulkClass.Append("int convertedIdx = 0;\r\n");
        bulkClass.Append(bulkParameterTypes[i] + "[] convertedBulk = new " + bulkParameterTypes[i] + "[this.bulk.Length/sizeof(" + bulkParameterTypes[i] + ")];\r\n");
        bulkClass.Append("for (int n = 0; n < this.bulk.Length; n += sizeof(" + bulkParameterTypes[i] + "))");
        bulkClass.Append("{");
        bulkClass.Append("convertedBulk[convertedIdx++] = BitConverter.To" + bulkParameterTypeNames[i]+ "(this.bulk, n);");
        bulkClass.Append("}\r\n");
        bulkClass.Append("return convertedBulk;");
        bulkClass.Append("}\r\n");
      }
      
      bulkClass.Append("public Bulk(string path)");
      bulkClass.Append("{\r\n");
      bulkClass.Append("this.FromFile(path);");
      bulkClass.Append("\r\n}\r\n");

      foreach(string s in bulkParameterTypes)
      {
        bulkClass.Append("public Bulk(" + s + "[] bulk)");
        bulkClass.Append("{");
        bulkClass.Append("this.bulk = GetBytes(bulk);");
        bulkClass.Append("}\r\n");
      }
      

      bulkClass.Append("public Stream GetStream()");
      bulkClass.Append("{\r\n");
      bulkClass.Append("if(this.bulkStream == null)");
      bulkClass.Append("{\r\n");
      bulkClass.Append("if(this.bulk == null)");
      bulkClass.Append("{\r\n");
      bulkClass.Append("this.bulkStream = new MemoryStream();\r\n");
      bulkClass.Append("}\r\n");
      bulkClass.Append("else");
      bulkClass.Append("{\r\n");
      bulkClass.Append("this.bulkStream = new MemoryStream(this.bulk);\r\n");
      bulkClass.Append("}\r\n");
      bulkClass.Append("}\r\n");
      bulkClass.Append("return this.bulkStream;");
      bulkClass.Append("\r\n}\r\n");

      bulkClass.Append("public int GetStreamLength()");
      bulkClass.Append("{\r\n");
      bulkClass.Append("return this.bulkStream != null ? (int)this.bulkStream.Length:0;");
      bulkClass.Append("\r\n}\r\n");

      bulkClass.Append("public void Close()");
      bulkClass.Append("{\r\n");
      bulkClass.Append("if(this.bulkStream != null)");
      bulkClass.Append("{");
      bulkClass.Append("this.bulkStream.Dispose();");
      bulkClass.Append("this.bulkStream = null;");
      bulkClass.Append("}");
      bulkClass.Append("\r\n}\r\n");
      
      bulkClass.Append("public void ToFile(string path)");
      bulkClass.Append("{\r\n");
      bulkClass.Append("if(this.bulk != null)");
      bulkClass.Append("{");
      bulkClass.Append("this.bulkStream = File.OpenWrite(path);\r\n");
      bulkClass.Append("this.bulkStream.Write(this.bulk, 0, this.bulk.Length);\r\n");
      bulkClass.Append("this.Close();");
      bulkClass.Append("}");
      bulkClass.Append("\r\n}\r\n");

      bulkClass.Append("public void FromFile(string path)");
      bulkClass.Append("{\r\n");
      bulkClass.Append("this.bulkStream = File.Open(path, FileMode.Open);");
      bulkClass.Append("this.bulk = new byte[this.bulkStream.Length];");
      bulkClass.Append("this.bulkStream.Read(this.bulk, 0, this.GetStreamLength());");
      bulkClass.Append("this.Close();");
      bulkClass.Append("}");

      bulkClass.Append("\r\n}\r\n");
      bulkNameSpace.Append(bulkClass);
      bulkNameSpace.Append("}");
      generatedCode.Append(bulkNameSpace);

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
        classInstances.Append(classInstanceName + " = new " + className + "." + className + "(ref communication); \r\n");

        cmdNames.Append(@"@""" + cmdName + @"""");
        cmdNames.Append(",\r\n");
        classDataName = "Data";
        generatedCode.Append("\r\n/* -------------------- 0x" + cmdDef.CommandId.ToString("X4") + "-------------------- */\r\n");

        System.Text.StringBuilder cmdNameSpace = new System.Text.StringBuilder();
        System.Text.StringBuilder enumNameSpace = new System.Text.StringBuilder();
        System.Text.StringBuilder cmdClass = new System.Text.StringBuilder();
        // DATA CLASS START
        System.Text.StringBuilder dataclass = new System.Text.StringBuilder();

        dataclass.Append("public class " + classDataName + "\r\n{\r\n");

        dataclassDescription.Append(@"@""");
        dataclassDescription.Append("Parameters\r\n");

        // DATA SETTERS AND GETTERS START
        for (int i = 0; i < cmdDef.Parameters.Count; i++)
        {
          ParameterDefinition para = cmdDef.Parameters[i];
          string parameterName = formatParameter(para.Discription, "p" + i.ToString(), "");
                
          dataclass.Append(CreateDataSettersAndGetters(para, parameterName));
          dataclassDescription.Append(parameterName + "\r\n");
        }
        dataclassDescription.Append("Reply\r\n");
        for (int i = 0; i < cmdDef.ReplyParameters.Count; i++)
        {
          ParameterDefinition para = cmdDef.ReplyParameters[i];
          string parameterName = formatReplyParameter(para.Discription, "p" + i.ToString(), "");
          
          dataclass.Append(CreateDataSettersAndGetters(para, parameterName));
          dataclassDescription.Append(parameterName + "\r\n");
        }
        // DATA SETTERS AND GETTERS END

        if (cmdDef.CommandType == CommandStatus.BulkSent || cmdDef.CommandType == CommandStatus.BulkReceived)
        {
          dataclass.Append("public Bulk.Bulk bulk;\r\n");
        }
        dataclass.Append("} ");
        dataclassDescription.Append(@"""" + ",\r\n");
        enumNameSpace.Append("namespace " + className + "\r\n{\r\n namespace InternalEnums{");
        cmdNameSpace.Append("namespace " + className + "\r\n{\r\n");

        enumNameSpace.Append(CreateEnums(cmdDef, false));
        enumNameSpace.Append("}}");

        cmdClass.Append(CreateEnums(cmdDef,true));
        cmdClass.Append("public class " + className + "\r\n{\r\n");
        cmdClass.Append("public " + className + "(){communication = null;}\r\n");
        cmdClass.Append("public " + className + "(ref IStandardCommunication comm){communication = comm;}\r\n");
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
            string enumName = "InternalEnums.e" + parameterName;
            bool isEnum = cmdDef.Parameters[i].IsEnum;

            code.Append("d." + parameterName + "(" + (isEnum ? "(" + enumName + ")" : "") + "parameters." + GetParameterReadString(para) + ");\r\n");
            if (isEnum)
            {
              cmdClass.Append("public " + "e" + parameterName + " " + "e" + parameterName + ";\r\n");
              //  code.Append(enumName + " e" + i + " = new " + enumName + "();\r\n");
            }
          }

          //if ((cmdDef.CommandId >= 0x6000) && (cmdDef.CommandId <= 0x7FFF))
          if (cmdDef.CommandType == CommandStatus.BulkReceived)
          {
            code.Append("d.bulk = new Bulk.Bulk();\r\n");
          }
          //else if ((cmdDef.CommandId >= 0xA000) && (cmdDef.CommandId <= 0xBFFF))
          else if (cmdDef.CommandType == CommandStatus.BulkSent)
          {
            code.Append("d.bulk = new Bulk.Bulk(bulk);\r\n");
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

          // EVENT CALLBACKS END
          setupEventReceivers.Append("communication.SetEventReceiver(0x" + cmdDef.CommandId.ToString("X4") + ", new NewEventDelegate(" + "this." + classInstanceName + "." + onEvent + "));\r\n");
        }
        else
        {
          // COMMAND WRAPPERS START
          StringBuilder inputDataParameters = new StringBuilder();
          //StringBuilder[]inputParameterList = new StringBuilder();
          //StringBuilder rawInputParameters = new StringBuilder();
          StringBuilder passedInputParameters = new StringBuilder();

          StringBuilder inputParaFile = new StringBuilder();
          StringBuilder inputParaArray = new StringBuilder();

          StringBuilder sendDataWrapper = new StringBuilder();
          StringBuilder sendParaArrayWrapper = new StringBuilder();
          StringBuilder sendParaFileWrapper = new StringBuilder();

          

          StringBuilder cmdWrapper = new StringBuilder();
          StringBuilder rawWrapper = new StringBuilder();
          StringBuilder codeData = new StringBuilder();

          StringBuilder codeParaArray = new StringBuilder();
          StringBuilder codeParaFile = new StringBuilder();

          codeData.Append("Parameters p = new Parameters();\r\n");

          codeParaFile.Append(classDataName + " d = new " + classDataName + "();\r\n");
          codeParaArray.Append(classDataName + " d = new " + classDataName + "();\r\n");

          inputDataParameters.Append("Data d");

          passedInputParameters.Append("d");
          for (int i = 0; i < cmdDef.Parameters.Count; i++)
          {
            string parameterName = formatParameter(cmdDef.Parameters[i].ToString(), "p" + i.ToString() + "", "");
            string enumName = "InternalEnums.e" + parameterName;

            string type = cmdDef.Parameters[i].Type.ToString();
            bool isEnum = cmdDef.Parameters[i].IsEnum;
            string input = cmdDef.Parameters[i].Type.ToString() + " " + parameterName + ((i < (cmdDef.Parameters.Count - 1)) ? "," : "");

            inputParaFile.Append(input);
            inputParaArray.Append(input);

            codeData.Append("p.Write(d." + parameterName + "());\r\n");
            codeParaFile.Append("d." + parameterName + "(" + parameterName + ");\r\n");
            codeParaArray.Append("d." + parameterName + "(" + parameterName + ");\r\n");

            if (isEnum)
            {
              cmdClass.Append("public " + "e" + parameterName + " " + "e" + parameterName + ";\r\n");
            }
          }

          //if ((cmdDef.CommandId >= 0x4000) && (cmdDef.CommandId <= 0x5FFF))
          if (cmdDef.CommandType == CommandStatus.BulkReceived)
          {
            codeData.Append("if(d.bulk == null)");
            codeData.Append("{");
            codeData.Append("d.bulk = new Bulk.Bulk();");
            codeData.Append("}");
            codeData.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p, d.bulk.GetStream());\r\n");
            codeData.Append("d.bulk.FromStream(d.bulk.GetStream());\r\n");
          }
          //else if ((cmdDef.CommandId >= 0x8000) && (cmdDef.CommandId <= 0xBFFF))
          else if (cmdDef.CommandType == CommandStatus.BulkSent)
          {
            //passedInputParameters.Append((cmdDef.Parameters.Count > 0 ? "," : "") + "bulkPath");
            codeData.Append("if(d.bulk == null)");
            codeData.Append("{");
            codeData.Append(@"throw new System.InvalidOperationException(@""" + "bulk = null is not allowed when sending bulk data" + @""");");
            codeData.Append("}");
            codeData.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p, d.bulk.GetStream(), (int)d.bulk.GetStreamLength());\r\n");
          }
          else
          {
            codeData.Append("communication.SendCommand((UInt16)" + "0x" + cmdDef.CommandId.ToString("X4") + ", ref p);\r\n");
          }


          for (int i = 0; i < cmdDef.ReplyParameters.Count; i++)
          {
            string parameterName = formatReplyParameter(cmdDef.ReplyParameters[i].ToString(), "p" + i.ToString(), "");

            string enumName = "InternalEnums.e" + parameterName;
            bool isEnum = cmdDef.ReplyParameters[i].IsEnum;
            codeData.Append("d." + parameterName + "(" + (isEnum ? "(" + enumName + ")" : "") + "p." + GetParameterReadString(cmdDef.ReplyParameters[i]) + ");\r\n");

            if (isEnum)
            {
              cmdClass.Append("public " + "e" + parameterName + " " + "e" + parameterName + ";\r\n");
            }
          }

          codeData.Append("return d;");

          sendDataWrapper.Append("public " + classDataName + " Send");
          sendDataWrapper.Append("(" + inputDataParameters + ")");
          sendDataWrapper.Append("{");
          sendDataWrapper.Append(codeData);
          sendDataWrapper.Append("}");


          if (cmdDef.CommandType == CommandStatus.BulkSent || cmdDef.CommandType == CommandStatus.BulkReceived)
          {
            codeParaFile.Append("d.bulk = new Bulk.Bulk();\r\n");
            if (cmdDef.CommandType == CommandStatus.BulkSent)
            {
              codeParaFile.Append("d.bulk.FromFile(bulkPath);\r\n");
              codeParaFile.Append("return Send(" + passedInputParameters + ");");

              codeParaArray.Append("d.bulk = new Bulk.Bulk(bulk);\r\n");
              codeParaArray.Append("return Send(" + passedInputParameters + ");");
              foreach (string s in bulkParameterTypes)
              {
                sendParaArrayWrapper.Append("public " + classDataName + " Send");
                sendParaArrayWrapper.Append("(" + inputParaArray + (inputParaArray.Length > 0 ? ", " : "") + s + "[] bulk" + ")");
                sendParaArrayWrapper.Append("{");
                sendParaArrayWrapper.Append(codeParaArray);
                sendParaArrayWrapper.Append("}");
              }
            }
            else
            {
              codeParaFile.Append("Send(" + passedInputParameters + ");");
              codeParaFile.Append("d.bulk.ToFile(bulkPath);");
              codeParaFile.Append("return d;");

              codeParaArray.Append("d.bulk = new Bulk.Bulk();\r\n");
              codeParaArray.Append("return Send(" + passedInputParameters + ");");
              sendParaArrayWrapper.Append("public " + classDataName + " Send");
              sendParaArrayWrapper.Append("(" + inputParaArray + ")");
              sendParaArrayWrapper.Append("{");
              sendParaArrayWrapper.Append(codeParaArray);
              sendParaArrayWrapper.Append("}");
            }
            
            
          
            // Bulk from/to file
            sendParaFileWrapper.Append("public " + classDataName + " Send");
            sendParaFileWrapper.Append("(" + inputParaFile + (inputParaFile.Length > 0 ? ", " : "") + "System.String bulkPath" + ")");
            sendParaFileWrapper.Append("{");
            sendParaFileWrapper.Append(codeParaFile);
            sendParaFileWrapper.Append("}");

          }
          else
          {
            codeParaArray.Append("return Send(" + passedInputParameters + ");");
            sendParaArrayWrapper.Append("public " + classDataName + " Send");
            sendParaArrayWrapper.Append("(" + inputParaArray + ")");
            sendParaArrayWrapper.Append("{");
            sendParaArrayWrapper.Append(codeParaArray);
            sendParaArrayWrapper.Append("}");
          }
          /*
          if (inputParameters.ToString() != "" && inputParameters.ToString() != rawInputParameters.ToString())
          {
            rawWrapper.Append("public " + classDataName + " Send");
            rawWrapper.Append("(" + rawInputParameters + ")");
            rawWrapper.Append("{");
            rawWrapper.Append("return Send (" + passedInputParameters + ");\r\n");
            rawWrapper.Append("}");
            cmdClass.Append(rawWrapper);
          }
          */
          cmdClass.Append(sendDataWrapper.ToString() + sendParaFileWrapper.ToString() + sendParaArrayWrapper.ToString());
          
          // COMMAND WRAPPERS END
        }
        cmdClass.Append("\r\n}\r\n"); // class
        cmdNameSpace.Append(cmdClass);
        cmdNameSpace.Append("\r\n}\r\n");

        generatedCode.Append(enumNameSpace);
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

    private string CreateEnum(IList<ParameterDefinition> parameters, string prefix, string suffix, bool structOut)
    {
      
      System.Text.StringBuilder structCode = new System.Text.StringBuilder();
      System.Text.StringBuilder enumDeclarations = new System.Text.StringBuilder();
      
      for (int i = 0; i < parameters.Count; i++)
      {
        System.Text.StringBuilder structEnumGetters = new System.Text.StringBuilder();
        System.Text.StringBuilder structEnumDeclarations = new System.Text.StringBuilder();
        ParameterDefinition para = parameters[i];
        if (!para.IsEnum)
          continue;

        string parameterName = formatParameter(para.Discription, prefix + "p" + i.ToString() + suffix, ""); // the names prefix and suffix does not make much sense when both are used as prefix together with the paramters number
        string enumName = "e" + parameterName;
        enumDeclarations.Append("public enum " + enumName + ":" + GetParameterType(para) + "{");
        structCode.Append("public class " + "e" + parameterName/*+ ":" + GetParameterType(para)*/ + "{");
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
          
          structEnumGetters.Append("public static " + para.Type + " " + enumValueName + "(){ return(" + para.Type + ") InternalEnums." + enumName + "." + enumValueName + ";}\r\n");
          //structEnumDeclarations.Append(enumValueName + " = (" + para.Type + ") " + enumName + "." + enumValueName + ";");
          enumDeclarations.Append(enumValueName + " = " + enumValue + ((j != para.Enums.Count - 1) ? ", " : ""));
        }
        enumDeclarations.Append("}\r\n");

        structCode.Append(structEnumGetters);
        //structCode.Append(enumName + "(){");
        //structCode.Append(structEnumDeclarations.ToString());
        //structCode.Append("}\r\n");
        structCode.Append("}\r\n");
      }
      
      
      return structOut ? structCode.ToString() : enumDeclarations.ToString();
    }
    private string CreateEnums(CommandDefinition cmdDef, bool structOut)
    {
      System.Text.StringBuilder code = new System.Text.StringBuilder();

      string name;

      if (cmdDef.EventType == EventType.NotEvent)
        name = formatCmd(cmdDef);
      else
        name = formatEvent(cmdDef);

      code.Append(CreateEnum(cmdDef.Parameters, "", "", structOut));
      code.Append(CreateEnum(cmdDef.ReplyParameters, "", "r", structOut));

      return code.ToString();
    }
    string CreateDataSettersAndGetters(ParameterDefinition para, string parameterName)
    {
      System.Text.StringBuilder code = new System.Text.StringBuilder();
      
      string enumName = "InternalEnums.e" + parameterName;
      bool isEnum = para.IsEnum;

      code.Append("public " + para.Type.ToString() + " " + "internal" + parameterName + ";\r\n");
      code.Append("public " + (isEnum ? enumName : para.Type.ToString()) + " " + parameterName + "()");
      code.Append("{");
      code.Append("return " + (isEnum ? "(" + enumName + ")" : "") + "internal" + parameterName +  ";");
      code.Append("}\r\n");

      code.Append("public void " + parameterName + "(" + para.Type.ToString() + " " + parameterName + ")");
      code.Append("{");
      code.Append("internal" + parameterName + " = " + parameterName + ";");
      code.Append("}\r\n");

      if (isEnum)
      {
        code.Append("public void " + parameterName + "(" + enumName + " " + parameterName + ")");
        code.Append("{");
        code.Append("internal" + parameterName  + " = " + "(" + para.Type.ToString() + ")" + parameterName + ";");
        code.Append("}\r\n");
      }
            
      code.Append("\r\n");
      return code.ToString();
    }
  }
}