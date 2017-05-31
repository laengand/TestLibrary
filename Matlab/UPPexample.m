%% Example usage of an upp 
% Sets up the generator to a sine with a given frequency and sets up the
% analyzer to a fft and rms test

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
genFrequency = 5000.0;
fftSizeEnum = enum.AnalyzerFftSizeS8k;

%% Set the output of the generator to OFF in case it is ON
[~, state] = upp.GetGeneratorOutputState;
if(state)
    upp.SetGeneratorOutputState(false);
end

try
%% Setup Generator
channel = 1;
upp.ConfigureGeneratorAnalog(channel, enum.GenOutputUnbal, enum.GenImpedance10, enum.GenOutputCommGnd, enum.GenBwidth22, enum.GenVoltRangAuto, 10.0, enum.UnitV);
upp.ConfigureGeneratorReference(10.0, enum.UnitV, 1000.0, enum.UnitHz);
upp.SetGeneratorFunction(enum.GenFuncSine);
upp.SetGeneratorDCOffset(false);
upp.SetGeneratorVoltage(channel, 1.0, enum.UnitV);
upp.SetGeneratorFrequency(channel, genFrequency, enum.UnitHz);

%% Setup Analyzer 
channel = 1;
upp.SetAnalyzerRefImpedance(600.0);
upp.SetAnalyzerChannelInputRange(channel, enum.AnalyzerChInputRangeAuto);
upp.SetAnalyzerLevelMeasTime(enum.AnalyzerMeasTimeAfas);
upp.SetAnalyzerFilter(1, enum.AnalyzerPrefilterOff);
upp.SetAnalyzerUnit(channel, enum.AnalyzerMeasurementFunc, enum.UnitDbv);
upp.SetAnalyzerFunction(enum.AnalyzerFuncFft);
upp.SetAnalyzerFFTSize(fftSizeEnum);

%% Enable output a measuring mode
% Set the output of the generator to ON
upp.SetGeneratorOutputState(true);

% Set measureing mode (0) single (1) continuous 
upp.SetMeasurementMode(1);
	
%% Initiate the measurement and read the result. 
upp.StartMeasurementWaitOPC(15000);
fftSize = 512*2^fftSizeEnum;

% In order for the upp class to fill a buffer with data, it needs a .Net array 
buffer = NET.createArray('System.Double',fftSize/2);

figure(1)
ph = plot(0,0); xlabel('Hz'); ylabel('dB');

for i=1:10
    title(ph.Parent, ['Measurement number: ' num2str(i)])
    
    % Read the trace data of Ax
    upp.ReadTraceDataSets(enum.DispSubsysFft, 1,enum.DataSetAx, buffer.Length, buffer);
    ph.XData = buffer.double;
    
    % Read the trace data of Ay
    upp.ReadTraceDataSets(enum.DispSubsysFft, 1,enum.DataSetAy, buffer.Length,buffer);
    ph.YData = buffer.double;
        
    % force the redrawing of the figure
    drawnow
end

%% Stop the measurement
upp.MeasurementControl(enum.MeasStop);

%% Set the Analyzer to RMS measurement
upp.SetAnalyzerFunction(enum.AnalyzerFuncRms);

% Set measureing mode (0) single (1) continuous 
upp.SetMeasurementMode(0);

%% Initiate the measurement and read the result
upp.StartMeasurement;

[retVal, measurementResult, units] = upp.ReadMeasurementResult(channel, enum.AnalyzerMeasurementFunc)

catch ex
    upp.Dispose
end
%% Disconnect from the upp
upp.Dispose