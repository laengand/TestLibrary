classdef RMSMeasurement < Measurement
    
    properties(Access = private) 
        
        snSequence; % not sure if this variable and the next is related
        measTime;
        
        filter1;
        filter2;
        fnctSettling;
        fnctSettlingSamples;
        fnctSettlingTolerance;
        fnctSettlingResolution;
        fnctSettlingTimeout;
        
        rmsMeasIdx;
    end
    
    methods
        function self = RMSMeasurement(upx)
            self = self@Measurement(upx);
            self.tm.Name = [mfilename 'Timer'];
            self.rmsMeasIdx = self.AddNumericalMeasurement(1, self.enum.MeasurementFunction, [], true);
        end
        
        function SetFilters(self, filter1, filter2)
            self.filter1 = filter1;
            self.filter2 = filter2;
        end
        
        function SetFunctionSettling(self, fnctSettling, samples, tolerance, resolution, timeout)
            self.fnctSettling = fnctSettling;
            self.fnctSettlingSamples = samples;
            self.fnctSettlingTolerance = tolerance;
            self.fnctSettlingResolution = resolution;
            self.fnctSettlingTimeout = timeout;
        end
        
        function GetSetup(self)
            % GetSetup
            % Gets the current RMS Setup in the Analyzer Function window
            self.GetSetup@Measurement;
            [~, self.snSequence] = self.upx.GetAnalyzerSNSequenceState;
            if(self.snSequence)
                [~, self.measTime] = self.upx.GetAnalyzerSNMeasTime;
            end
            [~, self.filter1] = self.upx.GetAnalyzerFilter(1);
            [~, self.filter2] = self.upx.GetAnalyzerFilter(2);
            
            [~, self.fnctSettling] = self.upx.GetMeasurementFunctionsSettling;
            if(self.fnctSettling ~= self.enum.MeasFuncSettlingOff)
                [~, self.fnctSettlingSamples] = self.upx.GetMeasurementFunctionSettlingCount;
                [~, self.fnctSettlingTolerance] = self.upx.GetMeasurementFunctionSettlingTolerance;
                [~, self.fnctSettlingResolution] = self.upx.GetMeasurementFunctionSettlingResolution;
                [~, self.fnctSettlingTimeout] = self.upx.GetMeasurementFunctionSettlingTimeout;
            end
        
        end
        
        function SetSetup(self)
            % SetSetup
            % Sets the RMS Setup in the Analyzer Function window
            self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncRms);
            self.SetSetup@Measurement;
            self.upx.SetAnalyzerSNSequenceState(self.snSequence);
            if(self.snSequence)
                self.upx.SetAnalyzerSNMeasTime(self.measTime);
            end
            self.upx.SetAnalyzerFilter(1, self.filter1);
            self.upx.SetAnalyzerFilter(2, self.filter2);
            
            self.upx.SetMeasurementFunctionsSettling(self.fnctSettling);
            if(self.fnctSettling ~= self.enum.MeasFuncSettlingOff)
                self.upx.SetMeasurementFunctionSettlingCount(self.fnctSettlingSamples);
                self.upx.SetMeasurementFunctionSettlingTolerance(self.fnctSettlingTolerance);
                self.upx.SetMeasurementFunctionSettlingResolution(self.fnctSettlingResolution);
                self.upx.SetMeasurementFunctionSettlingTimeout(self.fnctSettlingTimeout);
            end
        end
        
        function SetRmsGraphicsHandle(self, graphicsHandle)
            self.SetNumericalGraphicsHandle(self.rmsMeasIdx, graphicsHandle);
        end
        
        function numLog = GetRmsNumLog(self)
            numLog = self.numericalMeasurementList(self.rmsMeasIdx).log;
        end
    end
    
end

