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
3.  Create a Communicator Generator and generate a Communicator for the given device
4.  Perform test
  
 -- Usage --
1.  Make a copy of the Test.m and call it something, <script name>.m.

2.  Set the PID of your device and edit the "pidFolderPath" to the folder 
    containing your PID file.

3.  Run the <script name>.m 
  
4.  As the device will be sending events at some point, Matlab will need 
    handlers for these events. Use the CreateTestTemplate.m to create a template 
    for a test. By specifying 'full' in the opt parameter, a complete set of 
    event callbacks will be generated. Specifying 'bare' will only generate 
    a minimum of functions for the test. This is useful if you don't want 
    your test to contain all your event callbacks.
    In the default script, a ping test generated and performed.
   
5.  The ping test will attempt to connect to the device and report an error if 
    the connection could not be established.
  
6.  After a successfull connection, the test will send a ping command

7.  After having sent all the commands, the ping test will enter a paused state 
    where it can still receive events. To exit this state, hit a random key 
    when the command windows is selected.
  
8.  The script will now disconnect from the device and exit

 -- Note --
Steps when changing the PID file.
1.  Delete the GeneratedCommunicator0x<PID>.dll, you might have to close Matlab if the
    dll has already been loaded into memory
2.  Rerun your script. This will generate a new GeneratedCommunicator0x<PID>.dll

Steps when setting up realTime event handlers
1.  Call deviceComm.SetRealTimeEventReceiver(hex2dec('<hex id>')), <file path>, receive size)
    before sending commands which will initiate realtime events e.g. 
    deviceComm.SetRealTimeEventReceiver(hex2dec('6400'), '..\Scripts\Eagles HotelCalifornia_f32.aiff', 4096)

Sending Commands
    Commands for the given device can be accessed through 
    deviceComm.<commmand name>.Send. If the command contains enumerators, these can be 
    accessed through C<command id>.<enumerator name>.<enumerator value> Matlab will 
    list the available commands after C is entered folowed by a 
    <TAB>.    