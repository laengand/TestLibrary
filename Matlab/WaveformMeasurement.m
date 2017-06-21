classdef WaveformMeasurement < Measurement
    
    properties(Access = private)
        waveform;
    end
    
    properties
        measMode;
        traceLength;
        triggerChannel;
        triggerSource;
        triggerLevel;
        triggerSlope;
        pretrigger;
        autoTrigger;
    end
    
    
    methods
        function self = WaveformMeasurement(upx)
            self = self@Measurement(upx);
            self.subsystem = self.enum.DispSubsysWav;
            self.isTraceData = true;
            self.waveform = true;
        end
        function GetSetup(self)
%             [~, self.waveform] = self.upx.GetAnalyzerWaveformMonitorState;
            [~, self.measMode] = self.upx.GetAnalyzerWaveformMonitorMeasMode;
            [~, self.traceLength] = self.upx.GetAnalyzerWaveformMonitorTraceLength;
            [~, self.triggerChannel] = self.upx.GetMultichannelAnalyzerTriggerChannel;
            [~, self.triggerSource] = self.upx.GetAnalyzerWaveformMonitorTriggerSource;
            [~, self.triggerLevel] = self.upx.GetAnalyzerWaveformMonitorTriggerLevel;
            [~, self.triggerSlope] = self.upx.GetAnalyzerWaveformMonitorTriggerSlope;
            [~, self.pretrigger] = self.upx.GetAnalyzerWaveformMonitorPretrigger;
            [~, self.autoTrigger] = self.upx.GetAnalyzerWaveformMonitorAutotrigger;
        end
        
        function SetSetup(self)
            self.upx.SetAnalyzerWaveformMonitorState(self.waveform);
            if(self.waveform ~= false)
                self.upx.SetAnalyzerWaveformMonitorMeasMode(self.measMode);
                self.upx.SetAnalyzerWaveformMonitorTraceLength(self.traceLength);
                self.upx.SetMultichannelAnalyzerTriggerChannel(self.triggerChannel);
% the following commands throw an exeption
%                 self.upx.SetAnalyzerWaveformMonitorTriggerSource(self.triggerSource);
%                 self.upx.SetAnalyzerWaveformMonitorTriggerLevel(self.triggerLevel);
%                 self.upx.SetAnalyzerWaveformMonitorTriggerSlope(self.triggerSlope);
%                 self.upx.SetAnalyzerWaveformMonitorPretrigger(self.pretrigger);
%                 self.upx.SetAnalyzerWaveformMonitorAutotrigger(self.autoTrigger)
            end
        end
    end
    
end

