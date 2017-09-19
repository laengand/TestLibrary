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
ser = '120003'; % refer to the backplate of the individual device.
reset = true;
idQuery = true;

upp = Upx(ser, idQuery, reset);
enum = InstrumentDrivers.rsupvConstants;

%% Set the desired generator frequency and fft size
rmsEnable = 0;

genFrequency = 1000.0;
fftSizeEnum = enum.AnalyzerFftSizeS8k;

sampleRate = 48000;
%     sampleRate = 96000;
% sampleRate = 192000;


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

meas = FFTMeasurement(upp);
%     fftMeas = Measurement(upp);
meas.EnableLogging(true);
meas.GetSetup();

bandwidthEnum = int32(log2(sampleRate/48000));
upp.SetAnalyzerBandwidth(bandwidthEnum);

fftSize = double(512*2^fftSizeEnum);

%     period = 0.06*fftSize/1024;
% period = 32768/sampleRate;
period = fftSize/sampleRate*1.5; % As it takes a while to transfer the data we cannot not only use the fft calculation time
figure
fftLineHandle = semilogx(0,0); ylim([-200 10]);
xlabel('Frequency [Hz]'); ylabel('Magnitude [dB]');
title(fftLineHandle.Parent, 'FFT')

meas.SetFFTGraphicsHandle(fftLineHandle);

dim = [.2 .5 .3 .3];
frequencyTextbox = annotation('textbox', dim, 'FitBoxToText', 'on');
frequencyTextbox.UserData = 'Frequency: ';
ch = 1;
meas.FrequencyPhaseMeasurementEnable(false, ch, enum.AnalyzerFreqPhaseFreq, frequencyTextbox);
meas.FrequencyPhaseMeasurementEnable(true);

dim = [.2 .40 .3 .3];
levelTextbox = annotation('textbox', dim, 'FitBoxToText', 'on');
levelTextbox.UserData = 'Rms: ';
meas.LevelMonitorEnable(false, ch, enum.AnalyzerLevMonRms, levelTextbox);
meas.LevelMonitorEnable(true);

dim = [.2 .30 .3 .3];
inputTextbox = annotation('textbox', dim, 'FitBoxToText','on');
inputTextbox.UserData = 'Peak: ';
meas.InputMonitorEnable(false, ch, enum.AnalyzerInputMonIpea, inputTextbox)
meas.InputMonitorEnable(true);

meas.fftSize = fftSizeEnum;

meas.SetSetup();
meas.StartMeasurement(period)
%     period = 0.2;

pause(5)
meas.StopMeasurement;

%% RMS
meas = RMSMeasurement(upp);
meas.GetSetup;
meas.SetSetup;
figure
dim = [0.0 .7 .3 .3];
rmsTextbox = annotation('textbox', dim, 'FitBoxToText', 'on');
rmsTextbox.UserData = 'Rms: ';
meas.SetRmsGraphicsHandle(rmsTextbox);

period = 0.05;
meas.StartMeasurement(period);
pause(5)
meas.StopMeasurement;

%% Waveform
meas = Measurement(upp);
meas.GetSetup;
period = 1;
meas.traceLength = period/10;
meas.SetSetup();
figure
wfLineHandle = plot(0, 0); xlabel('Time [s]'); ylabel('Voltage [V]');
title(wfLineHandle.Parent, 'Waveform')
% meas.WaveformEnable(false, wfLineHandle);
% meas.WaveformEnable(true);

dim = [.2 .5 .3 .3];
frequencyTextbox = annotation('textbox', dim, 'FitBoxToText', 'on');
frequencyTextbox.UserData = 'Frequency: ';
ch = 1;
meas.FrequencyPhaseMeasurementEnable(false, ch, enum.AnalyzerFreqPhaseFreq, frequencyTextbox);
meas.FrequencyPhaseMeasurementEnable(true);

dim = [.2 .40 .3 .3];
levelTextbox = annotation('textbox', dim, 'FitBoxToText', 'on');
levelTextbox.UserData = 'Rms: ';
meas.LevelMonitorEnable(false, ch, enum.AnalyzerLevMonRms, levelTextbox);
meas.LevelMonitorEnable(true);

dim = [.2 .30 .3 .3];
inputTextbox = annotation('textbox', dim, 'FitBoxToText','on');
inputTextbox.UserData = 'Peak: ';
meas.InputMonitorEnable(false, ch, enum.AnalyzerInputMonIpea, inputTextbox)
meas.InputMonitorEnable(true);

genFrequency = 100;
upp.SetGeneratorFrequency(channel, genFrequency, enum.UnitHz);
meas.StartMeasurement(period);
pause(5)
meas.StopMeasurement;

[x, y, sX, sY] = meas.GetWaveformTraceLog;
%% Stop the measurement and clean up


%% Disconnect from the upp
upp.Dispose

%% Restore the path
path(p);
