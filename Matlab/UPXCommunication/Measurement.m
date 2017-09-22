classdef Measurement < handle
    
    properties(Access = private)
        enableLogging;
        
        numericalMeasIdx = 1;
        traceMeasIdx = 1;
        
        % Frequency/Phase
        freqPhase;
        freqPhaseMeasTime;
        
        % Monitor
        levelMonitor;
        inputMonitor;
        
        % Waveform
        waveform;
        measMode;
        traceLength;
        triggerChannel;
        triggerSource;
        triggerLevel;
        triggerSlope;
        pretrigger;
        autoTrigger;
        
        % BarGraph
        barGraph;
    end
    
    properties(Access = protected)
        upx;
        tm;
        enum;
        
        numericalMeasurementList;
        traceMeasurementList;
        
        functionMeasListIdx;
        levelMonitorMeasListIdx;
        inputMonitorMeasListIdx;
        frequencyMeasListIdx;
        phaseGroupDelayMeasListIdx;
        
        waveformMeasListIdx;
        barGraphMeasListIdx;
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
            'postMeasFunction', []);
        
        traceMeasurement = struct( ...
            'enable', [], ...
            'subsystem', [], ...
            'subsystemNumber', [], ...
            'dataSet', [], ...
            'buffer', [], ...
            'logX', [], ...
            'logY', [], ...
            'countX', [], ...
            'countY', [], ...
            'graphicsHandle', [], ...
            'postMeasFunction', []);
    end
    properties(Access = public)

    end
    
    methods(Access = protected)
        %% Numerical Measurements
        function idx = AddNumericalMeasurement(self, channel, measurement, graphicsHandle, enable)
            if(isempty(self.numericalMeasurementList))
                self.numericalMeasurementList = self.numericalMeasurement; % adds new struct to vector
            else
                self.numericalMeasurementList(end + 1) = self.numericalMeasurement; % adds new struct to vector
            end
            self.numericalMeasurementList(end).channel = channel; % assigns value to the new struct
            self.numericalMeasurementList(end).measurement = measurement;
            self.numericalMeasurementList(end).graphicsHandle = graphicsHandle;
            self.numericalMeasurementList(end).enable = enable;
            idx = length(self.numericalMeasurementList);
        end
        
        function SetNumericalPostMeasFunction(self, idx, postMeasFunction)
            self.numericalMeasurementList(idx).postMeasFunction = postMeasFunction;
        end
        
        function SetNumericalGraphicsHandle(self, idx, graphicsHandle)
            self.numericalMeasurementList(idx).graphicsHandle = graphicsHandle;
        end
        
        function SetNumericalEnable(self, idx, enable)
            self.numericalMeasurementList(idx).enable = enable;
        end
        
        %% Trace Measurements
        function idx = AddTraceMeasurement(self, subsystem, subsystemNumber, dataSet, bufferSize, graphicsHandle, enable)
            if(isempty(self.traceMeasurementList))
                self.traceMeasurementList = self.traceMeasurement; % adds new struct to vector
            else
                self.traceMeasurementList(end + 1) = self.traceMeasurement; % adds new struct to vector
            end
            self.traceMeasurementList(end).subsystem = subsystem;
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
        
        function SetTracePostMeasFunction(self, idx, postMeasFunction)
            self.traceMeasurementList(idx).postMeasFunction = postMeasFunction;
        end
        
        function SetTraceGraphicsHandle(self, idx, graphicsHandle)
            self.traceMeasurementList(idx).graphicsHandle = graphicsHandle;
        end
        
        function SetTraceEnable(self, idx, enable)
            self.traceMeasurementList(idx).enable = enable;
        end
        
        function [traceLogX, traceLogY] = GetTraceLog(self, idx)
            traceLogX = self.traceMeasurementList(idx).logX;
            traceLogY = self.traceMeasurementList(idx).logY;
        end
        
        function numLog = GetNumLog(self, idx)
            numLog = self.numericalMeasurementList(idx).log;
        end
        
    end
    methods
        %% Get Setup
        function [freqPhase, freqPhaseMeasTime] = GetFrequencyPhaseSetup(self)
            [~, freqPhase] = self.upx.GetAnalyzerCombinedMeasurement;
            [~, freqPhaseMeasTime] = self.upx.GetAnalyzerMeasurementTime;
        end
        
        function [levelMonitor, inputMonitor] = GetMonitorSetup(self)
            [~, levelMonitor] = self.upx.GetAnalyzerLevelMonitor;
            [~, inputMonitor] = self.upx.GetAnalyzerInputMonitor;
        end
        
        function [waveform, measMode, traceLength, triggerChannel, triggerSource, triggerLevel, triggerSlope, pretrigger, autoTrigger] = GetWaveformSetup(self)
            [~, waveform] = self.upx.GetAnalyzerWaveformMonitorState;
            [~, measMode] = self.upx.GetAnalyzerWaveformMonitorMeasMode;
            [~, traceLength] = self.upx.GetAnalyzerWaveformMonitorTraceLength;
            [~, triggerChannel] = self.upx.GetMultichannelAnalyzerTriggerChannel;
            [~, triggerSource] = self.upx.GetAnalyzerWaveformMonitorTriggerSource;
            [~, triggerLevel] = self.upx.GetAnalyzerWaveformMonitorTriggerLevel;
            [~, triggerSlope] = self.upx.GetAnalyzerWaveformMonitorTriggerSlope;
            [~, pretrigger] = self.upx.GetAnalyzerWaveformMonitorPretrigger;
            [~, autoTrigger] = self.upx.GetAnalyzerWaveformMonitorAutotrigger;
        end
        
        function barGraph = GetBarGraphSetup(self)
            [~, barGraph] = self.upx.GetAnalyzerBargraphState();
        end
        
        function GetSetup(self)
            [self.freqPhase, self.freqPhaseMeasTime] = self.GetFrequencyPhaseSetup();
            [self.levelMonitor, self.inputMonitor] = self.GetMonitorSetup();
            [self.waveform, ...
                self.measMode, ...
                self.traceLength, ...
                self.triggerChannel, ...
                self.triggerSource, ...
                self.triggerLevel, ...
                self.triggerSlope, ...
                self.pretrigger, ...
                self.autoTrigger] = self.GetWaveformSetup();
            self.barGraph = self.GetBarGraphSetup();
        end
        
        %% Set Setup
        function SetFrequencyPhaseSetup(self, freqPhase, freqPhaseMeasTime)
            self.upx.SetAnalyzerCombinedMeasurement(freqPhase);
            self.upx.SetAnalyzerMeasurementTime(freqPhaseMeasTime);
        end
        
        function SetMonitorSetup(self, levelMonitor, inputMonitor)
            self.upx.SetAnalyzerLevelMonitor(levelMonitor);
            self.upx.SetAnalyzerInputMonitor(inputMonitor);
        end
        
        function SetWaveformSetup(self, waveform, measMode, traceLength, triggerChannel, triggerSource, triggerLevel, triggerSlope, pretrigger, autoTrigger)
            self.upx.SetAnalyzerWaveformMonitorState(waveform);
            if(waveform ~= false)
                self.upx.SetAnalyzerWaveformMonitorMeasMode(measMode);
                self.upx.SetAnalyzerWaveformMonitorTraceLength(traceLength);
                [~, bandWidthEnum] = self.upx.GetAnalyzerBandwidth;
                switch bandWidthEnum
                    case self.enum.AnalyzerBwidth22
                        self.SetTraceBuffer(self.waveformMeasListIdx, 48000*traceLength)
                    case self.enum.AnalyzerBwidth40
                        self.SetTraceBuffer(self.waveformMeasListIdx, 96000*traceLength)
                    case self.enum.AnalyzerBwidth80
                        self.SetTraceBuffer(self.waveformMeasListIdx, 192000*traceLength)
                    case self.enum.AnalyzerBwidth250
                        self.SetTraceBuffer(self.waveformMeasListIdx, 768000*traceLength)
                end
                self.upx.SetMultichannelAnalyzerTriggerChannel(triggerChannel);
                % the following commands throw an exeption
                %                 self.upx.SetAnalyzerWaveformMonitorTriggerSource(self.triggerSource);
                %                 self.upx.SetAnalyzerWaveformMonitorTriggerLevel(self.triggerLevel);
                %                 self.upx.SetAnalyzerWaveformMonitorTriggerSlope(self.triggerSlope);
                %                 self.upx.SetAnalyzerWaveformMonitorPretrigger(self.pretrigger);
                %                 self.upx.SetAnalyzerWaveformMonitorAutotrigger(self.autoTrigger)
            end
        end
        
        function SetBarGraphSetup(self, barGraph)
            [~, func] = self.upx.GetAnalyzerFunction();
            switch func
                case self.enum.AnalyzerFuncThd
                    self.SetTraceBuffer(self.barGraphMeasListIdx, 9)
                    self.upx.SetAnalyzerBargraphState(logical(barGraph));
                case self.enum.AnalyzerFuncMdis
                    self.SetTraceBuffer(self.barGraphMeasListIdx, 6)
                    self.upx.SetAnalyzerBargraphState(logical(barGraph));
                case self.enum.AnalyzerFuncDfd
                    self.SetTraceBuffer(self.barGraphMeasListIdx, 5)
                    self.upx.SetAnalyzerBargraphState(logical(barGraph));
            end
        end
        
        function SetSetup(self)
            %             self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncOff);
            self.SetFrequencyPhaseSetup(self.freqPhase, self.freqPhaseMeasTime)
            self.SetMonitorSetup(self.levelMonitor, self.inputMonitor)
            self.SetWaveformSetup(self.waveform, ...
                self.measMode, ...
                self.traceLength, ...
                self.triggerChannel, ...
                self.triggerSource, ...
                self.triggerLevel, ...
                self.triggerSlope, ...
                self.pretrigger, ...
                self.autoTrigger);
            self.SetBarGraphSetup(self.barGraph);
        end
        
        %% Frequency Phase Measurement
        function FrequencyPhaseMeasurementEnable(self, enable, channel, combinedMeasurement, graphicsHandle)
            if nargin > 2;
                self.upx.SetAnalyzerCombinedMeasurement(combinedMeasurement);
                self.numericalMeasurementList(self.frequencyMeasListIdx).channel = channel;
                self.numericalMeasurementList(self.frequencyMeasListIdx).graphicsHandle = graphicsHandle;
            end
            self.numericalMeasurementList(self.frequencyMeasListIdx).enable = enable;
        end
        
        %% Level Monitor
        function LevelMonitorEnable(self, enable, channel, levelMonitor, graphicsHandle)
            if nargin > 2;
                self.upx.SetAnalyzerLevelMonitor(levelMonitor);
                self.levelMonitor = levelMonitor;
                self.numericalMeasurementList(self.levelMonitorMeasListIdx).channel = channel;
                self.numericalMeasurementList(self.levelMonitorMeasListIdx).graphicsHandle = graphicsHandle;
            end
            self.numericalMeasurementList(self.levelMonitorMeasListIdx).enable = enable;
        end
        
        %% Input Monitor
        function InputMonitorEnable(self, enable, channel, inputMonitor, graphicsHandle)
            if nargin > 2;
                self.inputMonitor = inputMonitor;
                self.upx.SetAnalyzerInputMonitor(inputMonitor);
                self.numericalMeasurementList(self.inputMonitorMeasListIdx).channel = channel;
                self.numericalMeasurementList(self.inputMonitorMeasListIdx).graphicsHandle = graphicsHandle;
            end
            self.numericalMeasurementList(self.inputMonitorMeasListIdx).enable = enable;
            
        end
        
        %% Waveform
        function WaveformEnable(self, enable, graphicsHandle)
            if nargin > 2;
                self.traceMeasurementList(self.waveformMeasListIdx).graphicsHandle = graphicsHandle;
            end
            self.waveform = enable;
            
            self.SetWaveformSetup(self.waveform, ...
                self.measMode, ...
                self.traceLength, ...
                self.triggerChannel, ...
                self.triggerSource, ...
                self.triggerLevel, ...
                self.triggerSlope, ...
                self.pretrigger, ...
                self.autoTrigger);
            
            self.traceMeasurementList(self.waveformMeasListIdx).enable = enable;
        end
        
        %% BarGraph
        function BarGraphEnable(self, enable, graphicsHandle)
            if nargin > 2;
                self.traceMeasurementList(self.barGraphMeasListIdx).graphicsHandle = graphicsHandle;
            end
            self.traceMeasurementList(self.barGraphMeasListIdx).enable = enable;
            self.SetBarGraphSetup(enable)
        end
        
        %% Constructor
        function self = Measurement(upx)
            self.upx = upx;
            self.enum = InstrumentDrivers.rsupvConstants;
            self.tm = timer;
            
            self.functionMeasListIdx        = self.AddNumericalMeasurement(1, self.enum.MeasurementFunction, [], false);
            self.levelMonitorMeasListIdx    = self.AddNumericalMeasurement(1, self.enum.MeasurementLevelMonitor, [], false);
            self.inputMonitorMeasListIdx    = self.AddNumericalMeasurement(1, self.enum.MeasurementInputMonitor, [], false);
            self.frequencyMeasListIdx       = self.AddNumericalMeasurement(1, self.enum.MeasurementFrequency, [], false);
            self.phaseGroupDelayMeasListIdx = self.AddNumericalMeasurement(1, self.enum.MeasurementPhaseGrpDelay, [], false);
            
            self.waveformMeasListIdx = self.AddTraceMeasurement(self.enum.DispSubsysWav, 1, [self.enum.DataSetAx self.enum.DataSetAy], 0, [], false);
            self.barGraphMeasListIdx = self.AddTraceMeasurement(self.enum.DispSubsysBar, 1, [self.enum.DataSetAx self.enum.DataSetAy], 0, [], false);
        end
        
        function delete(self)
            delete(self.tm)
        end
        
        function EnableLogging(self, enable)
            self.enableLogging = enable;
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
        
        function numLog = GetFrequencyNumLog(self)
            numLog = self.numericalMeasurementList(self.levelMonitorMeasListIdx).log;
        end
        
        function numLog = GetLevelMonitorNumLog(self)
            numLog = self.numericalMeasurementList(self.levelMonitorMeasListIdx).log;
        end
        
        function numLog = GetInputMonitorNumLog(self)
            numLog = self.numericalMeasurementList(self.inputMonitorMeasListIdx).log;
        end
        
        function [traceXLog, traceYLog, countXLog, countYLog] = GetWaveformTraceLog(self)
            traceXLog = self.traceMeasurementList(self.waveformMeasListIdx).logX;
            traceYLog = self.traceMeasurementList(self.waveformMeasListIdx).logY;
            
            countXLog = self.traceMeasurementList(self.waveformMeasListIdx).countX;
            countYLog = self.traceMeasurementList(self.waveformMeasListIdx).countY;
        end
        
        function [traceXLog, traceYLog, countXLog, countYLog] = GetBarGraphTraceLog(self)
            traceXLog = self.traceMeasurementList(self.waveformMeasListIdx).logX;
            traceYLog = self.traceMeasurementList(self.waveformMeasListIdx).logY;
            
            countXLog = self.traceMeasurementList(self.waveformMeasListIdx).countX;
            countYLog = self.traceMeasurementList(self.waveformMeasListIdx).countY;
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
            %             tic
            for i = 1:length(self.traceMeasurementList)
                if(self.traceMeasurementList(i).enable)
                    
                    % Check if there is enough data to fill the buffer. 
                    % Yes it is annoying that we have to wait for the upx
                    % to be ready with data, but if we don't wait we might
                    % get corrupted data
                    
                    countX = 0;
                    countY = 0;
                    
                    while(countX < self.traceMeasurementList(i).buffer.Length || countY < self.traceMeasurementList(i).buffer.Length)
                        [~, countX] = self.upx.ReadTraceDataSetCount( ...
                            self.traceMeasurementList(i).subsystem, ...
                            self.traceMeasurementList(i).subsystemNumber, ...
                            self.traceMeasurementList(i).dataSet(1));
                        [~, countY] = self.upx.ReadTraceDataSetCount( ...
                            self.traceMeasurementList(i).subsystem, ...
                            self.traceMeasurementList(i).subsystemNumber, ...
                            self.traceMeasurementList(i).dataSet(2));
                        pause(0.01);
                    end
                    
                    % Read the trace data x
                    statusX = self.upx.ReadTraceDataSets( ...
                        self.traceMeasurementList(i).subsystem, ...
                        self.traceMeasurementList(i).subsystemNumber, ...
                        self.traceMeasurementList(i).dataSet(1), ...
                        self.traceMeasurementList(i).buffer.Length, ...
                        self.traceMeasurementList(i).buffer);
                    
                    x = self.traceMeasurementList(i).buffer.double;
                    if statusX ~= 0 || all(x == 0)
                        warning(['Trace x measurement error: ' num2str(statusX)])
                    end
                    
                    % Read the trace data of y
                    statusY = self.upx.ReadTraceDataSets( ...
                        self.traceMeasurementList(i).subsystem, ...
                        self.traceMeasurementList(i).subsystemNumber, ...
                        self.traceMeasurementList(i).dataSet(2), ...
                        self.traceMeasurementList(i).buffer.Length, ...
                        self.traceMeasurementList(i).buffer);
                    
                    y = self.traceMeasurementList(i).buffer.double;
                    if statusY ~= 0 || all(y == 0)
                        warning(['Trace y measurement error: ' num2str(statusY)])
                    end
                    
                    if(~isempty(self.traceMeasurementList(i).postMeasFunction))
                        self.traceMeasurementList(i).postMeasFunction(x, y)
                    end
                    
                    if(self.enableLogging)
                        self.traceMeasurementList(i).countX(self.traceMeasIdx) = countX;
                        self.traceMeasurementList(i).countY(self.traceMeasIdx) = countY;
                        self.traceMeasurementList(i).logX(:, self.traceMeasIdx) = x';
                        self.traceMeasurementList(i).logY(:, self.traceMeasIdx) = y';
                        self.traceMeasIdx = self.traceMeasIdx + 1;
                    end
                    if ~isempty(self.traceMeasurementList(i).graphicsHandle)
                        if(isgraphics(self.traceMeasurementList(i).graphicsHandle,'line') || ...
                                isgraphics(self.traceMeasurementList(i).graphicsHandle, 'bar') || ...
                                isgraphics(self.traceMeasurementList(i).graphicsHandle,'stem'))
                            self.traceMeasurementList(i).graphicsHandle.XData = x;
                            self.traceMeasurementList(i).graphicsHandle.YData = y;
                        end
                    end
                    
                end
            end
            
            for i = 1:length(self.numericalMeasurementList)
                if(self.numericalMeasurementList(i).enable)
                    [status, measurementResult, units] = self.upx.ReadMeasurementResult(self.numericalMeasurementList(i).channel, self.numericalMeasurementList(i).measurement);
                    
                    if status ~= 0;
                        warning(['Numerical measurement error: ' num2str(status)])
                    end
                    
                    if(~isempty(self.numericalMeasurementList(i).postMeasFunction))
                        self.numericalMeasurementList(i).postMeasFunction(measurementResult, units)
                    end
                    
                    if ~isempty(self.numericalMeasurementList(i).graphicsHandle)    
                        if(isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'line') )
                            self.lineHandle.YData = [measurementResult measurementResult];
                            
                        elseif(isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'bar') )
                            self.lineHandle.YData = measurementResult;
                            
                        elseif(isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'legend') || ...
                                isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'uicontrol') || ...
                                isgraphics(self.numericalMeasurementList(i).graphicsHandle, 'textboxshape'))
                            self.numericalMeasurementList(i).graphicsHandle.String = [self.numericalMeasurementList(i).graphicsHandle.UserData num2str(measurementResult) ' ' units];
                        end
                    end
                    if(self.enableLogging)
                        self.numericalMeasurementList(i).log{end + 1, 1} = measurementResult;
                        self.numericalMeasurementList(i).log{end, 2} = units;
                    end
                    
                end
            end
            %             toc
        end
    end
end