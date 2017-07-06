classdef Measurement < handle
    
    properties(Access = private)
        enableLogging;
    end
    
    properties(Access = protected)
        upx;
        tm;
        enum;
        subsystem;
        buffer;
        isTraceData;
        traceLogX = [];
        traceLogY = [];
        logIdx = 1;
        numLog;
    end
    properties
        
        lineHandle;
        anno;
        
        % Numeric display variables
        measurement;
        channel;
        preMeasFunction;
        postMeasFunction;
    end
    
    methods
        
        function self = Measurement(upx)
            self.upx = upx;
            self.enum = InstrumentDrivers.rsupvConstants;
            self.tm = timer;
        end
        
        function delete(self)
            delete(self.tm)
        end
        
        function EnableLogging(self, enableLogging)
            self.enableLogging = enableLogging;
        end
        
        function ClearLog(self)
            self.numLog = [];
            self.traceLogX = [];
            self.traceLogY = [];
            self.logIdx = 1;
        end
        
        function [traceLogX, traceLogY] = GetTraceLog(self)
            traceLogX = self.traceLogX;
            traceLogY = self.traceLogY;
        end
        
        function numLog = GetNumLog (self)
            numLog = self.numLog;
        end
        function tm = GetTimer(self)
            tm = self.tm;
        end
        
        function StartMeasurement(self, period, buffer, lineHandle, anno)
            self.buffer = buffer;
            self.lineHandle = lineHandle;
            self.anno = anno;
            self.tm.ExecutionMode = 'fixedRate';
            self.tm.Period = period;
            self.tm.TimerFcn = @self.timerCallback;
            self.tm.BusyMode = 'queue';
            self.tm.UserData = self;
            self.upx.StartMeasurementWaitOPC(15000);
            start(self.tm)
        end
        
        function StopMeasurement(self)
            stop(self.tm);
            self.upx.MeasurementControl(self.enum.MeasStop);
        end
        
        
        function timerCallback(self, ~, ~)
            if(~isempty(self.preMeasFunction))
                self.preMeasFunction(self)
            end
            if(self.isTraceData)
                % Read the trace data of Ax
                self.upx.ReadTraceDataSets(self.subsystem, 1, self.enum.DataSetAx, self.buffer.Length, self.buffer);
                x = self.buffer.double;
                
                % Read the trace data of Ay
                self.upx.ReadTraceDataSets(self.subsystem, 1, self.enum.DataSetAy, self.buffer.Length, self.buffer);
                y = self.buffer.double;
                
                if(self.enableLogging)
                    self.traceLogX(:, self.logIdx) = x';
                    self.traceLogY(:, self.logIdx) = y';
                    self.logIdx = self.logIdx + 1;
                end
                if(isgraphics(self.lineHandle,'line') )
                    self.lineHandle.XData = x;
                    self.lineHandle.YData = y;
                end
            else
                [~, measurementResult, units] = self.upx.ReadMeasurementResult(self.channel, self.measurement);
                
                if(isgraphics(self.lineHandle,'line') )
                    self.lineHandle.YData = [measurementResult measurementResult];
                end
                if(isgraphics(self.lineHandle,'bar') )
                    self.lineHandle.YData = measurementResult;
                end
                if(isgraphics(self.anno,'legend') )
                    self.anno.String = [num2str(measurementResult) ' ' units];
                end
                
                if(self.enableLogging)
                    if(isempty(self.numLog))
                        self.numLog{1, 1} = measurementResult;
                        self.numLog{1, 2} = units;
                    else
                        self.numLog{end + 1, 1} = measurementResult;
                        self.numLog{end, 2} = units;
                    end
                end
            end
            if(~isempty(self.postMeasFunction))
                self.postMeasFunction(self)
            end
        end
        
    end
end