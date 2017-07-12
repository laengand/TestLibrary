function [testCollection] = DeviceTestCollection1(notifyEvent)
    
    % Init Testlibrary
    [folder, name, ext] = fileparts(mfilename('fullpath'));
%     cd(folder);
    
    % now get the path to the dot net library dll
    oldpath=pwd;
%     addpath('..\TestLibrary\Matlab\')
    cd([folder '\..\DotNetLibrary'])
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
    
    
    % Set the PID
    hexId = '0012'; % Replace this with the desired PID
    id = hex2dec(hexId);
    %pidFolderPath = 'C:\Users\Fyn_ivg\Desktop\Testtool\Command Definitions';
    %pidFolderPath ='C:\sw\testtool_laad\Command Definitions';  % SSMSA path
    pidFolderPath ='C:\Users\laad\Documents\Visual Studio 2015\Projects\FirmwareTestTool\PC\code\Output\Debug\Command Definitions';  % laad path
    
    pidFilePath = [pidFolderPath '\USB, PID ' hexId '.txt'];
    
    % Create Communication generator class
    commGen = CommunicatorGenerator(id, pidFilePath);
    
    % Get the instance of the generated class
    deviceComm = commGen.generatedCommunicator;
    
    p = addpath([folder '\..\..\..\EagleTest\']);
    addpath('..\');
    addpath([folder '\..\']);
    testCollection = Eagle_XTest(notifyEvent, deviceComm);
    testCollection.Connect;
%     testCollection.Disconnect;
    
    path(p)
end