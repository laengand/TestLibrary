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
        jUITable;
        tableSelectSingleton = 0;
        openTestPushtool;
        startContPushtool
        stopPushtool;
        testCollectionText;
        selectAllCheckBox;
        
        startIcon;
        stopIcon;
        continueIcon;
        openTestIcon;
        hObject;
        stateOld;
        stateNew;
        stateTimer;
        statePhaseLog = struct('setup', false, 'exercise', false, 'verify', false, 'teardown', false);
        filePaths;
        startContState = 'start';
    end
    
    properties(Access = private, Constant)
        COLUMN_TESTSELECTION = 1;
        COLUMN_NAME = 2;
        COLUMN_DATE = 3;
        COLUMN_RESULT = 4;
        COLUMN_NUMBER_OF_COLUMNS = 4;
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
                DisplayException(ex)
            end
        end
        %% UI callbacks        
        function StartContPushtoolCallback(self, ~, ~, ~)
             if(isempty(self.testCollectionIndices))
                return
             end
            
            if(strcmp(self.startContState, 'start'))
                self.startContState = 'continue';
                self.Start;
                self.startContPushtool.CData = self.continueIcon;
                self.startContPushtool.TooltipString = 'Continue';
                self.stopPushtool.Enable = 'on';
                self.testListBox.Enable = 'off';
                
            elseif(strcmp(self.startContState, 'continue'))
                self.ContinuePushtoolCallback;
            end
        end
        
        function StopPushtoolCallback(self, ~, ~, ~)
            self.startContState = 'start';
            self.Stop;
            self.startContPushtool.CData = self.startIcon;
            self.startContPushtool.TooltipString = 'Start';
            self.stopPushtool.Enable = 'off';
            self.testListBox.Enable = 'on';
        end
        
        function ContinuePushtoolCallback(self, ~, ~, ~)
            switch(self.stateOld)
                    
                case TestRunnerState.SETUP
                    self.NotifySetupDone;
                    
                case TestRunnerState.EXERCISE
                    self.NotifyExerciseDone;
                    
                case TestRunnerState.VERIFY
                    self.NotifyVerifyDone;
                    
                case TestRunnerState.TEARDOWN
                    self.NotifyTeardownDone;
            end
        end
        
        function SelectAllCheckBoxCallback(self, ~, ~, ~)
            if(~isempty(self.testListBox.Data))
                self.testListBox.Data(:,1) = {logical(self.selectAllCheckBox.Value)};
                self.TestListboxCallback();
            end
        end
        
        function TestListboxCallback(self, ~, ~, ~)
            if self.stateOld ~= TestRunnerState.IDLE
                return
            end
            if(~all(cell2mat(self.testListBox.Data(:, 1))))
                self.selectAllCheckBox.Value = false;
            end
            idxNew = find(cell2mat(self.testListBox.Data(:, self.COLUMN_TESTSELECTION)));
            
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
                diffIdx = setdiff(self.testCollectionIndices, idxNew);
                self.UiTeardown(diffIdx);
                diffIdx = setdiff(idxNew, self.testCollectionIndices);
                self.UiSetup(diffIdx);
                
            else % numel(idxNew) == numel(idxOld)
                if(idxNew ~= self.testCollectionIndices)
                    self.UiTeardown(self.testCollectionIndices)
                    diffIdx = setdiff(idxNew, self.testCollectionIndices);
                    self.UiSetup(diffIdx);
                end
            end
            
            self.testCollectionIndices = idxNew;
            self.tableSelectSingleton = false;
        end
        
        function OpenTestPushtoolClickedCallback(self, ~, ~, ~)
            self.LoadTestCollection();
        end
        
        function StartTest(self, ~, ~)
            self.idxCounter = 1;
            if(~isempty(self.testCollectionIndices))
                self.currentIdx = self.testCollectionIndices(self.idxCounter);
                self.stateNew = TestRunnerState.SETUP;
            end
        end
        
        function SetupTest(self)
            self.statePhaseLog.setup = true;
            self.testCollection.GetTestCase(self.currentIdx).Setup();
        end
        
        function ExerciseTest(self)
            self.statePhaseLog.exercise = true;
            self.testCollection.GetTestCase(self.currentIdx).Exercise();
        end
        
        function VerifyTest(self)
            self.statePhaseLog.verify = true;
            self.testCollection.GetTestCase(self.currentIdx).Verify();
        end
        
        function TeardownTest(self)
            self.statePhaseLog.teardown = true;
            self.testCollection.GetTestCase(self.currentIdx).Teardown();
        end
                
        function StopTest(self, ~, ~)
            
            if(~self.statePhaseLog.teardown)
                self.TeardownTest;
            end
            self.ClearStatePhaseLog;
            self.idxCounter = 1;
            self.stateNew = TestRunnerState.IDLE;
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
            
            oldTimers = timerfindall('Name', [mfilename 'Timer']);
            if(~isempty(oldTimers))
                stop(oldTimers);
                delete(oldTimers);
            end
            self.stateTimer = timer;
            self.stateTimer.TimerFcn = @self.stateLoop;
            self.stateTimer.Period = 0.5;
            self.stateTimer.Name = [mfilename 'Timer'];
            self.stateTimer.ExecutionMode = 'fixedSpacing';
            self.stateTimer.BusyMode = 'queue';
            
            %% 
            
            %%
            if(nargin == 1)
                self.hObject = hObject;
                
                
                self.testCollectionText = findobj(hObject,'tag','testCollectionText');
                self.testCollectionText.String = 'No test collection';
                
                if(0)
                    self.testListBox = findobj(hObject,'tag', 'testListbox');
                    self.testListBox.Callback = @self.TestListboxCallback;
                    self.testListBox.Max = 2;
                    self.testListBox.Value = [];
                else
                    height = hObject.Position(4);
                    self.testListBox = uitable(...
                    'ColumnName', {'' 'Name' 'Latest test' 'Result'},...
                    'ColumnEditable',[true false false false]...
                    );
                    
                    self.testListBox.ColumnWidth = {20 150 110 50};
