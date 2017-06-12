%% Example usage of an upp 
% Sets up the generator to a sine with a given frequency and sets up the
% analyzer to a fft and rms test
clear
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
% upxCon = UpxController(upp);


%% Set the desired generator frequency and fft size
rmsEnable = 0;
fftEnable = 1;
genFrequency = 5000.0;
fftSizeEnum = enum.AnalyzerFftSizeS1k;

%% Set the output of the generator to OFF in case it is ON
[~, state] = upp.GetGeneratorOutputState;
if(state)
    upp.SetGeneratorOutputState(false);
end

try
%% Setup Generator
% channel = 1;
% upp.ConfigureGeneratorAnalog(channel, enum.GenOutputUnbal, enum.GenImpedance10, enum.GenOutputCommGnd, enum.GenBwidth22, enum.GenVoltRangAuto, 10.0, enum.UnitV);
% upp.ConfigureGeneratorReference(10.0, enum.UnitV, 1000.0, enum.UnitHz);
% upp.SetGeneratorFunction(enum.GenFuncRandom);
% % upp.SetGeneratorDCOffset(false);
% upp.SetGeneratorVoltage(channel, 1.0, enum.UnitV);
% % upp.SetGeneratorFrequency(channel, genFrequency, enum.UnitHz);
% upp.SetGeneratorRandomShape(enum.GenRandomShapeWhite)
% upp.SetGeneratorFislter
upp.SetGeneratorOutputState(true);
%% Setup Analyzer 
channel = 1;
% upp.SetAnalyzerRefImpedance(600.0);
% upp.SetAnalyzerChannelInputRange(channel, enum.AnalyzerChInputRangeAuto);
% upp.SetAnalyzerLevelMeasTime(enum.AnalyzerMeasTimeAfas);
% upp.SetAnalyzerFilter(1, enum.AnalyzerPrefilterOff);
% upp.SetAnalyzerUnit(channel, enum.AnalyzerMeasurementFunc, enum.UnitDbv);
% upp.SetAnalyzerFunction(enum.AnalyzerFuncFft);
% upp.SetAnalyzerFFTSize(fftSizeEnum);
close all;
%% FFT
if(fftEnable)
    fftMeas = FFTMeasurement(upp);
    fftMeas.enableLogging = true;
    fftMeas.GetSetup();
    
    fftMeas.subsystem = enum.DispSubsysFft;
    fftSize = 512*2^fftSizeEnum;
    fftMeas.fftSize = fftSizeEnum;
    fftMeas.SetSetup();
    
    figure(1)
    
    fftLineHandle = plot(0,0); %xlim([0 waveForm.traceLength]);
    anno = legend('show');
    
    fftBuffer = NET.createArray('System.Double', fftSize/2);
    period = 0.1;
    fftMeas.StartMeasurement(period, fftBuffer, fftLineHandle,0)
end

%% Waveform 
waveForm = WaveformMeasurement(upp);
waveForm.GetSetup;
waveForm.waveform = true; % 
waveForm.traceLength = 0.01;
waveForm.SetSetup;
sampleRate = 48000;

f2 = figure(2);
sb = subplot(1,2,1);
wfLineHandle = plot(sb,0,0); %xlim([0 waveForm.traceLength]);
rmsLine = line(wfLineHandle.Parent,[0 waveForm.traceLength], [0 0], 'Color', 'r');

waveFormBuffer = NET.createArray('System.Double', sampleRate*waveForm.traceLength);
period = 0.1;
waveForm.StartMeasurement(period, waveFormBuffer, wfLineHandle, 0);

%% RMS
if(rmsEnable)
    figure(3)
    rmsBarHandle = bar(0);
    rmsMeas = RMSMeasurement(upp);
    rmsMeas.GetSetup;
    rmsMeas.SetSetup;
    rmsMeas.enableLogging = true;
    rmsMeas.channel = 1;
    
    % rmsMeas.StartMeasurement(period, 0, rmsBarHandle, 0);
end
%% Monitor
% f4 = figure(4);
sb = subplot(1,2,2);
monitorBarHandle = bar(sb,0);
monitor = Monitor(upp);
monitor.GetSetup;
monitor.levelMonitor = monitor.enum.AnalyzerLevMonRms;
monitor.channel = 1;
monitor.SetSetup;

monitor.StartMeasurement(period, 0, rmsLine, anno);
% monitor.
%% Enable output a measuring mode
% Set the output of the generator to ON
upp.SetGeneratorOutputState(true);

% Set measureing mode (0) single (1) continuous 
upp.SetMeasurementMode(1);
	
%% Initiate the measurement and read the result. 
% upp.StartMeasurementWaitOPC(15000);
fftSize = 512*2^fftSizeEnum;

%% Make some measurements
pause;

%% Stop the measurement
waveForm.StopMeasurement;
fftMeas.StopMeasurement;
rmsMeas.StopMeasurement;
upp.MeasurementControl(enum.MeasStop);

%% Set the Analyzer to RMS measurement
% upp.SetAnalyzerFunction(enum.AnalyzerFuncRms);
% 
% % Set measureing mode (0) single (1) continuous 
% upp.SetMeasurementMode(0);

%% Initiate the measurement and read the result
% upp.StartMeasurement;
% 
% [retVal, measurementResult, units] = upp.ReadMeasurementResult(channel, enum.AnalyzerMeasurementFunc)

catch ex
    upp.Dispose
end
%% Disconnect from the upp
upp.Dispose