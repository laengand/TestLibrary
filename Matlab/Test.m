clear
clc

[folder, name, ext] = fileparts(mfilename('fullpath'));
cd(folder);

% now get the path to the dot net library dll
oldpath=pwd;
cd(['.' filesep 'DotNetLibrary'])
fullpath=pwd;
cd(oldpath);
PathToLibrary = [fullpath filesep];
LibraryName = 'TestLibrary.dll';

% Load the TestLibrary 
try
   asmInfo = NET.addAssembly([PathToLibrary LibraryName]);
catch ex
    ex.ExceptionObject.LoaderExceptions.Get(0).Message
    error('Library or support file loading problem. Script halted')
end

% Set the pid 
hexId = '0012';
id = hex2dec(hexId);
pidFolderPath = 'C:\Users\laad\Documents\Visual Studio 2015\Projects\FirmwareTestTool\PC\code\Output\Debug\Command Definitions';
pidFilePath = [pidFolderPath '\USB, PID ' hexId '.txt'];

import TestLibrary.*;
test = TestClass(id, pidFilePath);
device = test.GeneratedClass;

% Create default event handlers. These should be modified to correspond to
% a desired action, when an event is received
CreateEventHandlers(id,test);

% Create instance of event handlers and set up listeners
eventHandlers = EventHandlerClass0x0012();
e = cell(test.eventHandlerNames)';
els = eventHandlers.SetupEventListeners(device);

% Connect to the device
if test.Connect() == 0
    error('Unable to connect to device. Reset the device.')
end
    

% Perform test
disp('Test is running. Hit a key to stop')
device.Ping
    
pause('on')
pause
pause('off')

% Remember to disconnect from the device
test.Disconnect();
