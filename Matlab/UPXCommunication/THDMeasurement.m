classdef THDMeasurement < Measurement
    properties(Access = private) 
        thdMeasIdx;
        channel;
    end
    
    properties(Access = public) % should be private and assigned through functions
        thdMeasMode;
        harmonicState;
        fundamental
        fundamentalValue;
        refinement;
        equalizer;
        equalizerFile;
        
        limitEnable;
        
        fnctSettling;
        fnctSettlingSamples;
        fnctSettlingTolerance;
        fnctSettlingResolution;
        fnctSettlingTimeout;
    end
    
    methods
        function self = THDMeasurement(upx)
            self = self@Measurement(upx);
            self.tm.Name = [mfilename 'Timer'];
            self.channel = 1;
            self.thdMeasIdx = self.AddNumericalMeasurement(self.channel, self.enum.MeasurementFunction, [], true);
        end
        
        function GetSetup(self)
            self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncThd);
            self.GetSetup@Measurement;
            [~, self.thdMeasMode] = self.upx.GetAnalyzerTHDMeasMode;
            [~, self.harmonicState(2)] = self.upx.GetAnalyzerTHDHarmonicState(2);
            [~, self.harmonicState(3)] = self.upx.GetAnalyzerTHDHarmonicState(3);
            [~, self.harmonicState(4)] = self.upx.GetAnalyzerTHDHarmonicState(4);
            [~, self.harmonicState(5)] = self.upx.GetAnalyzerTHDHarmonicState(5);
            [~, self.harmonicState(6)] = self.upx.GetAnalyzerTHDHarmonicState(6);
            [~, self.harmonicState(7)] = self.upx.GetAnalyzerTHDHarmonicState(7);
            [~, self.harmonicState(8)] = self.upx.GetAnalyzerTHDHarmonicState(8);
            [~, self.harmonicState(9)] = self.upx.GetAnalyzerTHDHarmonicState(9);
            [~, self.fundamental] = self.upx.GetAnalyzerTHDFundamental;
            [~, self.fundamentalValue] = self.upx.GetAnalyzerTHDFundamentalValue;
            [~, self.refinement] = self.upx.GetAnalyzerRefinement;
            [~, self.equalizer] = self.upx.GetAnalyzerFFTEqualizer;
            self.equalizerFile = '';
            [~, self.fnctSettling] = self.upx.GetMeasurementFunctionsSettling;
            if(self.fnctSettling ~= self.enum.MeasFuncSettlingOff)
                [~, self.fnctSettlingSamples] = self.upx.GetMeasurementFunctionSettlingCount;
                [~, self.fnctSettlingTolerance] = self.upx.GetMeasurementFunctionSettlingTolerance;
                [~, self.fnctSettlingResolution] = self.upx.GetMeasurementFunctionSettlingResolution;
                [~, self.fnctSettlingTimeout] = self.upx.GetMeasurementFunctionSettlingTimeout;
            end
                       
            
            %[~, self.refinement] = self.upx.GetAnalyzerRefinement;

        end
        function SetSetup(self)
            self.SetSetup@Measurement;
%             self.upx.SetGeneratorChannelMode(0);    % RSUPV_GEN_CH_OFF (0) - Off
            
            self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncThd);
            self.upx.SetAnalyzerTHDMeasMode(self.thdMeasMode);
            
            if (self.thdMeasMode == self.enum.AnalyzerThdMmodeSel)
                self.upx.SetAnalyzerTHDHarmonicState(2, logical(self.harmonicState(2)));
                self.upx.SetAnalyzerTHDHarmonicState(3, logical(self.harmonicState(3)));
                self.upx.SetAnalyzerTHDHarmonicState(4, logical(self.harmonicState(4)));
                self.upx.SetAnalyzerTHDHarmonicState(5, logical(self.harmonicState(5)));
                self.upx.SetAnalyzerTHDHarmonicState(6, logical(self.harmonicState(6)));
                self.upx.SetAnalyzerTHDHarmonicState(7, logical(self.harmonicState(7)));
                self.upx.SetAnalyzerTHDHarmonicState(8, logical(self.harmonicState(8)));
                self.upx.SetAnalyzerTHDHarmonicState(9, logical(self.harmonicState(9)));
            end
            self.upx.SetAnalyzerTHDFundamental(self.fundamental);
            if (self.fundamental == self.enum.AnalyzerThdFundVal)
                self.upx.SetAnalyzerTHDFundamentalValue(self.fundamentalValue);
            end
            self.upx.SetAnalyzerRefinement(self.refinement);
            self.upx.SetAnalyzerFFTEqualizer(logical(self.equalizer));
            self.upx.SetAnalyzerFFTEqualizerFile(self.equalizerFile);
            self.upx.SetMeasurementFunctionsSettling(self.fnctSettling);
            if (self.fnctSettling ~= self.enum.MeasFuncSettlingOff)
                self.upx.SetMeasurementFunctionSettlingCount(self.fnctSettlingSamples);
                self.upx.SetMeasurementFunctionSettlingTolerance(self.fnctSettlingTolerance);
                self.upx.SetMeasurementFunctionSettlingResolution(self.fnctSettlingResolution);
                self.upx.SetMeasurementFunctionSettlingTimeout(self.fnctSettlingTimeout);
            end
        end
        
        function SetThdPostMeasFunction(self, postMeasFunction)
            self.SetNumericalPostMeasFunction(self.thdMeasIdx, postMeasFunction);
        end
                
        function SetThdGraphicsHandle(self, graphicsHandle)
            self.SetNumericalGraphicsHandle(self.thdMeasIdx, graphicsHandle);
        end
        
        function numLog = GetTHDNumLog(self)
            numLog = self.GetNumLog(self.thdMeasIdx);
        end
    end
    
end

