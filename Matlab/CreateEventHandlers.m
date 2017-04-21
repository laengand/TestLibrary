function CreateEventHandlers(id, testClass)
className = ['EventHandlerClass0x' dec2hex(id,4)];
eventHandlers = sprintf('%s\r\n\r\n','%This is a generated file. Remove the .template extension prior to use.');
eventHandlers = sprintf('%sclassdef %s < handle\r\n', eventHandlers, className);
eventHandlers = sprintf('%s%s\r\n',eventHandlers, 'methods(Access = public)');
eventHandlers = sprintf('%sfunction self = %s()\r\n', eventHandlers, className);
eventHandlers = sprintf('%send\r\n',eventHandlers);

eventListeners = sprintf('function els = SetupEventListeners(obj,generatedClass)\r\n');
first = 1;
gClass = testClass.GeneratedClass;
for i=1:gClass.cmdNames.Length-1
    
    if testClass.interpreter.CommandList.Item(i-1).EventType == IA.Common.StandardCommunication.Tools.EventType.NotEvent == 0
        eventName = char(gClass.cmdNames(i));
        id = ['0x' dec2hex(testClass.interpreter.CommandList.Item(i-1).CommandId)];
        if first == 1
            eventListeners = [eventListeners 'els(1) = event.listener(generatedClass,' '''' eventName '''' ',@obj.' eventName ');'];
            first = 0;
        else
            eventListeners = [eventListeners 'els(end + 1) = event.listener(generatedClass,' '''' eventName '''' ',@obj.' eventName ');'];
        end

        eventListeners = sprintf('%s\r\n',eventListeners);
        func = sprintf('%s %s %s\r\n','%%',id, eventName);
        
        A = strread(char(gClass.cmdDescriptions(i)), '%s', 'delimiter', sprintf('\n'));
        B = [];
        for j = 1:numel(A)
            if strcmp(char(A(j)),'Parameters') == 1 || strcmp(char(A(j)),'Reply') == 1
                B = [B sprintf('%s %s\r\n','%', char(A(j)))];
            else
                B = [B sprintf('%s   eventData.Data.%s\r\n','%', char(A(j)))];
            end
        end 
        func = [func B 'function ' eventName '( self, ~, eventData )'];
        func = sprintf('%s\r\n',func);
        func = sprintf('%s%s\r\n',func, 'end');
        eventHandlers = sprintf('%s%s\r\n',eventHandlers, func);
    end
end

eventListeners = sprintf('%s%s\r\n', eventListeners, 'end');
eventHandlers = sprintf('%s%s\r\n',eventHandlers,eventListeners);
eventHandlers = sprintf('%s%s\r\n',eventHandlers,'end');
eventHandlers = sprintf('%s%s\r\n',eventHandlers,'end');
filename = [className '.m.template'];
FID = fopen(filename,'w');
fprintf(FID, '%s', eventHandlers);
fclose(FID);
end