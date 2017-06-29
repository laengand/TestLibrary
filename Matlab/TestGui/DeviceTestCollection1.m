function [testCollection] = DeviceTestCollection1(notifyEvent) 
    testCollection = TestCollection;
    testCollection.Attach(Test1(notifyEvent))
    testCollection.Attach(Test2(notifyEvent))
end