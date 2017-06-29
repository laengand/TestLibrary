classdef ITestCase < handle
    % ITest Test interface class
    
    properties
    end
    
    methods(Access = public)
        function self = ITestCase
        end
    end
    
    methods(Abstract)
        
        UiSetup(self)
        % Methods specified in the 4-phase method in xUnit Test Patterns 
        % book by Gerard Meszaros
        
        Setup(self)
        Exercise(self)
        Verify(self)
        Teardown(self)
                
        UiTeardown(self)
        
        GetName(self)
    end
    
end

