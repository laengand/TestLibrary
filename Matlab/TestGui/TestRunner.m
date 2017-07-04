classdef TestRunner < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    %     properties(Access = private)
    properties(Access = public)
        testCollection;
        testCollectionIndices;
        testCollectionPath;
        idxOld;
        currentIdx;
        lockedIdx;
        idxCounter = 1;
        testListBox;
        startStopToggleTool;
        openTestPushTool;
        startIcon;
        stopIcon;
        openTestIcon;
        stateOld;
        stateNew;
        stateTimer;
        statePhaseLog = struct('setup', false,'exercise', false,'verify', false, 'teardown', false);
        filePaths;
    end
    
    methods(Access = private)
        function stateLoop(self, ~, ~)
            try
            if(self.stateNew == self.stateOld)
                return
            end
            self.stateOld = self.stateNew;
            switch(self.stateNew)
                case TestRunnerState.IDLE
                    
                case TestRunnerState.START
                    self.StartTest;
                    
                case TestRunnerState.SETUP
                    self.SetupTest;
                    
                case TestRunnerState.EXERCISE
                    self.ExerciseTest;
                    
                case TestRunnerState.VERIFY
                    self.VerifyTest;
                    
                case TestRunnerState.TEARDOWN
                    self.TeardownTest;
                    
                case TestRunnerState.STOP
                    self.StopTest;
            end
            catch ex
                disp(ex.message)
            end
        end
        %% UI callbacks
        function StartStopToggleToolCallback(self, ~, ~, ~)
            if(isempty(self.testCollectionIndices))
                self.startStopToggleTool.State = 'off';
                return
            end
            
            if(strcmp(self.startStopToggleTool.State,'on'))
                self.Start
            else
                self.Stop;
            end
        end
        
        function TestListboxCallback(self, ~, ~, ~)
            
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
        
        function OpenTestPushToolClickedCallback(self, ~, ~, ~)
            self.LoadTestCollection
        end
        
        function StartTest(self, ~, ~)
                        
            self.testListBox.Enable = 'off';
            self.startStopToggleTool.CData = self.stopIcon;
            
            self.idxCounter = 1;
            if(~isempty(self.testCollectionIndices))
                self.currentIdx = self.testCollectionIndices(self.idxCounter);
                self.stateNew = TestRunnerState.SETUP;
            end
        end
        
        function SetupTest(self)
            self.statePhaseLog.setup = true;
            self.testCollection.GetTestCase(self.currentIdx).Setup;
        end
        
        function ExerciseTest(self)
            self.statePhaseLog.exercise = true;
            self.testCollection.GetTestCase(self.currentIdx).Exercise;
        end
        
        function VerifyTest(self)
            self.statePhaseLog.verify = true;
                self.testCollection.GetTestCase(self.currentIdx).Verify;
        end
        
        function TeardownTest(self)
            self.statePhaseLog.teardown = true;
            self.testCollection.GetTestCase(self.currentIdx).Teardown;
        end
                
        function StopTest(self, ~, ~)
            self.testListBox.Enable = 'on';
            self.startStopToggleTool.CData = self.startIcon;
            if(~self.statePhaseLog.teardown)
                self.TeardownTest;
            end
            self.ClearStatePhaseLog;
            %             cellfun(@(t) t.Teardown, testCaseList(self.testCollectionIndices(self.idxCounter:end)));
            self.idxCounter = 1;
        end
        
        function ClearStatePhaseLog(self)
            self.statePhaseLog.setup = false;
            self.statePhaseLog.exercise = false;
            self.statePhaseLog.verify = false;
            self.statePhaseLog.teardown = false;    
        end
    end
    
    methods(Access = public)
        
        function self = TestRunner(hObject)
            % Constructor
            self.filePaths = path;
            self.stateNew = TestRunnerState.IDLE;
            self.stateOld = self.stateNew;
            self.stateTimer = timer;
            self.stateTimer.TimerFcn = @self.stateLoop;
            self.stateTimer.Period = 0.5;
            self.stateTimer.Name = [mfilename 'Timer'];
            self.stateTimer.ExecutionMode = 'fixedSpacing';
            self.stateTimer.BusyMode = 'queue';
            if(nargin == 1)
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
                self.startStopToggleTool.ClickedCallback = @self.StartStopToggleToolCallback;
                
                self.stopIcon = load('stopIcon.mat');
                self.stopIcon = self.stopIcon.mat;
            end
            
            start(self.stateTimer);
        end
        
        function delete(self)
            % Destructor
            stop(self.stateTimer);
            delete(self.stateTimer);
            path(self.filePaths);
        end
        
        function SetTestCollection(self, testCollection)
            % SetTestCollection(testCollection)
            % Sets the active test collection
            self.testCollection = testCollection;
        end
        
        function SetTestCollectionIndices(self, testCollectionIndices)
            % SetTestCollectionIndices(testCollectionIndices)
            % Sets the active test collection indices
            self.testCollectionIndices = testCollectionIndices;
        end
        
        function Start(self)
            % Start
            % Starts the active tests based on the test collection and the
            % selected indices
            self.stateNew = TestRunnerState.START;
        end
        
        function Stop(self)
            % Stop
            % Stops the current test
            self.stateNew = TestRunnerState.STOP;
        end
        
        %% Test events
        function NotifySetupDone(self)
            if(self.stateNew ~= TestRunnerState.STOP)
                self.stateNew = TestRunnerState.EXERCISE;
            end
        end
        
        function NotifyExerciseDone(self)
            if(self.stateNew ~= TestRunnerState.STOP)
                self.stateNew = TestRunnerState.VERIFY;
            end
        end
        
        function NotifyVerifyDone(self)
            if(self.stateNew ~= TestRunnerState.STOP)
                self.stateNew = TestRunnerState.TEARDOWN;
            end
        end
        
        function NotifyTeardownDone(self)
            if(self.stateNew ~= TestRunnerState.STOP)
                self.idxCounter = self.idxCounter + 1;
                if(self.idxCounter <= numel(self.testCollectionIndices))
                    self.currentIdx = self.testCollectionIndices(self.idxCounter);
                    self.ClearStatePhaseLog;
                    self.stateNew = TestRunnerState.SETUP;
                    
                elseif(self.idxCounter > numel(self.testCollectionIndices))
                    self.testListBox.Enable = 'on';
                    self.startStopToggleTool.CData = self.startIcon;
                    self.startStopToggleTool.State = 'off';
                    self.stateNew = TestRunnerState.IDLE;
                end
            end
        end
        
        %% Test UI callbacks
        function UiSetup(self, idx)
            if(~isempty(self.testCollection))
                testCaseList = self.testCollection.GetTestCaseList;
                cellfun(@(t) t.UiSetup, testCaseList(idx));
            end
        end
        
        function UiTeardown(self, idx)
            testCaseList = self.testCollection.GetTestCaseList;
            cellfun(@(t) t.UiTeardown, testCaseList(idx));
        end
        
        
        %% Event callbacks

        function LoadTestCollection(self, fileName)
            pathName = '';
            if(nargin == 1)
                try
                    [fileName, pathName] = uigetfile('*.m','Select the Test collection file', self.testCollectionPath);
                catch
                    [fileName, pathName] = uigetfile('*.m','Select the Test collection file');
                end
            end
            self.testCollectionPath = pathName;
            if(fileName ~= 0)
                
                if(~isempty(self.testCollection))
                    testCaseList = self.testCollection.GetTestCaseList;
                    cellfun(@(t) t.UiTeardown, testCaseList(self.testCollectionIndices), 'UniformOutput', false);
                    self.testCollectionIndices = [];
                end
                [~, name, ~] = fileparts(fileName);
                
                addpath(pathName);
                
                testCollectionFuncHandle = str2func(name);
                temp = testCollectionFuncHandle(self);
                
                if(isa(temp,'TestCollection'))
                    self.testCollection = temp;
                    
                    if(~isempty(self.testListBox))
                        self.testListBox.Value = [];
                        self.testListBox.String = cellfun(@(t) t.GetName, self.testCollection.GetTestCaseList, 'UniformOutput', false);
                    end
                end
                
            end
        end
    end
    
end

