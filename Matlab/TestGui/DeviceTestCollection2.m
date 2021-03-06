function [testCollection] = DeviceTestCollection2(notifyEvent)
    folder = fileparts(mfilename('fullpath'));
    addpath([folder '\..\Test\']);
    addpath([folder '\..\']);
    testCollection = TestCollection;
    testCollection.Attach(Test1(notifyEvent))
    testCollection.Attach(Test2(notifyEvent))
    testCollection.Attach(Test3(notifyEvent))
    testCollection.Attach(Test4(notifyEvent))
    testCollection.Attach(Test5(notifyEvent))
    testCollection.Attach(Test6(notifyEvent))
    testCollection.Attach(Test7(notifyEvent))
    testCollection.Attach(Test8(notifyEvent))
    testCollection.Attach(Test9(notifyEvent))
    testCollection.Attach(UPPEagleNarrowbandTest(notifyEvent))
    testCollection.Attach(UPPEaglePureToneTest(notifyEvent))
    testCollection.Attach(UPPEagleWarbleTest(notifyEvent))
    testCollection.Attach(UPPEagleNarrowbandTest(notifyEvent))
    
end