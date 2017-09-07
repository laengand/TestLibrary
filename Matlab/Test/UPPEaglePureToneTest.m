classdef UPPEaglePureToneTest < ITestCase & AbstractTest
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        hControl;
        outputTest;
        listbox;
        oldpath;
        fm = [125 160 200 250 315 400 500 630 750 800 1000 1250 1500 1600 2000 2500 3000 3150 4000 5000 6000 6300 8000 9000 10000 11200 12500 14000 16000];
        fmIdx = [];
        upp;
%         fftMeas;
        
%         f2h;
%         fftSemilogx_H;
        thdMeas;
        subMeasIdx;
        memoryTransferComplete;
    end
    
    methods(Access = public)
        function self = UPPEaglePureToneTest(notifyEvent)
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
            %pidFolderPath = 'C:\Users\laad\Documents\Visual Studio 2015\Projects\FirmwareTestTool\PC\code\Output\Debug\Command Definitions';
            pidFolderPath = 'C:\Users\Fyn_ivg\Desktop\Testtool\Command Definitions';            
            pidFilePath = [pidFolderPath '\USB, PID ' hexId '.txt'];
            
            %% Create Communication generator class
            commGen = CommunicatorGenerator(id, pidFilePath);
            
            %% Get the instance of the generated class
            self@AbstractTest(commGen.generatedCommunicator);
            self.oldpath = p;
            self.fmIdx = 1:1:length(self.fm);
        end
        
        %% Destructor
        function delete(self)
            path(self.oldpath)
        end
        
        function name = Name(~)
            name = 'PureTone test';
        end
        
        function name = GetName(~)
            [~, name, ~] = fileparts(mfilename('fullpath'));
        end
        
        function UiSetup(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            
%             self.f2h = figure;
%             self.f2h.Position(1,3) = 500;
%             self.f2h.Position(1,4) = 250;
%             self.f2h.Name = 'FFTs';
% 
%             self.fftSemilogx_H = semilogx(0,0);
%             self.fftSemilogx_H.Parent.YLim = [-200 0];
%             self.fftSemilogx_H.Parent.XLim = [100 22050];
%             self.fftSemilogx_H.Parent.YLabel.String = 'dB';
%             self.fftSemilogx_H.Parent.XLabel.String = 'Hz';
%             self.fftSemilogx_H.Parent.XGrid = 'on';
%             self.fftSemilogx_H.Parent.YGrid = 'on';

            self.hControl = figure;
            
            itemHeight = 23;
            height = self.hControl.Position(4);
            width = self.hControl.Position(3);

            self.outputTest = uicontrol(...
                'Parent', self.hControl,...
                'Style','text',...
                'HorizontalAlignment', 'left',...
                'Units', 'pixels',...
                'Position', [0 height-itemHeight*15 width 20],...
                'String', '');
            
            self.listbox = uicontrol(...
                'Parent', self.hControl,...
                'Style', 'listbox',...
                'Max', 2,...
                'Min', 0,...
                'String', cellfun(@(c) num2str(c), num2cell(self.fm), 'UniformOutput', false),...
                'Value', self.fmIdx,...
                'TooltipString', 'Select the desired frequency',...
                'UserData', [],...
                'Units', 'pixels',...
                'Position', [0 height-itemHeight*14 width itemHeight*14],...
                'Callback', @self.freqListboxCallback);
        end
        
        function UiTeardown(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            
            self.upp.Dispose;
            %close(self.f2h);
            close(self.hControl);
        end
        
        function Setup(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))

            self.subMeasIdx = 0;
            try
                self.RegisterEventListeners;
                self.deviceComm.Connect;
                
                self.DownloadDSPCode;

                self.ReadyToUse;
                self.InitInstrument;
                
                ser = '120082'; % refer to the backplate of the individual device.
                reset = false;
                idQuery = true;

                self.upp = Upx(ser, idQuery, reset);
                
                self.upp.SetMeasurementMode(1);

                ch = 1;
                chMask = 2^(ch-1);

                % set output
                self.deviceComm.C0300SetOutput(chMask, C0300.ep1Input.e3Headset2Left);
                % set output weighting
                self.deviceComm.C0500SetOutputWeighting(chMask, C0500.ep1Weighting.e0Nofilter, C0500.ep2Transducer.e0NOTSPEC, C0500.ep3Coupler.e0NoStandard);
                % set output polarity
                self.deviceComm.C0402SetOutputPolarity(chMask, C0402.ep1polarity.e0Condensation);
                % set output level
                self.deviceComm.C0302SetOutputLevel(chMask, C0302.ep1Ext_Rangestatus.e0None, 40.0*100, 140.0*100, 140.0*100, 140.0*100);

                % set output stimulus type
                self.deviceComm.C0403Setoutputstimulustype(chMask, C0403.ep1Stimulus.e1Puretone, C0403.ep2OptChNo.e0Ch1, C0403.ep3OptWeigthning.e0Nonelinear, C0403.ep4PseudoSize.e2n1024);
                % set output frequency
                self.deviceComm.C0400SetOutputFrequency(chMask, 1000);

                % set tone switch
                self.deviceComm.C0501SetToneSwitch(chMask, C0501.ep1Switch.e3UnMute);
                % set tone switch
                self.deviceComm.C0501SetToneSwitch(chMask, C0501.ep1Switch.e1On);

                ch = 2;
                chMask = 2^(ch-1);

                % set output
                self.deviceComm.C0300SetOutput(chMask, C0300.ep1Input.e2Headset1Right);
                % set output weighting
                self.deviceComm.C0500SetOutputWeighting(chMask, C0500.ep1Weighting.e0Nofilter, C0500.ep2Transducer.e0NOTSPEC, C0500.ep3Coupler.e0NoStandard);
                % set output polarity
                self.deviceComm.C0402SetOutputPolarity(chMask, C0402.ep1polarity.e0Condensation);
                % set output level
                self.deviceComm.C0302SetOutputLevel(chMask, C0302.ep1Ext_Rangestatus.e0None, 140.0*100, 60.0*100, 140.0*100, 140.0*100);

                % set output stimulus type
                self.deviceComm.C0403Setoutputstimulustype(chMask, C0403.ep1Stimulus.e9StimulusChannel, C0403.ep2OptChNo.e0Ch1, C0403.ep3OptWeigthning.e0Nonelinear, C0403.ep4PseudoSize.e2n1024);
                % set output frequency
                self.deviceComm.C0400SetOutputFrequency(chMask, 1000);

                % set tone switch
                self.deviceComm.C0501SetToneSwitch(chMask, C0501.ep1Switch.e3UnMute);
                % set tone switch
                self.deviceComm.C0501SetToneSwitch(chMask, C0501.ep1Switch.e1On);

                self.thdMeas = THDMeasurement(self.upp);
                self.thdMeas.GetSetup();
                self.thdMeas.fundamental = InstrumentDrivers.rsupvConstants.AnalyzerThdFundVal;
                
                self.notifyEvent.NotifySetupDone;
            catch ex
                disp(ex.message)
            end 
        end
        
        %% Init Instrument
        function [ ] = InitInstrument(self)
            reply = self.deviceComm.C4F06RequestBoardCalibrationData();

            data = reply.bulk.ToUInt8.uint8;
            fileID = fopen('tmp.zip','w');
            fwrite(fileID, data);
            fclose(fileID);
            gunzip('tmp.zip');
            xDoc = xmlread('tmp');

            for ch=1:2
                outputAttGainInput(ch) = str2double(xDoc.getElementsByTagName('OutputAttenuator').item(ch-1).getElementsByTagName('Gain').item(0).item(0).getData);
                outputAttOffsetInput(ch) = str2double(xDoc.getElementsByTagName('OutputAttenuator').item(ch-1).getElementsByTagName('Offset').item(0).item(0).getData);
                outputAttTHDInput(ch) = str2double(xDoc.getElementsByTagName('OutputAttenuator').item(ch-1).getElementsByTagName('Thd').item(0).item(0).getData);
            end

            for ch=1:4
                inputAttGainInput(ch) = str2double(xDoc.getElementsByTagName('InputAttenuator').item(ch-1).getElementsByTagName('Gain').item(0).item(0).getData);
                inputAttOffsetInput(ch) = str2double(xDoc.getElementsByTagName('InputAttenuator').item(ch-1).getElementsByTagName('Offset').item(0).item(0).getData);
            end
            
            % set init input att.
            self.deviceComm.C0100SetInitInputAtt(C0100.ep0Channel.e0Ch1, inputAttOffsetInput(1), inputAttGainInput(1), 0);
            self.deviceComm.C0100SetInitInputAtt(C0100.ep0Channel.e1Ch2, inputAttOffsetInput(2), inputAttGainInput(2), 0);
            self.deviceComm.C0100SetInitInputAtt(C0100.ep0Channel.e2Ch3, inputAttOffsetInput(3), inputAttGainInput(3), 0);
            self.deviceComm.C0100SetInitInputAtt(C0100.ep0Channel.e3Ch4, inputAttOffsetInput(4), inputAttGainInput(4), 0);
            % set input : OFF
            self.deviceComm.C0200SetInputTransducer(C0200.ep0Channel.e8Ch1234, C0200.ep1Input.e0OFF);
            % set input level : 100
            self.deviceComm.C0201SetInputLevel(C0201.ep0Channel.e8Ch1234, 10000);


            % set init output att.
            self.deviceComm.C0101SetInitOutputAtt(C0101.ep0Channel.e0Ch1, outputAttOffsetInput(1), outputAttGainInput(1), outputAttTHDInput(1));
            self.deviceComm.C0101SetInitOutputAtt(C0101.ep0Channel.e1Ch2, outputAttOffsetInput(2), outputAttGainInput(2), outputAttTHDInput(2));
            % set output frequency : 1000
            self.deviceComm.C0400SetOutputFrequency(C0400.ep0Channel.e5Ch12, 1000.0);
            % set output stimulus type : NoOutput
            self.deviceComm.C0403Setoutputstimulustype(C0403.ep0ChMask.e5Ch12, C0403.ep1Stimulus.e0Nooutput, C0403.ep2OptChNo.e0Ch1, C0403.ep3OptWeigthning.e0Nonelinear,C0403.ep4PseudoSize.e2n1024);
            % set output polarity : Condensation
            self.deviceComm.C0402SetOutputPolarity(C0402.ep0Channel.e5Ch12, C0402.ep1polarity.e0Condensation);
            % set output weighting : None
            self.deviceComm.C0500SetOutputWeighting(C0500.ep0Channel.e5Ch12, C0500.ep1Weighting.e0Nofilter, C0500.ep2Transducer.e0NOTSPEC, C0500.ep3Coupler.e0NoStandard);
            % set output : OFF
            self.deviceComm.C0300SetOutput(C0300.ep0Channel.e5Ch12, C0300.ep1Input.e0OFF);
            % set output calibration level : 0
            self.deviceComm.C0301SetOutputCalibrationLevel(C0301.ep0Channel.e5Ch12, 0);
            % set output level : 140
            self.deviceComm.C0302SetOutputLevel(C0302.ep0Channel.e5Ch12, C0302.ep1Ext_Rangestatus.e0None, 14000, 14000, 14000, 14000);
            % set tone switch rise fall time
            self.deviceComm.C0503SetToneSwitchRiseFallTime(35);
            % set tone swtich mode : Manual, Continuous
            self.deviceComm.C0502SetToneSwitchMode(C0502.ep0Channel.e5Ch12, C0502.ep1Mode.e0Manual, C0502.ep2Type.e0Continuous);
            % set tone switch : UnMute
            self.deviceComm.C0501SetToneSwitch(C0501.ep0Channel.e5Ch12, C0501.ep1Switch.e3UnMute);
            % set tone switch : Off
            self.deviceComm.C0501SetToneSwitch(C0501.ep0Channel.e5Ch12, C0501.ep1Switch.e0Off);

            
            % set monitor ch select : all monitor output ch 1&2 to None, monitor input ch1&2 to None, Assist monitor input ch 1&2 to None
            self.deviceComm.C0381SetMonitorChSelect(C0381.ep0MonitorStimCH1.e0None, C0381.ep1MonitorStimCH2.e0None, C0381.ep2MonitorInputCH1.e0None, C0381.ep3MonitorInputCH2.e0None, C0381.ep4AssistMonitorCH1.e0None, C0381.ep5AssistMonitorCH2.e0None);
            % set monitor output : 1 and 2 off
            self.deviceComm.C0382SetMonitorOutput(C0382.ep0MonitorOutput1.e0Monitoroff, C0382.ep1MonitorOutput2.e0Monitoroff);
            % set monitor level : 1 to -100 dB and 2 to -100dB
            self.deviceComm.C0383SetMonitorLevel(10000, 10000);
            % set mastervolume monitor volume level : monitor -0 dB and assmonitor -0dB
            self.deviceComm.C0385SetMasterVolumeLevel(0, 0);
            
            
            % set init batt att. initalize Battery left Current offset uA and Current gain
            self.deviceComm.C0102SetInitBattery(C0102.ep0Bat_Ch.e0BatLeft, 0, 1.0267);
            % set battery voltage and imp : 1.300V, 0 Ohm
            self.deviceComm.C090FSetBatteryVoltageAndImp(C090F.ep0Bat_Ch.e0BatLeft, 1300, 0);
        end
        
        %%
        function ReadyToUse(self)
            self.deviceComm.C0010DSPcommandregister(C0010.ep0Status.e1ReadytoUse);
            pause(0.1);
            self.deviceComm.C0012SetGPIOOutput(C0012.ep0Output.e4V12, C0012.ep1Status.e1ON);
            pause(0.5);
        end
        
        %%
        function [ ] = DownloadDSPCode(self)
            self.memoryTransferComplete = false;
            folder = fileparts(mfilename('fullpath'));
            %fileName = [folder filesep 'DSP.ldr'];
            fileName = [folder '\..\..\..\EagleTests\DSP.ldr'];
            self.deviceComm.SetRealTimeEventReceiver(hex2dec('6F04'), fileName, 4096);
            s = dir(fileName);
            self.deviceComm.C0F00SetWriteMemory(C0F00.ep0location.e1DSP, s.bytes);
            
            while (self.memoryTransferComplete == false)
                pause(0.1);
            end
        end        
        
        function cont = SetupSubTest(self)
            self.subMeasIdx = self.subMeasIdx + 1;
            if(self.subMeasIdx > length(self.fmIdx))
                self.notifyEvent.NotifyExerciseDone;
                cont = false;
            else
                ch = 1;
                chMask = 2^(ch-1);
                freq = self.fm(self.fmIdx(self.subMeasIdx));
                self.deviceComm.C0400SetOutputFrequency(chMask, single(freq));
                self.thdMeas.fundamentalValue = freq;
                if freq < 22000/2
                    self.upp.SetAnalyzerBandwidth(InstrumentDrivers.rsupvConstants.AnalyzerBwidth22);
                elseif freq < 40000/2
                    self.upp.SetAnalyzerBandwidth(InstrumentDrivers.rsupvConstants.AnalyzerBwidth40);
                else
                    self.upp.SetAnalyzerBandwidth(InstrumentDrivers.rsupvConstants.AnalyzerBwidth80);
                end
                cont = true;
            end
        end
        
        
        function Exercise(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            
            try
                if self.SetupSubTest
                    fftSizeEnum = InstrumentDrivers.rsupvConstants.AnalyzerFftSizeS4k;
                    fftSize = 512*2^fftSizeEnum;
                    %self.thdMeas.fftSize = fftSizeEnum;
                    self.thdMeas.SetSetup();

                    period = single(fftSize)/48000;
                    tm = self.thdMeas.GetTimer();
                    tm.StartDelay = 0.01;
                    self.thdMeas.StartMeasurement(period, [], [], self.outputTest);
                    self.thdMeas.postMeasFunction = @self.UpdateTime;
                end
            catch ex
                disp(ex.message)
            end 
        end
        
        function Verify(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))

            self.notifyEvent.NotifyVerifyDone
        end
        
        function Teardown(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            
            delete(self.thdMeas);
            self.UnregisterEventListeners;
            
            self.notifyEvent.NotifyTeardownDone;
        end
        
        function Run(~)
        end
        
        %% RegisterEventListeners
        function RegisterEventListeners(self)
            self.AddEventListener(self.deviceComm.E2F04,@self.MemoryTransferComplete);
            self.EnableEventListeners();
        end
        
        %% UnregisterEventListeners
        function UnregisterEventListeners(self)
            self.DisableEventListeners();
            self.RemoveEventListener(self.deviceComm.E2F04,@self.MemoryTransferComplete);
        end
        
        function freqListboxCallback(self, hObject, ~)
            self.fmIdx = hObject.Value;
        end
        
        function UpdateTime(self, obj)
            self.thdMeas.StopMeasurement;
            
            freq = self.fm(self.fmIdx(self.subMeasIdx));
            disp([num2str(freq) 'Hz ' self.outputTest.String]);
            
            if self.SetupSubTest
                self.thdMeas.SetSetup();
                
                fftSizeEnum = InstrumentDrivers.rsupvConstants.AnalyzerFftSizeS4k;
                fftSize = 512*2^fftSizeEnum;
                period = single(fftSize)/48000;
                self.thdMeas.StartMeasurement(period, [], [], self.outputTest);
            end
        end
        
        %% 0x2F04 MemoryTransferComplete
        % Parameters
        %   eventData.Data.p0TransferStatus
        %   eventData.Data.p1Id
        % Reply
        function MemoryTransferComplete( self, ~, ~ )
            self.memoryTransferComplete = true;
        end
        
    end
    
end

