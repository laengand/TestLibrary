classdef Test6 < ITestCase
    properties
        notifyEvent
    end
    methods
        function self = Test6(notifyEvent)
            self@ITestCase;
            self.notifyEvent = notifyEvent;
        end
        
        function UiSetup(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
        end
        
        function Setup(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            pause(0.5)
            self.notifyEvent.NotifySetupDone;
        end
        function Exercise(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            pause(0.5)
            self.notifyEvent.NotifyExerciseDone;
        end
        
        function Verify(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            pause(0.5)
            self.notifyEvent.NotifyVerifyDone;
        end
        
        function Teardown(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            pause(0.5)
            self.notifyEvent.NotifyTeardownDone;
        end
        
        function UiTeardown(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
        end
        
        function name = GetName(~)
            [~, name, ~] = fileparts(mfilename('fullpath'));
        end
        
    end
end
