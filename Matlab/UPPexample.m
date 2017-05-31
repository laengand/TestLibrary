%% Example usage of an upp 
% Sets up the generator to a sine with a given frequency. 

%% Create an Upx class if it does not already exist
if(~exist('Upx', 'file'))
    CreateUPxClass('Upx');
end

%% Create an instance of the Upx class
ser = '120003'; % refer to the backplate of the individual device.
reset = true;
idQuery = true;

upp = Upx(ser, idQuery, reset);
enum = InstrumentDrivers.rsupvConstants;

%% Set the desired generator frequency and fft size
genFrequency = 5000.0/2;
fftSizeEnum = enum.AnalyzerFftSizeS512;

%% Set the output of the generator to OFF in case it is ON
[~, state] = upp.GetGeneratorOutputState;
if(state)
    upp.SetGeneratorOutputState(false);
end

%% Setup Generator
upp.ConfigureGeneratorAnalog(1, enum.GenOutputUnbal, enum.GenImpedance10, enum.GenOutputCommGnd, enum.GenBwidth22, enum.GenVoltRangAuto, 10.0, enum.UnitV);
upp.ConfigureGeneratorReference(10.0, enum.UnitV, 1000.0, enum.UnitHz);
upp.SetGeneratorFunction(enum.GenFuncSine);
upp.SetGeneratorDCOffset(false);
upp.SetGeneratorVoltage(1, 1.0, enum.UnitV);
upp.SetGeneratorFrequency(1, genFrequency, enum.UnitHz);

%% Setup Analyzer 
upp.SetAnalyzerRefImpedance(600.0);
upp.SetAnalyzerChannelInputRange(1, enum.AnalyzerChInputRangeAuto);
upp.SetAnalyzerLevelMeasTime(enum.AnalyzerMeasTimeAfas);
upp.SetAnalyzerFilter(1, enum.AnalyzerPrefilterOff);
upp.SetAnalyzerUnit(1, enum.AnalyzerMeasurementFunc, enum.UnitDbv);
upp.SetAnalyzerFunction(enum.AnalyzerFuncFft);
upp.SetAnalyzerFFTSize(fftSizeEnum)

%% Enable output a measuring mode
% Set the output of the generator to ON
upp.SetGeneratorOutputState(true);

% Set measureing mode (0) single (1) continuous 
upp.SetMeasurementMode(1);

%% Initiate the measurement and read the result
upp.StartMeasurementWaitOPC(15000);
fftSize = 512*2^fftSizeEnum;
buffer = NET.createArray('System.Double',fftSize/2);

figure(1)
ph = plot(0,0);

for i=1:1000
    
    upp.ReadTraceDataSets(enum.DispSubsysFft, 1,enum.DataSetAx, buffer.Length, buffer);
    ph.XData = buffer.double;
    
    upp.ReadTraceDataSets(enum.DispSubsysFft, 1,enum.DataSetAy, buffer.Length,buffer);
    ph.YData = buffer.double;
        
    title(ph.Parent, num2str(i))
    drawnow
end

%% Stop the measurement
upp.MeasurementControl(1);

%% Disconnect from the upp
upp.Dispose