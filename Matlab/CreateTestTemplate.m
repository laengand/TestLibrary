function CreateTestTemplate(name, deviceComm, opt)
% CreateTestTemplate
% Script to create a template to base a device test on
    p = addpath('.\Misc\');
    
if(strcmp(opt, 'bare') == 0 && strcmp(opt, 'full') == 0)
    error('not a valid ''opt'' parameters. Use ''full'' or ''bare'' ');
end

newline = [char(13) char(10)];
classContainer = ['classdef ' name ' < AbstractTest' newline]; % start of classDef
classContainer = [classContainer ...
    'properties(Access = public)' newline ...
    'end' newline ...
    newline];


classContainer = [classContainer ...
    'methods(Access = public)' newline ...     % start of methods(Access = public)
    '%% Constructor' newline...
    'function self = ' name '(deviceComm)' newline ...
    'self@AbstractTest(deviceComm);' newline];

if(strcmp(opt, 'bare') == 0)
    classContainer =[ classContainer, ...
        'self.RegisterEventListeners;' newline ];
end

classContainer = [ classContainer, ...
    'end' newline ...
    newline];

classContainer = [classContainer, ...
    '%% Run ' newline ...
    '% Implement your test here ' newline ...
    'function Run(self)' newline];

if(strcmp(opt, 'bare') == 0)
    classContainer = [classContainer, ...
        'deviceComm = self.deviceComm;' newline ...
        '% Connect to the device' newline ...
        'if deviceComm.Connect() == 0' newline ...
        'error(''Unable to connect to device. Reset the device.'')' newline ...
        'end' newline ...
        '% Perform test' newline ...
        'disp(''Test is running. Hit a key to stop'')' newline ...
        'deviceComm.C0000Ping' newline ...
        'pause(''on'')' newline ...
        'pause' newline ...
        'pause(''off'')' newline ...
        newline ...
        '% Disconnect from the device' newline ...
        'deviceComm.Disconnect();' newline];
end
classContainer = [classContainer, ...
    'end' newline ...
    newline];

registerEventListeners = '';

registerEventListeners = [registerEventListeners ...
    '%% ' 'RegisterEventListeners' newline];

registerEventListeners = [registerEventListeners, ...
    'function RegisterEventListeners(self)' newline];

unregisterEventListeners = '';

unregisterEventListeners = [unregisterEventListeners ...
    '%% ' 'UnregisterEventListeners' newline];

unregisterEventListeners = [unregisterEventListeners, ...
    'function UnregisterEventListeners(self)' newline];

unregisterEventListeners = [unregisterEventListeners, ...
    'self.DisableEventListeners();' newline];

eventCallbacks ='';

if(strcmp(opt, 'bare') == 0)
    commandList = deviceComm.commandList;
    for i=1:deviceComm.commandList.Count

        if commandList.Item(i-1).EventType ~= IA.Common.StandardCommunication.Tools.EventType.NotEvent
            eventName = char(deviceComm.cmdNames(i)); % matlab indexing
            id = ['0x' dec2hex(commandList.Item(i-1).CommandId)];
            hexid = dec2hex(commandList.Item(i-1).CommandId);
            registerEventListeners = [registerEventListeners 'self.AddEventListener(self.deviceComm.E' hexid ',@self.' eventName ');' newline];
            unregisterEventListeners = [unregisterEventListeners 'self.RemoveEventListener(self.deviceComm.E' hexid ',@self.' eventName ');' newline];

            func = ['%% ' id  ' ' eventName newline];

            paraDesc = textscan(char(deviceComm.cmdDescriptions(i)), '%s', 'delimiter', sprintf('\n'));
            paraDesc = paraDesc{1};
            para = [];
            for j = 1:numel(paraDesc)
                if strcmp(char(paraDesc(j)),'Parameters') == 1 || strcmp(char(paraDesc(j)),'Reply') == 1
                    para = [para ...
                        '% ' char(paraDesc(j)) newline];
                else
                    para = [para ...
                        '%   eventData.Data.' char(paraDesc(j)) newline];
                end
            end

            func = [func, ...
                para newline ...
                'function ' eventName '( self, ~, eventData )' newline ...
                'end' newline];
            eventCallbacks = [eventCallbacks func];
        end
    end
end;
registerEventListeners = [registerEventListeners ...
    'self.EnableEventListeners();' newline];

registerEventListeners = [registerEventListeners ...
    'end' newline];

unregisterEventListeners = [unregisterEventListeners ...
    'end' newline];


    classContainer = [classContainer, ...
        registerEventListeners newline ...
        unregisterEventListeners newline];
    
    classContainer = [classContainer, ... % end of methods(Access = public)
    'end' newline ...
    newline];
    
    classContainer = [classContainer, ...
    'methods(Access = private)' newline]; % Start of methods(Access = private)
    
    classContainer = [classContainer, ...
        eventCallbacks];

classContainer = [classContainer, ...
    'end' newline ...          % end of methods(Access = private)
    'end' newline ...
    newline];            % end of classDef

filename = [name '.m'];
if exist(filename, 'file') ~= 0
    prompt = ['File ''' filename '''' ' already exists. Is it okay to overwrite? Y/N: ' ];
    x = input(prompt,'s');
    if(strcmp(lower(x),'y') == 1)
        FID = fopen(filename,'w');
        fprintf(FID, '%s', classContainer);
        fclose(FID);
        SmartIndent(filename);
    end
else
    FID = fopen(filename,'w');
    fprintf(FID, '%s', classContainer);
    fclose(FID);
    SmartIndent(filename);
end
path(p)
end