%                     self.testListBox.CellSelectionCallback = @self.TestListboxCallback;
                    self.testListBox.CellEditCallback = @self.TestListboxCallback;
                    self.testListBox.Interruptible = 'off';
                end
                
                self.testListBox.Position = [1 0 self.testListBox.Extent(3) height-self.testCollectionText.Position(4)] ;
              
                self.selectAllCheckBox = uicontrol(...
                'style','checkbox',...
                'position',[self.testListBox.Position(1)+(self.testListBox.Position(3)-sum(cell2mat(self.testListBox.ColumnWidth))) self.testCollectionText.Position(2) 15 self.testCollectionText.Position(4)],...
                'callback', @self.SelectAllCheckBoxCallback...
                );
            
            
                hObject.Position(3) = self.testListBox.Extent(3)-3;
                self.testCollectionText.Position(1) =  self.hObject.Position(3)/2-self.testCollectionText.Position(3)/2;
               
                jUIScrollPane = findjobj(self.testListBox);
                self.jUITable = jUIScrollPane.getViewport.getView;
                
                self.openTestIcon = load('openTestIcon.mat');
                self.openTestIcon = self.openTestIcon.mat;
                
                self.openTestPushtool = findobj(hObject,'tag','openTestPushtool');
                self.openTestPushtool.ClickedCallback = @self.OpenTestPushtoolClickedCallback;
                
                self.startIcon = load('startIcon.mat');
                self.startIcon = self.startIcon.mat;
                
                self.stopIcon = load('stopIcon.mat');
                self.stopIcon = self.stopIcon.mat;
                
                self.stopPushtool = findobj(hObject,'tag','stopPushtool');
                self.stopPushtool.ClickedCallback = @self.StopPushtoolCallback;
                self.stopPushtool.Enable = 'off';
                                
                self.continueIcon = load('continueIcon.mat');
                self.continueIcon = self.continueIcon.mat;
                
                self.startContPushtool = findobj(hObject,'tag','startContPushtool');
                self.startContPushtool.ClickedCallback = @self.StartContPushtoolCallback; 
                self.startContPushtool.CData = self.startIcon;
                                
                
            end
            
            start(self.stateTimer);
        end
        
        function delete(self)
            % Destructor
            self.UiTeardown(self.testCollectionIndices);
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
        
        function state = GetCurrentState(self)
            state = self.stateNew;
        end

        function stopped = IsStopped(self)
            stopped = (TestRunnerState.STOP == self.stateNew);
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
                self.UpdateResult(self.currentIdx);
                if(self.idxCounter <= numel(self.testCollectionIndices))
                    self.currentIdx = self.testCollectionIndices(self.idxCounter);
                    self.ClearStatePhaseLog;
                    self.stateNew = TestRunnerState.SETUP;
                    
                elseif(self.idxCounter > numel(self.testCollectionIndices))
                    self.testListBox.Enable = 'on';
                    self.stopPushtool.Enable = 'off';
                    self.startContState = 'start';
                    self.startContPushtool.CData = self.startIcon;
                    self.startContPushtool.TooltipString = 'Start';
                    self.stateNew = TestRunnerState.IDLE;
                    for i=1:numel(self.testCollectionIndices)
                        if(~self.jUITable.isCellSelected(self.testCollectionIndices(i),0))
                            self.jUITable.changeSelection(self.testCollectionIndices(i)-1,0,true,false)
                        end   
                    end
                end
            end
            self.ClearStatePhaseLog;
        end
        
        %% Test UI callbacks
        function UiSetup(self, idx)
            if(~isempty(self.testCollection))
                testCaseList = self.testCollection.GetTestCaseList;
                cellfun(@(t) t.UiSetup, testCaseList(idx));
            end
        end
        
        function UiTeardown(self, idx)
            if ~isempty(idx)
                testCaseList = self.testCollection.GetTestCaseList;
                cellfun(@(t) t.UiTeardown, testCaseList(idx));
            end
        end
        
        function coloredStr = SetBackground(self, str, color)
            coloredStr = ['<HTML><table border=0 width=400 bgcolor=' color '><TR><TD>' str '</TD></TR> </table></HTML>'];
