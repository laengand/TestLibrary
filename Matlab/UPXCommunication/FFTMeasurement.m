classdef FFTMeasurement < Measurement
        
    properties(Access = private)
        fftMeasIdx;
        
        filter1;
        filter2;
        
        fftSize;
        window;
        avgMode;
        avgCount;
    end
    
    properties(Access = public) % needs to be assigned in separate functions instead of being public
        delayRefChannel;
        equalizer;
        equalizerFile;
        freqLimit;
        triggered;
    end
    
    methods
        function self = FFTMeasurement(upx)
            self = self@Measurement(upx);
            self.tm.Name = [mfilename 'Timer']; 
            self.fftMeasIdx = self.AddTraceMeasurement(self.enum.DispSubsysFft, 1, [self.enum.DataSetAx self.enum.DataSetAy], 0, [], true);
        end
        
        function SetFilters(self, filter1, filter2)
            self.filter1 = filter1;
            self.filter2 = filter2;
        end
        
        function SetFftParameters(self, size, window, avgMode, avgCount)
            self.fftSize = size;
            self.window = window;
            self.avgMode = avgMode;
            self.avgCount = avgCount;
        end
        
        function GetSetup(self)
            % GetSetup
            % Gets the current FFT Setup in the Analyzer Function window
            self.GetSetup@Measurement;
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
            
        end
        
        function SetSetup(self)
            % SetSetup
            % Sets the FFT Setup in the Analyzer Function window
            self.SetSetup@Measurement;
            self.upx.SetAnalyzerFunction(self.enum.AnalyzerFuncFft);
            self.upx.SetAnalyzerFFTDelayCh1(self.delayRefChannel);
            self.upx.SetAnalyzerFilter(1, self.filter1);
            self.upx.SetAnalyzerFilter(2, self.filter2);
            self.upx.SetAnalyzerFFTEqualizer(self.equalizer);
            self.upx.SetAnalyzerFFTEqualizerFile(self.equalizerFile);
            self.upx.SetAnalyzerFFTFrequencyLimitState(self.freqLimit);
            self.upx.SetAnalyzerFFTSize(self.fftSize);
            self.SetTraceBuffer(self.fftMeasIdx, (512*2^self.fftSize)/2)
            
            self.upx.SetAnalyzerFFTWindow(self.window);
            self.upx.SetAnalyzerFFTAvgMode(self.avgMode);
            if(self.avgMode ~= self.enum.AnalyzerFftAverModeOff)
                self.upx.SetAnalyzerFFTAvgCount(self.avgCount);
            end
            self.upx.SetAnalyzerFFTTriggeredState(self.triggered);

        end
        
        function [traceLogX, traceLogY] = GetFftTraceLog(self)
            [traceLogX, traceLogY] = self.GetTraceLog(self.fftMeasIdx);
        end
        
        function SetFFTPostMeasFunction(self, postMeasFunction)
            self.SetTracePostMeasFunction(self.fftMeasIdx, postMeasFunction)
        end
        
        function SetFFTGraphicsHandle(self, graphicsHandle)
            self.SetTraceGraphicsHandle(self.fftMeasIdx, graphicsHandle);
        end
              
    end
    
end

