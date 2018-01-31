using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using TestLibrary;
using System.IO;

namespace TestLibraryConsole
{
  class Program
  {
    static void Main(string[] args)
    {
      ushort id = 0x0012;
      string pidFolderPath = @"C:\Users\laad\Documents\Visual Studio 2015\Projects\FirmwareTestTool\PC\code\Output\Debug\Command Definitions";
      string pidFilePath = pidFolderPath + @"\USB, PID " + id.ToString("X4") + ".txt";
      string pidFile = File.ReadAllText(pidFilePath);
      CommunicatorGenerator comGen = new CommunicatorGenerator(id, pidFilePath);
      TestLibrary.Communicator deviceComm = new TestLibrary.Communicator(id, pidFile);
      deviceComm.Connect();
      deviceComm.C0000Ping();
      deviceComm.C0013RequestAccessoryStatusNr();
      deviceComm.C4F06RequestBoardCalibrationData();
      deviceComm.Disconnect();
      if (false)
      {
        //CommunicatorGenerator comGen = new CommunicatorGenerator(id, pidFilePath);
        //Assembly assembly = comGen.assembly;

        //Type type = assembly.GetType("TestLibrary.Communicator");
        //object deviceComm = comGen.generatedCommunicator;
        //object reply = type.GetMethod("Connect").Invoke(deviceComm, new object[] { });
        ////MethodInfo method = type.GetMethod( "C0000Ping", new Type[] { typeof(bool) });
        //reply = type.GetMethod("C0000Ping", new Type[] { typeof(bool) }).Invoke(deviceComm, new object[] { true });
        //reply = type.GetMethod("C4F06RequestBoardCalibrationData", new Type[] { typeof(bool) }).Invoke(deviceComm, new object[] { true });
        //var input = Console.ReadLine();
        //reply = type.GetMethod("Disconnect").Invoke(deviceComm, new object[] { });
      }
      //comGen.Dispose();

    }
  }
}