%             coloredStr = ['<span style="background-color:' color '">' str '</span>'];
        end
        
        function UpdateResult(self, idx)
            folder = self.testCollection.GetTestCase(idx).GetResultFolder();
            folderInfo = dir(folder);
            self.testListBox.Data(idx,self.COLUMN_DATE) = {''};
            self.testListBox.Data(idx,self.COLUMN_RESULT) = {self.SetBackground('','gray')};
            
            if ~isempty(folderInfo)
                [~,latestResultFolderIdx] = max([folderInfo(3:end).datenum]);
                latestResultFolderIdx = latestResultFolderIdx+2; % account for . and .. in folder structure
                
                while (latestResultFolderIdx > 0)
                    latestResultFolderInfo = folderInfo(latestResultFolderIdx);
                    latestResultFolderFiles = dir([folder filesep latestResultFolderInfo.name]);
                    
                    if any(strcmpi({latestResultFolderFiles.name},'result.mat'))
                        result = load([folder filesep latestResultFolderInfo.name filesep 'result.mat']);
                    else
                        latestResultFolderIdx = latestResultFolderIdx - 1;
                        continue;
                    end
                    
                    if isfield(result,'Result')
                        result = result.Result;
                    elseif isfield(result,'result')
                        result = result.result;
                    else
                        latestResultFolderIdx = latestResultFolderIdx - 1;
                        continue;
                    end
                    
                    self.testListBox.Data(idx, self.COLUMN_DATE) = {latestResultFolderInfo.date};
                    if(result.passed)
                        self.testListBox.Data(idx, self.COLUMN_RESULT) = {self.SetBackground('','green')};
                    else
                        self.testListBox.Data(idx, self.COLUMN_RESULT) = {self.SetBackground('','red')};
                    end
                    break;
                end
            end
        end
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
                    delete(self.testCollection);
                    self.testCollectionIndices = [];
                end
                [~, name, ~] = fileparts(fileName);
                
                addpath(pathName);
                
                testCollectionFuncHandle = str2func(name);
                temp = testCollectionFuncHandle(self);
                
                if(isa(temp,'TestCollection'))
                    self.testCollection = temp;
                    self.testCollectionText.String = name;
                    if(~isempty(self.testListBox))
                        temp = cellfun(@(t) t.GetName, self.testCollection.GetTestCaseList(), 'UniformOutput', false);
                        self.testListBox.Data = cell(numel(temp),self.COLUMN_NUMBER_OF_COLUMNS);
                        self.testListBox.Data(:,self.COLUMN_TESTSELECTION) = {false};
                        self.testListBox.Data(:,self.COLUMN_NAME) = temp;
                        
                        for i=1:numel(temp)
                            self.UpdateResult(i);
                        end
                        
                        self.hObject.Position(3) = self.testListBox.Extent(3)+15;
                        self.testListBox.Position(3) = self.testListBox.Extent(3)+15;
                        self.testCollectionText.Position(1) =  self.hObject.Position(3)/2-self.testCollectionText.Position(3)/2;
                        
                        columnWidth = cell2mat(self.testListBox.ColumnWidth);
                        jUIScrollPane = findjobj(self.testListBox);
                        idxColumnWidth = jUIScrollPane.getComponent(4).getComponent(0).getWidth();
                        
                        self.selectAllCheckBox.Position(1) = idxColumnWidth + (columnWidth(1)/2-self.selectAllCheckBox.Position(3)/2) +2;
                    end
                end
            end
        end
    end
    
end

