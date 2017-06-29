classdef TestCollection < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        testCaseList = {}
    end
    
    methods
        function Attach(self, testCase)
            % Attach
            % Adds a test case to the end of the test case list
            self.testCaseList{end + 1} = testCase;
        end
        
        function Detach(self, testCase)
            % Detach
            % Find the specific test case and remove it from the list of 
            % test cases
            idx = cellfun(@(t) testCase == t, self.testCaseList);
            self.testCaseList = self.testCaseList(~idx);
        end
        
        function testCaseList = GetTestCaseList(self)
            testCaseList = self.testCaseList;
        end
        function testCase = GetTestCase(self, idx)
            testCase = self.testCaseList{idx};
        end
%         function Run(self)
%             % Run
%             % Runs any test case attached to the test case list
%             for i = 1:numel(self.testCaseList)
%                 self.testCaseList{i}.Setup;
%                 self.testCaseList{i}.Exercise;
%                 self.testCaseList{i}.Verify;
%                 self.testCaseList{i}.Teardown;
%             end
%         end
    end
    
end

