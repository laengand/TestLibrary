classdef TestRunner < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        els;
        testCollection;
        testCollectionIndices;
        testCollectionPath;
        idxOld
        currentIdx;
        idxCounter = 1;
        stop = false;
        
        
        
        testListBox;
        startStopToggleTool;
        openTestPushTool;
        startIcon;
        stopIcon;
        openTestIcon;
    end
    events
        startEvent
        setupDoneEvent
        exerciseDoneEvent
        verifyDoneEvent
        teardownDoneEvent
        stopEvent
    end
    methods
        
        function NotifySetupDone(self)
            if(~self.stop)
                notify(self,'setupDoneEvent');
            end
        end
        
        function NotifyExerciseDone(self)
            if(~self.stop)
                notify(self,'exerciseDoneEvent');
            end
        end
        
        function NotifyVerifyDone(self)
            if(~self.stop)
                notify(self,'verifyDoneEvent');
            end
        end
        
        function NotifyTeardownDone(self)
            if(~self.stop)
                notify(self,'teardownDoneEvent');
            end
        end
        
        
        function self = TestRunner(hObject)
            
            self.testListBox = findobj(hObject,'tag', 'testListbox');
            self.testListBox.Callback = @self.TestListboxCallback;
            self.testListBox.Max = 2;
            self.testListBox.Value = [];

            self.openTestIcon = load('openTestIcon.mat');
            self.openTestIcon = self.openTestIcon.mat;
            
            self.openTestPushTool = findobj(hObject,'tag','openTestPushTool');
            self.openTestPushTool.ClickedCallback = @self.OpenTestPushToolClickedCallback;
                        
            self.startIcon = load('startIcon.mat');
            self.startIcon = self.startIcon.mat;
        
            self.startStopToggleTool = findobj(hObject,'tag','startStopToggletool');
            self.startStopToggleTool.ClickedCallback = @self.StartStopPushButtonCallback;

            self.stopIcon = load('stopIcon.mat');
            self.stopIcon = self.stopIcon.mat;
            
            self.els{1} = addlistener(self,'startEvent', @self.StartCallback);
            self.els{end}.Recursive = 1;
            self.els{end + 1} = addlistener(self,'setupDoneEvent', @self.SetupDoneCallback);
            self.els{end}.Recursive = 1;
            self.els{end + 1} = addlistener(self,'exerciseDoneEvent', @self.ExerciseDoneCallback);
            self.els{end}.Recursive = 1;
            self.els{end + 1} = addlistener(self,'verifyDoneEvent', @self.VerifyDoneCallback);
            self.els{end}.Recursive = 1;
            self.els{end + 1} = addlistener(self,'teardownDoneEvent', @self.TeardownDoneCallback);
            self.els{end}.Recursive = 1;
            self.els{end + 1} = addlistener(self,'stopEvent', @self.StopCallback);
            self.els{end}.Recursive = 1;
        end
        function SetTestCollection(self, testCollection)
            self.testCollection = testCollection;
        end
        
        function SetTestCollectionIndices(self, testCollectionIndices)
            self.testCollectionIndices = testCollectionIndices;
            
        end
        function UiSetup(self, idx)
            testCaseList = self.testCollection.GetTestCaseList;
            cellfun(@(t) t.UiSetup, testCaseList(idx));
        end
        
        function Start(self)
            self.startStopPushButton.String = 'Stop';
            self.startStopPushButton.Enable = 'on';
            self.testListBox.Enable = 'off';
            self.stop = false;
            self.startStopPushTool.CData = self.stopIcon;
            self.idxCounter = 1;
            notify(self,'startEvent');
        end
        function Stop(self)
            self.startStopPushButton.String= 'Start';
            self.startStopPushButton.Enable = 'on';
            self.testListBox.Enable = 'on';
            self.startStopPushTool.CData = self.startIcon;
            self.stop = true;
            notify(self,'stopEvent');
        end
        
        function UiTeardown(self, idx)
            testCaseList = self.testCollection.GetTestCaseList;
            cellfun(@(t) t.UiTeardown, testCaseList(idx));
        end
        
        
        
        
        %% event callbacks
        function StartCallback(self, ~, eventdata)
            self.currentIdx = self.testCollectionIndices(self.idxCounter);
            self.testCollection.GetTestCase(self.currentIdx).Setup;
        end
        
        function SetupDoneCallback(self, ~, eventdata)
            self.testCollection.GetTestCase(self.currentIdx).Exercise;
        end
        
        function ExerciseDoneCallback(self, ~, eventdata)    
            self.testCollection.GetTestCase(self.currentIdx).Verify;
        end
        
        function VerifyDoneCallback(self, ~, eventdata)           
            self.testCollection.GetTestCase(self.currentIdx).Teardown;
        end
        
        function TeardownDoneCallback(self, ~, eventdata)
            self.idxCounter = self.idxCounter + 1;
            if(self.idxCounter <= numel(self.testCollectionIndices))
                self.currentIdx = self.testCollectionIndices(self.idxCounter);
                notify(self,'startEvent')
            elseif(self.idxCounter > numel(self.testCollectionIndices))
                self.startStopPushButton.String = 'Start';
                self.startStopPushButton.Enable = 'on';
                self.testListBox.Enable = 'on';
                self.startStopPushTool.CData = self.startIcon;
                self.startStopPushTool.State = 'off';
            end
        end
        
        
        function StopCallback(self, ~, eventdata)
            testCaseList = self.testCollection.GetTestCaseList;
            cellfun(@(t) t.Teardown, testCaseList(self.testCollectionIndices(self.idxCounter:end)));
            self.idxCounter = 1;
            
        end
        
        % --- Executes on button press in pushbutton1.
        function StartStopPushButtonCallback(self, hObject, eventdata, handles)
            % hObject    handle to pushbutton1 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            if(isempty(self.testCollectionIndices))
                self.startStopPushTool.State = 'off';
                return
            end
