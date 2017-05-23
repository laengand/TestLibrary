classdef AbstractTest < handle & matlab.mixin.SetGet
    properties(Access = public)
        els = {}; % event listeners
        deviceComm = {};
        lostAndFoundEvents = {}; %  all unregistered events will be here
    end

    methods(Access = public)
        %% Constructer
        function self = AbstractTest(deviceComm)
            self.deviceComm = deviceComm;
            
            % find all events 
            props = properties(self.deviceComm);
            allEvents = props(~cellfun(@isempty,regexp(props,'^E\w{4}$'))); % begins with E followed by a 4 symbols word
            
            % setup default callback for all events.
            for n=1:length(allEvents)
                if(~isempty(self.els))
                    self.els{end+1} = event.listener(self.deviceComm.(allEvents{n}), 'Handler', @self.LostAndFoundCallback);
                else
                    self.els{1} = event.listener(self.deviceComm.(allEvents{n}), 'Handler', @self.LostAndFoundCallback);
                end;
                
                % All events are added but disabled, so an object can be
                % created but not called before you want to.
                self.els{end}.Enabled = false;
            end 
        end
        
        %% AddEventListener
        % Add a callback upon receiving an event
        function AddEventListener(self, eventInstance, callback)
            if(~isempty(self.els)) % some listeners already there
                found = false;
                
                % Overwrite default callback
                for n=1:length(self.els)
                    % Only one source is supported
                    if((self.els{n}.Source{1}.ToString == eventInstance.ToString) && strcmp(char(self.els{n}.Callback),char(@self.LostAndFoundCallback)))
                        % found event, so overwrite it
                        self.els{n} = event.listener(eventInstance, 'Handler', callback);
                        self.els{n}.Enabled = false;
                        found = true;
                        break;
                    end;
                end;
                
                if(~found)
                    % not found, so add a new one
                    self.els{end + 1} = event.listener(eventInstance, 'Handler', callback);
                    self.els{end}.Enabled = false;
                end;
            else % no listeners there, just create it.
              self.els{1} = event.listener(eventInstance, 'Handler', callback);
              self.els{end}.Enabled = false;
            end  
        end
        
        %% RemoveEventListener
        % Remove a callback from receiving list
        function RemoveEventListener(self, eventInstance, callback)
            if ~isempty(self.els)
                for n=1:length(self.els)
                    % Only one source is supported
                    if((self.els{n}.Source{1}.ToString == eventInstance.ToString) && strcmp(char(self.els{n}.Callback),char(callback)))
                        % found it, so add default callback.
                        self.els{n} = event.listener(eventInstance, 'Handler', @self.LostAndFoundCallback);
                        self.els{n}.Enabled = false;
                        break;
                    end;
                end;
            end;
        end
        
        %% EnableEventListeners
        % Enable all added event listeners
        function EnableEventListeners(self)
            if ~isempty(self.els)
                for n=1:length(self.els)
                    self.els{n}.Enabled = true;
                end;
            end;
        end
 
        %% DiableEventListeners
        % Diable all added event listeners
        function DisableEventListeners(self)
            if ~isempty(self.els)
                for n=1:length(self.els)
                    self.els{n}.Enabled = false;
                end;
            end;
        end
        
    end

        %% Abstract methods
    methods(Abstract)
        Run(self) % Put all your tings in this method
        RegisterEventListeners(self)% place all you listeners her
        UnregisterEventListeners(self) % place all listeners to remove here.
    end

    methods(Access = private)
        % Default callback: To inform the user that you got something,
        % you did not add a listener to.
        function LostAndFoundCallback( self, calling, eventData )
            % Find event name
            label = (char(calling.ToString));
            label = label(1:5);
            
            if(isempty(self.lostAndFoundEvents))
                % all new, so just put the event
                self.lostAndFoundEvents = struct(label,cell(1));
                self.lostAndFoundEvents.(label){1} = eventData.Data;
            elseif(~isfield(self.lostAndFoundEvents,label))
                % not got this event before, so create list
                self.lostAndFoundEvents.(label){1} = eventData.Data;
            else
                % append list, as we do have prev items
                self.lostAndFoundEvents.(label){end+1} = eventData.Data;
            end;
        end
    end
end