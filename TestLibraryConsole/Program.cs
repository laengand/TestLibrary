using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TestLibrary;
namespace TestLibraryConsole
{
  class Program
  {
    static void Main(string[] args)
    {
      ushort id = 0x000E;
      string pidFolderPath = @"C:\Users\laad\Documents\Visual Studio 2015\Projects\FirmwareTestTool\PC\code\Output\Debug\Command Definitions";
      string pidFilePath = pidFolderPath + @"\USB, PID " + id.ToString("X4") + ".txt";
      CommunicatorGenerator comGen = new CommunicatorGenerator(id, pidFilePath);
    }
  }
}
