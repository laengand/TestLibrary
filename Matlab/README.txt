--------------------------------- TestLibrary ---------------------------------
 -- Introduction --
The TestLibrary is a tool for communication between Matlab and a given 
device (audiometer, tympanometer etc.). The only requirement is a PID file.
The TestLibrary consists of a C# dll which reads a PID file and creates a 
class which can communicate with the device with the given PID. 
TestClass
  |
  -> GeneratedClass

Folder structure:
TestLibrary
| +-- Matlab
|   +-- DotNetLibrary
| +-- TestLibrary
| +-- TestLibraryConsole

The dll containing this generated class will be called 
GeneratedClass0x<PID>.dll e.g. GeneratedClass0x0012.dll. The dll will be placed 
in the DotNetLibrary folder. This dll is created once. If you make changes to 
the PID file, you will have to delete the generated dll in order to generate a 
new dll.

As a user of the TestLibrary, the Matlab folder is the only one which should be 
considered. The Matlab folder contains a file called Test.m. This file should 
used as a reference when creating your own test scripts, in other words make a 
copy of it instead of editing the file directly as it might be changed during 
further development of the TestLibrary. The Test.m assumes the DotNetLibrary to
be in the same folder. If you run your script from another folder, you will 
have to change the PathToLibrary variable in your script.
  
General structure of the Test.m file:
1.  Load TestLibrary
2.  Set the PID to use
3.  Create TestClass and generate a class for the given device
4.  Connect to the device
5.  Perform test
6.  Disconnect from the device
  
 -- Usage --
1.  Make a copy of the Test.m and call it something, <script name>.m.

2.  Set the PID of your device and edit the "pidFolderPath" to the folder 
    containing your PID file.

3.  Run the <script name>.m 
  
4.  As the device will be sending events at some point, Matlab will need 
    handlers for these events. When the <script name>.m is run it will check if
    any event handlers for the exist given PID. If none exists, it will 
    generate a set of default event handlers in a file called 
    EventHandlerClass0x<PID>.m.template e.g EventHandlerClass0x0012.m.template.
    An error will be reported since no event handlers existed. 
    In order to use generated event handlers, you have to remove the .template 
    extension and rerun the <script name>.m.
  
5.  The script will attempt to connect to the device and report and error if 
    the connection could not be established.
  
6.  After a successfull connection, the script will send whatever commands you 
    have specified. 
  
7.  After having sent all the commands, the script will enter a paused state 
    where it can still receive events. To exit this state, hit a random key 
    when the command windows is selected.
  
8.  The script will now disconnect from the device and exit

 -- Note --
Steps when changing the PID file.
1.  Delete the GeneratedClass0x<PID>.dll, you might have to close Matlab if the
    dll has already been loaded into memory
2.  Rerun your script. This will generate a new GeneratedClass0x<PID>.dll
