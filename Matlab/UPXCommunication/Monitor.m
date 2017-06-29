classdef Monitor < Measurement
    
    properties
        levelMonitor;
        %         secondMonitor;
        inputMonitor;
    end
    
    methods
        function self = Monitor(upx)
            self = self@Measurement(upx);
            self.isTraceData = false;
        end
        
        function GetSetup(self)
            [~, self.levelMonitor] = self.upx.GetAnalyzerLevelMonitor;
            [~, self.inputMonitor] = self.upx.GetAnalyzerInputMonitor;
        end
        
        function SetSetup(self)
            if(self.levelMonitor ~= self.enum.AnalyzerLevMonOff)
                self.measurement = self.enum.MeasurementLevelMonitor;
                self.upx.SetAnalyzerLevelMonitor(self.levelMonitor);
            elseif(self.levelMonitor ~= self.enum.AnalyzerInputMonOff)
                self.measurement = self.enum.MeasurementInputMonitor;
                self.upx.SetAnalyzerInputMonitor(self.inputMonitor);
            end
        end
    end
    
end

