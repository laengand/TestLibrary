classdef UPPEagleNarrowbandTest < ITestCase & AbstractTest
    properties(Access = private)
        dataLog;
        dataLogIdx = 1;
        fftMeas;
        fftPlotAxes;
        fftPlot;
        measLoopIte = 1;
        fig;
        listbox;
        fm = [125 160 200 250 315 400 500 630 750 800 1000 1250 1500 1600 2000 2500 3000 3150 4000 5000 6000 6300 8000 9000 10000 11200 12500 14000 16000];
        fmIdx = [];
        memoryTransferComplete = false;
        filepaths;
        timeEdit;
        measuringTime;
        measuringPeriod = 0.1;
        measuringCounter = 0;
    end
    
    methods (Access = private)
        function freqListboxCallback(self, hObject, ~)
            self.fmIdx = hObject.Value;
        end
        
        function timeEditCallback(self, hObject, ~)
            
            if isempty(str2double(hObject.String))
                warndlg('Input must be numerical');
            else
                self.measuringTime = str2double(hObject.String);
            end
        end
        function StartStopMeasurement(self)
            if(self.measLoopIte <= numel(self.fmIdx))
                self.deviceComm.C0400SetOutputFrequency(C0400.ep0Channel.e0Ch1, single(self.fm(self.fmIdx(self.measLoopIte))));
                self.fftMeas.ClearLog;
                
                tm = self.fftMeas.GetTimer;
                tm.TasksToExecute = self.measuringTime/self.measuringPeriod;
                tm.Stopfcn = @(~,~) self.CollectData;
                
                fftSize = 512*2^self.fftMeas.fftSize;
                fftBuffer = NET.createArray('System.Double', fftSize/2);
                legend(self.fftPlotAxes,['Frequency: ' num2str(self.fm(self.fmIdx(self.measLoopIte))) 'Hz'])
                self.fftMeas.StartMeasurement(self.measuringPeriod, fftBuffer, self.fftPlot,0)
            else
                self.deviceComm.Disconnect();
                self.measLoopIte = 1;
                self.measuringCounter = 0;
                if(~isempty(self.notifyEvent))
                    self.notifyEvent.NotifyExerciseDone;
                end
            end
        end
        
        function CollectData(self)
            if(isvalid(self.fftMeas))
                self.fftMeas.StopMeasurement
                [X, Y] = self.fftMeas.GetTraceLog;
                self.dataLog{end + 1} = {self.fm(self.fmIdx(self.measLoopIte)),X,Y};
                self.dataLogIdx = self.dataLogIdx + 1;
                self.measLoopIte = self.measLoopIte + 1;
                self.StartStopMeasurement;
            end
        end
        function UpdateTime(self, obj)
            tm = self.fftMeas.GetTimer;
            self.measuringCounter = self.measuringCounter + 1;
            self.timeEdit.String = [num2str(self.measuringPeriod*self.measuringCounter) '/' num2str(self.measuringPeriod*tm.TasksToExecute*numel(self.fmIdx))];       
        end
        
    end
    methods (Access = public)
        %% Constructor
        function self = UPPEagleNarrowbandTest(notifyEvent)
            self@ITestCase(notifyEvent);
            [folder, name, ext] = fileparts(mfilename('fullpath'));
            p = addpath([folder '\..\UPXCommunication\']);
            addpath(folder);
            
            % now get the path to the dot net library dll
            oldpath=pwd;
            cd(folder);
            
            cd(['..' filesep 'DotNetLibrary'])
            fullpath=pwd;
            cd(oldpath);
            PathToLibrary = [fullpath filesep];
            LibraryName = 'TestLibrary.dll';
            
            % Load the TestLibrary
            try
                asmInfo = NET.addAssembly([PathToLibrary LibraryName]);
                import TestLibrary.*;
            catch ex
                ex.ExceptionObject.LoaderExceptions.Get(0).Message
                error('Library or support file loading problem. Script halted')
            end
            %% Set the PID
            hexId = '0012'; % Replace this with the desired PID
            id = hex2dec(hexId);
            pidFolderPath = 'C:\Users\laad\Documents\Visual Studio 2015\Projects\FirmwareTestTool\PC\code\Output\Debug\Command Definitions';
            pidFilePath = [pidFolderPath '\USB, PID ' hexId '.txt'];
            
            %% Create Communication generator class
            commGen = CommunicatorGenerator(id, pidFilePath);
            
            %% Get the instance of the generated class
            self@AbstractTest(commGen.generatedCommunicator);
            self.filepaths = p;
        end
        %% Destructor
        function delete(self)
            path(self.filepaths)
        end
        
        %% TestCase functions
        function name = GetName(~)
            [~, name, ~] = fileparts(mfilename('fullpath'));
        end
        
        function UiSetup(self)
            %% UiSetup
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            folder = fileparts(mfilename('fullpath'));
            self.fig = openfig([folder filesep 'UPPEagleNarrowbandTest']);
            self.listbox = findobj(self.fig,'tag','freqListbox');
            self.listbox.Callback = @self.freqListboxCallback;
            self.listbox.Max = 2;
            self.fmIdx = self.listbox.Value;
            self.listbox.String = cellfun(@(c) num2str(c), num2cell(self.fm), 'UniformOutput', false);
            self.fftPlotAxes = findobj(self.fig,'tag','fftPlot');
            self.fftPlot = semilogx(self.fftPlotAxes, 0, 0); xlim(self.fftPlotAxes, [0.1 100000]); ylim(self.fftPlotAxes, [-90 10]);
            self.timeEdit = findobj(self.fig,'tag','timeEdit');
            self.timeEdit.Callback = @self.timeEditCallback;
        end
        
        function Setup(self)
            %% Setup
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            self.listbox.Enable = 'off';
            self.timeEdit.Enable = 'off';
            try
                ser = '120003'; % refer to the backplate of the individual device.
                reset = true;
                idQuery = true;
                
                upp = Upx(ser, idQuery, reset);
                enum = InstrumentDrivers.rsupvConstants;
                upp.SetMeasurementMode(1);
                upp.SetAnalyzerBandwidth(enum.AnalyzerBwidth22);
                
                self.fftMeas = FFTMeasurement(upp);
                fftSizeEnum = enum.AnalyzerFftSizeS16k;
                self.fftMeas.EnableLogging(true);
                self.fftMeas.GetSetup();
                
                self.fftMeas.fftSize = fftSizeEnum;
                self.fftMeas.window = enum.AnalyzerFftWindBlac;
                self.fftMeas.postMeasFunction = @self.UpdateTime;
                self.fftMeas.SetSetup();
                
                self.RegisterEventListeners;
                self.deviceComm.Connect;
                
                self.DownloadDSPCode;
                self.ReadyToUse;
                self.InitInstrument;
                
                self.deviceComm.C0403Setoutputstimulustype(C0403.ep0ChMask.e0Ch1, C0403.ep1Stimulus.e3Narrowbandnoise, C0403.ep2OptChNo.e0Ch1, C0403.ep3OptWeigthning.e0Nonelinear, C0403.ep4PseudoSize.e2n1024);
%                 self.deviceComm.C0403Setoutputstimulustype(C0403.ep0ChMask.e0Ch1, C0403.ep1Stimulus.e1Puretone, C0403.ep2OptChNo.e0Ch1, C0403.ep3OptWeigthning.e0Nonelinear, C0403.ep4PseudoSize.e2n1024);
                self.deviceComm.C0403Setoutputstimulustype(C0403.ep0ChMask.e1Ch2, C0403.ep1Stimulus.e9StimulusChannel, C0403.ep2OptChNo.e0Ch1, C0403.ep3OptWeigthning.e0Nonelinear, C0403.ep4PseudoSize.e2n1024);
                % 0400 Ch1, 1000                                        //Set frequency in ch1 to 1000 Hz
                self.deviceComm.C0302SetOutputLevel(C0302.ep0Channel.e0Ch1, C0302.ep1Ext_Rangestatus.e0None, 2000, 0, 0, 0);
                if(~isempty(self.notifyEvent))
                    self.notifyEvent.NotifySetupDone;
                end
            catch ex
                disp(ex.message)
            end 
        end
        
        function Exercise(self)
            %% Exercise
            try
                ST = dbstack('-completenames');
                disp(char(ST(1).name))
                self.StartStopMeasurement;
            catch ex
                disp(ex.message)
            end
        end
        
        
        function Verify(self)
            %% Verify
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            list = {
                'freq'; ...
                'fcLowerValid'; ...
                'fcUpperValid'; ...
                'lowerSlopeValid'; ...
                'upperSlopeValid'; ...
                'lowerLevel35dBValid'; ...
                'upperLevel35dBValid';...
                };
            tfList = [];
            figList = [];
            for i=1:numel(self.dataLog)
                
                fm = self.dataLog{i}{1}; %#ok
                dataMeanX = mean(self.dataLog{i}{2},2);
                dataMeanY = mean(self.dataLog{i}{3},2);
                
                EnableSmoothing = false;
                if(EnableSmoothing)
                    
                    res = 1/4;
                    
                    % increase the number of datapoints so when the slopes of the
                    x = dataMeanX(1):abs(dataMeanX(1)-dataMeanX(2))*res:dataMeanX(end);
                    y = interp1(dataMeanX,dataMeanY, x);
                    
                    dataMeanX = x';
                    dataMeanY = y';
                    
                    span = ceil(self.fm(i)/100/res); % span should be odd
                    if rem(span,2) == 0     % if not odd, add 1
                        span = span + 1;
                    end
                    
                    dataMeanYa = smooth(dataMeanY,span);
                    dataMeanYb = dataMeanY;
                    dataMeanYb(end:-1:1) = smooth(dataMeanY(end:-1:1), span);
                    
                    dataMeanY = mean([dataMeanYa dataMeanYb],2);
                end
                
                [tf, chList, figList(end + 1)] = NarrowbandNoiseTest(fm, dataMeanX, dataMeanY, 'off'); %% 'off' idicates that the assosicated figures are not visible at the time of creation
                
                tfList = [tfList tf];
                
                list(:,end + 1) = { fm; ...
                    chList.fcLowerValid; ...
                    chList.fcUpperValid; ...
                    chList.lowerSlopeValid; ...
                    chList.upperSlopeValid; ...
                    chList.lowerLevel35dBValid; ...
                    chList.upperLevel35dBValid; ...
                    }; %#ok
                
            end
            savefig(figList, 'results')
            save('chList', 'list')
            if(~isempty(self.notifyEvent))
                self.notifyEvent.NotifyVerifyDone;
            end
        end
        
        function Teardown(self)
            %% Teardown
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            if(~isempty(self.listbox))
                self.listbox.Enable = 'on';
                self.timeEdit.Enable = 'on';
                self.timeEdit.String = num2str(self.measuringTime);
            end
            self.dataLog = {};
            self.dataLogIdx = 1;
            self.fftMeas.StopMeasurement
            delete(self.fftMeas);
            
            self.UnregisterEventListeners;
            if(~isempty(self.notifyEvent))
                self.notifyEvent.NotifyTeardownDone;
            end
        end
        
        function UiTeardown(self)
           %% UiTeardown
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            if(isnumeric(self.fig))
                return
            end
            if(isvalid(self.fig))
                close(self.fig);
            end
        end
        %% Misc
        function ReadyToUse(self)
            deviceComm = self.deviceComm;
            
            deviceComm.C0010DSPcommandregister(C0010.ep0Status.e1ReadytoUse);
            pause(0.1);
            deviceComm.C0012SetGPIOOutput(C0012.ep0Output.e4V12, C0012.ep1Status.e1ON);
            pause(0.5);
        end
        
        function DownloadDSPCode(self)
            deviceComm = self.deviceComm;
            
            self.memoryTransferComplete = false;
            folder = fileparts(mfilename('fullpath'));
            
            fileName = [folder '\..\..\..\EagleTest\DSP.ldr'];
            
            deviceComm.SetRealTimeEventReceiver(hex2dec('6F04'), fileName, 4096);
            s = dir(fileName);
            deviceComm.C0F00SetWriteMemory(C0F00.ep0location.e1DSP, s.bytes);
            
            while (self.memoryTransferComplete == false)
                pause(0.1);
            end
        end
        
        function InitInstrument(self)
            deviceComm = self.deviceComm;
            
            % // Set Init Input Att.
            deviceComm.C0100SetInitInputAtt(C0100.ep0Channel.e0Ch1, 15159, 1.0078, 0);
            deviceComm.C0100SetInitInputAtt(C0100.ep0Channel.e1Ch2, 15250, 1.0056, 0);
            deviceComm.C0100SetInitInputAtt(C0100.ep0Channel.e2Ch3, 15255, 1.0083, 0);
            deviceComm.C0100SetInitInputAtt(C0100.ep0Channel.e3Ch4, 15165, 1.0068, 0);
            
            % // Set Init Output Att.
            deviceComm.C0101SetInitOutputAtt(C0101.ep0Channel.e0Ch1, 14116, 0.986, 6955);
            deviceComm.C0101SetInitOutputAtt(C0101.ep0Channel.e1Ch2, 14090, 0.986, 7635);
            
            % // Set Init Batt Att. initalize Battery left Current offset uA and Current gain
            deviceComm.C0102SetInitBattery(C0102.ep0Bat_Ch.e0BatLeft, 0, 1.0267);
            
            % // Set Input Transducer
            deviceComm.C0200SetInputTransducer(C0200.ep0Channel.e8Ch1234, C0200.ep1Input.e0OFF);
            
            % // Set Output Frequency
            deviceComm.C0400SetOutputFrequency(C0400.ep0Channel.e0Ch1, 1000.0);
            deviceComm.C0400SetOutputFrequency(C0400.ep0Channel.e1Ch2, 2000.0);
            
            % // Set Output Stimulus Type
            deviceComm.C0403Setoutputstimulustype(C0403.ep0ChMask.e0Ch1, C0403.ep1Stimulus.e0Nooutput, C0403.ep2OptChNo.e0Ch1, C0403.ep3OptWeigthning.e0Nonelinear,C0403.ep4PseudoSize.e0n256);
            deviceComm.C0403Setoutputstimulustype(C0403.ep0ChMask.e1Ch2, C0403.ep1Stimulus.e0Nooutput, C0403.ep2OptChNo.e1Ch2, C0403.ep3OptWeigthning.e0Nonelinear,C0403.ep4PseudoSize.e0n256);
            
            % // Set Output
            deviceComm.C0300SetOutput(C0300.ep0Channel.e0Ch1, C0300.ep1Input.e1Headset1Left);
            deviceComm.C0300SetOutput(C0300.ep0Channel.e1Ch2, C0300.ep1Input.e2Headset1Right);
            
            % // Set Output Calibration Level
            deviceComm.C0301SetOutputCalibrationLevel(C0301.ep0Channel.e5Ch12, 0);
            
            % // Set Output Level
            deviceComm.C0302SetOutputLevel(C0302.ep0Channel.e5Ch12, C0302.ep1Ext_Rangestatus.e0None, 7000, 7000, 12000, 12000);
            
            % // Set Tone Swtich Mode
            deviceComm.C0502SetToneSwitchMode(C0502.ep0Channel.e5Ch12, C0502.ep1Mode.e0Manual, C0502.ep2Type.e0Continuous);
            
            % // Set Tone Switch
            deviceComm.C0501SetToneSwitch(C0501.ep0Channel.e5Ch12, C0501.ep1Switch.e3UnMute);
            
            % // Set Tone Switch
            deviceComm.C0501SetToneSwitch(C0501.ep0Channel.e5Ch12, C0501.ep1Switch.e1On);
        end
        %% 0x2F04 MemoryTransferComplete
        % Parameters
        %   eventData.Data.p0TransferStatus
        %   eventData.Data.p1Id
        % Reply
        
        function MemoryTransferComplete( self, ~, eventData )
            self.memoryTransferComplete = true;
        end
        
        %% AbstractTest functions
        function UnregisterEventListeners(self)
            self.RemoveEventListener(self.deviceComm.E2F04,@self.MemoryTransferComplete);
            self.DisableEventListeners;
        end
        
        function RegisterEventListeners(self)
            self.AddEventListener(self.deviceComm.E2F04,@self.MemoryTransferComplete);
            self.EnableEventListeners;
        end
        
        function Run(~)
        end
        
        
    end
end







