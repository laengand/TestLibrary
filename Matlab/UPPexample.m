%% Example usage of an upp 
% Sets up the generator to a sine with a given frequency and sets up the
% analyzer to a fft and rms test
clear
p = path;
addpath('.\UPXCommunication\')
%% Create an Upx class if it does not already exist
if(~exist('Upx', 'file'))
    CreateUPxClass('Upx');
end

%% Create an instance of the Upx class
ser = '120082'; % refer to the backplate of the individual device.
reset = true;
idQuery = true;

upp = Upx(ser, idQuery, reset);
enum = InstrumentDrivers.rsupvConstants;

%% Set the desired generator frequency and fft size
rmsEnable = 1;

genFrequency = 5000.0;
fftSizeEnum = enum.AnalyzerFftSizeS1k;

%% Set the output of the generator to OFF in case it is ON
[~, state] = upp.GetGeneratorOutputState;
if(state)
    upp.SetGeneratorOutputState(false);
end

% try
%% Setup Generator
channel = 1;
upp.ConfigureGeneratorAnalog(channel, enum.GenOutputUnbal, enum.GenImpedance10, enum.GenOutputCommGnd, enum.GenBwidth22, enum.GenVoltRangAuto, 10.0, enum.UnitV);
upp.ConfigureGeneratorReference(10.0, enum.UnitV, 1000.0, enum.UnitHz);

upp.SetGeneratorFunction(enum.GenFuncSine);
upp.SetGeneratorVoltage(channel, 1.0, enum.UnitV);
upp.SetGeneratorFrequency(channel, genFrequency, enum.UnitHz);

upp.SetGeneratorOutputState(true);

close all;

%% Set measureing mode (0) single (1) continuous 
upp.SetMeasurementMode(1);

%% FFT
if(~rmsEnable)
    fftMeas = FFTMeasurement(upp);
    fftMeas.EnableLogging(true);
    fftMeas.GetSetup();
    
    fftSize = 512*2^fftSizeEnum;
    fftMeas.fftSize = fftSizeEnum;
    fftMeas.SetSetup();
    
    figure
    sb = subplot(1,2,1);
    fftLineHandle = plot(0,0);
    xlabel('Time [s]'); ylabel('Magnitude [dB]');
    title(fftLineHandle .Parent, 'Waveform')

    fftBuffer = NET.createArray('System.Double', fftSize/2);
    period = 0.1;
    fftMeas.StartMeasurement(period, fftBuffer, fftLineHandle,0)
end

%% Waveform 
waveForm = WaveformMeasurement(upp);
waveForm.GetSetup;
waveForm.traceLength = 0.01;
waveForm.SetSetup;
waveForm.EnableLogging(true);
sampleRate = 48000;

sb = subplot(1,2,2);
wfLineHandle = plot(sb,0,0); xlabel('Time [s]'); ylabel('Voltage [V]');
title(wfLineHandle.Parent, 'Waveform')

hold on

rmsLine = line([0 waveForm.traceLength], [0 0], 'Color', 'r');

hold off

anno = legend(rmsLine, 'show');
waveFormBuffer = NET.createArray('System.Double', sampleRate*waveForm.traceLength);
period = 0.1;
waveForm.StartMeasurement(period, waveFormBuffer, wfLineHandle, 0);

%% RMS
if(rmsEnable)
    sb = subplot(1,2,1);
    rmsBarHandle = bar(0); ylabel('Voltage [V]');
    title(rmsBarHandle.Parent, 'RMS')
    rmsMeas = RMSMeasurement(upp);
    rmsMeas.GetSetup;
    rmsMeas.channel = 1;
    rmsMeas.SetSetup;
        
    rmsMeas.StartMeasurement(period, 0, rmsBarHandle, 0);
end

%% Monitor

monitor = Monitor(upp);
monitor.GetSetup;
monitor.levelMonitor = enum.AnalyzerLevMonRms;
monitor.channel = 1;
monitor.SetSetup;

monitor.StartMeasurement(period, 0, rmsLine, anno);
% monitor.
%% Enable output a measuring mode
% Set the output of the generator to ON
upp.SetGeneratorOutputState(true);

	
%% Initiate the measurement and read the result. 
% upp.StartMeasurementWaitOPC(15000);
fftSize = 512*2^fftSizeEnum;

%% Make some measurements
pause;

%% Stop the measurement and clean up
if(rmsEnable)
    rmsMeas.StopMeasurement;
    delete(rmsMeas)
else
    fftMeas.StopMeasurement;
    delete(fftMeas)
end
waveForm.StopMeasurement;
monitor.StopMeasurement
delete(waveForm)
delete(monitor)

pause(2)
%% Disconnect from the upp
upp.Dispose

%% Restore the path
path(p);
