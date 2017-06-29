classdef FFTMeasurement < Measurement
        
    properties(Access = public)
        delayRefChannel;
        filter1;
        filter2;
        equalizer;
        equalizerFile;
        freqLimit;
        %         barGraph;
        %         postFFT;
        fftSize;
        window;
        avgMode
        avgCount;
        triggered;
        %         start;
        %         stop;
        %         resolution;
        %         measTime;
        freqPhase;
        freqPhaseMeasTime;
    end
    
    methods
        function self = FFTMeasurement(upx)
            self = self@Measurement(upx);
            self.subsystem = self.enum.DispSubsysFft;
            self.isTraceData = true;
        end
        
        function GetSetup(self)
            % GetSetup
            % Gets the current FFT Setup in the Analyzer Function window
            self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncFft);
            [~, self.delayRefChannel] = self.upx.GetAnalyzerFFTDelayCh1;
            [~, self.filter1] = self.upx.GetAnalyzerFilter(1);
            [~, self.filter2] = self.upx.GetAnalyzerFilter(2);
            [~, self.equalizer] = self.upx.GetAnalyzerFFTEqualizer;
            self.equalizerFile = '';
            [~, self.freqLimit] = self.upx.GetAnalyzerFFTFrequencyLimitState;
            [~, self.fftSize] = self.upx.GetAnalyzerFFTSize;
            [~, self.window] = self.upx.GetAnalyzerFFTWindow;
            [~, self.avgMode] = self.upx.GetAnalyzerFFTAvgMode;
            [~, self.avgCount] = self.upx.GetAnalyzerFFTAvgCount;
            [~, self.triggered] = self.upx.GetAnalyzerFFTTriggeredState;
            [~, self.freqPhase] = self.upx.GetAnalyzerCombinedMeasurement;
            [~, self.freqPhaseMeasTime] = self.upx.GetAnalyzerMeasurementTime;
        end
        
        function SetSetup(self)
            % SetSetup
            % Sets the FFT Setup in the Analyzer Function window
            self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncFft);
            self.upx.SetAnalyzerFFTDelayCh1(self.delayRefChannel);
            self.upx.SetAnalyzerFilter(1, self.filter1);
            self.upx.SetAnalyzerFilter(2, self.filter2);
            self.upx.SetAnalyzerFFTEqualizer(self.equalizer);
            self.upx.SetAnalyzerFFTEqualizerFile(self.equalizerFile);
            self.upx.SetAnalyzerFFTFrequencyLimitState(self.freqLimit);
            self.upx.SetAnalyzerFFTSize(self.fftSize);
            self.upx.SetAnalyzerFFTWindow(self.window);
            self.upx.SetAnalyzerFFTAvgMode(self.avgMode);
            if(self.avgMode ~= self.enum.AnalyzerFftAverModeOff)
                self.upx.SetAnalyzerFFTAvgCount(self.avgCount);
            end
            self.upx.SetAnalyzerFFTTriggeredState(self.triggered);
            self.upx.SetAnalyzerCombinedMeasurement(self.freqPhase);
            self.upx.SetAnalyzerMeasurementTime(self.freqPhaseMeasTime);
            
        end
    end
    
end

