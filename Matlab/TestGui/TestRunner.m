classdef TestRunner < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        els;
        testCollection;
        testCollectionIdx;
        testCollectionPath;
        currentIdx;
        idxCounter = 1;
        stop = false;
        handles;
        testListBox;
        idxOld
        startStopPushButton;
        startStopPushTool;
        openTestPushTool;
        openTestPushButton;
        stopPushTool;
        toolbar;
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
            
%             self.startStopPushButton = uicontrol(...
%                 'Parent', hObject,...
%                 'FontUnits',get(0,'defaultuicontrolFontUnits'),...
%                 'Units','characters',...
%                 'String','Start',...
%                 'Style',get(0,'defaultuicontrolStyle'),...
%                 'Position',[-0.2 -0.0769230769230769 30.2 3.92307692307692],...
%                 'Callback',@self.StartStopPushButtonCallback,...
%                 'Children',[],...
%                 'Tag','startStopPushButton' ...
%                 );
            %             'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );
            
%             self.openTestPushButton = uicontrol(...
%                 'Parent', hObject,...
%                 'FontUnits',get(0,'defaultuicontrolFontUnits'),...
%                 'Units','characters',...
%                 'String','Load Test(s)',...
%                 'Style',get(0,'defaultuicontrolStyle'),...
%                 'Position',[-0.2 15.3076923076923 30.2 3.92307692307693],...
%                 'Callback',@self.OpenTestPushToolClickedCallback,...
%                 'Children',[],...
%                 'Tag','openTestPushButton' ...
%                 );
            %             'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );
            parentPosition = hObject.Position;
            parentUnits = hObject.Units;
            self.testListBox = uicontrol(...
                'Parent',hObject,...
                'FontUnits',get(0,'defaultuicontrolFontUnits'),...
                'Units', parentUnits,...
                'Max',2,...
                'String',blanks(0),...
                'Style','listbox',...
                'Value', [],...
                'Position', [3 3 parentPosition(3:4)-3], ...
                'BackgroundColor',[1 1 1],...
                'Callback',@self.TestListboxCallback,...
                'Children',[], ...
                'Tag','testListbox');
            
%             'Units', 'pixels', ...    
%              'Position',[0 0 200 150],...
            % 'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)TestGui_export('listbox1_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
            
%             self.toolbar = uitoolbar(...
%                 'Parent', hObject,...
%                 'Tag','toolbar'); %,...
            %                 'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );
            
            %             appdata = [];
            %             appdata.toolid = 'Standard.FileOpen';
            %             appdata.CallbackInUse = struct(...
            %                 'ClickedCallback', 'TestGui(''uipushtool3_ClickedCallback'',gcbo,[],guidata(gcbo))');
            %             appdata.lastValidTag = 'uipushtool3';
            self.openTestIcon = load('openTestIcon.mat');
            self.openTestIcon = self.openTestIcon.mat;
            
            self.openTestPushTool = findobj(hObject,'tag','openTestPushTool');
            self.openTestPushTool.ClickedCallback = @self.OpenTestPushToolClickedCallback;
            
%             self.openTestPushTool = uipushtool(...
%                 'Parent', self.toolbar,...
%                 'Serializable',get(0,'defaultuipushtoolSerializable'),...
%                 'Children',[],...
%                 'BusyAction','cancel',...
%                 'Interruptible','off',...
%                 'Tag','openTestPushToolClickedCallback',...
%                 'CData', self.openTestIcon,...
%                 'ClickedCallback',@self.OpenTestPushToolClickedCallback,...
%                 'Separator',get(0,'defaultuipushtoolSeparator'),...
%                 'TooltipString','Open File',...
%                 'HandleVisibility',get(0,'defaultuipushtoolHandleVisibility')); %,...
            %                 'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );
            
            self.startIcon = load('startIcon.mat');
            self.startIcon = self.startIcon.mat;
        
            self.startStopPushTool = findobj(hObject,'tag','startStopToggletool');
            self.startStopPushTool.ClickedCallback = @self.StartStopPushButtonCallback;
%             self.startStopPushTool = uitoggletool(...
%             'Parent', self.toolbar,...
%             'Children',[],...
%             'Tag','startStopPushtool',...
%             'CData',self.startIcon, ...
%             'ClickedCallback', @self.StartStopPushButtonCallback, ...
%             'Separator', get(0,'defaultuitoggletoolSeparator'));

        
        %             'OffCallback', @self.StopCallback, ...
%             'OnCallback', @self.StartCallback, ...
            self.stopIcon = load('stopIcon.mat');
            self.stopIcon = self.stopIcon.mat;
            
%             self.stopPushTool = uipushtool(...
%                 'Parent', self.toolbar,...
%                 'Children',[],...
%                 'Tag','stop',...
%                 'CData',self.stopIcon{2},...
%                 'ClickedCallback', @self.StopCallback, ...    
%                 'Separator',get(0,'defaultuipushtoolSeparator')); %,...
%                 'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

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
        
        function SetTestCollectionIdx(self, testCollectionIdx)
            self.testCollectionIdx = testCollectionIdx;
            
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
            self.currentIdx = self.testCollectionIdx(self.idxCounter);
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
            if(self.idxCounter <= numel(self.testCollectionIdx))
                self.currentIdx = self.testCollectionIdx(self.idxCounter);
                notify(self,'startEvent')
            elseif(self.idxCounter > numel(self.testCollectionIdx))
                self.startStopPushButton.String = 'Start';
                self.startStopPushButton.Enable = 'on';
                self.testListBox.Enable = 'on';
                self.startStopPushTool.CData = self.startIcon;
                self.startStopPushTool.State = 'off';
            end
        end
        
        
        function StopCallback(self, ~, eventdata)
            testCaseList = self.testCollection.GetTestCaseList;
            cellfun(@(t) t.Teardown, testCaseList(self.testCollectionIdx(self.idxCounter:end)));
            self.idxCounter = 1;
            
        end
        
        % --- Executes on button press in pushbutton1.
        function StartStopPushButtonCallback(self, hObject, eventdata, handles)
            % hObject    handle to pushbutton1 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            if(isempty(self.testCollectionIdx))
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
                if(~isempty(self.testCollectionIdx))
                    self.UiTeardown(self.testCollectionIdx);
                    self.testCollectionIdx = idxNew;
                end
                return
            end
            
            if(isempty(self.testCollectionIdx))
                self.UiSetup(idxNew)
                
            elseif(numel(idxNew) > numel(self.testCollectionIdx))
                diffIdx = setdiff(idxNew, self.testCollectionIdx);
                self.UiSetup(diffIdx);
                
            elseif numel(idxNew) < numel(self.testCollectionIdx)
                diffIdx = setdiff(self.testCollectionIdx,idxNew);
                self.UiTeardown(diffIdx);
                diffIdx = setdiff(idxNew,self.testCollectionIdx);
                self.UiSetup(diffIdx);
                
            else % numel(idxNew) == numel(idxOld)
                if(idxNew ~= self.testCollectionIdx)
                    self.UiTeardown(self.testCollectionIdx)
                    diffIdx = setdiff(idxNew, self.testCollectionIdx);
                    self.UiSetup(diffIdx);
                end
            end
            
            self.testCollectionIdx = idxNew;
            
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
                    cellfun(@(t) t.UiTeardown, testCaseList(self.testCollectionIdx), 'UniformOutput', false);
                    self.testCollectionIdx = [];
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

