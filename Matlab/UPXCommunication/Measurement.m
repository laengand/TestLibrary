classdef Measurement < handle
    
    properties(Access = private)
        enableLogging;
        levelMonitor;
        %         secondMonitor;
        inputMonitor;
        numericalMeasIdx = 1;
        traceMeasIdx = 1;
        
    end
    
    properties(Access = protected)
        upx;
        tm;
        enum;
        %         subsystem;
        %         buffer;
        %         isTraceData;
        %         traceLogX = [];
        %         traceLogY = [];
        %         logIdx = 1;
        %         numLog;
        numericalMeasurementList;
        traceMeasurementList;
        
        functionMeasListIdx;
        levelMonitorRmsMeasListIdx;
        levelMonitorDcMeasListIdx;
        levelMonitorPeakMeasListIdx;
        inputMonitorMeasListIdx;
        frequencyMeasListIdx;
        phaseGroupDelayMeasListIdx;
    end
    
    properties(Constant)
        functionIdx = 1;
        levelMonitorIdx = 2;
        inputMonitorIdx = 3;
        frequencyIdx = 4;
        phaseGroupDelayIdx = 5;
        
        sweepGraphIdx = 1;
        fftGraphIdx = 2;
        waveformIdx = 3;
        barGraphIdx = 4;
        
        numericalMeasurement = struct( ...
            'enable', [], ...        
            'channel', [], ...
            'measurement', [], ...
            'log', [], ...
            'graphicsHandle', [], ...
            'preMeasFunction', []);
        
        traceMeasurement = struct( ...
            'enable', [], ...
            'subsystem', [], ...
            'subsystemNumber', [], ...
            'dataSet', [], ...
            'buffer', [], ...
            'logX', [], ...
            'logY', [], ...
            'graphicsHandle', []);
            
    end
    properties
        
        %         lineHandle;
        %         anno;
        
        % Numeric display variables
        %         measurement;
        %         channel;
        preMeasFunction;
        postMeasFunction;
        
    end
    methods(Access = protected)
        
        function idx = AddNumericalMeasurement(self, channel, measurement, graphicsHandle, enable)
            if(isempty(self.numericalMeasurementList))
                self.numericalMeasurementList = self.numericalMeasurement; % adds new struct to vector
            else
                self.numericalMeasurementList(end + 1) = self.numericalMeasurement; % adds new struct to vector
            end
            self.numericalMeasurementList(end).channel = channel; % adds new struct to vector
            self.numericalMeasurementList(end).measurement = measurement; % assigns value to the new struct
            self.numericalMeasurementList(end).graphicsHandle = graphicsHandle;
            self.numericalMeasurementList(end).enable = enable;
            idx = length(self.numericalMeasurementList);
        end
        
        function idx = AddTraceMeasurement(self, subsystem, subsystemNumber, dataSet, bufferSize, graphicsHandle, enable)
            if(isempty(self.traceMeasurementList))
                self.traceMeasurementList = self.traceMeasurement; % adds new struct to vector
            else
                self.traceMeasurementList(end + 1) = self.traceMeasurement; % adds new struct to vector
            end
            self.traceMeasurementList(end).subsystem = subsystem; % adds new struct to vector
            self.traceMeasurementList(end).subsystemNumber = subsystemNumber; % assigns value to the new struct
            self.traceMeasurementList(end).dataSet = dataSet;
            if(bufferSize > 0)
                buffer = NET.createArray('System.Double', bufferSize);
            else
                buffer = [];
            end
            self.traceMeasurementList(end).buffer = buffer;
            self.traceMeasurementList(end).graphicsHandle = graphicsHandle;
            self.traceMeasurementList(end).enable = enable;
            idx = length(self.traceMeasurementList);
        end
        
        function SetTraceBuffer(self, idx, bufferSize)
            buffer = NET.createArray('System.Double', bufferSize);
            self.traceMeasurementList(idx).buffer = buffer;
        end
        
        function SetTraceGraphicsHandle(self, idx, graphicsHandle)
            self.traceMeasurementList(idx).graphicsHandle = graphicsHandle;
        end
        
        function SetTraceEnable(self, idx, enable)
            self.traceMeasurementList(idx).enable = enable;
        end
        
    end
    methods
        function GetSetup(self)
            [~, self.levelMonitor] = self.upx.GetAnalyzerLevelMonitor;
            [~, self.inputMonitor] = self.upx.GetAnalyzerInputMonitor;
        end
        
        function SetSetup(self)
            if(self.levelMonitor ~= self.enum.AnalyzerLevMonOff)
                self.upx.SetAnalyzerLevelMonitor(self.levelMonitor);
            end
            if(self.levelMonitor ~= self.enum.AnalyzerInputMonOff)
                self.upx.SetAnalyzerInputMonitor(self.inputMonitor);
            end
            
        end
        
        function FrequencyPhaseMeasurementEnable(self, enable, channel, combinedMeasurement, graphicsHandle)
            if nargin > 2;
                self.upx.SetAnalyzerCombinedMeasurement(combinedMeasurement);
                self.numericalMeasurementList(self.frequencyMeasListIdx).channel = channel;
                self.numericalMeasurementList(self.frequencyMeasListIdx).graphicsHandle = graphicsHandle;
            end
            self.numericalMeasurementList(self.frequencyMeasListIdx).enable = enable;
        end
        
        %% Level Monitor
        % RMS
        function LevelMonitorRmsEnable(self, enable, channel, graphicsHandle)
            if nargin > 2;
                self.LevelMonitorEnable(enable, self.levelMonitorRmsMeasListIdx, channel, graphicsHandle, @self.LevelMonitorRmsPreMeas);
            else
                self.LevelMonitorEnable(enable, self.levelMonitorRmsMeasListIdx);
            end 
        end
        
        function LevelMonitorRmsPreMeas(self, obj)
            obj.upx.SetAnalyzerLevelMonitor(self.enum.AnalyzerLevMonRms);
        end
        
        % DC
        function LevelMonitorDCEnable(self, enable, channel, graphicsHandle)
            if nargin > 2;
                self.LevelMonitorEnable(enable, self.levelMonitorDcMeasListIdx, channel, graphicsHandle, @self.LevelMonitorDCPreMeas);
            else
                self.LevelMonitorEnable(enable, self.levelMonitorDcMeasListIdx);
            end 
        end
        
        function LevelMonitorDCPreMeas(self, obj)
            obj.upx.SetAnalyzerLevelMonitor(self.enum.AnalyzerLevMonDc);
        end
        
        % Peak
        function LevelMonitorPeakEnable(self, enable, channel, graphicsHandle)
            if nargin > 2;
                self.LevelMonitorEnable(enable, self.levelMonitorPeakMeasListIdx, channel, graphicsHandle, @self.LevelMonitorPeakPreMeas);
            else
                self.LevelMonitorEnable(enable, self.levelMonitorPeakMeasListIdx);
            end 
        end
        
        function LevelMonitorPeakPreMeas(self, obj)
            obj.upx.SetAnalyzerLevelMonitor(self.enum.AnalyzerLevMonImax);
        end
        
        function LevelMonitorEnable(self, enable, idx, channel, graphicsHandle, preMeasFunction)
            if nargin > 3;
                self.numericalMeasurementList(idx).channel = channel;
                self.numericalMeasurementList(idx).graphicsHandle = graphicsHandle;
                self.numericalMeasurementList(idx).preMeasFunction = preMeasFunction;
            end
            self.numericalMeasurementList(idx).enable = enable;
        end
        %% Constructor
        function self = Measurement(upx)
            self.upx = upx;
            self.enum = InstrumentDrivers.rsupvConstants;
            self.tm = timer;
            
        
            self.AddNumericalMeasurement(1, self.enum.MeasurementFunction, [], false);
            self.levelMonitorRmsMeasListIdx  = self.AddNumericalMeasurement(1, self.enum.MeasurementLevelMonitor, [], false);
            self.levelMonitorDcMeasListIdx   = self.AddNumericalMeasurement(1, self.enum.MeasurementLevelMonitor, [], false);
            self.levelMonitorPeakMeasListIdx = self.AddNumericalMeasurement(1, self.enum.MeasurementLevelMonitor, [], false);
            self.inputMonitorMeasListIdx     = self.AddNumericalMeasurement(1, self.enum.MeasurementInputMonitor, [], false);
            self.frequencyMeasListIdx        = self.AddNumericalMeasurement(1, self.enum.MeasurementFrequency, [], false);
            self.AddNumericalMeasurement(1, self.enum.MeasurementPhaseGrpDelay, [], false);
            
        end
        
        function delete(self)
            delete(self.tm)
        end
        
        function EnableLogging(self, enableLogging)
            self.enableLogging = enableLogging;
        end
        
        function ClearLog(self)
            for i=1:length(self.numericalMeasurementList)
                self.numericalMeasurementList(i).log = {};
            end
            for i = 1:length(self.traceMeasurementList)
                self.traceMeasurementList(i).logX = [];
                self.traceMeasurementList(i).logY = [];
            end
            
            self.traceMeasIdx = 1;
        end
        
        function [traceLogX, traceLogY] = GetTraceLog(self, idx)
            traceLogX = self.traceMeasurementList(idx).logX;
            traceLogY = self.traceMeasurementList(idx).logY;
        end
        
        function numLog = GetNumLog (self, idx)
            numLog = self.numericalMeasurementList(idx).log;
        end
        function tm = GetTimer(self)
            tm = self.tm;
        end
        
        function StartMeasurement(self, period)

            self.tm.ExecutionMode = 'fixedRate';
            self.tm.Period = period;
            self.tm.TimerFcn = @self.TimerCallback;
            self.tm.BusyMode = 'queue';
            self.tm.UserData = self;
            self.upx.StartMeasurementWaitOPC(15000);
            start(self.tm)
        end
        
        function StopMeasurement(self)
            stop(self.tm);
            self.upx.MeasurementControl(self.enum.MeasStop);
        end
        
        
        function TimerCallback(self, ~, ~)
            if(~isempty(self.preMeasFunction))
                self.preMeasFunction(self);
            end
            
            for i = 1:length(self.traceMeasurementList)
                if(self.traceMeasurementList(i).enable)
                    % Read the trace data of Ax
                    self.upx.ReadTraceDataSets( ...
                        self.traceMeasurementList(i).subsystem, ...
                        self.traceMeasurementList(i).subsystemNumber, ...
                        self.traceMeasurementList(i).dataSet(1), ...
                        self.traceMeasurementList(i).buffer.Length, ...
                        self.traceMeasurementList(i).buffer);
                    
                    x = self.traceMeasurementList(i).buffer.double;
                    
                    % Read the trace data of Ay
                    %                 self.upx.ReadTraceDataSets(self.subsystem, 1, self.enum.DataSetAy, self.buffer.Length, self.buffer);
                    self.upx.ReadTraceDataSets( ...
                        self.traceMeasurementList(i).subsystem, ...
                        self.traceMeasurementList(i).subsystemNumber, ...
                        self.traceMeasurementList(i).dataSet(2), ...
                        self.traceMeasurementList(i).buffer.Length, ...
                        self.traceMeasurementList(i).buffer);
                    y = self.traceMeasurementList(i).buffer.double;
                    
                    if(self.enableLogging)
                        self.traceMeasurementList(i).logX(:, self.traceMeasIdx) = x';
                        self.traceMeasurementList(i).logY(:, self.traceMeasIdx) = y';
                        self.traceMeasIdx = self.traceMeasIdx + 1;
                    end
                    if(isgraphics(self.traceMeasurementList(i).graphicsHandle,'line') )
                        self.traceMeasurementList(i).graphicsHandle.XData = x;
                        self.traceMeasurementList(i).graphicsHandle.YData = y;
                    end
                end
            end
            
            for i = 1:length(self.numericalMeasurementList)
                if(self.numericalMeasurementList(i).enable)     
                    if (isa(self.numericalMeasurementList(i).preMeasFunction, 'function_handle'))
                        self.numericalMeasurementList(i).preMeasFunction(self);
                    end
                    
                    [status, measurementResult, units] = self.upx.ReadMeasurementResult(self.numericalMeasurementList(i).channel, self.numericalMeasurementList(i).measurement);
                    if status ~= 0;
                        warning(['Measurement error' num2str(status)])
                    end
                    disp([num2str(self.numericalMeasurementList(i).measurement) ': ' num2str(measurementResult) ' ' units])
                    if(isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'line') )
                        self.lineHandle.YData = [measurementResult measurementResult];
                        
                    elseif(isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'bar') )
                        self.lineHandle.YData = measurementResult;
                        
                    elseif(isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'legend') || ...
                            isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'uicontrol') || ...
                            isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'textboxshape'))
                        self.numericalMeasurementList(i).graphicsHandle.String = [num2str(measurementResult) ' ' units];
                    end
                    
                    if(self.enableLogging)
                        self.numericalMeasurementList(i).log{end + 1, 1} = measurementResult;
                        self.numericalMeasurementList(i).log{end, 2} = units;
                    end
                   
                end
            end
            
            if(~isempty(self.postMeasFunction))
                self.postMeasFunction(self)
            end
            drawnow;
        end
    end
end