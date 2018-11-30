clear
clc
%% Init Testlibrary
addpath('Doc');
addpath('Doc/html');
% addpath('Doc/helpfiles');
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
   import TestLibrary.*;
catch ex
    ex.ExceptionObject.LoaderExceptions.Get(0).Message
    error('Library or support file loading problem. Script halted')
end


%% Set the PID 
hexId = '0012'; % Replace this with the desired PID
id = hex2dec(hexId);
pidFolderPath = 'C:\Users\laad\Documents\Visual Studio 2015\Projects\FirmwareTestTool\PC\code\Output\Debug\Command Definitions';
pidFilePath = [pidFolderPath '\USB, PID ' hexId '.txt'];

%% Create Communication generator class 
commGen = CommunicatorGenerator(id, pidFilePath);

%% Get the instance of the generated class 
deviceComm = commGen.generatedCommunicator;
    
%% Create a ping test
% CreateTestTemplate('PingTest', deviceComm, 'full');
test = PingTest(deviceComm);  

%% Run test
test.Run
