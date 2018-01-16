classdef RMSMeasurement < Measurement
    
    properties(Access = private) 
        snSequence;
        levelMeasTime;
        levelMeasTimeValue;
        levelMeasBandwidth;
        levelMeasBandwidthValue;
        levelMeasFrequencyMode;
        levelMeasFrequencyValue;
        levelMeasFrequencyFactor;
        filter1;
        filter2;
        fnctSettling;
        fnctSettlingSamples;
        fnctSettlingTolerance;
        fnctSettlingResolution;
        fnctSettlingTimeout;
        
        rmsMeasIdx;
        
        selective;
    end
    
    methods
        function self = RMSMeasurement(upx, selective)
            self = self@Measurement(upx);
            self.selective = selective;
            self.tm.Name = [mfilename 'Timer'];
            self.rmsMeasIdx = self.AddNumericalMeasurement(1, self.enum.MeasurementFunction, [], true);
        end

        function SetLevelMeasTime(self, levelMeasTime, levelMeasTimeValue)
            self.levelMeasTime = levelMeasTime;
            self.levelMeasTimeValue = levelMeasTimeValue;
            
            [~, func] = self.upx.GetAnalyzerFunction();
            if func == self.enum.AnalyzerFuncRmss || func == self.enum.AnalyzerFuncRms
                [~, self.levelMeasTime] = self.upx.GetAnalyzerLevelMeasTime();
                if self.levelMeasTime == self.enum.AnalyzerMeasTimeVal
                    [~, self.levelMeasTimeValue] = self.upx.GetAnalyzerLevelMeasTimeValue();
                end
            end
        end

        function SetLevelMeasBandwidth(self, levelMeasBandwidth, levelMeasBandwidthValue) 
            self.levelMeasBandwidth = levelMeasBandwidth;
            self.levelMeasBandwidthValue = levelMeasBandwidthValue;
        end

        function SetlevelMeasFrequency(self, levelMeasFrequencyMode, value)
            self.levelMeasFrequencyMode = levelMeasFrequencyMode;
            if self.levelMeasFrequencyMode == self.enum.AnalyzerMeasFmodeFix
                self.levelMeasFrequencyValue = value;
            end
            if self.levelMeasFrequencyMode == self.enum.AnalyzerMeasFmodeGent
                self.levelMeasFrequencyFactor = value;
            end
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
            if self.selective
                self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncRmss);
            else
                self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncRms);
            end
            
            if ~self.selective
                [~, self.snSequence] = self.upx.GetAnalyzerSNSequenceState;
            end
            [~, self.levelMeasTime] = self.upx.GetAnalyzerLevelMeasTime();
            if self.levelMeasTime == self.enum.AnalyzerMeasTimeVal
                [~, self.levelMeasTimeValue] = self.upx.GetAnalyzerLevelMeasTimeValue();
            end
            if self.selective
                    [~, self.levelMeasBandwidth] = self.upx.GetAnalyzerLevelMeasBandwidth();
                    if self.levelMeasBandwidth == self.enum.AnalyzerMeasBandPfix
                        [~, self.levelMeasBandwidthValue] = self.upx.GetAnalyzerLevelMeasBandwidthValue();
                    end
                    [~, self.levelMeasFrequencyMode] = self.upx.GetAnalyzerLevelMeasFrequencyMode();
                    if self.levelMeasFrequencyMode == self.enum.AnalyzerMeasFmodeFix
                        [~, self.levelMeasFrequencyValue] = self.upx.GetAnalyzerLevelMeasFrequencyValue();
                    end
                    if self.levelMeasFrequencyMode == self.enum.AnalyzerMeasFmodeGent
                        [~, self.levelMeasFrequencyFactor] = self.upx.GetAnalyzerLevelMeasFrequencyFactor();
                    end
            else
                [~, self.filter1] = self.upx.GetAnalyzerFilter(1);
            end
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
            self.SetSetup@Measurement;
            if self.selective
                self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncRmss);
            else
                self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncRms);
            end
            if ~self.selective
                self.upx.SetAnalyzerSNSequenceState(self.snSequence);
            end
            
            self.upx.SetAnalyzerLevelMeasTime(self.levelMeasTime);
            if self.levelMeasTime == self.enum.AnalyzerMeasTimeVal
                self.upx.SetAnalyzerLevelMeasTimeValue(self.levelMeasTimeValue);
            end
            
            if self.selective
                self.upx.SetAnalyzerLevelMeasBandwidth(self.enum.AnalyzerMeasBandPpct1);
                if self.levelMeasBandwidth == self.enum.AnalyzerMeasBandPfix
                    self.upx.SetAnalyzerLevelMeasBandwidthValue(self.levelMeasBandwidthValue);
                end
                self.upx.SetAnalyzerLevelMeasFrequencyMode(self.enum.AnalyzerMeasFmodeFix);
                if self.levelMeasFrequencyMode == self.enum.AnalyzerMeasFmodeFix
                    self.upx.SetAnalyzerLevelMeasFrequencyValue(self.levelMeasFrequencyValue);
                end
                if self.levelMeasFrequencyMode == self.enum.AnalyzerMeasFmodeGent
                    self.upx.SetAnalyzerLevelMeasFrequencyFactor(self.levelMeasFrequencyFactor);
                end
                %sweep control
                %self.upx.SetAnalyzerLevelMeasFrequencyStart(FrequencyStart);
                %self.upx.SetAnalyzerLevelMeasFrequencyStop(FrequencyStop);
            else
                self.upx.SetAnalyzerFilter(1, self.filter1);
            end
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

