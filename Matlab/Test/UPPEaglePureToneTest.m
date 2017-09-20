classdef UPPEaglePureToneTest < ITestCase & UPPEagleBase
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        hControl;
        outputTest;
        listbox;
        fm = [125 160 200 250 315 400 500 630 750 800 1000 1250 1500 1600 2000 2500 3000 3150 4000 5000 6000 6300 8000 9000 10000 11200 12500 14000 16000];
        fmIdx = [];
        upp;
%         fftMeas;
        
%         f2h;
%         fftSemilogx_H;
        thdMeas;
        subMeasIdx;
    end
    
    methods(Access = public)
        function self = UPPEaglePureToneTest(notifyEvent)
            self@ITestCase(notifyEvent);
            
            self@UPPEagleBase();
            
            self.fmIdx = 1:1:length(self.fm);
        end
        
        %%
        function name = Name(~)
            name = 'PureTone test';
        end
        
        %%
        function name = GetName(~)
            [~, name, ~] = fileparts(mfilename('fullpath'));
        end
        
        %%
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
        
        %%
        function UiTeardown(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            
            self.upp.Dispose;
            %close(self.f2h);
            close(self.hControl);
        end
        
        %%
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
                
%                 ser = '120082'; % refer to the backplate of the individual device.
                ser = '120003'; % refer to the backplate of the individual device.
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
        
        %%
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
        
        %%
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
                    self.thdMeas.SetThdPostMeasFunction(@self.UpdateTime);
                    self.thdMeas.SetThdGraphicsHandle(self.outputTest);
                    self.thdMeas.StartMeasurement(period);
                    
                end
            catch ex
                disp(ex.message)
            end 
        end
        
        %%
        function Verify(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))

            self.notifyEvent.NotifyVerifyDone
        end
        
        %%
        function Teardown(self)
            ST = dbstack('-completenames');
            disp(char(ST(1).name))
            
            self.deviceComm.Disconnect();
            
            delete(self.thdMeas);
            self.UnregisterEventListeners;
            
            self.notifyEvent.NotifyTeardownDone;
        end
        
        %%
        function Run(~)
        end
        
        %% RegisterEventListeners
        function RegisterEventListeners(self)
            %...
            RegisterEventListeners@UPPEagleBase(self);
        end
        
        %% UnregisterEventListeners
        function UnregisterEventListeners(self)
            UnregisterEventListeners@UPPEagleBase(self);
            %...
        end
        
        %%
        function freqListboxCallback(self, hObject, ~)
            self.fmIdx = hObject.Value;
        end
        
        %%
        function UpdateTime(self, x, y)
            self.thdMeas.StopMeasurement;
            
            freq = self.fm(self.fmIdx(self.subMeasIdx));
            disp([num2str(freq) 'Hz ' self.outputTest.String]);
            
            if self.SetupSubTest
                self.thdMeas.SetSetup();
                
                fftSizeEnum = InstrumentDrivers.rsupvConstants.AnalyzerFftSizeS4k;
                fftSize = 512*2^fftSizeEnum;
                period = single(fftSize)/48000;
                self.thdMeas.StartMeasurement(period);
            end
        end
        
    end
    
end

