classdef TestCollection < handle
    %TestCollection 
    %   Class to contain one or more tests
    
    properties(Access = private)
        testCaseList = {}
    end
    
    methods
        function Attach(self, testCase)
            % Attach Adds a test case to the end of the test case list
            self.testCaseList{end + 1} = testCase;
        end
        
        function Detach(self, testCase)
            % Detach Finds the specific test case and removes it from the list of test cases
            idx = cellfun(@(t) testCase == t, self.testCaseList);
            self.testCaseList = self.testCaseList(~idx);
        end
        
        function testCaseList = GetTestCaseList(self)
            testCaseList = self.testCaseList;
        end
        
        function testCase = GetTestCase(self, idx)
            testCase = self.testCaseList{idx};
        end
        
    end
    
end