%             if (strcmp(self.startStopPushButton.String,'Start')) || strcmp(self.startStopPushTool.State,'on'))
            if(strcmp(self.startStopPushTool.State,'on'))
                self.Start
            else
                self.Stop
            end
        end
        
        % --- Executes on selection change in listbox1.
        function TestListboxCallback(self, ~, eventdata, handles)
            % hObject    handle to listbox1 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            % Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
            %        contents{get(hObject,'Value')} returns selected item from listbox1
            
            
            idxNew = self.testListBox.Value;
            if(isempty(idxNew))
                if(~isempty(self.testCollectionIndices))
                    self.UiTeardown(self.testCollectionIndices);
                    self.testCollectionIndices = idxNew;
                end
                return
            end
            
            if(isempty(self.testCollectionIndices))
                self.UiSetup(idxNew)
                
            elseif(numel(idxNew) > numel(self.testCollectionIndices))
                diffIdx = setdiff(idxNew, self.testCollectionIndices);
                self.UiSetup(diffIdx);
                
            elseif numel(idxNew) < numel(self.testCollectionIndices)
                diffIdx = setdiff(self.testCollectionIndices,idxNew);
                self.UiTeardown(diffIdx);
                diffIdx = setdiff(idxNew,self.testCollectionIndices);
                self.UiSetup(diffIdx);
                
            else % numel(idxNew) == numel(idxOld)
                if(idxNew ~= self.testCollectionIndices)
                    self.UiTeardown(self.testCollectionIndices)
                    diffIdx = setdiff(idxNew, self.testCollectionIndices);
                    self.UiSetup(diffIdx);
                end
            end
            
            self.testCollectionIndices = idxNew;
            
        end
        
        function LoadTestCollection(self, fileName)
            if(nargin == 1) 
                try
                    [fileName, self.testCollectionPath] = uigetfile('*.m','Select the Test collection file', self.testCollectionPath);
                catch
                    [fileName, self.testCollectionPath] = uigetfile('*.m','Select the Test collection file');
                end
            end
            if(fileName ~= 0)
                
                if(~isempty(self.testCollection))
                    testCaseList = self.testCollection.GetTestCaseList;
                    cellfun(@(t) t.UiTeardown, testCaseList(self.testCollectionIndices), 'UniformOutput', false);
                    self.testCollectionIndices = [];
                end
                [pathName, name, ~] = fileparts(fileName);
                p = path;
                path(p, pathName)
                
                testCollectionFuncHandle = str2func(name);
                self.testCollection = testCollectionFuncHandle(self);
                path(p);
                self.testListBox.Value = [];
                self.testListBox.String = cellfun(@(t) t.GetName, self.testCollection.GetTestCaseList, 'UniformOutput', false);
            end
        end
        function OpenTestPushToolClickedCallback(self, hObject, eventdata, handles)
            % hObject    handle to uipushtool3 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            self.LoadTestCollection
                
        end
    end
    
end

