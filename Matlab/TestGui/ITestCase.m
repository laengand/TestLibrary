classdef ITestCase < handle
    % ITest Test interface class
    
    properties(Access = protected)
        notifyEvent;
        resultPath = '';
    end
    
    methods(Access = public)
        function self = ITestCase(notifyEvent)
            self.notifyEvent = notifyEvent;
        end
        function folder = GetResultFolder(self)
            folder = self.resultPath;
        end
    end
    
    methods(Abstract)
        
        UiSetup(self)
        UiTeardown(self)
        
        % Methods specified in the 4-phase method in xUnit Test Patterns 
        % book by Gerard Meszaros
        Setup(self)
        Exercise(self)
        Verify(self)
        Teardown(self)
        
        GetName(self)
    end
    
end

