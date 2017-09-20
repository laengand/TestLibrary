classdef UPPEagleBase < AbstractTest
    
    properties
        oldpath;
        memoryTransferComplete;
    end
    
    methods(Access = public)
        %%
        function self = UPPEagleBase()
            [folder, ~, ~] = fileparts(mfilename('fullpath'));
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
%             pidFolderPath = 'C:\Users\Fyn_ivg\Desktop\Testtool\Command Definitions';            
            pidFilePath = [pidFolderPath '\USB, PID ' hexId '.txt'];
            
            %% Create Communication generator class
            commGen = CommunicatorGenerator(id, pidFilePath);
            
            %% Get the instance of the generated class
            self@AbstractTest(commGen.generatedCommunicator);
            self.oldpath = p;
        end
        
        %% Destructor
        function delete(self)
            path(self.oldpath)
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
            fileName = [folder '\..\..\..\EagleTest\DSP.ldr'];
            self.deviceComm.SetRealTimeEventReceiver(hex2dec('6F04'), fileName, 4096);
            s = dir(fileName);
            self.deviceComm.C0F00SetWriteMemory(C0F00.ep0location.e1DSP, s.bytes);
            
            while (self.memoryTransferComplete == false)
                pause(0.1);
            end
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

