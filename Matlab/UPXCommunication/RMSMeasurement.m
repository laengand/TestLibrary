classdef RMSMeasurement < Measurement
    
    properties(Access = private) 
        snSequence;
        measTime;
        filter1;
        filter2;
        fnctSettling;
        fnctSettlingSamples;
        fnctSettlingTolerance;
        fnctSettlingResolution;
        fnctSettlingTimeout;
        postFFT;
        freqPhase;
        freqPhaseMeasTime;
    end
    
    methods
        function self = RMSMeasurement(upx)
            self = self@Measurement(upx);
            self.isTraceData = false;
            self.measurement = self.enum.MeasurementFunction;
            self.tm.Name = [mfilename 'Timer'];
        end
        function GetSetup(self)
            % GetRMSSetup
            % Gets the current RMS Setup in the Analyzer Function window
            
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
            [~, self.postFFT] = self.upx.GetAnalyzerPostFFTState;
                        
            [~, self.freqPhase] = self.upx.GetAnalyzerCombinedMeasurement;
            [~, self.freqPhaseMeasTime] = self.upx.GetAnalyzerMeasurementTime;
            
        end
        function SetSetup(self)
            % SetRMSSetup
            % Sets the RMS Setup in the Analyzer Function window
            self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncRms);
            
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
            self.upx.SetAnalyzerPostFFTState(self.postFFT);
                        
            self.upx.SetAnalyzerCombinedMeasurement(self.freqPhase);
            self.upx.SetAnalyzerMeasurementTime(self.freqPhaseMeasTime);
            
        end
    end
    
end

