classdef Upx
    properties(Access = public)
    end
    
    properties(Access = public)
    end
    
    properties(Access = private)
        upxHandle;
    end
    
    methods(Access = public)
        %% Constructor
        function self = Upx(serialNr, idQuery, reset)
            [folder, ~, ~] = fileparts(mfilename('fullpath'));
            oldpath = pwd;
            cd(folder);
            cd(['..' filesep 'DotNetLibrary'])
            fullpath=pwd;
            cd(oldpath);
            PathToLibrary = [fullpath filesep];
            LibraryName ='UPxComm.dll';
            try
                asmInfo = NET.addAssembly([PathToLibrary LibraryName]);
                import InstrumentDrivers.*
            catch ex
                ex
                error('Library or support file loading problem. Script halted')
            end
            self.upxHandle = rsupv(['USB::0x0AAD::0x004D::' serialNr '::INSTR'], idQuery, reset);
        end
        
        function [RetVal] = ConfigureAnalyzerFFTFrequencyLimit(self, LimitEnable, FreqLimLow, FreqLimUpp)
            % ConfigureAnalyzerFFTFrequencyLimit
            % [RetVal] = ConfigureAnalyzerFFTFrequencyLimit(self, LimitEnable, FreqLimLow, FreqLimUpp)
            [RetVal] = self.upxHandle.ConfigureAnalyzerFFTFrequencyLimit(LimitEnable, FreqLimLow, FreqLimUpp);
        end
        function [RetVal] = ConfigureAnalyzerFundamental(self, Fundamental, FundamentalValue)
            % ConfigureAnalyzerFundamental
            % [RetVal] = ConfigureAnalyzerFundamental(self, Fundamental, FundamentalValue)
            [RetVal] = self.upxHandle.ConfigureAnalyzerFundamental(Fundamental, FundamentalValue);
        end
        function [RetVal] = ConfigureAnalyzerNotchFilter(self, NotchGain, NotchFrequency, NotchCenterFrequency)
            % ConfigureAnalyzerNotchFilter
            % [RetVal] = ConfigureAnalyzerNotchFilter(self, NotchGain, NotchFrequency, NotchCenterFrequency)
            [RetVal] = self.upxHandle.ConfigureAnalyzerNotchFilter(NotchGain, NotchFrequency, NotchCenterFrequency);
        end
        function [RetVal] = ConfigureAnalyzerPEAQ(self, ModelVersion, MeasurementMode, StoreWAVToFilename)
            % ConfigureAnalyzerPEAQ
            % [RetVal] = ConfigureAnalyzerPEAQ(self, ModelVersion, MeasurementMode, StoreWAVToFilename)
            [RetVal] = self.upxHandle.ConfigureAnalyzerPEAQ(ModelVersion, MeasurementMode, StoreWAVToFilename);
        end
        function [RetVal] = ConfigureAnalyzerPESQ(self, AccordingTo, MeasurementMode, StoreWAVToFilename)
            % ConfigureAnalyzerPESQ
            % [RetVal] = ConfigureAnalyzerPESQ(self, AccordingTo, MeasurementMode, StoreWAVToFilename)
            [RetVal] = self.upxHandle.ConfigureAnalyzerPESQ(AccordingTo, MeasurementMode, StoreWAVToFilename);
        end
        function [RetVal] = ConfigureAnalyzerPeakMeasurement(self, MeasMode, IntervalTime, IntervalTimeValue)
            % ConfigureAnalyzerPeakMeasurement
            % [RetVal] = ConfigureAnalyzerPeakMeasurement(self, MeasMode, IntervalTime, IntervalTimeValue)
            [RetVal] = self.upxHandle.ConfigureAnalyzerPeakMeasurement(MeasMode, IntervalTime, IntervalTimeValue);
        end
        function [RetVal] = ConfigureAnalyzerSweep(self, SweepControl, Spacing, Points, Start, StartUnits, Stop, StopUnits, Step, StepUnits)
            % ConfigureAnalyzerSweep
            % [RetVal] = ConfigureAnalyzerSweep(self, SweepControl, Spacing, Points, Start, StartUnits, Stop, StopUnits, Step, StepUnits)
            [RetVal] = self.upxHandle.ConfigureAnalyzerSweep(SweepControl, Spacing, Points, Start, StartUnits, Stop, StopUnits, Step, StepUnits);
        end
        function [RetVal] = ConfigureAnalyzerTHD(self, MeasMode, Harmonic, HarmonicState)
            % ConfigureAnalyzerTHD
            % [RetVal] = ConfigureAnalyzerTHD(self, MeasMode, Harmonic, HarmonicState)
            [RetVal] = self.upxHandle.ConfigureAnalyzerTHD(MeasMode, Harmonic, HarmonicState);
        end
        function [RetVal] = ConfigureAudioMonitoring(self, SignalSource, MonitoringChannel, Speaker, PhoneOutputreserved, Volume)
            % ConfigureAudioMonitoring
            % [RetVal] = ConfigureAudioMonitoring(self, SignalSource, MonitoringChannel, Speaker, PhoneOutputreserved, Volume)
            [RetVal] = self.upxHandle.ConfigureAudioMonitoring(SignalSource, MonitoringChannel, Speaker, PhoneOutputreserved, Volume);
        end
        function [RetVal] = ConfigureBPorBSFilter(self, FilterNumber, PassbLow, PassbUpp, Attenuation)
            % ConfigureBPorBSFilter
            % [RetVal] = ConfigureBPorBSFilter(self, FilterNumber, PassbLow, PassbUpp, Attenuation)
            [RetVal] = self.upxHandle.ConfigureBPorBSFilter(FilterNumber, PassbLow, PassbUpp, Attenuation);
        end
        function [RetVal] = ConfigureDigBitstreamAnalyzer(self, ClockSource, ChannelMode, Alignment, DwnsmplFact, ClockFrequency, DutyCycle)
            % ConfigureDigBitstreamAnalyzer
            % [RetVal] = ConfigureDigBitstreamAnalyzer(self, ClockSource, ChannelMode, Alignment, DwnsmplFact, ClockFrequency, DutyCycle)
            [RetVal] = self.upxHandle.ConfigureDigBitstreamAnalyzer(ClockSource, ChannelMode, Alignment, DwnsmplFact, ClockFrequency, DutyCycle);
        end
        function [RetVal] = ConfigureFileDefinedFilter(self, FilterNumber, FileDefinedFilter, FilterDelay)
            % ConfigureFileDefinedFilter
            % [RetVal] = ConfigureFileDefinedFilter(self, FilterNumber, FileDefinedFilter, FilterDelay)
            [RetVal] = self.upxHandle.ConfigureFileDefinedFilter(FilterNumber, FileDefinedFilter, FilterDelay);
        end
        function [RetVal] = ConfigureGeneratorAMModulation(self, ModFreq, ModFreqUnits, CarrierFreq, CarrierFreqUnits, ModDepth, CarrierVolt, CarrierVoltUnits)
            % ConfigureGeneratorAMModulation
            % [RetVal] = ConfigureGeneratorAMModulation(self, ModFreq, ModFreqUnits, CarrierFreq, CarrierFreqUnits, ModDepth, CarrierVolt, CarrierVoltUnits)
            [RetVal] = self.upxHandle.ConfigureGeneratorAMModulation(ModFreq, ModFreqUnits, CarrierFreq, CarrierFreqUnits, ModDepth, CarrierVolt, CarrierVoltUnits);
        end
        function [RetVal] = ConfigureGeneratorAnalog(self, Channel, OutputType, Impedance, Common, Bandwidth, VoltRange, MaxVoltage, Units)
            % ConfigureGeneratorAnalog
            % [RetVal] = ConfigureGeneratorAnalog(self, Channel, OutputType, Impedance, Common, Bandwidth, VoltRange, MaxVoltage, Units)
            [RetVal] = self.upxHandle.ConfigureGeneratorAnalog(Channel, OutputType, Impedance, Common, Bandwidth, VoltRange, MaxVoltage, Units);
        end
        function [RetVal] = ConfigureGeneratorArbitrary(self, ShapeFile, VoltPeak, Units)
            % ConfigureGeneratorArbitrary
            % [RetVal] = ConfigureGeneratorArbitrary(self, ShapeFile, VoltPeak, Units)
            [RetVal] = self.upxHandle.ConfigureGeneratorArbitrary(ShapeFile, VoltPeak, Units);
        end
        function [RetVal] = ConfigureGeneratorDFD(self, Mode, DiffFreq, DiffFreqUnits, MeanFreq, MeanFreqUnits, UpperFreq, UpperFreqUnits, VoltageValue, VoltageUnits)
            % ConfigureGeneratorDFD
            % [RetVal] = ConfigureGeneratorDFD(self, Mode, DiffFreq, DiffFreqUnits, MeanFreq, MeanFreqUnits, UpperFreq, UpperFreqUnits, VoltageValue, VoltageUnits)
            [RetVal] = self.upxHandle.ConfigureGeneratorDFD(Mode, DiffFreq, DiffFreqUnits, MeanFreq, MeanFreqUnits, UpperFreq, UpperFreqUnits, VoltageValue, VoltageUnits);
        end
        function [RetVal] = ConfigureGeneratorDIM(self, SquareSine, Bandwidth, VoltageValue, VoltageUnits)
            % ConfigureGeneratorDIM
            % [RetVal] = ConfigureGeneratorDIM(self, SquareSine, Bandwidth, VoltageValue, VoltageUnits)
            [RetVal] = self.upxHandle.ConfigureGeneratorDIM(SquareSine, Bandwidth, VoltageValue, VoltageUnits);
        end
        function [RetVal] = ConfigureGeneratorDigital(self, SyncTo, SampleFreq, SampleFreqValue, SyncOutput, IntClkFreq, SyncOutType, AuxOutput)
            % ConfigureGeneratorDigital
            % [RetVal] = ConfigureGeneratorDigital(self, SyncTo, SampleFreq, SampleFreqValue, SyncOutput, IntClkFreq, SyncOutType, AuxOutput)
            [RetVal] = self.upxHandle.ConfigureGeneratorDigital(SyncTo, SampleFreq, SampleFreqValue, SyncOutput, IntClkFreq, SyncOutType, AuxOutput);
        end
        function [RetVal] = ConfigureGeneratorDigitalAudioRefGen(self, RefGenData, PhaseToRef, FramePhaseValue, Units)
            % ConfigureGeneratorDigitalAudioRefGen
            % [RetVal] = ConfigureGeneratorDigitalAudioRefGen(self, RefGenData, PhaseToRef, FramePhaseValue, Units)
            [RetVal] = self.upxHandle.ConfigureGeneratorDigitalAudioRefGen(RefGenData, PhaseToRef, FramePhaseValue, Units);
        end
        function [RetVal] = ConfigureGeneratorFMModulation(self, ModFreq, ModFreqUnits, CarrierFreq, CarrierFreqUnits, Deviation, CarrierVolt, CarrierVoltUnits)
            % ConfigureGeneratorFMModulation
            % [RetVal] = ConfigureGeneratorFMModulation(self, ModFreq, ModFreqUnits, CarrierFreq, CarrierFreqUnits, Deviation, CarrierVolt, CarrierVoltUnits)
            [RetVal] = self.upxHandle.ConfigureGeneratorFMModulation(ModFreq, ModFreqUnits, CarrierFreq, CarrierFreqUnits, Deviation, CarrierVolt, CarrierVoltUnits);
        end
        function [RetVal] = ConfigureGeneratorI2S(self, SyncTo, WordLength, SampleFrequency, VariableSampleFrequency, MClkRatio, AudioBits, Format, FsyncShape, FsyncPolarity, WordOffset)
            % ConfigureGeneratorI2S
            % [RetVal] = ConfigureGeneratorI2S(self, SyncTo, WordLength, SampleFrequency, VariableSampleFrequency, MClkRatio, AudioBits, Format, FsyncShape, FsyncPolarity, WordOffset)
            [RetVal] = self.upxHandle.ConfigureGeneratorI2S(SyncTo, WordLength, SampleFrequency, VariableSampleFrequency, MClkRatio, AudioBits, Format, FsyncShape, FsyncPolarity, WordOffset);
        end
        function [RetVal] = ConfigureGeneratorModDist(self, UpperFreq, UpperFreqUnits, LowerFreq, LowerFreqUnits, VoltCh21, TotalVoltage, VoltageUnits)
            % ConfigureGeneratorModDist
            % [RetVal] = ConfigureGeneratorModDist(self, UpperFreq, UpperFreqUnits, LowerFreq, LowerFreqUnits, VoltCh21, TotalVoltage, VoltageUnits)
            [RetVal] = self.upxHandle.ConfigureGeneratorModDist(UpperFreq, UpperFreqUnits, LowerFreq, LowerFreqUnits, VoltCh21, TotalVoltage, VoltageUnits);
        end
        function [RetVal] = ConfigureGeneratorReference(self, RefVoltage, VoltageUnits, RefFrequency, FrequencyUnits)
            % ConfigureGeneratorReference
            % [RetVal] = ConfigureGeneratorReference(self, RefVoltage, VoltageUnits, RefFrequency, FrequencyUnits)
            [RetVal] = self.upxHandle.ConfigureGeneratorReference(RefVoltage, VoltageUnits, RefFrequency, FrequencyUnits);
        end
        function [RetVal] = ConfigureHDMIAnalyzerAudio(self, Input, AudioCoding)
            % ConfigureHDMIAnalyzerAudio
            % [RetVal] = ConfigureHDMIAnalyzerAudio(self, Input, AudioCoding)
            [RetVal] = self.upxHandle.ConfigureHDMIAnalyzerAudio(Input, AudioCoding);
        end
        function [RetVal] = ConfigureHDMIGeneratorAudio(self, AudioFormat, Channel, SyncTo, SampleFrequency, VariableSampleFrequency)
            % ConfigureHDMIGeneratorAudio
            % [RetVal] = ConfigureHDMIGeneratorAudio(self, AudioFormat, Channel, SyncTo, SampleFrequency, VariableSampleFrequency)
            [RetVal] = self.upxHandle.ConfigureHDMIGeneratorAudio(AudioFormat, Channel, SyncTo, SampleFrequency, VariableSampleFrequency);
        end
        function [RetVal] = ConfigureHDMIGeneratorVideo(self, Source, FormatResolution, FormatFrequency, ColorDepth)
            % ConfigureHDMIGeneratorVideo
            % [RetVal] = ConfigureHDMIGeneratorVideo(self, Source, FormatResolution, FormatFrequency, ColorDepth)
            [RetVal] = self.upxHandle.ConfigureHDMIGeneratorVideo(Source, FormatResolution, FormatFrequency, ColorDepth);
        end
        function [RetVal] = ConfigureLPorHPFilter(self, FilterNumber, FilterOrder, Passband, FilterAttenuation)
            % ConfigureLPorHPFilter
            % [RetVal] = ConfigureLPorHPFilter(self, FilterNumber, FilterOrder, Passband, FilterAttenuation)
            [RetVal] = self.upxHandle.ConfigureLPorHPFilter(FilterNumber, FilterOrder, Passband, FilterAttenuation);
        end
        function [RetVal] = ConfigureMeasurementFunctionsSettling(self, FnctSettling, Samples, Timeout, Resolution, Tolerance)
            % ConfigureMeasurementFunctionsSettling
            % [RetVal] = ConfigureMeasurementFunctionsSettling(self, FnctSettling, Samples, Timeout, Resolution, Tolerance)
            [RetVal] = self.upxHandle.ConfigureMeasurementFunctionsSettling(FnctSettling, Samples, Timeout, Resolution, Tolerance);
        end
        function [RetVal] = ConfigureNotchFilter(self, FilterNumber, CenterFreq, FilterWidth, FilterAttenuation)
            % ConfigureNotchFilter
            % [RetVal] = ConfigureNotchFilter(self, FilterNumber, CenterFreq, FilterWidth, FilterAttenuation)
            [RetVal] = self.upxHandle.ConfigureNotchFilter(FilterNumber, CenterFreq, FilterWidth, FilterAttenuation);
        end
        function [RetVal] = ConfigureOctaveFilter(self, FilterNumber, CenterFreq, FilterAttenuation)
            % ConfigureOctaveFilter
            % [RetVal] = ConfigureOctaveFilter(self, FilterNumber, CenterFreq, FilterAttenuation)
            [RetVal] = self.upxHandle.ConfigureOctaveFilter(FilterNumber, CenterFreq, FilterAttenuation);
        end
        function [RetVal] = ConfigureUSIAnalyzerClockAndFrequency(self, Clock, MixedSamplingFrequency, Ratio)
            % ConfigureUSIAnalyzerClockAndFrequency
            % [RetVal] = ConfigureUSIAnalyzerClockAndFrequency(self, Clock, MixedSamplingFrequency, Ratio)
            [RetVal] = self.upxHandle.ConfigureUSIAnalyzerClockAndFrequency(Clock, MixedSamplingFrequency, Ratio);
        end
        function [RetVal] = ConfigureUSIAnalyzerFrame(self, Samples, NumberOfSlots)
            % ConfigureUSIAnalyzerFrame
            % [RetVal] = ConfigureUSIAnalyzerFrame(self, Samples, NumberOfSlots)
            [RetVal] = self.upxHandle.ConfigureUSIAnalyzerFrame(Samples, NumberOfSlots);
        end
        function [RetVal] = ConfigureUSIAnalyzerFsync(self, FsyncWidth, VariableFsyncWidth, FsyncOffset, FsyncSlope)
            % ConfigureUSIAnalyzerFsync
            % [RetVal] = ConfigureUSIAnalyzerFsync(self, FsyncWidth, VariableFsyncWidth, FsyncOffset, FsyncSlope)
            [RetVal] = self.upxHandle.ConfigureUSIAnalyzerFsync(FsyncWidth, VariableFsyncWidth, FsyncOffset, FsyncSlope);
        end
        function [RetVal] = ConfigureUSIAnalyzerSlot(self, FirstBit, SlotLength, AudioBits, LeadBits)
            % ConfigureUSIAnalyzerSlot
            % [RetVal] = ConfigureUSIAnalyzerSlot(self, FirstBit, SlotLength, AudioBits, LeadBits)
            [RetVal] = self.upxHandle.ConfigureUSIAnalyzerSlot(FirstBit, SlotLength, AudioBits, LeadBits);
        end
        function [RetVal] = ConfigureUSIGeneratorClockAndFrequency(self, Clock, MixedSamplingFrequency, Ratio)
            % ConfigureUSIGeneratorClockAndFrequency
            % [RetVal] = ConfigureUSIGeneratorClockAndFrequency(self, Clock, MixedSamplingFrequency, Ratio)
            [RetVal] = self.upxHandle.ConfigureUSIGeneratorClockAndFrequency(Clock, MixedSamplingFrequency, Ratio);
        end
        function [RetVal] = ConfigureUSIGeneratorFrame(self, Samples, NumberOfSlots)
            % ConfigureUSIGeneratorFrame
            % [RetVal] = ConfigureUSIGeneratorFrame(self, Samples, NumberOfSlots)
            [RetVal] = self.upxHandle.ConfigureUSIGeneratorFrame(Samples, NumberOfSlots);
        end
        function [RetVal] = ConfigureUSIGeneratorFsync(self, FsyncWidth, VariableFsyncWidth, FsyncOffset, FsyncSlope)
            % ConfigureUSIGeneratorFsync
            % [RetVal] = ConfigureUSIGeneratorFsync(self, FsyncWidth, VariableFsyncWidth, FsyncOffset, FsyncSlope)
            [RetVal] = self.upxHandle.ConfigureUSIGeneratorFsync(FsyncWidth, VariableFsyncWidth, FsyncOffset, FsyncSlope);
        end
        function [RetVal] = ConfigureUSIGeneratorJitter(self, BClkJitterFrequency, BClkJitterAmplitude, MClkJitterFrequency, MClkJitterAmplitude)
            % ConfigureUSIGeneratorJitter
            % [RetVal] = ConfigureUSIGeneratorJitter(self, BClkJitterFrequency, BClkJitterAmplitude, MClkJitterFrequency, MClkJitterAmplitude)
            [RetVal] = self.upxHandle.ConfigureUSIGeneratorJitter(BClkJitterFrequency, BClkJitterAmplitude, MClkJitterFrequency, MClkJitterAmplitude);
        end
        function [RetVal] = ConfigureUSIGeneratorSlClk(self, SlClkWidth, VariableSlClkWidth, SlClkOffset, SlClkSlope)
            % ConfigureUSIGeneratorSlClk
            % [RetVal] = ConfigureUSIGeneratorSlClk(self, SlClkWidth, VariableSlClkWidth, SlClkOffset, SlClkSlope)
            [RetVal] = self.upxHandle.ConfigureUSIGeneratorSlClk(SlClkWidth, VariableSlClkWidth, SlClkOffset, SlClkSlope);
        end
        function [RetVal] = ConfigureUSIGeneratorSlot(self, FirstBit, SlotLength, AudioBits, LeadBits)
            % ConfigureUSIGeneratorSlot
            % [RetVal] = ConfigureUSIGeneratorSlot(self, FirstBit, SlotLength, AudioBits, LeadBits)
            [RetVal] = self.upxHandle.ConfigureUSIGeneratorSlot(FirstBit, SlotLength, AudioBits, LeadBits);
        end
        function [] = Dispose(self)
            % Dispose
            % [] = Dispose(self)
            self.upxHandle.Dispose();
        end
        function [RetVal] = Equals(self, obj)
            % Equals
            % [RetVal] = Equals(self, obj)
            [RetVal] = self.upxHandle.Equals(obj);
        end
        function [RetVal, ChannelMode] = GetAnalogAnalyzerChannelMode(self)
            % GetAnalogAnalyzerChannelMode
            % [RetVal, ChannelMode] = GetAnalogAnalyzerChannelMode(self)
            [RetVal, ChannelMode] = self.upxHandle.GetAnalogAnalyzerChannelMode();
        end
        function [RetVal, Bandwidth] = GetAnalyzerBandwidth(self)
            % GetAnalyzerBandwidth
            % [RetVal, Bandwidth] = GetAnalyzerBandwidth(self)
            [RetVal, Bandwidth] = self.upxHandle.GetAnalyzerBandwidth();
        end
        function [RetVal, BargraphState] = GetAnalyzerBargraphState(self)
            % GetAnalyzerBargraphState
            % [RetVal, BargraphState] = GetAnalyzerBargraphState(self)
            [RetVal, BargraphState] = self.upxHandle.GetAnalyzerBargraphState();
        end
        function [RetVal, Input] = GetAnalyzerChannelInput(self, Channel)
            % GetAnalyzerChannelInput
            % [RetVal, Input] = GetAnalyzerChannelInput(self, Channel)
            [RetVal, Input] = self.upxHandle.GetAnalyzerChannelInput(Channel);
        end
        function [RetVal, Common] = GetAnalyzerChannelInputCommon(self, Channel)
            % GetAnalyzerChannelInputCommon
            % [RetVal, Common] = GetAnalyzerChannelInputCommon(self, Channel)
            [RetVal, Common] = self.upxHandle.GetAnalyzerChannelInputCommon(Channel);
        end
        function [RetVal, Imped] = GetAnalyzerChannelInputImpedance(self, Channel)
            % GetAnalyzerChannelInputImpedance
            % [RetVal, Imped] = GetAnalyzerChannelInputImpedance(self, Channel)
            [RetVal, Imped] = self.upxHandle.GetAnalyzerChannelInputImpedance(Channel);
        end
        function [RetVal, Range] = GetAnalyzerChannelInputRange(self, Channel)
            % GetAnalyzerChannelInputRange
            % [RetVal, Range] = GetAnalyzerChannelInputRange(self, Channel)
            [RetVal, Range] = self.upxHandle.GetAnalyzerChannelInputRange(Channel);
        end
        function [RetVal, RangeValue] = GetAnalyzerChannelInputRangeValue(self, Channel)
            % GetAnalyzerChannelInputRangeValue
            % [RetVal, RangeValue] = GetAnalyzerChannelInputRangeValue(self, Channel)
            [RetVal, RangeValue] = self.upxHandle.GetAnalyzerChannelInputRangeValue(Channel);
        end
        function [RetVal, CombinedMeasurement] = GetAnalyzerCombinedMeasurement(self)
            % GetAnalyzerCombinedMeasurement
            % [RetVal, CombinedMeasurement] = GetAnalyzerCombinedMeasurement(self)
            [RetVal, CombinedMeasurement] = self.upxHandle.GetAnalyzerCombinedMeasurement();
        end
        function [RetVal, Coupling] = GetAnalyzerCoupling(self)
            % GetAnalyzerCoupling
            % [RetVal, Coupling] = GetAnalyzerCoupling(self)
            [RetVal, Coupling] = self.upxHandle.GetAnalyzerCoupling();
        end
        function [RetVal, DCSuppression] = GetAnalyzerDCSuppression(self)
            % GetAnalyzerDCSuppression
            % [RetVal, DCSuppression] = GetAnalyzerDCSuppression(self)
            [RetVal, DCSuppression] = self.upxHandle.GetAnalyzerDCSuppression();
        end
        function [RetVal, MeasurementMode] = GetAnalyzerDFDMeasurementMode(self)
            % GetAnalyzerDFDMeasurementMode
            % [RetVal, MeasurementMode] = GetAnalyzerDFDMeasurementMode(self)
            [RetVal, MeasurementMode] = self.upxHandle.GetAnalyzerDFDMeasurementMode();
        end
        function [RetVal, DynamicMode] = GetAnalyzerDynamicMode(self)
            % GetAnalyzerDynamicMode
            % [RetVal, DynamicMode] = GetAnalyzerDynamicMode(self)
            [RetVal, DynamicMode] = self.upxHandle.GetAnalyzerDynamicMode();
        end
        function [RetVal, AvgCount] = GetAnalyzerFFTAvgCount(self)
            % GetAnalyzerFFTAvgCount
            % [RetVal, AvgCount] = GetAnalyzerFFTAvgCount(self)
            [RetVal, AvgCount] = self.upxHandle.GetAnalyzerFFTAvgCount();
        end
        function [RetVal, AvgMode] = GetAnalyzerFFTAvgMode(self)
            % GetAnalyzerFFTAvgMode
            % [RetVal, AvgMode] = GetAnalyzerFFTAvgMode(self)
            [RetVal, AvgMode] = self.upxHandle.GetAnalyzerFFTAvgMode();
        end
        function [RetVal, CompFactor] = GetAnalyzerFFTCompFactor(self)
            % GetAnalyzerFFTCompFactor
            % [RetVal, CompFactor] = GetAnalyzerFFTCompFactor(self)
            [RetVal, CompFactor] = self.upxHandle.GetAnalyzerFFTCompFactor();
        end
        function [RetVal, DelayChannel1] = GetAnalyzerFFTDelayCh1(self)
            % GetAnalyzerFFTDelayCh1
            % [RetVal, DelayChannel1] = GetAnalyzerFFTDelayCh1(self)
            [RetVal, DelayChannel1] = self.upxHandle.GetAnalyzerFFTDelayCh1();
        end
        function [RetVal, Equalizer] = GetAnalyzerFFTEqualizer(self)
            % GetAnalyzerFFTEqualizer
            % [RetVal, Equalizer] = GetAnalyzerFFTEqualizer(self)
            [RetVal, Equalizer] = self.upxHandle.GetAnalyzerFFTEqualizer();
        end
        function [RetVal, FreqLimLow] = GetAnalyzerFFTFrequencyLimitLow(self)
            % GetAnalyzerFFTFrequencyLimitLow
            % [RetVal, FreqLimLow] = GetAnalyzerFFTFrequencyLimitLow(self)
            [RetVal, FreqLimLow] = self.upxHandle.GetAnalyzerFFTFrequencyLimitLow();
        end
        function [RetVal, LimitEnable] = GetAnalyzerFFTFrequencyLimitState(self)
            % GetAnalyzerFFTFrequencyLimitState
            % [RetVal, LimitEnable] = GetAnalyzerFFTFrequencyLimitState(self)
            [RetVal, LimitEnable] = self.upxHandle.GetAnalyzerFFTFrequencyLimitState();
        end
        function [RetVal, FreqLimUpp] = GetAnalyzerFFTFrequencyLimitUpp(self)
            % GetAnalyzerFFTFrequencyLimitUpp
            % [RetVal, FreqLimUpp] = GetAnalyzerFFTFrequencyLimitUpp(self)
            [RetVal, FreqLimUpp] = self.upxHandle.GetAnalyzerFFTFrequencyLimitUpp();
        end
        function [RetVal, FFTSize] = GetAnalyzerFFTMaxSize(self)
            % GetAnalyzerFFTMaxSize
            % [RetVal, FFTSize] = GetAnalyzerFFTMaxSize(self)
            [RetVal, FFTSize] = self.upxHandle.GetAnalyzerFFTMaxSize();
        end
        function [RetVal, MeasTime] = GetAnalyzerFFTMeasurementTime(self)
            % GetAnalyzerFFTMeasurementTime
            % [RetVal, MeasTime] = GetAnalyzerFFTMeasurementTime(self)
            [RetVal, MeasTime] = self.upxHandle.GetAnalyzerFFTMeasurementTime();
        end
        function [RetVal, FFTMonitor] = GetAnalyzerFFTMonitorState(self)
            % GetAnalyzerFFTMonitorState
            % [RetVal, FFTMonitor] = GetAnalyzerFFTMonitorState(self)
            [RetVal, FFTMonitor] = self.upxHandle.GetAnalyzerFFTMonitorState();
        end
        function [RetVal, Resolution] = GetAnalyzerFFTResolution(self)
            % GetAnalyzerFFTResolution
            % [RetVal, Resolution] = GetAnalyzerFFTResolution(self)
            [RetVal, Resolution] = self.upxHandle.GetAnalyzerFFTResolution();
        end
        function [RetVal, FFTSize] = GetAnalyzerFFTSize(self)
            % GetAnalyzerFFTSize
            % [RetVal, FFTSize] = GetAnalyzerFFTSize(self)
            [RetVal, FFTSize] = self.upxHandle.GetAnalyzerFFTSize();
        end
        function [RetVal, TriggeredFFTEnable] = GetAnalyzerFFTTriggeredState(self)
            % GetAnalyzerFFTTriggeredState
            % [RetVal, TriggeredFFTEnable] = GetAnalyzerFFTTriggeredState(self)
            [RetVal, TriggeredFFTEnable] = self.upxHandle.GetAnalyzerFFTTriggeredState();
        end
        function [RetVal, Undersample] = GetAnalyzerFFTUndersampleState(self)
            % GetAnalyzerFFTUndersampleState
            % [RetVal, Undersample] = GetAnalyzerFFTUndersampleState(self)
            [RetVal, Undersample] = self.upxHandle.GetAnalyzerFFTUndersampleState();
        end
        function [RetVal, Window] = GetAnalyzerFFTWindow(self)
            % GetAnalyzerFFTWindow
            % [RetVal, Window] = GetAnalyzerFFTWindow(self)
            [RetVal, Window] = self.upxHandle.GetAnalyzerFFTWindow();
        end
        function [RetVal, Center] = GetAnalyzerFFTZoomCenter(self)
            % GetAnalyzerFFTZoomCenter
            % [RetVal, Center] = GetAnalyzerFFTZoomCenter(self)
            [RetVal, Center] = self.upxHandle.GetAnalyzerFFTZoomCenter();
        end
        function [RetVal, Start] = GetAnalyzerFFTZoomStart(self)
            % GetAnalyzerFFTZoomStart
            % [RetVal, Start] = GetAnalyzerFFTZoomStart(self)
            [RetVal, Start] = self.upxHandle.GetAnalyzerFFTZoomStart();
        end
        function [RetVal, Stop] = GetAnalyzerFFTZoomStop(self)
            % GetAnalyzerFFTZoomStop
            % [RetVal, Stop] = GetAnalyzerFFTZoomStop(self)
            [RetVal, Stop] = self.upxHandle.GetAnalyzerFFTZoomStop();
        end
        function [RetVal, Filter] = GetAnalyzerFilter(self, FilterNumber)
            % GetAnalyzerFilter
            % [RetVal, Filter] = GetAnalyzerFilter(self, FilterNumber)
            [RetVal, Filter] = self.upxHandle.GetAnalyzerFilter(FilterNumber);
        end
        function [RetVal, FormatPhase] = GetAnalyzerFormatPhase(self)
            % GetAnalyzerFormatPhase
            % [RetVal, FormatPhase] = GetAnalyzerFormatPhase(self)
            [RetVal, FormatPhase] = self.upxHandle.GetAnalyzerFormatPhase();
        end
        function [RetVal, RefFrequency, RefPhase] = GetAnalyzerFrequencyPhaseReference(self)
            % GetAnalyzerFrequencyPhaseReference
            % [RetVal, RefFrequency, RefPhase] = GetAnalyzerFrequencyPhaseReference(self)
            [RetVal, RefFrequency, RefPhase] = self.upxHandle.GetAnalyzerFrequencyPhaseReference();
        end
        function [RetVal, RefFrequencyValue, FrequencyUnits, RefPhaseValue, PhaseUnits, GroupDelayRefValue, GroupDelayUnits] = GetAnalyzerFrequencyPhaseReferenceValue(self)
            % GetAnalyzerFrequencyPhaseReferenceValue
            % [RetVal, RefFrequencyValue, FrequencyUnits, RefPhaseValue, PhaseUnits, GroupDelayRefValue, GroupDelayUnits] = GetAnalyzerFrequencyPhaseReferenceValue(self)
            [RetVal, RefFrequencyValue, FrequencyUnits, RefPhaseValue, PhaseUnits, GroupDelayRefValue, GroupDelayUnits] = self.upxHandle.GetAnalyzerFrequencyPhaseReferenceValue();
        end
        function [RetVal, FrequencyUnitAuto, PhaseUnitAuto] = GetAnalyzerFrequencyPhaseUnitAuto(self, Channel)
            % GetAnalyzerFrequencyPhaseUnitAuto
            % [RetVal, FrequencyUnitAuto, PhaseUnitAuto] = GetAnalyzerFrequencyPhaseUnitAuto(self, Channel)
            [RetVal, FrequencyUnitAuto, PhaseUnitAuto] = self.upxHandle.GetAnalyzerFrequencyPhaseUnitAuto(Channel);
        end
        function [RetVal, FrequencyUserUnit, PhaseUserUnit] = GetAnalyzerFrequencyPhaseUserUnit(self, Channel)
            % GetAnalyzerFrequencyPhaseUserUnit
            % [RetVal, FrequencyUserUnit, PhaseUserUnit] = GetAnalyzerFrequencyPhaseUserUnit(self, Channel)
            FrequencyUserUnit = System.Text.StringBuilder(256);
            PhaseUserUnit = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetAnalyzerFrequencyPhaseUserUnit(Channel, FrequencyUserUnit, PhaseUserUnit);
            FrequencyUserUnit = char(FrequencyUserUnit.ToString);
            PhaseUserUnit = char(PhaseUserUnit.ToString);
        end
        function [RetVal, Units] = GetAnalyzerFrequencyUnit(self, Channel)
            % GetAnalyzerFrequencyUnit
            % [RetVal, Units] = GetAnalyzerFrequencyUnit(self, Channel)
            [RetVal, Units] = self.upxHandle.GetAnalyzerFrequencyUnit(Channel);
        end
        function [RetVal, Function] = GetAnalyzerFunction(self)
            % GetAnalyzerFunction
            % [RetVal, Function] = GetAnalyzerFunction(self)
            [RetVal, Function] = self.upxHandle.GetAnalyzerFunction();
        end
        function [RetVal, InputMonitor] = GetAnalyzerInputMonitor(self)
            % GetAnalyzerInputMonitor
            % [RetVal, InputMonitor] = GetAnalyzerInputMonitor(self)
            [RetVal, InputMonitor] = self.upxHandle.GetAnalyzerInputMonitor();
        end
        function [RetVal, Instrument] = GetAnalyzerInstrument(self)
            % GetAnalyzerInstrument
            % [RetVal, Instrument] = GetAnalyzerInstrument(self)
            [RetVal, Instrument] = self.upxHandle.GetAnalyzerInstrument();
        end
        function [RetVal, MeasTime] = GetAnalyzerLevelDCMeasTime(self)
            % GetAnalyzerLevelDCMeasTime
            % [RetVal, MeasTime] = GetAnalyzerLevelDCMeasTime(self)
            [RetVal, MeasTime] = self.upxHandle.GetAnalyzerLevelDCMeasTime();
        end
        function [RetVal, Bandwidth] = GetAnalyzerLevelMeasBandwidth(self)
            % GetAnalyzerLevelMeasBandwidth
            % [RetVal, Bandwidth] = GetAnalyzerLevelMeasBandwidth(self)
            [RetVal, Bandwidth] = self.upxHandle.GetAnalyzerLevelMeasBandwidth();
        end
        function [RetVal, BandwidthValue] = GetAnalyzerLevelMeasBandwidthValue(self)
            % GetAnalyzerLevelMeasBandwidthValue
            % [RetVal, BandwidthValue] = GetAnalyzerLevelMeasBandwidthValue(self)
            [RetVal, BandwidthValue] = self.upxHandle.GetAnalyzerLevelMeasBandwidthValue();
        end
        function [RetVal, FrequencyFactor] = GetAnalyzerLevelMeasFrequencyFactor(self)
            % GetAnalyzerLevelMeasFrequencyFactor
            % [RetVal, FrequencyFactor] = GetAnalyzerLevelMeasFrequencyFactor(self)
            [RetVal, FrequencyFactor] = self.upxHandle.GetAnalyzerLevelMeasFrequencyFactor();
        end
        function [RetVal, FrequencyMode] = GetAnalyzerLevelMeasFrequencyMode(self)
            % GetAnalyzerLevelMeasFrequencyMode
            % [RetVal, FrequencyMode] = GetAnalyzerLevelMeasFrequencyMode(self)
            [RetVal, FrequencyMode] = self.upxHandle.GetAnalyzerLevelMeasFrequencyMode();
        end
        function [RetVal, FrequencyStart] = GetAnalyzerLevelMeasFrequencyStart(self)
            % GetAnalyzerLevelMeasFrequencyStart
            % [RetVal, FrequencyStart] = GetAnalyzerLevelMeasFrequencyStart(self)
            [RetVal, FrequencyStart] = self.upxHandle.GetAnalyzerLevelMeasFrequencyStart();
        end
        function [RetVal, FrequencyStop] = GetAnalyzerLevelMeasFrequencyStop(self)
            % GetAnalyzerLevelMeasFrequencyStop
            % [RetVal, FrequencyStop] = GetAnalyzerLevelMeasFrequencyStop(self)
            [RetVal, FrequencyStop] = self.upxHandle.GetAnalyzerLevelMeasFrequencyStop();
        end
        function [RetVal, FrequencyValue] = GetAnalyzerLevelMeasFrequencyValue(self)
            % GetAnalyzerLevelMeasFrequencyValue
            % [RetVal, FrequencyValue] = GetAnalyzerLevelMeasFrequencyValue(self)
            [RetVal, FrequencyValue] = self.upxHandle.GetAnalyzerLevelMeasFrequencyValue();
        end
        function [RetVal, MeasTime] = GetAnalyzerLevelMeasTime(self)
            % GetAnalyzerLevelMeasTime
            % [RetVal, MeasTime] = GetAnalyzerLevelMeasTime(self)
            [RetVal, MeasTime] = self.upxHandle.GetAnalyzerLevelMeasTime();
        end
        function [RetVal, MeasTimeValue] = GetAnalyzerLevelMeasTimeValue(self)
            % GetAnalyzerLevelMeasTimeValue
            % [RetVal, MeasTimeValue] = GetAnalyzerLevelMeasTimeValue(self)
            [RetVal, MeasTimeValue] = self.upxHandle.GetAnalyzerLevelMeasTimeValue();
        end
        function [RetVal, LevelMonitor] = GetAnalyzerLevelMonitor(self)
            % GetAnalyzerLevelMonitor
            % [RetVal, LevelMonitor] = GetAnalyzerLevelMonitor(self)
            [RetVal, LevelMonitor] = self.upxHandle.GetAnalyzerLevelMonitor();
        end
        function [RetVal, MeasTime] = GetAnalyzerMeasurementTime(self)
            % GetAnalyzerMeasurementTime
            % [RetVal, MeasTime] = GetAnalyzerMeasurementTime(self)
            [RetVal, MeasTime] = self.upxHandle.GetAnalyzerMeasurementTime();
        end
        function [RetVal, MeasMode] = GetAnalyzerNOCTMeasMode(self)
            % GetAnalyzerNOCTMeasMode
            % [RetVal, MeasMode] = GetAnalyzerNOCTMeasMode(self)
            [RetVal, MeasMode] = self.upxHandle.GetAnalyzerNOCTMeasMode();
        end
        function [RetVal, NotchCenterFrequency] = GetAnalyzerNotchCenterFrequency(self)
            % GetAnalyzerNotchCenterFrequency
            % [RetVal, NotchCenterFrequency] = GetAnalyzerNotchCenterFrequency(self)
            [RetVal, NotchCenterFrequency] = self.upxHandle.GetAnalyzerNotchCenterFrequency();
        end
        function [RetVal, NotchFrequency] = GetAnalyzerNotchFrequency(self)
            % GetAnalyzerNotchFrequency
            % [RetVal, NotchFrequency] = GetAnalyzerNotchFrequency(self)
            [RetVal, NotchFrequency] = self.upxHandle.GetAnalyzerNotchFrequency();
        end
        function [RetVal, NotchGain] = GetAnalyzerNotchGain(self)
            % GetAnalyzerNotchGain
            % [RetVal, NotchGain] = GetAnalyzerNotchGain(self)
            [RetVal, NotchGain] = self.upxHandle.GetAnalyzerNotchGain();
        end
        function [RetVal, AvgDelay] = GetAnalyzerPEAQAvgDelay(self)
            % GetAnalyzerPEAQAvgDelay
            % [RetVal, AvgDelay] = GetAnalyzerPEAQAvgDelay(self)
            [RetVal, AvgDelay] = self.upxHandle.GetAnalyzerPEAQAvgDelay();
        end
        function [RetVal, DegLevel] = GetAnalyzerPEAQDegLevel(self)
            % GetAnalyzerPEAQDegLevel
            % [RetVal, DegLevel] = GetAnalyzerPEAQDegLevel(self)
            [RetVal, DegLevel] = self.upxHandle.GetAnalyzerPEAQDegLevel();
        end
        function [RetVal, DelayDetect] = GetAnalyzerPEAQDelayDetect(self)
            % GetAnalyzerPEAQDelayDetect
            % [RetVal, DelayDetect] = GetAnalyzerPEAQDelayDetect(self)
            [RetVal, DelayDetect] = self.upxHandle.GetAnalyzerPEAQDelayDetect();
        end
        function [RetVal, MeasurementMode] = GetAnalyzerPEAQMeasurementMode(self)
            % GetAnalyzerPEAQMeasurementMode
            % [RetVal, MeasurementMode] = GetAnalyzerPEAQMeasurementMode(self)
            [RetVal, MeasurementMode] = self.upxHandle.GetAnalyzerPEAQMeasurementMode();
        end
        function [RetVal, ModelVersion] = GetAnalyzerPEAQModel(self)
            % GetAnalyzerPEAQModel
            % [RetVal, ModelVersion] = GetAnalyzerPEAQModel(self)
            [RetVal, ModelVersion] = self.upxHandle.GetAnalyzerPEAQModel();
        end
        function [RetVal, ReferenceLevel] = GetAnalyzerPEAQReferenceLevel(self)
            % GetAnalyzerPEAQReferenceLevel
            % [RetVal, ReferenceLevel] = GetAnalyzerPEAQReferenceLevel(self)
            [RetVal, ReferenceLevel] = self.upxHandle.GetAnalyzerPEAQReferenceLevel();
        end
        function [RetVal, AccordingTo] = GetAnalyzerPESQAccordingTo(self)
            % GetAnalyzerPESQAccordingTo
            % [RetVal, AccordingTo] = GetAnalyzerPESQAccordingTo(self)
            [RetVal, AccordingTo] = self.upxHandle.GetAnalyzerPESQAccordingTo();
        end
        function [RetVal, AvgDelay] = GetAnalyzerPESQAvgDelay(self)
            % GetAnalyzerPESQAvgDelay
            % [RetVal, AvgDelay] = GetAnalyzerPESQAvgDelay(self)
            [RetVal, AvgDelay] = self.upxHandle.GetAnalyzerPESQAvgDelay();
        end
        function [RetVal, DegLevel] = GetAnalyzerPESQDegLevel(self)
            % GetAnalyzerPESQDegLevel
            % [RetVal, DegLevel] = GetAnalyzerPESQDegLevel(self)
            [RetVal, DegLevel] = self.upxHandle.GetAnalyzerPESQDegLevel();
        end
        function [RetVal, MeasurementMode] = GetAnalyzerPESQMeasurementMode(self)
            % GetAnalyzerPESQMeasurementMode
            % [RetVal, MeasurementMode] = GetAnalyzerPESQMeasurementMode(self)
            [RetVal, MeasurementMode] = self.upxHandle.GetAnalyzerPESQMeasurementMode();
        end
        function [RetVal, ReferenceLevel] = GetAnalyzerPESQReferenceLevel(self)
            % GetAnalyzerPESQReferenceLevel
            % [RetVal, ReferenceLevel] = GetAnalyzerPESQReferenceLevel(self)
            [RetVal, ReferenceLevel] = self.upxHandle.GetAnalyzerPESQReferenceLevel();
        end
        function [RetVal, Attenuation] = GetAnalyzerPOLQAAttenuation(self)
            % GetAnalyzerPOLQAAttenuation
            % [RetVal, Attenuation] = GetAnalyzerPOLQAAttenuation(self)
            [RetVal, Attenuation] = self.upxHandle.GetAnalyzerPOLQAAttenuation();
        end
        function [RetVal, Band] = GetAnalyzerPOLQABand(self)
            % GetAnalyzerPOLQABand
            % [RetVal, Band] = GetAnalyzerPOLQABand(self)
            [RetVal, Band] = self.upxHandle.GetAnalyzerPOLQABand();
        end
        function [RetVal, DegLevel] = GetAnalyzerPOLQADegLevel(self)
            % GetAnalyzerPOLQADegLevel
            % [RetVal, DegLevel] = GetAnalyzerPOLQADegLevel(self)
            [RetVal, DegLevel] = self.upxHandle.GetAnalyzerPOLQADegLevel();
        end
        function [RetVal, DegSpRatio] = GetAnalyzerPOLQADegSpRatio(self)
            % GetAnalyzerPOLQADegSpRatio
            % [RetVal, DegSpRatio] = GetAnalyzerPOLQADegSpRatio(self)
            [RetVal, DegSpRatio] = self.upxHandle.GetAnalyzerPOLQADegSpRatio();
        end
        function [RetVal, Gain] = GetAnalyzerPOLQAGain(self)
            % GetAnalyzerPOLQAGain
            % [RetVal, Gain] = GetAnalyzerPOLQAGain(self)
            [RetVal, Gain] = self.upxHandle.GetAnalyzerPOLQAGain();
        end
        function [RetVal, MaxDelay] = GetAnalyzerPOLQAMaxDelay(self)
            % GetAnalyzerPOLQAMaxDelay
            % [RetVal, MaxDelay] = GetAnalyzerPOLQAMaxDelay(self)
            [RetVal, MaxDelay] = self.upxHandle.GetAnalyzerPOLQAMaxDelay();
        end
        function [RetVal, MeasurementMode] = GetAnalyzerPOLQAMeasurementMode(self)
            % GetAnalyzerPOLQAMeasurementMode
            % [RetVal, MeasurementMode] = GetAnalyzerPOLQAMeasurementMode(self)
            [RetVal, MeasurementMode] = self.upxHandle.GetAnalyzerPOLQAMeasurementMode();
        end
        function [RetVal, MinDelay] = GetAnalyzerPOLQAMinDelay(self)
            % GetAnalyzerPOLQAMinDelay
            % [RetVal, MinDelay] = GetAnalyzerPOLQAMinDelay(self)
            [RetVal, MinDelay] = self.upxHandle.GetAnalyzerPOLQAMinDelay();
        end
        function [RetVal, RefSpRatio] = GetAnalyzerPOLQARefSpRatio(self)
            % GetAnalyzerPOLQARefSpRatio
            % [RetVal, RefSpRatio] = GetAnalyzerPOLQARefSpRatio(self)
            [RetVal, RefSpRatio] = self.upxHandle.GetAnalyzerPOLQARefSpRatio();
        end
        function [RetVal, RefLevel] = GetAnalyzerPOLQAReferenceLevel(self)
            % GetAnalyzerPOLQAReferenceLevel
            % [RetVal, RefLevel] = GetAnalyzerPOLQAReferenceLevel(self)
            [RetVal, RefLevel] = self.upxHandle.GetAnalyzerPOLQAReferenceLevel();
        end
        function [RetVal, SNRDegraded] = GetAnalyzerPOLQASNRDegraded(self)
            % GetAnalyzerPOLQASNRDegraded
            % [RetVal, SNRDegraded] = GetAnalyzerPOLQASNRDegraded(self)
            [RetVal, SNRDegraded] = self.upxHandle.GetAnalyzerPOLQASNRDegraded();
        end
        function [RetVal, SNRRef] = GetAnalyzerPOLQASNRRef(self)
            % GetAnalyzerPOLQASNRRef
            % [RetVal, SNRRef] = GetAnalyzerPOLQASNRRef(self)
            [RetVal, SNRRef] = self.upxHandle.GetAnalyzerPOLQASNRRef();
        end
        function [RetVal, IntervalTime] = GetAnalyzerPeakMeasIntervalTime(self)
            % GetAnalyzerPeakMeasIntervalTime
            % [RetVal, IntervalTime] = GetAnalyzerPeakMeasIntervalTime(self)
            [RetVal, IntervalTime] = self.upxHandle.GetAnalyzerPeakMeasIntervalTime();
        end
        function [RetVal, IntervalTimeValue] = GetAnalyzerPeakMeasIntervalTimeValue(self)
            % GetAnalyzerPeakMeasIntervalTimeValue
            % [RetVal, IntervalTimeValue] = GetAnalyzerPeakMeasIntervalTimeValue(self)
            [RetVal, IntervalTimeValue] = self.upxHandle.GetAnalyzerPeakMeasIntervalTimeValue();
        end
        function [RetVal, MeasMode] = GetAnalyzerPeakMeasMode(self)
            % GetAnalyzerPeakMeasMode
            % [RetVal, MeasMode] = GetAnalyzerPeakMeasMode(self)
            [RetVal, MeasMode] = self.upxHandle.GetAnalyzerPeakMeasMode();
        end
        function [RetVal, Units] = GetAnalyzerPhaseUnit(self)
            % GetAnalyzerPhaseUnit
            % [RetVal, Units] = GetAnalyzerPhaseUnit(self)
            [RetVal, Units] = self.upxHandle.GetAnalyzerPhaseUnit();
        end
        function [RetVal, PostFFT] = GetAnalyzerPostFFTState(self)
            % GetAnalyzerPostFFTState
            % [RetVal, PostFFT] = GetAnalyzerPostFFTState(self)
            [RetVal, PostFFT] = self.upxHandle.GetAnalyzerPostFFTState();
        end
        function [RetVal, PrenFilter] = GetAnalyzerPrefilter(self)
            % GetAnalyzerPrefilter
            % [RetVal, PrenFilter] = GetAnalyzerPrefilter(self)
            [RetVal, PrenFilter] = self.upxHandle.GetAnalyzerPrefilter();
        end
        function [RetVal, FileLength] = GetAnalyzerRecordFileLength(self)
            % GetAnalyzerRecordFileLength
            % [RetVal, FileLength] = GetAnalyzerRecordFileLength(self)
            [RetVal, FileLength] = self.upxHandle.GetAnalyzerRecordFileLength();
        end
        function [RetVal, RecordLength, Units] = GetAnalyzerRecordLength(self)
            % GetAnalyzerRecordLength
            % [RetVal, RecordLength, Units] = GetAnalyzerRecordLength(self)
            [RetVal, RecordLength, Units] = self.upxHandle.GetAnalyzerRecordLength();
        end
        function [RetVal, RecordPretrigger, Units] = GetAnalyzerRecordPretrigger(self)
            % GetAnalyzerRecordPretrigger
            % [RetVal, RecordPretrigger, Units] = GetAnalyzerRecordPretrigger(self)
            [RetVal, RecordPretrigger, Units] = self.upxHandle.GetAnalyzerRecordPretrigger();
        end
        function [RetVal, TriggerLevel, Units] = GetAnalyzerRecordTriggerLevel(self)
            % GetAnalyzerRecordTriggerLevel
            % [RetVal, TriggerLevel, Units] = GetAnalyzerRecordTriggerLevel(self)
            [RetVal, TriggerLevel, Units] = self.upxHandle.GetAnalyzerRecordTriggerLevel();
        end
        function [RetVal, TriggerSlope] = GetAnalyzerRecordTriggerSlope(self)
            % GetAnalyzerRecordTriggerSlope
            % [RetVal, TriggerSlope] = GetAnalyzerRecordTriggerSlope(self)
            [RetVal, TriggerSlope] = self.upxHandle.GetAnalyzerRecordTriggerSlope();
        end
        function [RetVal, TriggerSource] = GetAnalyzerRecordTriggerSource(self)
            % GetAnalyzerRecordTriggerSource
            % [RetVal, TriggerSource] = GetAnalyzerRecordTriggerSource(self)
            [RetVal, TriggerSource] = self.upxHandle.GetAnalyzerRecordTriggerSource();
        end
        function [RetVal, RefImped] = GetAnalyzerRefImpedance(self)
            % GetAnalyzerRefImpedance
            % [RetVal, RefImped] = GetAnalyzerRefImpedance(self)
            [RetVal, RefImped] = self.upxHandle.GetAnalyzerRefImpedance();
        end
        function [RetVal, Reference] = GetAnalyzerReference(self, Channel, Measurement)
            % GetAnalyzerReference
            % [RetVal, Reference] = GetAnalyzerReference(self, Channel, Measurement)
            [RetVal, Reference] = self.upxHandle.GetAnalyzerReference(Channel, Measurement);
        end
        function [RetVal, ReferenceValue, Units] = GetAnalyzerReferenceValue(self, Channel, Measurement)
            % GetAnalyzerReferenceValue
            % [RetVal, ReferenceValue, Units] = GetAnalyzerReferenceValue(self, Channel, Measurement)
            [RetVal, ReferenceValue, Units] = self.upxHandle.GetAnalyzerReferenceValue(Channel, Measurement);
        end
        function [RetVal, Refinement] = GetAnalyzerRefinement(self)
            % GetAnalyzerRefinement
            % [RetVal, Refinement] = GetAnalyzerRefinement(self)
            [RetVal, Refinement] = self.upxHandle.GetAnalyzerRefinement();
        end
        function [RetVal, MeasMode] = GetAnalyzerSNMeasMode(self)
            % GetAnalyzerSNMeasMode
            % [RetVal, MeasMode] = GetAnalyzerSNMeasMode(self)
            [RetVal, MeasMode] = self.upxHandle.GetAnalyzerSNMeasMode();
        end
        function [RetVal, MeasTime] = GetAnalyzerSNMeasTime(self)
            % GetAnalyzerSNMeasTime
            % [RetVal, MeasTime] = GetAnalyzerSNMeasTime(self)
            [RetVal, MeasTime] = self.upxHandle.GetAnalyzerSNMeasTime();
        end
        function [RetVal, SNEnable] = GetAnalyzerSNSequenceState(self)
            % GetAnalyzerSNSequenceState
            % [RetVal, SNEnable] = GetAnalyzerSNSequenceState(self)
            [RetVal, SNEnable] = self.upxHandle.GetAnalyzerSNSequenceState();
        end
        function [RetVal, SampleFrequency, SampleFrequencyValue] = GetAnalyzerSampleFrequency(self)
            % GetAnalyzerSampleFrequency
            % [RetVal, SampleFrequency, SampleFrequencyValue] = GetAnalyzerSampleFrequency(self)
            [RetVal, SampleFrequency, SampleFrequencyValue] = self.upxHandle.GetAnalyzerSampleFrequency();
        end
        function [RetVal, StartCondition] = GetAnalyzerStartCondition(self)
            % GetAnalyzerStartCondition
            % [RetVal, StartCondition] = GetAnalyzerStartCondition(self)
            [RetVal, StartCondition] = self.upxHandle.GetAnalyzerStartCondition();
        end
        function [RetVal, StartDelay] = GetAnalyzerStartDelay(self)
            % GetAnalyzerStartDelay
            % [RetVal, StartDelay] = GetAnalyzerStartDelay(self)
            [RetVal, StartDelay] = self.upxHandle.GetAnalyzerStartDelay();
        end
        function [RetVal, SweepControl] = GetAnalyzerSweepControl(self)
            % GetAnalyzerSweepControl
            % [RetVal, SweepControl] = GetAnalyzerSweepControl(self)
            [RetVal, SweepControl] = self.upxHandle.GetAnalyzerSweepControl();
        end
        function [RetVal, Points] = GetAnalyzerSweepPoints(self)
            % GetAnalyzerSweepPoints
            % [RetVal, Points] = GetAnalyzerSweepPoints(self)
            [RetVal, Points] = self.upxHandle.GetAnalyzerSweepPoints();
        end
        function [RetVal, Spacing] = GetAnalyzerSweepSpacing(self)
            % GetAnalyzerSweepSpacing
            % [RetVal, Spacing] = GetAnalyzerSweepSpacing(self)
            [RetVal, Spacing] = self.upxHandle.GetAnalyzerSweepSpacing();
        end
        function [RetVal, Start, Units] = GetAnalyzerSweepStart(self)
            % GetAnalyzerSweepStart
            % [RetVal, Start, Units] = GetAnalyzerSweepStart(self)
            [RetVal, Start, Units] = self.upxHandle.GetAnalyzerSweepStart();
        end
        function [RetVal, Step, Units] = GetAnalyzerSweepSteps(self)
            % GetAnalyzerSweepSteps
            % [RetVal, Step, Units] = GetAnalyzerSweepSteps(self)
            [RetVal, Step, Units] = self.upxHandle.GetAnalyzerSweepSteps();
        end
        function [RetVal, Stop, Units] = GetAnalyzerSweepStop(self)
            % GetAnalyzerSweepStop
            % [RetVal, Stop, Units] = GetAnalyzerSweepStop(self)
            [RetVal, Stop, Units] = self.upxHandle.GetAnalyzerSweepStop();
        end
        function [RetVal, Fundamental] = GetAnalyzerTHDFundamental(self)
            % GetAnalyzerTHDFundamental
            % [RetVal, Fundamental] = GetAnalyzerTHDFundamental(self)
            [RetVal, Fundamental] = self.upxHandle.GetAnalyzerTHDFundamental();
        end
        function [RetVal, FundamentalValue] = GetAnalyzerTHDFundamentalValue(self)
            % GetAnalyzerTHDFundamentalValue
            % [RetVal, FundamentalValue] = GetAnalyzerTHDFundamentalValue(self)
            [RetVal, FundamentalValue] = self.upxHandle.GetAnalyzerTHDFundamentalValue();
        end
        function [RetVal, HarmonicState] = GetAnalyzerTHDHarmonicState(self, Harmonic)
            % GetAnalyzerTHDHarmonicState
            % [RetVal, HarmonicState] = GetAnalyzerTHDHarmonicState(self, Harmonic)
            [RetVal, HarmonicState] = self.upxHandle.GetAnalyzerTHDHarmonicState(Harmonic);
        end
        function [RetVal, MeasMode] = GetAnalyzerTHDMeasMode(self)
            % GetAnalyzerTHDMeasMode
            % [RetVal, MeasMode] = GetAnalyzerTHDMeasMode(self)
            [RetVal, MeasMode] = self.upxHandle.GetAnalyzerTHDMeasMode();
        end
        function [RetVal, Equalizer] = GetAnalyzerTHDNEqualizer(self)
            % GetAnalyzerTHDNEqualizer
            % [RetVal, Equalizer] = GetAnalyzerTHDNEqualizer(self)
            [RetVal, Equalizer] = self.upxHandle.GetAnalyzerTHDNEqualizer();
        end
        function [RetVal, FreqLimLow] = GetAnalyzerTHDNFrequencyLimLow(self)
            % GetAnalyzerTHDNFrequencyLimLow
            % [RetVal, FreqLimLow] = GetAnalyzerTHDNFrequencyLimLow(self)
            [RetVal, FreqLimLow] = self.upxHandle.GetAnalyzerTHDNFrequencyLimLow();
        end
        function [RetVal, FreqLimUpp] = GetAnalyzerTHDNFrequencyLimUpp(self)
            % GetAnalyzerTHDNFrequencyLimUpp
            % [RetVal, FreqLimUpp] = GetAnalyzerTHDNFrequencyLimUpp(self)
            [RetVal, FreqLimUpp] = self.upxHandle.GetAnalyzerTHDNFrequencyLimUpp();
        end
        function [RetVal, MeasurementMode] = GetAnalyzerTHDNMeasurementMode(self)
            % GetAnalyzerTHDNMeasurementMode
            % [RetVal, MeasurementMode] = GetAnalyzerTHDNMeasurementMode(self)
            [RetVal, MeasurementMode] = self.upxHandle.GetAnalyzerTHDNMeasurementMode();
        end
        function [RetVal, RejectBandwidth] = GetAnalyzerTHDNRejectBandwidth(self)
            % GetAnalyzerTHDNRejectBandwidth
            % [RetVal, RejectBandwidth] = GetAnalyzerTHDNRejectBandwidth(self)
            [RetVal, RejectBandwidth] = self.upxHandle.GetAnalyzerTHDNRejectBandwidth();
        end
        function [RetVal, Rejection] = GetAnalyzerTHDNRejection(self)
            % GetAnalyzerTHDNRejection
            % [RetVal, Rejection] = GetAnalyzerTHDNRejection(self)
            [RetVal, Rejection] = self.upxHandle.GetAnalyzerTHDNRejection();
        end
        function [RetVal, Samples] = GetAnalyzerTriggerSettlingCount(self)
            % GetAnalyzerTriggerSettlingCount
            % [RetVal, Samples] = GetAnalyzerTriggerSettlingCount(self)
            [RetVal, Samples] = self.upxHandle.GetAnalyzerTriggerSettlingCount();
        end
        function [RetVal, Settling] = GetAnalyzerTriggerSettlingMode(self)
            % GetAnalyzerTriggerSettlingMode
            % [RetVal, Settling] = GetAnalyzerTriggerSettlingMode(self)
            [RetVal, Settling] = self.upxHandle.GetAnalyzerTriggerSettlingMode();
        end
        function [RetVal, Resolution] = GetAnalyzerTriggerSettlingResolution(self)
            % GetAnalyzerTriggerSettlingResolution
            % [RetVal, Resolution] = GetAnalyzerTriggerSettlingResolution(self)
            [RetVal, Resolution] = self.upxHandle.GetAnalyzerTriggerSettlingResolution();
        end
        function [RetVal, Tolerance] = GetAnalyzerTriggerSettlingTolerance(self)
            % GetAnalyzerTriggerSettlingTolerance
            % [RetVal, Tolerance] = GetAnalyzerTriggerSettlingTolerance(self)
            [RetVal, Tolerance] = self.upxHandle.GetAnalyzerTriggerSettlingTolerance();
        end
        function [RetVal, Units] = GetAnalyzerUnit(self, Channel, Measurement)
            % GetAnalyzerUnit
            % [RetVal, Units] = GetAnalyzerUnit(self, Channel, Measurement)
            [RetVal, Units] = self.upxHandle.GetAnalyzerUnit(Channel, Measurement);
        end
        function [RetVal, UnitAuto] = GetAnalyzerUnitAuto(self, Channel, Measurement)
            % GetAnalyzerUnitAuto
            % [RetVal, UnitAuto] = GetAnalyzerUnitAuto(self, Channel, Measurement)
            [RetVal, UnitAuto] = self.upxHandle.GetAnalyzerUnitAuto(Channel, Measurement);
        end
        function [RetVal, UserUnit] = GetAnalyzerUserUnit(self, Channel, Measurement)
            % GetAnalyzerUserUnit
            % [RetVal, UserUnit] = GetAnalyzerUserUnit(self, Channel, Measurement)
            UserUnit = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetAnalyzerUserUnit(Channel, Measurement, UserUnit);
            UserUnit = char(UserUnit.ToString);
        end
        function [RetVal, Autotrigger] = GetAnalyzerWaveformMonitorAutotrigger(self)
            % GetAnalyzerWaveformMonitorAutotrigger
            % [RetVal, Autotrigger] = GetAnalyzerWaveformMonitorAutotrigger(self)
            [RetVal, Autotrigger] = self.upxHandle.GetAnalyzerWaveformMonitorAutotrigger();
        end
        function [RetVal, CompressionFactor] = GetAnalyzerWaveformMonitorCompressionFactor(self)
            % GetAnalyzerWaveformMonitorCompressionFactor
            % [RetVal, CompressionFactor] = GetAnalyzerWaveformMonitorCompressionFactor(self)
            [RetVal, CompressionFactor] = self.upxHandle.GetAnalyzerWaveformMonitorCompressionFactor();
        end
        function [RetVal, MeasMode] = GetAnalyzerWaveformMonitorMeasMode(self)
            % GetAnalyzerWaveformMonitorMeasMode
            % [RetVal, MeasMode] = GetAnalyzerWaveformMonitorMeasMode(self)
            [RetVal, MeasMode] = self.upxHandle.GetAnalyzerWaveformMonitorMeasMode();
        end
        function [RetVal, Pretrigger] = GetAnalyzerWaveformMonitorPretrigger(self)
            % GetAnalyzerWaveformMonitorPretrigger
            % [RetVal, Pretrigger] = GetAnalyzerWaveformMonitorPretrigger(self)
            [RetVal, Pretrigger] = self.upxHandle.GetAnalyzerWaveformMonitorPretrigger();
        end
        function [RetVal, WaveformMonitor] = GetAnalyzerWaveformMonitorState(self)
            % GetAnalyzerWaveformMonitorState
            % [RetVal, WaveformMonitor] = GetAnalyzerWaveformMonitorState(self)
            [RetVal, WaveformMonitor] = self.upxHandle.GetAnalyzerWaveformMonitorState();
        end
        function [RetVal, TraceLength] = GetAnalyzerWaveformMonitorTraceLength(self)
            % GetAnalyzerWaveformMonitorTraceLength
            % [RetVal, TraceLength] = GetAnalyzerWaveformMonitorTraceLength(self)
            [RetVal, TraceLength] = self.upxHandle.GetAnalyzerWaveformMonitorTraceLength();
        end
        function [RetVal, TriggerLevel, Units] = GetAnalyzerWaveformMonitorTriggerLevel(self)
            % GetAnalyzerWaveformMonitorTriggerLevel
            % [RetVal, TriggerLevel, Units] = GetAnalyzerWaveformMonitorTriggerLevel(self)
            [RetVal, TriggerLevel, Units] = self.upxHandle.GetAnalyzerWaveformMonitorTriggerLevel();
        end
        function [RetVal, TriggerSlope] = GetAnalyzerWaveformMonitorTriggerSlope(self)
            % GetAnalyzerWaveformMonitorTriggerSlope
            % [RetVal, TriggerSlope] = GetAnalyzerWaveformMonitorTriggerSlope(self)
            [RetVal, TriggerSlope] = self.upxHandle.GetAnalyzerWaveformMonitorTriggerSlope();
        end
        function [RetVal, TriggerSource] = GetAnalyzerWaveformMonitorTriggerSource(self)
            % GetAnalyzerWaveformMonitorTriggerSource
            % [RetVal, TriggerSource] = GetAnalyzerWaveformMonitorTriggerSource(self)
            [RetVal, TriggerSource] = self.upxHandle.GetAnalyzerWaveformMonitorTriggerSource();
        end
        function [RetVal, AnalogAuxOutput] = GetAuxAnalogOutput(self)
            % GetAuxAnalogOutput
            % [RetVal, AnalogAuxOutput] = GetAuxAnalogOutput(self)
            [RetVal, AnalogAuxOutput] = self.upxHandle.GetAuxAnalogOutput();
        end
        function [RetVal, AudioMonitor] = GetAuxAudioMonitor(self)
            % GetAuxAudioMonitor
            % [RetVal, AudioMonitor] = GetAuxAudioMonitor(self)
            [RetVal, AudioMonitor] = self.upxHandle.GetAuxAudioMonitor();
        end
        function [RetVal, DCValue, Units] = GetAuxDCVoltage(self)
            % GetAuxDCVoltage
            % [RetVal, DCValue, Units] = GetAuxDCVoltage(self)
            [RetVal, DCValue, Units] = self.upxHandle.GetAuxDCVoltage();
        end
        function [RetVal, MonitoringChannel] = GetAuxMonitoringChannel(self)
            % GetAuxMonitoringChannel
            % [RetVal, MonitoringChannel] = GetAuxMonitoringChannel(self)
            [RetVal, MonitoringChannel] = self.upxHandle.GetAuxMonitoringChannel();
        end
        function [RetVal, PhoneOutput] = GetAuxPhoneOutput(self)
            % GetAuxPhoneOutput
            % [RetVal, PhoneOutput] = GetAuxPhoneOutput(self)
            [RetVal, PhoneOutput] = self.upxHandle.GetAuxPhoneOutput();
        end
        function [RetVal, AuxPhonePermanentState] = GetAuxPhonePermanentState(self)
            % GetAuxPhonePermanentState
            % [RetVal, AuxPhonePermanentState] = GetAuxPhonePermanentState(self)
            [RetVal, AuxPhonePermanentState] = self.upxHandle.GetAuxPhonePermanentState();
        end
        function [RetVal, PhoneState] = GetAuxPhoneState(self)
            % GetAuxPhoneState
            % [RetVal, PhoneState] = GetAuxPhoneState(self)
            [RetVal, PhoneState] = self.upxHandle.GetAuxPhoneState();
        end
        function [RetVal, SignalSource] = GetAuxSignalSource(self)
            % GetAuxSignalSource
            % [RetVal, SignalSource] = GetAuxSignalSource(self)
            [RetVal, SignalSource] = self.upxHandle.GetAuxSignalSource();
        end
        function [RetVal, Speaker] = GetAuxSpeaker(self)
            % GetAuxSpeaker
            % [RetVal, Speaker] = GetAuxSpeaker(self)
            [RetVal, Speaker] = self.upxHandle.GetAuxSpeaker();
        end
        function [RetVal, MonitoredChannel] = GetAuxSpeakerMonitor(self, MonitorNumber)
            % GetAuxSpeakerMonitor
            % [RetVal, MonitoredChannel] = GetAuxSpeakerMonitor(self, MonitorNumber)
            [RetVal, MonitoredChannel] = self.upxHandle.GetAuxSpeakerMonitor(MonitorNumber);
        end
        function [RetVal, TriggerInputEdge] = GetAuxTriggerInputEdge(self)
            % GetAuxTriggerInputEdge
            % [RetVal, TriggerInputEdge] = GetAuxTriggerInputEdge(self)
            [RetVal, TriggerInputEdge] = self.upxHandle.GetAuxTriggerInputEdge();
        end
        function [RetVal, TriggerInput] = GetAuxTriggerInputEnable(self)
            % GetAuxTriggerInputEnable
            % [RetVal, TriggerInput] = GetAuxTriggerInputEnable(self)
            [RetVal, TriggerInput] = self.upxHandle.GetAuxTriggerInputEnable();
        end
        function [RetVal, TriggerInputMode] = GetAuxTriggerInputMode(self)
            % GetAuxTriggerInputMode
            % [RetVal, TriggerInputMode] = GetAuxTriggerInputMode(self)
            [RetVal, TriggerInputMode] = self.upxHandle.GetAuxTriggerInputMode();
        end
        function [RetVal, TriggerOutputEdge] = GetAuxTriggerOutputEdge(self)
            % GetAuxTriggerOutputEdge
            % [RetVal, TriggerOutputEdge] = GetAuxTriggerOutputEdge(self)
            [RetVal, TriggerOutputEdge] = self.upxHandle.GetAuxTriggerOutputEdge();
        end
        function [RetVal, TriggerOutput] = GetAuxTriggerOutputEnable(self)
            % GetAuxTriggerOutputEnable
            % [RetVal, TriggerOutput] = GetAuxTriggerOutputEnable(self)
            [RetVal, TriggerOutput] = self.upxHandle.GetAuxTriggerOutputEnable();
        end
        function [RetVal, TriggerOutputFrequency] = GetAuxTriggerOutputFrequency(self)
            % GetAuxTriggerOutputFrequency
            % [RetVal, TriggerOutputFrequency] = GetAuxTriggerOutputFrequency(self)
            [RetVal, TriggerOutputFrequency] = self.upxHandle.GetAuxTriggerOutputFrequency();
        end
        function [RetVal, TriggerOutputMode] = GetAuxTriggerOutputMode(self)
            % GetAuxTriggerOutputMode
            % [RetVal, TriggerOutputMode] = GetAuxTriggerOutputMode(self)
            [RetVal, TriggerOutputMode] = self.upxHandle.GetAuxTriggerOutputMode();
        end
        function [RetVal, Volume] = GetAuxVolume(self)
            % GetAuxVolume
            % [RetVal, Volume] = GetAuxVolume(self)
            [RetVal, Volume] = self.upxHandle.GetAuxVolume();
        end
        function [RetVal, Alignment] = GetDigBitstreamAnalyzerAlignment(self)
            % GetDigBitstreamAnalyzerAlignment
            % [RetVal, Alignment] = GetDigBitstreamAnalyzerAlignment(self)
            [RetVal, Alignment] = self.upxHandle.GetDigBitstreamAnalyzerAlignment();
        end
        function [RetVal, ChannelMode] = GetDigBitstreamAnalyzerChannelMode(self)
            % GetDigBitstreamAnalyzerChannelMode
            % [RetVal, ChannelMode] = GetDigBitstreamAnalyzerChannelMode(self)
            [RetVal, ChannelMode] = self.upxHandle.GetDigBitstreamAnalyzerChannelMode();
        end
        function [RetVal, ClockFrequency] = GetDigBitstreamAnalyzerClockFrequency(self)
            % GetDigBitstreamAnalyzerClockFrequency
            % [RetVal, ClockFrequency] = GetDigBitstreamAnalyzerClockFrequency(self)
            [RetVal, ClockFrequency] = self.upxHandle.GetDigBitstreamAnalyzerClockFrequency();
        end
        function [RetVal, ClockSource] = GetDigBitstreamAnalyzerClockSource(self)
            % GetDigBitstreamAnalyzerClockSource
            % [RetVal, ClockSource] = GetDigBitstreamAnalyzerClockSource(self)
            [RetVal, ClockSource] = self.upxHandle.GetDigBitstreamAnalyzerClockSource();
        end
        function [RetVal, DwnsmplFact] = GetDigBitstreamAnalyzerDownSamplingFactor(self)
            % GetDigBitstreamAnalyzerDownSamplingFactor
            % [RetVal, DwnsmplFact] = GetDigBitstreamAnalyzerDownSamplingFactor(self)
            [RetVal, DwnsmplFact] = self.upxHandle.GetDigBitstreamAnalyzerDownSamplingFactor();
        end
        function [RetVal, DutyCycle] = GetDigBitstreamAnalyzerDutyCycle(self)
            % GetDigBitstreamAnalyzerDutyCycle
            % [RetVal, DutyCycle] = GetDigBitstreamAnalyzerDutyCycle(self)
            [RetVal, DutyCycle] = self.upxHandle.GetDigBitstreamAnalyzerDutyCycle();
        end
        function [RetVal, AudioBits] = GetDigitalAnalyzerAudioBits(self)
            % GetDigitalAnalyzerAudioBits
            % [RetVal, AudioBits] = GetDigitalAnalyzerAudioBits(self)
            [RetVal, AudioBits] = self.upxHandle.GetDigitalAnalyzerAudioBits();
        end
        function [RetVal, Input] = GetDigitalAnalyzerAudioInput(self)
            % GetDigitalAnalyzerAudioInput
            % [RetVal, Input] = GetDigitalAnalyzerAudioInput(self)
            [RetVal, Input] = self.upxHandle.GetDigitalAnalyzerAudioInput();
        end
        function [RetVal, ChannelMode] = GetDigitalAnalyzerChannelMode(self)
            % GetDigitalAnalyzerChannelMode
            % [RetVal, ChannelMode] = GetDigitalAnalyzerChannelMode(self)
            [RetVal, ChannelMode] = self.upxHandle.GetDigitalAnalyzerChannelMode();
        end
        function [RetVal, JitterRef] = GetDigitalAnalyzerJitterRef(self)
            % GetDigitalAnalyzerJitterRef
            % [RetVal, JitterRef] = GetDigitalAnalyzerJitterRef(self)
            [RetVal, JitterRef] = self.upxHandle.GetDigitalAnalyzerJitterRef();
        end
        function [RetVal, MeasMode] = GetDigitalAnalyzerMeasMode(self)
            % GetDigitalAnalyzerMeasMode
            % [RetVal, MeasMode] = GetDigitalAnalyzerMeasMode(self)
            [RetVal, MeasMode] = self.upxHandle.GetDigitalAnalyzerMeasMode();
        end
        function [RetVal, AddImpairment] = GetDigitalGeneratorAddImpairment(self)
            % GetDigitalGeneratorAddImpairment
            % [RetVal, AddImpairment] = GetDigitalGeneratorAddImpairment(self)
            [RetVal, AddImpairment] = self.upxHandle.GetDigitalGeneratorAddImpairment();
        end
        function [RetVal, AudioBits] = GetDigitalGeneratorAudioBits(self)
            % GetDigitalGeneratorAudioBits
            % [RetVal, AudioBits] = GetDigitalGeneratorAudioBits(self)
            [RetVal, AudioBits] = self.upxHandle.GetDigitalGeneratorAudioBits();
        end
        function [RetVal, AuxOutput] = GetDigitalGeneratorAuxOutput(self)
            % GetDigitalGeneratorAuxOutput
            % [RetVal, AuxOutput] = GetDigitalGeneratorAuxOutput(self)
            [RetVal, AuxOutput] = self.upxHandle.GetDigitalGeneratorAuxOutput();
        end
        function [RetVal, BalancedAmplitude, Units] = GetDigitalGeneratorBalancedAmplitude(self)
            % GetDigitalGeneratorBalancedAmplitude
            % [RetVal, BalancedAmplitude, Units] = GetDigitalGeneratorBalancedAmplitude(self)
            [RetVal, BalancedAmplitude, Units] = self.upxHandle.GetDigitalGeneratorBalancedAmplitude();
        end
        function [RetVal, BalancedImpedance] = GetDigitalGeneratorBalancedImpedance(self)
            % GetDigitalGeneratorBalancedImpedance
            % [RetVal, BalancedImpedance] = GetDigitalGeneratorBalancedImpedance(self)
            [RetVal, BalancedImpedance] = self.upxHandle.GetDigitalGeneratorBalancedImpedance();
        end
        function [RetVal, CableSimulation] = GetDigitalGeneratorCableSimulation(self)
            % GetDigitalGeneratorCableSimulation
            % [RetVal, CableSimulation] = GetDigitalGeneratorCableSimulation(self)
            [RetVal, CableSimulation] = self.upxHandle.GetDigitalGeneratorCableSimulation();
        end
        function [RetVal, Channel] = GetDigitalGeneratorChannelMode(self)
            % GetDigitalGeneratorChannelMode
            % [RetVal, Channel] = GetDigitalGeneratorChannelMode(self)
            [RetVal, Channel] = self.upxHandle.GetDigitalGeneratorChannelMode();
        end
        function [RetVal, GenChannels] = GetDigitalGeneratorChannels(self, MeasChannel)
            % GetDigitalGeneratorChannels
            % [RetVal, GenChannels] = GetDigitalGeneratorChannels(self, MeasChannel)
            [RetVal, GenChannels] = self.upxHandle.GetDigitalGeneratorChannels(MeasChannel);
        end
        function [RetVal, FramePhase, Units] = GetDigitalGeneratorFramePhase(self)
            % GetDigitalGeneratorFramePhase
            % [RetVal, FramePhase, Units] = GetDigitalGeneratorFramePhase(self)
            [RetVal, FramePhase, Units] = self.upxHandle.GetDigitalGeneratorFramePhase();
        end
        function [RetVal, InternalClockFrequency] = GetDigitalGeneratorInternalClockFrequency(self)
            % GetDigitalGeneratorInternalClockFrequency
            % [RetVal, InternalClockFrequency] = GetDigitalGeneratorInternalClockFrequency(self)
            [RetVal, InternalClockFrequency] = self.upxHandle.GetDigitalGeneratorInternalClockFrequency();
        end
        function [RetVal, PhaseToRef] = GetDigitalGeneratorPhaseToRef(self)
            % GetDigitalGeneratorPhaseToRef
            % [RetVal, PhaseToRef] = GetDigitalGeneratorPhaseToRef(self)
            [RetVal, PhaseToRef] = self.upxHandle.GetDigitalGeneratorPhaseToRef();
        end
        function [RetVal, RefGeneratorData] = GetDigitalGeneratorRefGeneratorData(self)
            % GetDigitalGeneratorRefGeneratorData
            % [RetVal, RefGeneratorData] = GetDigitalGeneratorRefGeneratorData(self)
            [RetVal, RefGeneratorData] = self.upxHandle.GetDigitalGeneratorRefGeneratorData();
        end
        function [RetVal, SampleFrequency, VariableSampleFrequency] = GetDigitalGeneratorSampleFrequency(self)
            % GetDigitalGeneratorSampleFrequency
            % [RetVal, SampleFrequency, VariableSampleFrequency] = GetDigitalGeneratorSampleFrequency(self)
            [RetVal, SampleFrequency, VariableSampleFrequency] = self.upxHandle.GetDigitalGeneratorSampleFrequency();
        end
        function [RetVal, SourceMode] = GetDigitalGeneratorSourceMode(self)
            % GetDigitalGeneratorSourceMode
            % [RetVal, SourceMode] = GetDigitalGeneratorSourceMode(self)
            [RetVal, SourceMode] = self.upxHandle.GetDigitalGeneratorSourceMode();
        end
        function [RetVal, SyncOutputType] = GetDigitalGeneratorSyncOutType(self)
            % GetDigitalGeneratorSyncOutType
            % [RetVal, SyncOutputType] = GetDigitalGeneratorSyncOutType(self)
            [RetVal, SyncOutputType] = self.upxHandle.GetDigitalGeneratorSyncOutType();
        end
        function [RetVal, SyncOutput] = GetDigitalGeneratorSyncOutput(self)
            % GetDigitalGeneratorSyncOutput
            % [RetVal, SyncOutput] = GetDigitalGeneratorSyncOutput(self)
            [RetVal, SyncOutput] = self.upxHandle.GetDigitalGeneratorSyncOutput();
        end
        function [RetVal, SyncTo] = GetDigitalGeneratorSyncTo(self)
            % GetDigitalGeneratorSyncTo
            % [RetVal, SyncTo] = GetDigitalGeneratorSyncTo(self)
            [RetVal, SyncTo] = self.upxHandle.GetDigitalGeneratorSyncTo();
        end
        function [RetVal, UnbalancedAmplitude, Units] = GetDigitalGeneratorUnbalancedAmplitude(self)
            % GetDigitalGeneratorUnbalancedAmplitude
            % [RetVal, UnbalancedAmplitude, Units] = GetDigitalGeneratorUnbalancedAmplitude(self)
            [RetVal, UnbalancedAmplitude, Units] = self.upxHandle.GetDigitalGeneratorUnbalancedAmplitude();
        end
        function [RetVal, UnbalancedImpedance] = GetDigitalGeneratorUnbalancedImpedance(self)
            % GetDigitalGeneratorUnbalancedImpedance
            % [RetVal, UnbalancedImpedance] = GetDigitalGeneratorUnbalancedImpedance(self)
            [RetVal, UnbalancedImpedance] = self.upxHandle.GetDigitalGeneratorUnbalancedImpedance();
        end
        function [RetVal, UnbalancedOutput] = GetDigitalGeneratorUnbalancedOutput(self)
            % GetDigitalGeneratorUnbalancedOutput
            % [RetVal, UnbalancedOutput] = GetDigitalGeneratorUnbalancedOutput(self)
            [RetVal, UnbalancedOutput] = self.upxHandle.GetDigitalGeneratorUnbalancedOutput();
        end
        function [RetVal, AxisLabelAuto] = GetDisplayAxisLabelAuto(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayAxisLabelAuto
            % [RetVal, AxisLabelAuto] = GetDisplayAxisLabelAuto(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, AxisLabelAuto] = self.upxHandle.GetDisplayAxisLabelAuto(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, AxisLabelUserString] = GetDisplayAxisLabelUserString(self, Subsystem, SubsystemNumber, Trace, BufferSize)
            % GetDisplayAxisLabelUserString
            % [RetVal, AxisLabelUserString] = GetDisplayAxisLabelUserString(self, Subsystem, SubsystemNumber, Trace, BufferSize)
            AxisLabelUserString = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetDisplayAxisLabelUserString(Subsystem, SubsystemNumber, Trace, BufferSize, AxisLabelUserString);
            AxisLabelUserString = char(AxisLabelUserString.ToString);
        end
        function [RetVal, YSource] = GetDisplayBargraphMultichannelYSource(self, SubsystemNumber, Trace)
            % GetDisplayBargraphMultichannelYSource
            % [RetVal, YSource] = GetDisplayBargraphMultichannelYSource(self, SubsystemNumber, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplayBargraphMultichannelYSource(SubsystemNumber, Trace);
        end
        function [RetVal, YSource] = GetDisplayBargraphYSource(self, SubsystemNumber, Trace)
            % GetDisplayBargraphYSource
            % [RetVal, YSource] = GetDisplayBargraphYSource(self, SubsystemNumber, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplayBargraphYSource(SubsystemNumber, Trace);
        end
        function [RetVal, ChannelNumber] = GetDisplayChannel(self, SubsystemNumber, Subsystem, Trace)
            % GetDisplayChannel
            % [RetVal, ChannelNumber] = GetDisplayChannel(self, SubsystemNumber, Subsystem, Trace)
            [RetVal, ChannelNumber] = self.upxHandle.GetDisplayChannel(SubsystemNumber, Subsystem, Trace);
        end
        function [RetVal, CopyLimitSettings] = GetDisplayCopyLimitSettings(self, Subsystem, SubsystemNumber)
            % GetDisplayCopyLimitSettings
            % [RetVal, CopyLimitSettings] = GetDisplayCopyLimitSettings(self, Subsystem, SubsystemNumber)
            [RetVal, CopyLimitSettings] = self.upxHandle.GetDisplayCopyLimitSettings(Subsystem, SubsystemNumber);
        end
        function [RetVal, CopyReferenceSettings] = GetDisplayCopyReferenceSettings(self, Subsystem, SubsystemNumber)
            % GetDisplayCopyReferenceSettings
            % [RetVal, CopyReferenceSettings] = GetDisplayCopyReferenceSettings(self, Subsystem, SubsystemNumber)
            [RetVal, CopyReferenceSettings] = self.upxHandle.GetDisplayCopyReferenceSettings(Subsystem, SubsystemNumber);
        end
        function [RetVal, CopyScalingSettings] = GetDisplayCopyScalingSettings(self, Subsystem, SubsystemNumber)
            % GetDisplayCopyScalingSettings
            % [RetVal, CopyScalingSettings] = GetDisplayCopyScalingSettings(self, Subsystem, SubsystemNumber)
            [RetVal, CopyScalingSettings] = self.upxHandle.GetDisplayCopyScalingSettings(Subsystem, SubsystemNumber);
        end
        function [RetVal, CursorAmplitude] = GetDisplayCursorAmplitude(self, Subsystem, SubsystemNumber, CursorType)
            % GetDisplayCursorAmplitude
            % [RetVal, CursorAmplitude] = GetDisplayCursorAmplitude(self, Subsystem, SubsystemNumber, CursorType)
            [RetVal, CursorAmplitude] = self.upxHandle.GetDisplayCursorAmplitude(Subsystem, SubsystemNumber, CursorType);
        end
        function [RetVal, CursorMode] = GetDisplayCursorMode(self, Subsystem, SubsystemNumber, CursorType)
            % GetDisplayCursorMode
            % [RetVal, CursorMode] = GetDisplayCursorMode(self, Subsystem, SubsystemNumber, CursorType)
            [RetVal, CursorMode] = self.upxHandle.GetDisplayCursorMode(Subsystem, SubsystemNumber, CursorType);
        end
        function [RetVal, CursorPositionMode] = GetDisplayCursorMovement(self, Subsystem, SubsystemNumber, CursorType)
            % GetDisplayCursorMovement
            % [RetVal, CursorPositionMode] = GetDisplayCursorMovement(self, Subsystem, SubsystemNumber, CursorType)
            [RetVal, CursorPositionMode] = self.upxHandle.GetDisplayCursorMovement(Subsystem, SubsystemNumber, CursorType);
        end
        function [RetVal, CursorState] = GetDisplayCursorState(self, Subsystem, SubsystemNumber, CursorType)
            % GetDisplayCursorState
            % [RetVal, CursorState] = GetDisplayCursorState(self, Subsystem, SubsystemNumber, CursorType)
            [RetVal, CursorState] = self.upxHandle.GetDisplayCursorState(Subsystem, SubsystemNumber, CursorType);
        end
        function [RetVal, CursorXPosition, Units] = GetDisplayCursorXPosition(self, Subsystem, SubsystemNumber, CursorType)
            % GetDisplayCursorXPosition
            % [RetVal, CursorXPosition, Units] = GetDisplayCursorXPosition(self, Subsystem, SubsystemNumber, CursorType)
            [RetVal, CursorXPosition, Units] = self.upxHandle.GetDisplayCursorXPosition(Subsystem, SubsystemNumber, CursorType);
        end
        function [RetVal, CursorYPosition, Units] = GetDisplayCursorYPosition(self, Subsystem, SubsystemNumber, CursorType)
            % GetDisplayCursorYPosition
            % [RetVal, CursorYPosition, Units] = GetDisplayCursorYPosition(self, Subsystem, SubsystemNumber, CursorType)
            [RetVal, CursorYPosition, Units] = self.upxHandle.GetDisplayCursorYPosition(Subsystem, SubsystemNumber, CursorType);
        end
        function [RetVal, DataListFilterType] = GetDisplayDataListFilter(self, Subsystem, SubsystemNumber)
            % GetDisplayDataListFilter
            % [RetVal, DataListFilterType] = GetDisplayDataListFilter(self, Subsystem, SubsystemNumber)
            [RetVal, DataListFilterType] = self.upxHandle.GetDisplayDataListFilter(Subsystem, SubsystemNumber);
        end
        function [RetVal, YSource] = GetDisplayFFTGraphMultichannelYSource(self, SubsystemNumber, Trace)
            % GetDisplayFFTGraphMultichannelYSource
            % [RetVal, YSource] = GetDisplayFFTGraphMultichannelYSource(self, SubsystemNumber, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplayFFTGraphMultichannelYSource(SubsystemNumber, Trace);
        end
        function [RetVal, YSource] = GetDisplayFFTGraphYSource(self, SubsystemNumber, Trace)
            % GetDisplayFFTGraphYSource
            % [RetVal, YSource] = GetDisplayFFTGraphYSource(self, SubsystemNumber, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplayFFTGraphYSource(SubsystemNumber, Trace);
        end
        function [RetVal, InvertEqualization] = GetDisplayInvertEqu(self, Subsystem, SubsystemNumber)
            % GetDisplayInvertEqu
            % [RetVal, InvertEqualization] = GetDisplayInvertEqu(self, Subsystem, SubsystemNumber)
            [RetVal, InvertEqualization] = self.upxHandle.GetDisplayInvertEqu(Subsystem, SubsystemNumber);
        end
        function [RetVal, Legend] = GetDisplayLegend(self, Subsystem, SubsystemNumber, Trace, BufferSize)
            % GetDisplayLegend
            % [RetVal, Legend] = GetDisplayLegend(self, Subsystem, SubsystemNumber, Trace, BufferSize)
            Legend = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetDisplayLegend(Subsystem, SubsystemNumber, Trace, BufferSize, Legend);
            Legend = char(Legend.ToString);
        end
        function [RetVal, Legend] = GetDisplayLegendState(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayLegendState
            % [RetVal, Legend] = GetDisplayLegendState(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, Legend] = self.upxHandle.GetDisplayLegendState(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, LimitOffset] = GetDisplayLimitOffset(self, Subsystem, SubsystemNumber)
            % GetDisplayLimitOffset
            % [RetVal, LimitOffset] = GetDisplayLimitOffset(self, Subsystem, SubsystemNumber)
            [RetVal, LimitOffset] = self.upxHandle.GetDisplayLimitOffset(Subsystem, SubsystemNumber);
        end
        function [RetVal, LimitOffsetValue] = GetDisplayLimitOffsetValue(self, Subsystem, SubsystemNumber)
            % GetDisplayLimitOffsetValue
            % [RetVal, LimitOffsetValue] = GetDisplayLimitOffsetValue(self, Subsystem, SubsystemNumber)
            [RetVal, LimitOffsetValue] = self.upxHandle.GetDisplayLimitOffsetValue(Subsystem, SubsystemNumber);
        end
        function [RetVal, LimitShift] = GetDisplayLimitShift(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayLimitShift
            % [RetVal, LimitShift] = GetDisplayLimitShift(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, LimitShift] = self.upxHandle.GetDisplayLimitShift(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, LimitShiftParallel, Units] = GetDisplayLimitShiftParallel(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayLimitShiftParallel
            % [RetVal, LimitShiftParallel, Units] = GetDisplayLimitShiftParallel(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, LimitShiftParallel, Units] = self.upxHandle.GetDisplayLimitShiftParallel(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, LimitShiftSymmetrical, Units] = GetDisplayLimitShiftSymmetrical(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayLimitShiftSymmetrical
            % [RetVal, LimitShiftSymmetrical, Units] = GetDisplayLimitShiftSymmetrical(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, LimitShiftSymmetrical, Units] = self.upxHandle.GetDisplayLimitShiftSymmetrical(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, LimitSource] = GetDisplayLimitSource(self, Subsystem, SubsystemNumber, Trace, LimitType)
            % GetDisplayLimitSource
            % [RetVal, LimitSource] = GetDisplayLimitSource(self, Subsystem, SubsystemNumber, Trace, LimitType)
            [RetVal, LimitSource] = self.upxHandle.GetDisplayLimitSource(Subsystem, SubsystemNumber, Trace, LimitType);
        end
        function [RetVal, LimitSourceFilename] = GetDisplayLimitSourceFilename(self, Subsystem, SubsystemNumber, Trace, LimitType, BufferSize)
            % GetDisplayLimitSourceFilename
            % [RetVal, LimitSourceFilename] = GetDisplayLimitSourceFilename(self, Subsystem, SubsystemNumber, Trace, LimitType, BufferSize)
            LimitSourceFilename = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetDisplayLimitSourceFilename(Subsystem, SubsystemNumber, Trace, LimitType, BufferSize, LimitSourceFilename);
            LimitSourceFilename = char(LimitSourceFilename.ToString);
        end
        function [RetVal, LimitSourceValue, Units] = GetDisplayLimitSourceValue(self, Subsystem, SubsystemNumber, Trace, LimitType)
            % GetDisplayLimitSourceValue
            % [RetVal, LimitSourceValue, Units] = GetDisplayLimitSourceValue(self, Subsystem, SubsystemNumber, Trace, LimitType)
            [RetVal, LimitSourceValue, Units] = self.upxHandle.GetDisplayLimitSourceValue(Subsystem, SubsystemNumber, Trace, LimitType);
        end
        function [RetVal, LimitState] = GetDisplayLimitState(self, Subsystem, SubsystemNumber, Trace, LimitType)
            % GetDisplayLimitState
            % [RetVal, LimitState] = GetDisplayLimitState(self, Subsystem, SubsystemNumber, Trace, LimitType)
            [RetVal, LimitState] = self.upxHandle.GetDisplayLimitState(Subsystem, SubsystemNumber, Trace, LimitType);
        end
        function [RetVal, Harmonics] = GetDisplayMarkerHarmonics(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayMarkerHarmonics
            % [RetVal, Harmonics] = GetDisplayMarkerHarmonics(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, Harmonics] = self.upxHandle.GetDisplayMarkerHarmonics(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, MarkerMode] = GetDisplayMarkerMode(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayMarkerMode
            % [RetVal, MarkerMode] = GetDisplayMarkerMode(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, MarkerMode] = self.upxHandle.GetDisplayMarkerMode(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, MarkerXPosition, Units] = GetDisplayMarkerXPosition(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayMarkerXPosition
            % [RetVal, MarkerXPosition, Units] = GetDisplayMarkerXPosition(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, MarkerXPosition, Units] = self.upxHandle.GetDisplayMarkerXPosition(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, MaxChannelsDisplay] = GetDisplayMaxChannels(self)
            % GetDisplayMaxChannels
            % [RetVal, MaxChannelsDisplay] = GetDisplayMaxChannels(self)
            [RetVal, MaxChannelsDisplay] = self.upxHandle.GetDisplayMaxChannels();
        end
        function [RetVal, ModifyEqulization] = GetDisplayModifyEqu(self, Subsystem, SubsystemNumber)
            % GetDisplayModifyEqu
            % [RetVal, ModifyEqulization] = GetDisplayModifyEqu(self, Subsystem, SubsystemNumber)
            [RetVal, ModifyEqulization] = self.upxHandle.GetDisplayModifyEqu(Subsystem, SubsystemNumber);
        end
        function [RetVal, Normalization] = GetDisplayNormalization(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayNormalization
            % [RetVal, Normalization] = GetDisplayNormalization(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, Normalization] = self.upxHandle.GetDisplayNormalization(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, NormalizationFrequency, Units] = GetDisplayNormalizationFrequency(self, Subsystem, SubsystemNumber)
            % GetDisplayNormalizationFrequency
            % [RetVal, NormalizationFrequency, Units] = GetDisplayNormalizationFrequency(self, Subsystem, SubsystemNumber)
            [RetVal, NormalizationFrequency, Units] = self.upxHandle.GetDisplayNormalizationFrequency(Subsystem, SubsystemNumber);
        end
        function [RetVal, NormalizeValue] = GetDisplayNormalizeValue(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayNormalizeValue
            % [RetVal, NormalizeValue] = GetDisplayNormalizeValue(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, NormalizeValue] = self.upxHandle.GetDisplayNormalizeValue(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, YSource] = GetDisplayPESQYSource(self, SubsystemNumber, Trace)
            % GetDisplayPESQYSource
            % [RetVal, YSource] = GetDisplayPESQYSource(self, SubsystemNumber, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplayPESQYSource(SubsystemNumber, Trace);
        end
        function [RetVal, Reference] = GetDisplayReference(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayReference
            % [RetVal, Reference] = GetDisplayReference(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, Reference] = self.upxHandle.GetDisplayReference(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, ReferenceValue, Units] = GetDisplayReferenceValue(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayReferenceValue
            % [RetVal, ReferenceValue, Units] = GetDisplayReferenceValue(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, ReferenceValue, Units] = self.upxHandle.GetDisplayReferenceValue(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, ScanOffset] = GetDisplayScanOffset(self, Subsystem, SubsystemNumber)
            % GetDisplayScanOffset
            % [RetVal, ScanOffset] = GetDisplayScanOffset(self, Subsystem, SubsystemNumber)
            [RetVal, ScanOffset] = self.upxHandle.GetDisplayScanOffset(Subsystem, SubsystemNumber);
        end
        function [RetVal, ScreenNumber] = GetDisplayScreen(self)
            % GetDisplayScreen
            % [RetVal, ScreenNumber] = GetDisplayScreen(self)
            [RetVal, ScreenNumber] = self.upxHandle.GetDisplayScreen();
        end
        function [RetVal, ShowMinMax] = GetDisplayShowMinMax(self, Subsystem, SubsystemNumber)
            % GetDisplayShowMinMax
            % [RetVal, ShowMinMax] = GetDisplayShowMinMax(self, Subsystem, SubsystemNumber)
            [RetVal, ShowMinMax] = self.upxHandle.GetDisplayShowMinMax(Subsystem, SubsystemNumber);
        end
        function [RetVal, StoreTraceAs] = GetDisplayStoreTraceAs(self, Subsystem, SubsystemNumber)
            % GetDisplayStoreTraceAs
            % [RetVal, StoreTraceAs] = GetDisplayStoreTraceAs(self, Subsystem, SubsystemNumber)
            [RetVal, StoreTraceAs] = self.upxHandle.GetDisplayStoreTraceAs(Subsystem, SubsystemNumber);
        end
        function [RetVal, StoreTraceToFile] = GetDisplayStoreTraceToFile(self, Subsystem, SubsystemNumber, BufferSize)
            % GetDisplayStoreTraceToFile
            % [RetVal, StoreTraceToFile] = GetDisplayStoreTraceToFile(self, Subsystem, SubsystemNumber, BufferSize)
            StoreTraceToFile = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetDisplayStoreTraceToFile(Subsystem, SubsystemNumber, BufferSize, StoreTraceToFile);
            StoreTraceToFile = char(StoreTraceToFile.ToString);
        end
        function [RetVal, XAxis] = GetDisplaySweepGraphXAxis(self, SweepGraphNumber)
            % GetDisplaySweepGraphXAxis
            % [RetVal, XAxis] = GetDisplaySweepGraphXAxis(self, SweepGraphNumber)
            [RetVal, XAxis] = self.upxHandle.GetDisplaySweepGraphXAxis(SweepGraphNumber);
        end
        function [RetVal, XSource] = GetDisplaySweepGraphXSource(self, SweepGraphNumber)
            % GetDisplaySweepGraphXSource
            % [RetVal, XSource] = GetDisplaySweepGraphXSource(self, SweepGraphNumber)
            [RetVal, XSource] = self.upxHandle.GetDisplaySweepGraphXSource(SweepGraphNumber);
        end
        function [RetVal, YSource] = GetDisplaySweepMultichannelYSource(self, SubsystemNumber, Trace)
            % GetDisplaySweepMultichannelYSource
            % [RetVal, YSource] = GetDisplaySweepMultichannelYSource(self, SubsystemNumber, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplaySweepMultichannelYSource(SubsystemNumber, Trace);
        end
        function [RetVal, YSource] = GetDisplaySweepYSource(self, SubsystemNumber, Trace)
            % GetDisplaySweepYSource
            % [RetVal, YSource] = GetDisplaySweepYSource(self, SubsystemNumber, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplaySweepYSource(SubsystemNumber, Trace);
        end
        function [RetVal, Trace] = GetDisplayTraceSelect(self, Subsystem, SubsystemNumber)
            % GetDisplayTraceSelect
            % [RetVal, Trace] = GetDisplayTraceSelect(self, Subsystem, SubsystemNumber)
            [RetVal, Trace] = self.upxHandle.GetDisplayTraceSelect(Subsystem, SubsystemNumber);
        end
        function [RetVal, TraceUpdateType] = GetDisplayTraceUpdate(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayTraceUpdate
            % [RetVal, TraceUpdateType] = GetDisplayTraceUpdate(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, TraceUpdateType] = self.upxHandle.GetDisplayTraceUpdate(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, Units] = GetDisplayUnit(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayUnit
            % [RetVal, Units] = GetDisplayUnit(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, Units] = self.upxHandle.GetDisplayUnit(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, UnitAuto] = GetDisplayUnitAuto(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayUnitAuto
            % [RetVal, UnitAuto] = GetDisplayUnitAuto(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, UnitAuto] = self.upxHandle.GetDisplayUnitAuto(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, UnitFunctionTrack] = GetDisplayUnitFunctionTrack(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayUnitFunctionTrack
            % [RetVal, UnitFunctionTrack] = GetDisplayUnitFunctionTrack(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, UnitFunctionTrack] = self.upxHandle.GetDisplayUnitFunctionTrack(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, UnitUserString] = GetDisplayUnitUserString(self, Subsystem, SubsystemNumber, Trace, BufferSize)
            % GetDisplayUnitUserString
            % [RetVal, UnitUserString] = GetDisplayUnitUserString(self, Subsystem, SubsystemNumber, Trace, BufferSize)
            UnitUserString = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetDisplayUnitUserString(Subsystem, SubsystemNumber, Trace, BufferSize, UnitUserString);
            UnitUserString = char(UnitUserString.ToString);
        end
        function [RetVal, YSource] = GetDisplayWaveformMultichannelYSource(self, Trace)
            % GetDisplayWaveformMultichannelYSource
            % [RetVal, YSource] = GetDisplayWaveformMultichannelYSource(self, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplayWaveformMultichannelYSource(Trace);
        end
        function [RetVal, YSource] = GetDisplayWaveformYSource(self, Trace)
            % GetDisplayWaveformYSource
            % [RetVal, YSource] = GetDisplayWaveformYSource(self, Trace)
            [RetVal, YSource] = self.upxHandle.GetDisplayWaveformYSource(Trace);
        end
        function [RetVal, Left, Units] = GetDisplayXAxisLeft(self, Subsystem, SubsystemNumber)
            % GetDisplayXAxisLeft
            % [RetVal, Left, Units] = GetDisplayXAxisLeft(self, Subsystem, SubsystemNumber)
            [RetVal, Left, Units] = self.upxHandle.GetDisplayXAxisLeft(Subsystem, SubsystemNumber);
        end
        function [RetVal, ReferenceValue, Units] = GetDisplayXAxisReferenceValue(self, Subsystem, SubsystemNumber)
            % GetDisplayXAxisReferenceValue
            % [RetVal, ReferenceValue, Units] = GetDisplayXAxisReferenceValue(self, Subsystem, SubsystemNumber)
            [RetVal, ReferenceValue, Units] = self.upxHandle.GetDisplayXAxisReferenceValue(Subsystem, SubsystemNumber);
        end
        function [RetVal, Right, Units] = GetDisplayXAxisRight(self, Subsystem, SubsystemNumber)
            % GetDisplayXAxisRight
            % [RetVal, Right, Units] = GetDisplayXAxisRight(self, Subsystem, SubsystemNumber)
            [RetVal, Right, Units] = self.upxHandle.GetDisplayXAxisRight(Subsystem, SubsystemNumber);
        end
        function [RetVal, Scaling] = GetDisplayXAxisScaling(self, Subsystem, SubsystemNumber)
            % GetDisplayXAxisScaling
            % [RetVal, Scaling] = GetDisplayXAxisScaling(self, Subsystem, SubsystemNumber)
            [RetVal, Scaling] = self.upxHandle.GetDisplayXAxisScaling(Subsystem, SubsystemNumber);
        end
        function [RetVal, Spacing] = GetDisplayXAxisSpacing(self, Subsystem, SubsystemNumber)
            % GetDisplayXAxisSpacing
            % [RetVal, Spacing] = GetDisplayXAxisSpacing(self, Subsystem, SubsystemNumber)
            [RetVal, Spacing] = self.upxHandle.GetDisplayXAxisSpacing(Subsystem, SubsystemNumber);
        end
        function [RetVal, Bottom, Units] = GetDisplayYAxisBottom(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayYAxisBottom
            % [RetVal, Bottom, Units] = GetDisplayYAxisBottom(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, Bottom, Units] = self.upxHandle.GetDisplayYAxisBottom(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, Spacing] = GetDisplayYAxisSpacing(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayYAxisSpacing
            % [RetVal, Spacing] = GetDisplayYAxisSpacing(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, Spacing] = self.upxHandle.GetDisplayYAxisSpacing(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, Top, Units] = GetDisplayYAxisTop(self, Subsystem, SubsystemNumber, Trace)
            % GetDisplayYAxisTop
            % [RetVal, Top, Units] = GetDisplayYAxisTop(self, Subsystem, SubsystemNumber, Trace)
            [RetVal, Top, Units] = self.upxHandle.GetDisplayYAxisTop(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal, MinVolt] = GetExternalSweepMinimumLevel(self)
            % GetExternalSweepMinimumLevel
            % [RetVal, MinVolt] = GetExternalSweepMinimumLevel(self)
            [RetVal, MinVolt] = self.upxHandle.GetExternalSweepMinimumLevel();
        end
        function [RetVal, Start, Units] = GetExternalSweepStartValue(self, SweepControl)
            % GetExternalSweepStartValue
            % [RetVal, Start, Units] = GetExternalSweepStartValue(self, SweepControl)
            [RetVal, Start, Units] = self.upxHandle.GetExternalSweepStartValue(SweepControl);
        end
        function [RetVal, Stop, Units] = GetExternalSweepStopValue(self, SweepControl)
            % GetExternalSweepStopValue
            % [RetVal, Stop, Units] = GetExternalSweepStopValue(self, SweepControl)
            [RetVal, Stop, Units] = self.upxHandle.GetExternalSweepStopValue(SweepControl);
        end
        function [RetVal, Variation] = GetExternalSweepVariation(self, SweepControl)
            % GetExternalSweepVariation
            % [RetVal, Variation] = GetExternalSweepVariation(self, SweepControl)
            [RetVal, Variation] = self.upxHandle.GetExternalSweepVariation(SweepControl);
        end
        function [RetVal, FilterAttenuation] = GetFilterAttenuation(self, FilterNumber)
            % GetFilterAttenuation
            % [RetVal, FilterAttenuation] = GetFilterAttenuation(self, FilterNumber)
            [RetVal, FilterAttenuation] = self.upxHandle.GetFilterAttenuation(FilterNumber);
        end
        function [RetVal, CenterFreq] = GetFilterCenterFreq(self, FilterNumber)
            % GetFilterCenterFreq
            % [RetVal, CenterFreq] = GetFilterCenterFreq(self, FilterNumber)
            [RetVal, CenterFreq] = self.upxHandle.GetFilterCenterFreq(FilterNumber);
        end
        function [RetVal, FilterDelay] = GetFilterDelay(self, FilterNumber)
            % GetFilterDelay
            % [RetVal, FilterDelay] = GetFilterDelay(self, FilterNumber)
            [RetVal, FilterDelay] = self.upxHandle.GetFilterDelay(FilterNumber);
        end
        function [RetVal, FilterOrder] = GetFilterOrder(self, FilterNumber)
            % GetFilterOrder
            % [RetVal, FilterOrder] = GetFilterOrder(self, FilterNumber)
            [RetVal, FilterOrder] = self.upxHandle.GetFilterOrder(FilterNumber);
        end
        function [RetVal, Passband] = GetFilterPassband(self, FilterNumber)
            % GetFilterPassband
            % [RetVal, Passband] = GetFilterPassband(self, FilterNumber)
            [RetVal, Passband] = self.upxHandle.GetFilterPassband(FilterNumber);
        end
        function [RetVal, PassbandLow] = GetFilterPassbandLow(self, FilterNumber)
            % GetFilterPassbandLow
            % [RetVal, PassbandLow] = GetFilterPassbandLow(self, FilterNumber)
            [RetVal, PassbandLow] = self.upxHandle.GetFilterPassbandLow(FilterNumber);
        end
        function [RetVal, PassbandUpp] = GetFilterPassbandUpp(self, FilterNumber)
            % GetFilterPassbandUpp
            % [RetVal, PassbandUpp] = GetFilterPassbandUpp(self, FilterNumber)
            [RetVal, PassbandUpp] = self.upxHandle.GetFilterPassbandUpp(FilterNumber);
        end
        function [RetVal, Stopband] = GetFilterStopband(self, FilterNumber)
            % GetFilterStopband
            % [RetVal, Stopband] = GetFilterStopband(self, FilterNumber)
            [RetVal, Stopband] = self.upxHandle.GetFilterStopband(FilterNumber);
        end
        function [RetVal, StopbandLow] = GetFilterStopbandLow(self, FilterNumber)
            % GetFilterStopbandLow
            % [RetVal, StopbandLow] = GetFilterStopbandLow(self, FilterNumber)
            [RetVal, StopbandLow] = self.upxHandle.GetFilterStopbandLow(FilterNumber);
        end
        function [RetVal, StopbandUpp] = GetFilterStopbandUpp(self, FilterNumber)
            % GetFilterStopbandUpp
            % [RetVal, StopbandUpp] = GetFilterStopbandUpp(self, FilterNumber)
            [RetVal, StopbandUpp] = self.upxHandle.GetFilterStopbandUpp(FilterNumber);
        end
        function [RetVal, FilterType] = GetFilterType(self, FilterNumber)
            % GetFilterType
            % [RetVal, FilterType] = GetFilterType(self, FilterNumber)
            [RetVal, FilterType] = self.upxHandle.GetFilterType(FilterNumber);
        end
        function [RetVal, FilterWidth] = GetFilterWidth(self, FilterNumber)
            % GetFilterWidth
            % [RetVal, FilterWidth] = GetFilterWidth(self, FilterNumber)
            [RetVal, FilterWidth] = self.upxHandle.GetFilterWidth(FilterNumber);
        end
        function [RetVal, ModulationFrequency, Units] = GetGeneratorAVModulationFrequency(self)
            % GetGeneratorAVModulationFrequency
            % [RetVal, ModulationFrequency, Units] = GetGeneratorAVModulationFrequency(self)
            [RetVal, ModulationFrequency, Units] = self.upxHandle.GetGeneratorAVModulationFrequency();
        end
        function [RetVal, AllChannelSine] = GetGeneratorAllChannelSine(self)
            % GetGeneratorAllChannelSine
            % [RetVal, AllChannelSine] = GetGeneratorAllChannelSine(self)
            [RetVal, AllChannelSine] = self.upxHandle.GetGeneratorAllChannelSine();
        end
        function [RetVal, AmplitudeVariation] = GetGeneratorAmplitudeVariation(self)
            % GetGeneratorAmplitudeVariation
            % [RetVal, AmplitudeVariation] = GetGeneratorAmplitudeVariation(self)
            [RetVal, AmplitudeVariation] = self.upxHandle.GetGeneratorAmplitudeVariation();
        end
        function [RetVal, Bandwidth] = GetGeneratorBandwidth(self)
            % GetGeneratorBandwidth
            % [RetVal, Bandwidth] = GetGeneratorBandwidth(self)
            [RetVal, Bandwidth] = self.upxHandle.GetGeneratorBandwidth();
        end
        function [RetVal, Channel] = GetGeneratorChannelMode(self)
            % GetGeneratorChannelMode
            % [RetVal, Channel] = GetGeneratorChannelMode(self)
            [RetVal, Channel] = self.upxHandle.GetGeneratorChannelMode();
        end
        function [RetVal, PhaseCh21] = GetGeneratorChannelPhaseRatio(self)
            % GetGeneratorChannelPhaseRatio
            % [RetVal, PhaseCh21] = GetGeneratorChannelPhaseRatio(self)
            [RetVal, PhaseCh21] = self.upxHandle.GetGeneratorChannelPhaseRatio();
        end
        function [RetVal, VoltCh21] = GetGeneratorChannelVoltageRatio(self)
            % GetGeneratorChannelVoltageRatio
            % [RetVal, VoltCh21] = GetGeneratorChannelVoltageRatio(self)
            [RetVal, VoltCh21] = self.upxHandle.GetGeneratorChannelVoltageRatio();
        end
        function [RetVal, Common] = GetGeneratorCommon(self)
            % GetGeneratorCommon
            % [RetVal, Common] = GetGeneratorCommon(self)
            [RetVal, Common] = self.upxHandle.GetGeneratorCommon();
        end
        function [RetVal, CrestFactor] = GetGeneratorCrestFactor(self)
            % GetGeneratorCrestFactor
            % [RetVal, CrestFactor] = GetGeneratorCrestFactor(self)
            [RetVal, CrestFactor] = self.upxHandle.GetGeneratorCrestFactor();
        end
        function [RetVal, CrestFactor] = GetGeneratorCrestFactorValue(self)
            % GetGeneratorCrestFactorValue
            % [RetVal, CrestFactor] = GetGeneratorCrestFactorValue(self)
            [RetVal, CrestFactor] = self.upxHandle.GetGeneratorCrestFactorValue();
        end
        function [RetVal, DCOffset] = GetGeneratorDCOffset(self)
            % GetGeneratorDCOffset
            % [RetVal, DCOffset] = GetGeneratorDCOffset(self)
            [RetVal, DCOffset] = self.upxHandle.GetGeneratorDCOffset();
        end
        function [RetVal, DCOffset, Units] = GetGeneratorDCOffsetChannelValue(self, Channel)
            % GetGeneratorDCOffsetChannelValue
            % [RetVal, DCOffset, Units] = GetGeneratorDCOffsetChannelValue(self, Channel)
            [RetVal, DCOffset, Units] = self.upxHandle.GetGeneratorDCOffsetChannelValue(Channel);
        end
        function [RetVal, DCOffset] = GetGeneratorDCOffsetCoupling(self)
            % GetGeneratorDCOffsetCoupling
            % [RetVal, DCOffset] = GetGeneratorDCOffsetCoupling(self)
            [RetVal, DCOffset] = self.upxHandle.GetGeneratorDCOffsetCoupling();
        end
        function [RetVal, DCOffset, Units] = GetGeneratorDCOffsetValue(self)
            % GetGeneratorDCOffsetValue
            % [RetVal, DCOffset, Units] = GetGeneratorDCOffsetValue(self)
            [RetVal, DCOffset, Units] = self.upxHandle.GetGeneratorDCOffsetValue();
        end
        function [RetVal, DiffFrequency, Units] = GetGeneratorDFDDiffFrequency(self)
            % GetGeneratorDFDDiffFrequency
            % [RetVal, DiffFrequency, Units] = GetGeneratorDFDDiffFrequency(self)
            [RetVal, DiffFrequency, Units] = self.upxHandle.GetGeneratorDFDDiffFrequency();
        end
        function [RetVal, MeanFrequency, Units] = GetGeneratorDFDMeanFrequency(self)
            % GetGeneratorDFDMeanFrequency
            % [RetVal, MeanFrequency, Units] = GetGeneratorDFDMeanFrequency(self)
            [RetVal, MeanFrequency, Units] = self.upxHandle.GetGeneratorDFDMeanFrequency();
        end
        function [RetVal, Bandwidth] = GetGeneratorDIMBandwidth(self)
            % GetGeneratorDIMBandwidth
            % [RetVal, Bandwidth] = GetGeneratorDIMBandwidth(self)
            [RetVal, Bandwidth] = self.upxHandle.GetGeneratorDIMBandwidth();
        end
        function [RetVal, SquareSine] = GetGeneratorDIMSquareToSine(self)
            % GetGeneratorDIMSquareToSine
            % [RetVal, SquareSine] = GetGeneratorDIMSquareToSine(self)
            [RetVal, SquareSine] = self.upxHandle.GetGeneratorDIMSquareToSine();
        end
        function [RetVal, Dither] = GetGeneratorDither(self)
            % GetGeneratorDither
            % [RetVal, Dither] = GetGeneratorDither(self)
            [RetVal, Dither] = self.upxHandle.GetGeneratorDither();
        end
        function [RetVal, Value, Units] = GetGeneratorDitherValue(self)
            % GetGeneratorDitherValue
            % [RetVal, Value, Units] = GetGeneratorDitherValue(self)
            [RetVal, Value, Units] = self.upxHandle.GetGeneratorDitherValue();
        end
        function [RetVal, Equalizer] = GetGeneratorEqualizer(self)
            % GetGeneratorEqualizer
            % [RetVal, Equalizer] = GetGeneratorEqualizer(self)
            [RetVal, Equalizer] = self.upxHandle.GetGeneratorEqualizer();
        end
        function [RetVal, Equalizer] = GetGeneratorEqualizerCoupling(self)
            % GetGeneratorEqualizerCoupling
            % [RetVal, Equalizer] = GetGeneratorEqualizerCoupling(self)
            [RetVal, Equalizer] = self.upxHandle.GetGeneratorEqualizerCoupling();
        end
        function [RetVal, Filter] = GetGeneratorFilter(self)
            % GetGeneratorFilter
            % [RetVal, Filter] = GetGeneratorFilter(self)
            [RetVal, Filter] = self.upxHandle.GetGeneratorFilter();
        end
        function [RetVal, Frequency, Units] = GetGeneratorFrequency(self, Channel)
            % GetGeneratorFrequency
            % [RetVal, Frequency, Units] = GetGeneratorFrequency(self, Channel)
            [RetVal, Frequency, Units] = self.upxHandle.GetGeneratorFrequency(Channel);
        end
        function [RetVal, FrequencySpacing] = GetGeneratorFrequencySpacing(self)
            % GetGeneratorFrequencySpacing
            % [RetVal, FrequencySpacing] = GetGeneratorFrequencySpacing(self)
            [RetVal, FrequencySpacing] = self.upxHandle.GetGeneratorFrequencySpacing();
        end
        function [RetVal, FrequencySpacingValue, Units] = GetGeneratorFrequencySpacingValue(self)
            % GetGeneratorFrequencySpacingValue
            % [RetVal, FrequencySpacingValue, Units] = GetGeneratorFrequencySpacingValue(self)
            [RetVal, FrequencySpacingValue, Units] = self.upxHandle.GetGeneratorFrequencySpacingValue();
        end
        function [RetVal, GeneratorFunction] = GetGeneratorFunction(self)
            % GetGeneratorFunction
            % [RetVal, GeneratorFunction] = GetGeneratorFunction(self)
            [RetVal, GeneratorFunction] = self.upxHandle.GetGeneratorFunction();
        end
        function [RetVal, FunctionMode] = GetGeneratorFunctionMode(self)
            % GetGeneratorFunctionMode
            % [RetVal, FunctionMode] = GetGeneratorFunctionMode(self)
            [RetVal, FunctionMode] = self.upxHandle.GetGeneratorFunctionMode();
        end
        function [RetVal, Impedance] = GetGeneratorImpedance(self)
            % GetGeneratorImpedance
            % [RetVal, Impedance] = GetGeneratorImpedance(self)
            [RetVal, Impedance] = self.upxHandle.GetGeneratorImpedance();
        end
        function [RetVal, Instrument] = GetGeneratorInstrument(self)
            % GetGeneratorInstrument
            % [RetVal, Instrument] = GetGeneratorInstrument(self)
            [RetVal, Instrument] = self.upxHandle.GetGeneratorInstrument();
        end
        function [RetVal, MaxVoltage, Units] = GetGeneratorMaxVoltage(self)
            % GetGeneratorMaxVoltage
            % [RetVal, MaxVoltage, Units] = GetGeneratorMaxVoltage(self)
            [RetVal, MaxVoltage, Units] = self.upxHandle.GetGeneratorMaxVoltage();
        end
        function [RetVal, VoltageLFUF] = GetGeneratorModDistLevelRatio(self)
            % GetGeneratorModDistLevelRatio
            % [RetVal, VoltageLFUF] = GetGeneratorModDistLevelRatio(self)
            [RetVal, VoltageLFUF] = self.upxHandle.GetGeneratorModDistLevelRatio();
        end
        function [RetVal, LowerFrequency, Units] = GetGeneratorModDistLowerFrequency(self)
            % GetGeneratorModDistLowerFrequency
            % [RetVal, LowerFrequency, Units] = GetGeneratorModDistLowerFrequency(self)
            [RetVal, LowerFrequency, Units] = self.upxHandle.GetGeneratorModDistLowerFrequency();
        end
        function [RetVal, UpperFrequency, Units] = GetGeneratorModDistUpperFrequency(self)
            % GetGeneratorModDistUpperFrequency
            % [RetVal, UpperFrequency, Units] = GetGeneratorModDistUpperFrequency(self)
            [RetVal, UpperFrequency, Units] = self.upxHandle.GetGeneratorModDistUpperFrequency();
        end
        function [RetVal, CarrierFrequency, Units] = GetGeneratorModulationCarrierFrequency(self)
            % GetGeneratorModulationCarrierFrequency
            % [RetVal, CarrierFrequency, Units] = GetGeneratorModulationCarrierFrequency(self)
            [RetVal, CarrierFrequency, Units] = self.upxHandle.GetGeneratorModulationCarrierFrequency();
        end
        function [RetVal, CarrierVoltage, Units] = GetGeneratorModulationCarrierVoltage(self)
            % GetGeneratorModulationCarrierVoltage
            % [RetVal, CarrierVoltage, Units] = GetGeneratorModulationCarrierVoltage(self)
            [RetVal, CarrierVoltage, Units] = self.upxHandle.GetGeneratorModulationCarrierVoltage();
        end
        function [RetVal, ModulationDepth] = GetGeneratorModulationDepth(self)
            % GetGeneratorModulationDepth
            % [RetVal, ModulationDepth] = GetGeneratorModulationDepth(self)
            [RetVal, ModulationDepth] = self.upxHandle.GetGeneratorModulationDepth();
        end
        function [RetVal, Deviation] = GetGeneratorModulationDeviation(self)
            % GetGeneratorModulationDeviation
            % [RetVal, Deviation] = GetGeneratorModulationDeviation(self)
            [RetVal, Deviation] = self.upxHandle.GetGeneratorModulationDeviation();
        end
        function [RetVal, ModulationFrequency, Units] = GetGeneratorModulationFrequency(self)
            % GetGeneratorModulationFrequency
            % [RetVal, ModulationFrequency, Units] = GetGeneratorModulationFrequency(self)
            [RetVal, ModulationFrequency, Units] = self.upxHandle.GetGeneratorModulationFrequency();
        end
        function [RetVal, AllChanSine] = GetGeneratorMultichannelAllChanSine(self, Channel)
            % GetGeneratorMultichannelAllChanSine
            % [RetVal, AllChanSine] = GetGeneratorMultichannelAllChanSine(self, Channel)
            [RetVal, AllChanSine] = self.upxHandle.GetGeneratorMultichannelAllChanSine(Channel);
        end
        function [RetVal, DCOffset] = GetGeneratorMultichannelDCOffset(self, Channel)
            % GetGeneratorMultichannelDCOffset
            % [RetVal, DCOffset] = GetGeneratorMultichannelDCOffset(self, Channel)
            [RetVal, DCOffset] = self.upxHandle.GetGeneratorMultichannelDCOffset(Channel);
        end
        function [RetVal, DCOffset, Units] = GetGeneratorMultichannelDCOffsetValue(self, Channel)
            % GetGeneratorMultichannelDCOffsetValue
            % [RetVal, DCOffset, Units] = GetGeneratorMultichannelDCOffsetValue(self, Channel)
            [RetVal, DCOffset, Units] = self.upxHandle.GetGeneratorMultichannelDCOffsetValue(Channel);
        end
        function [RetVal, Filter] = GetGeneratorMultichannelFilter(self, Channel)
            % GetGeneratorMultichannelFilter
            % [RetVal, Filter] = GetGeneratorMultichannelFilter(self, Channel)
            [RetVal, Filter] = self.upxHandle.GetGeneratorMultichannelFilter(Channel);
        end
        function [RetVal, Gain] = GetGeneratorMultichannelGain(self, Channel)
            % GetGeneratorMultichannelGain
            % [RetVal, Gain] = GetGeneratorMultichannelGain(self, Channel)
            [RetVal, Gain] = self.upxHandle.GetGeneratorMultichannelGain(Channel);
        end
        function [RetVal, LimitToFS] = GetGeneratorMultichannelLimitToFS(self, Channel)
            % GetGeneratorMultichannelLimitToFS
            % [RetVal, LimitToFS] = GetGeneratorMultichannelLimitToFS(self, Channel)
            [RetVal, LimitToFS] = self.upxHandle.GetGeneratorMultichannelLimitToFS(Channel);
        end
        function [RetVal, AddToChannel] = GetGeneratorMultichannelSine(self, Channel)
            % GetGeneratorMultichannelSine
            % [RetVal, AddToChannel] = GetGeneratorMultichannelSine(self, Channel)
            [RetVal, AddToChannel] = self.upxHandle.GetGeneratorMultichannelSine(Channel);
        end
        function [RetVal, Arbitrary] = GetGeneratorMultichannelSineArbitrary(self, Channel)
            % GetGeneratorMultichannelSineArbitrary
            % [RetVal, Arbitrary] = GetGeneratorMultichannelSineArbitrary(self, Channel)
            [RetVal, Arbitrary] = self.upxHandle.GetGeneratorMultichannelSineArbitrary(Channel);
        end
        function [RetVal, Equalizer] = GetGeneratorMultichannelSineEqualizer(self, Channel)
            % GetGeneratorMultichannelSineEqualizer
            % [RetVal, Equalizer] = GetGeneratorMultichannelSineEqualizer(self, Channel)
            [RetVal, Equalizer] = self.upxHandle.GetGeneratorMultichannelSineEqualizer(Channel);
        end
        function [RetVal, SineFrequency, Units] = GetGeneratorMultichannelSineFrequency(self, Channel)
            % GetGeneratorMultichannelSineFrequency
            % [RetVal, SineFrequency, Units] = GetGeneratorMultichannelSineFrequency(self, Channel)
            [RetVal, SineFrequency, Units] = self.upxHandle.GetGeneratorMultichannelSineFrequency(Channel);
        end
        function [RetVal, SinePhase, Units] = GetGeneratorMultichannelSinePhase(self, Channel)
            % GetGeneratorMultichannelSinePhase
            % [RetVal, SinePhase, Units] = GetGeneratorMultichannelSinePhase(self, Channel)
            [RetVal, SinePhase, Units] = self.upxHandle.GetGeneratorMultichannelSinePhase(Channel);
        end
        function [RetVal, VoltPeak, Units] = GetGeneratorMultichannelSineVoltPeak(self, Channel)
            % GetGeneratorMultichannelSineVoltPeak
            % [RetVal, VoltPeak, Units] = GetGeneratorMultichannelSineVoltPeak(self, Channel)
            [RetVal, VoltPeak, Units] = self.upxHandle.GetGeneratorMultichannelSineVoltPeak(Channel);
        end
        function [RetVal, SineVoltage, Units] = GetGeneratorMultichannelSineVoltage(self, Channel)
            % GetGeneratorMultichannelSineVoltage
            % [RetVal, SineVoltage, Units] = GetGeneratorMultichannelSineVoltage(self, Channel)
            [RetVal, SineVoltage, Units] = self.upxHandle.GetGeneratorMultichannelSineVoltage(Channel);
        end
        function [RetVal, TotalGain] = GetGeneratorMultichannelTotalGain(self, Channel)
            % GetGeneratorMultichannelTotalGain
            % [RetVal, TotalGain] = GetGeneratorMultichannelTotalGain(self, Channel)
            [RetVal, TotalGain] = self.upxHandle.GetGeneratorMultichannelTotalGain(Channel);
        end
        function [RetVal, NoofSine] = GetGeneratorMultisineNoOfSine(self)
            % GetGeneratorMultisineNoOfSine
            % [RetVal, NoofSine] = GetGeneratorMultisineNoOfSine(self)
            [RetVal, NoofSine] = self.upxHandle.GetGeneratorMultisineNoOfSine();
        end
        function [RetVal, PhaseNoi, Units] = GetGeneratorMultisinePhaseNoi(self, Number)
            % GetGeneratorMultisinePhaseNoi
            % [RetVal, PhaseNoi, Units] = GetGeneratorMultisinePhaseNoi(self, Number)
            [RetVal, PhaseNoi, Units] = self.upxHandle.GetGeneratorMultisinePhaseNoi(Number);
        end
        function [RetVal, TotalGain] = GetGeneratorMultisineTotalGain(self)
            % GetGeneratorMultisineTotalGain
            % [RetVal, TotalGain] = GetGeneratorMultisineTotalGain(self)
            [RetVal, TotalGain] = self.upxHandle.GetGeneratorMultisineTotalGain();
        end
        function [RetVal, State] = GetGeneratorOutputState(self)
            % GetGeneratorOutputState
            % [RetVal, State] = GetGeneratorOutputState(self)
            [RetVal, State] = self.upxHandle.GetGeneratorOutputState();
        end
        function [RetVal, OutputType] = GetGeneratorOutputType(self)
            % GetGeneratorOutputType
            % [RetVal, OutputType] = GetGeneratorOutputType(self)
            [RetVal, OutputType] = self.upxHandle.GetGeneratorOutputType();
        end
        function [RetVal, PDF] = GetGeneratorPDF(self)
            % GetGeneratorPDF
            % [RetVal, PDF] = GetGeneratorPDF(self)
            [RetVal, PDF] = self.upxHandle.GetGeneratorPDF();
        end
        function [RetVal, LoopChannel] = GetGeneratorPlayAnalyzerLoopChannel(self)
            % GetGeneratorPlayAnalyzerLoopChannel
            % [RetVal, LoopChannel] = GetGeneratorPlayAnalyzerLoopChannel(self)
            [RetVal, LoopChannel] = self.upxHandle.GetGeneratorPlayAnalyzerLoopChannel();
        end
        function [RetVal, LoopGain, Units] = GetGeneratorPlayAnalyzerLoopGain(self)
            % GetGeneratorPlayAnalyzerLoopGain
            % [RetVal, LoopGain, Units] = GetGeneratorPlayAnalyzerLoopGain(self)
            [RetVal, LoopGain, Units] = self.upxHandle.GetGeneratorPlayAnalyzerLoopGain();
        end
        function [RetVal, Channel] = GetGeneratorPlayChannel(self)
            % GetGeneratorPlayChannel
            % [RetVal, Channel] = GetGeneratorPlayChannel(self)
            [RetVal, Channel] = self.upxHandle.GetGeneratorPlayChannel();
        end
        function [RetVal, Mode] = GetGeneratorPlayMode(self)
            % GetGeneratorPlayMode
            % [RetVal, Mode] = GetGeneratorPlayMode(self)
            [RetVal, Mode] = self.upxHandle.GetGeneratorPlayMode();
        end
        function [RetVal, Restart] = GetGeneratorPlayRestart(self)
            % GetGeneratorPlayRestart
            % [RetVal, Restart] = GetGeneratorPlayRestart(self)
            [RetVal, Restart] = self.upxHandle.GetGeneratorPlayRestart();
        end
        function [RetVal, ScalePkToFS] = GetGeneratorPlayScalePkToFS(self)
            % GetGeneratorPlayScalePkToFS
            % [RetVal, ScalePkToFS] = GetGeneratorPlayScalePkToFS(self)
            [RetVal, ScalePkToFS] = self.upxHandle.GetGeneratorPlayScalePkToFS();
        end
        function [RetVal, Time] = GetGeneratorPlayTime(self)
            % GetGeneratorPlayTime
            % [RetVal, Time] = GetGeneratorPlayTime(self)
            [RetVal, Time] = self.upxHandle.GetGeneratorPlayTime();
        end
        function [RetVal, Domain] = GetGeneratorRandomDomain(self)
            % GetGeneratorRandomDomain
            % [RetVal, Domain] = GetGeneratorRandomDomain(self)
            [RetVal, Domain] = self.upxHandle.GetGeneratorRandomDomain();
        end
        function [RetVal, LowerFrequency, Units] = GetGeneratorRandomLowerFrequency(self)
            % GetGeneratorRandomLowerFrequency
            % [RetVal, LowerFrequency, Units] = GetGeneratorRandomLowerFrequency(self)
            [RetVal, LowerFrequency, Units] = self.upxHandle.GetGeneratorRandomLowerFrequency();
        end
        function [RetVal, Shape] = GetGeneratorRandomShape(self)
            % GetGeneratorRandomShape
            % [RetVal, Shape] = GetGeneratorRandomShape(self)
            [RetVal, Shape] = self.upxHandle.GetGeneratorRandomShape();
        end
        function [RetVal, UpperFrequency, Units] = GetGeneratorRandomUpperFrequency(self)
            % GetGeneratorRandomUpperFrequency
            % [RetVal, UpperFrequency, Units] = GetGeneratorRandomUpperFrequency(self)
            [RetVal, UpperFrequency, Units] = self.upxHandle.GetGeneratorRandomUpperFrequency();
        end
        function [RetVal, RefFrequency, Units] = GetGeneratorRefFrequency(self)
            % GetGeneratorRefFrequency
            % [RetVal, RefFrequency, Units] = GetGeneratorRefFrequency(self)
            [RetVal, RefFrequency, Units] = self.upxHandle.GetGeneratorRefFrequency();
        end
        function [RetVal, RefVoltage, Units] = GetGeneratorRefVoltage(self)
            % GetGeneratorRefVoltage
            % [RetVal, RefVoltage, Units] = GetGeneratorRefVoltage(self)
            [RetVal, RefVoltage, Units] = self.upxHandle.GetGeneratorRefVoltage();
        end
        function [RetVal, Interval, Units] = GetGeneratorSineBurstInterval(self)
            % GetGeneratorSineBurstInterval
            % [RetVal, Interval, Units] = GetGeneratorSineBurstInterval(self)
            [RetVal, Interval, Units] = self.upxHandle.GetGeneratorSineBurstInterval();
        end
        function [RetVal, LowLevel, Units] = GetGeneratorSineBurstLowLevel(self)
            % GetGeneratorSineBurstLowLevel
            % [RetVal, LowLevel, Units] = GetGeneratorSineBurstLowLevel(self)
            [RetVal, LowLevel, Units] = self.upxHandle.GetGeneratorSineBurstLowLevel();
        end
        function [RetVal, BurstonDelay, Units] = GetGeneratorSineBurstOnDelay(self)
            % GetGeneratorSineBurstOnDelay
            % [RetVal, BurstonDelay, Units] = GetGeneratorSineBurstOnDelay(self)
            [RetVal, BurstonDelay, Units] = self.upxHandle.GetGeneratorSineBurstOnDelay();
        end
        function [RetVal, OnTime, Units] = GetGeneratorSineBurstOnTime(self)
            % GetGeneratorSineBurstOnTime
            % [RetVal, OnTime, Units] = GetGeneratorSineBurstOnTime(self)
            [RetVal, OnTime, Units] = self.upxHandle.GetGeneratorSineBurstOnTime();
        end
        function [RetVal, Frequency, Units] = GetGeneratorSineFrequency(self)
            % GetGeneratorSineFrequency
            % [RetVal, Frequency, Units] = GetGeneratorSineFrequency(self)
            [RetVal, Frequency, Units] = self.upxHandle.GetGeneratorSineFrequency();
        end
        function [RetVal, LowDistortion] = GetGeneratorSineLowDistortion(self)
            % GetGeneratorSineLowDistortion
            % [RetVal, LowDistortion] = GetGeneratorSineLowDistortion(self)
            [RetVal, LowDistortion] = self.upxHandle.GetGeneratorSineLowDistortion();
        end
        function [RetVal, Voltage, Units] = GetGeneratorSineVoltage(self)
            % GetGeneratorSineVoltage
            % [RetVal, Voltage, Units] = GetGeneratorSineVoltage(self)
            [RetVal, Voltage, Units] = self.upxHandle.GetGeneratorSineVoltage();
        end
        function [RetVal, Channel] = GetGeneratorSingleChannel(self)
            % GetGeneratorSingleChannel
            % [RetVal, Channel] = GetGeneratorSingleChannel(self)
            [RetVal, Channel] = self.upxHandle.GetGeneratorSingleChannel();
        end
        function [RetVal, TrackToOtherChannel] = GetGeneratorSingleChannelTrackToOtherChannel(self)
            % GetGeneratorSingleChannelTrackToOtherChannel
            % [RetVal, TrackToOtherChannel] = GetGeneratorSingleChannelTrackToOtherChannel(self)
            [RetVal, TrackToOtherChannel] = self.upxHandle.GetGeneratorSingleChannelTrackToOtherChannel();
        end
        function [RetVal, Filter] = GetGeneratorStereoChannelFilter(self)
            % GetGeneratorStereoChannelFilter
            % [RetVal, Filter] = GetGeneratorStereoChannelFilter(self)
            [RetVal, Filter] = self.upxHandle.GetGeneratorStereoChannelFilter();
        end
        function [RetVal, Filter] = GetGeneratorStereoChannelFilterCoupling(self)
            % GetGeneratorStereoChannelFilterCoupling
            % [RetVal, Filter] = GetGeneratorStereoChannelFilterCoupling(self)
            [RetVal, Filter] = self.upxHandle.GetGeneratorStereoChannelFilterCoupling();
        end
        function [RetVal, Equalizer] = GetGeneratorStereoEqualizer(self)
            % GetGeneratorStereoEqualizer
            % [RetVal, Equalizer] = GetGeneratorStereoEqualizer(self)
            [RetVal, Equalizer] = self.upxHandle.GetGeneratorStereoEqualizer();
        end
        function [RetVal, FrequencyCh2, Units] = GetGeneratorStereoFrequencyCh2(self)
            % GetGeneratorStereoFrequencyCh2
            % [RetVal, FrequencyCh2, Units] = GetGeneratorStereoFrequencyCh2(self)
            [RetVal, FrequencyCh2, Units] = self.upxHandle.GetGeneratorStereoFrequencyCh2();
        end
        function [RetVal, FrequencyMode] = GetGeneratorStereoFrequencyMode(self)
            % GetGeneratorStereoFrequencyMode
            % [RetVal, FrequencyMode] = GetGeneratorStereoFrequencyMode(self)
            [RetVal, FrequencyMode] = self.upxHandle.GetGeneratorStereoFrequencyMode();
        end
        function [RetVal, VoltageCh2, Units] = GetGeneratorStereoVoltageCh2(self)
            % GetGeneratorStereoVoltageCh2
            % [RetVal, VoltageCh2, Units] = GetGeneratorStereoVoltageCh2(self)
            [RetVal, VoltageCh2, Units] = self.upxHandle.GetGeneratorStereoVoltageCh2();
        end
        function [RetVal, VoltageMode] = GetGeneratorStereoVoltageMode(self)
            % GetGeneratorStereoVoltageMode
            % [RetVal, VoltageMode] = GetGeneratorStereoVoltageMode(self)
            [RetVal, VoltageMode] = self.upxHandle.GetGeneratorStereoVoltageMode();
        end
        function [RetVal, SweepCtrl] = GetGeneratorSweepCtrl(self)
            % GetGeneratorSweepCtrl
            % [RetVal, SweepCtrl] = GetGeneratorSweepCtrl(self)
            [RetVal, SweepCtrl] = self.upxHandle.GetGeneratorSweepCtrl();
        end
        function [RetVal, Dwell, Units] = GetGeneratorSweepDwellTime(self)
            % GetGeneratorSweepDwellTime
            % [RetVal, Dwell, Units] = GetGeneratorSweepDwellTime(self)
            [RetVal, Dwell, Units] = self.upxHandle.GetGeneratorSweepDwellTime();
        end
        function [RetVal, Halt, HaltValue, Units] = GetGeneratorSweepHalt(self, Axis)
            % GetGeneratorSweepHalt
            % [RetVal, Halt, HaltValue, Units] = GetGeneratorSweepHalt(self, Axis)
            [RetVal, Halt, HaltValue, Units] = self.upxHandle.GetGeneratorSweepHalt(Axis);
        end
        function [RetVal, NextStep] = GetGeneratorSweepNextStep(self)
            % GetGeneratorSweepNextStep
            % [RetVal, NextStep] = GetGeneratorSweepNextStep(self)
            [RetVal, NextStep] = self.upxHandle.GetGeneratorSweepNextStep();
        end
        function [RetVal, Points] = GetGeneratorSweepPoints(self, Axis)
            % GetGeneratorSweepPoints
            % [RetVal, Points] = GetGeneratorSweepPoints(self, Axis)
            [RetVal, Points] = self.upxHandle.GetGeneratorSweepPoints(Axis);
        end
        function [RetVal, Spacing] = GetGeneratorSweepSpacing(self, Axis)
            % GetGeneratorSweepSpacing
            % [RetVal, Spacing] = GetGeneratorSweepSpacing(self, Axis)
            [RetVal, Spacing] = self.upxHandle.GetGeneratorSweepSpacing(Axis);
        end
        function [RetVal, Start, Units] = GetGeneratorSweepStart(self, Axis)
            % GetGeneratorSweepStart
            % [RetVal, Start, Units] = GetGeneratorSweepStart(self, Axis)
            [RetVal, Start, Units] = self.upxHandle.GetGeneratorSweepStart(Axis);
        end
        function [RetVal, Steps, Units] = GetGeneratorSweepSteps(self, Axis)
            % GetGeneratorSweepSteps
            % [RetVal, Steps, Units] = GetGeneratorSweepSteps(self, Axis)
            [RetVal, Steps, Units] = self.upxHandle.GetGeneratorSweepSteps(Axis);
        end
        function [RetVal, Stop, Units] = GetGeneratorSweepStop(self, Axis)
            % GetGeneratorSweepStop
            % [RetVal, Stop, Units] = GetGeneratorSweepStop(self, Axis)
            [RetVal, Stop, Units] = self.upxHandle.GetGeneratorSweepStop(Axis);
        end
        function [RetVal, XAxis] = GetGeneratorSweepXAxis(self)
            % GetGeneratorSweepXAxis
            % [RetVal, XAxis] = GetGeneratorSweepXAxis(self)
            [RetVal, XAxis] = self.upxHandle.GetGeneratorSweepXAxis();
        end
        function [RetVal, ZAxis] = GetGeneratorSweepZAxis(self)
            % GetGeneratorSweepZAxis
            % [RetVal, ZAxis] = GetGeneratorSweepZAxis(self)
            [RetVal, ZAxis] = self.upxHandle.GetGeneratorSweepZAxis();
        end
        function [RetVal, VoltageValue, Units] = GetGeneratorTotalVoltage(self)
            % GetGeneratorTotalVoltage
            % [RetVal, VoltageValue, Units] = GetGeneratorTotalVoltage(self)
            [RetVal, VoltageValue, Units] = self.upxHandle.GetGeneratorTotalVoltage();
        end
        function [RetVal, Variation] = GetGeneratorVariation(self)
            % GetGeneratorVariation
            % [RetVal, Variation] = GetGeneratorVariation(self)
            [RetVal, Variation] = self.upxHandle.GetGeneratorVariation();
        end
        function [RetVal, Voltage, Units] = GetGeneratorVoltage(self, Channel)
            % GetGeneratorVoltage
            % [RetVal, Voltage, Units] = GetGeneratorVoltage(self, Channel)
            [RetVal, Voltage, Units] = self.upxHandle.GetGeneratorVoltage(Channel);
        end
        function [RetVal, VoltageRMS, Units] = GetGeneratorVoltageRMS(self)
            % GetGeneratorVoltageRMS
            % [RetVal, VoltageRMS, Units] = GetGeneratorVoltageRMS(self)
            [RetVal, VoltageRMS, Units] = self.upxHandle.GetGeneratorVoltageRMS();
        end
        function [RetVal, VoltRange] = GetGeneratorVoltageRange(self)
            % GetGeneratorVoltageRange
            % [RetVal, VoltRange] = GetGeneratorVoltageRange(self)
            [RetVal, VoltRange] = self.upxHandle.GetGeneratorVoltageRange();
        end
        function [RetVal, CTS] = GetHDMIAnalyzerAudioCTSParameter(self)
            % GetHDMIAnalyzerAudioCTSParameter
            % [RetVal, CTS] = GetHDMIAnalyzerAudioCTSParameter(self)
            [RetVal, CTS] = self.upxHandle.GetHDMIAnalyzerAudioCTSParameter();
        end
        function [RetVal, Channel] = GetHDMIAnalyzerAudioChannel(self)
            % GetHDMIAnalyzerAudioChannel
            % [RetVal, Channel] = GetHDMIAnalyzerAudioChannel(self)
            [RetVal, Channel] = self.upxHandle.GetHDMIAnalyzerAudioChannel();
        end
        function [RetVal, AudioCoding] = GetHDMIAnalyzerAudioCoding(self)
            % GetHDMIAnalyzerAudioCoding
            % [RetVal, AudioCoding] = GetHDMIAnalyzerAudioCoding(self)
            [RetVal, AudioCoding] = self.upxHandle.GetHDMIAnalyzerAudioCoding();
        end
        function [RetVal, Detected] = GetHDMIAnalyzerAudioDetected(self, BufferSize)
            % GetHDMIAnalyzerAudioDetected
            % [RetVal, Detected] = GetHDMIAnalyzerAudioDetected(self, BufferSize)
            Detected = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIAnalyzerAudioDetected(BufferSize, Detected);
            Detected = char(Detected.ToString);
        end
        function [RetVal, AudioFormat] = GetHDMIAnalyzerAudioFormat(self)
            % GetHDMIAnalyzerAudioFormat
            % [RetVal, AudioFormat] = GetHDMIAnalyzerAudioFormat(self)
            [RetVal, AudioFormat] = self.upxHandle.GetHDMIAnalyzerAudioFormat();
        end
        function [RetVal, AudioInfoFrame] = GetHDMIAnalyzerAudioInfoFrame(self, BufferSize)
            % GetHDMIAnalyzerAudioInfoFrame
            % [RetVal, AudioInfoFrame] = GetHDMIAnalyzerAudioInfoFrame(self, BufferSize)
            AudioInfoFrame = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIAnalyzerAudioInfoFrame(BufferSize, AudioInfoFrame);
            AudioInfoFrame = char(AudioInfoFrame.ToString);
        end
        function [RetVal, Input] = GetHDMIAnalyzerAudioInput(self)
            % GetHDMIAnalyzerAudioInput
            % [RetVal, Input] = GetHDMIAnalyzerAudioInput(self)
            [RetVal, Input] = self.upxHandle.GetHDMIAnalyzerAudioInput();
        end
        function [RetVal, State] = GetHDMIAnalyzerAudioMeasChannelState(self, MeasChannel)
            % GetHDMIAnalyzerAudioMeasChannelState
            % [RetVal, State] = GetHDMIAnalyzerAudioMeasChannelState(self, MeasChannel)
            [RetVal, State] = self.upxHandle.GetHDMIAnalyzerAudioMeasChannelState(MeasChannel);
        end
        function [RetVal, N] = GetHDMIAnalyzerAudioNParameter(self)
            % GetHDMIAnalyzerAudioNParameter
            % [RetVal, N] = GetHDMIAnalyzerAudioNParameter(self)
            [RetVal, N] = self.upxHandle.GetHDMIAnalyzerAudioNParameter();
        end
        function [RetVal, AVI] = GetHDMIAnalyzerVideoAVI(self, BufferSize)
            % GetHDMIAnalyzerVideoAVI
            % [RetVal, AVI] = GetHDMIAnalyzerVideoAVI(self, BufferSize)
            AVI = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIAnalyzerVideoAVI(BufferSize, AVI);
            AVI = char(AVI.ToString);
        end
        function [RetVal, ColorDepth] = GetHDMIAnalyzerVideoColorDepth(self, BufferSize)
            % GetHDMIAnalyzerVideoColorDepth
            % [RetVal, ColorDepth] = GetHDMIAnalyzerVideoColorDepth(self, BufferSize)
            ColorDepth = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIAnalyzerVideoColorDepth(BufferSize, ColorDepth);
            ColorDepth = char(ColorDepth.ToString);
        end
        function [RetVal, EEDID] = GetHDMIAnalyzerVideoEEDID(self, BufferSize)
            % GetHDMIAnalyzerVideoEEDID
            % [RetVal, EEDID] = GetHDMIAnalyzerVideoEEDID(self, BufferSize)
            EEDID = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIAnalyzerVideoEEDID(BufferSize, EEDID);
            EEDID = char(EEDID.ToString);
        end
        function [RetVal, FormatNo] = GetHDMIAnalyzerVideoFormatNo(self, BufferSize)
            % GetHDMIAnalyzerVideoFormatNo
            % [RetVal, FormatNo] = GetHDMIAnalyzerVideoFormatNo(self, BufferSize)
            FormatNo = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIAnalyzerVideoFormatNo(BufferSize, FormatNo);
            FormatNo = char(FormatNo.ToString);
        end
        function [RetVal, HDCPState] = GetHDMIAnalyzerVideoHDCPState(self)
            % GetHDMIAnalyzerVideoHDCPState
            % [RetVal, HDCPState] = GetHDMIAnalyzerVideoHDCPState(self)
            [RetVal, HDCPState] = self.upxHandle.GetHDMIAnalyzerVideoHDCPState();
        end
        function [RetVal, SPD] = GetHDMIAnalyzerVideoSPD(self, BufferSize)
            % GetHDMIAnalyzerVideoSPD
            % [RetVal, SPD] = GetHDMIAnalyzerVideoSPD(self, BufferSize)
            SPD = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIAnalyzerVideoSPD(BufferSize, SPD);
            SPD = char(SPD.ToString);
        end
        function [RetVal, Timings] = GetHDMIAnalyzerVideoTimings(self, BufferSize)
            % GetHDMIAnalyzerVideoTimings
            % [RetVal, Timings] = GetHDMIAnalyzerVideoTimings(self, BufferSize)
            Timings = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIAnalyzerVideoTimings(BufferSize, Timings);
            Timings = char(Timings.ToString);
        end
        function [RetVal, AudioFormat] = GetHDMIGeneratorAudioFormat(self)
            % GetHDMIGeneratorAudioFormat
            % [RetVal, AudioFormat] = GetHDMIGeneratorAudioFormat(self)
            [RetVal, AudioFormat] = self.upxHandle.GetHDMIGeneratorAudioFormat();
        end
        function [RetVal, AudioInfoFrame] = GetHDMIGeneratorAudioInfoFrame(self, BufferSize)
            % GetHDMIGeneratorAudioInfoFrame
            % [RetVal, AudioInfoFrame] = GetHDMIGeneratorAudioInfoFrame(self, BufferSize)
            AudioInfoFrame = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIGeneratorAudioInfoFrame(BufferSize, AudioInfoFrame);
            AudioInfoFrame = char(AudioInfoFrame.ToString);
        end
        function [RetVal, SinkARC] = GetHDMIGeneratorAudioSinkARC(self)
            % GetHDMIGeneratorAudioSinkARC
            % [RetVal, SinkARC] = GetHDMIGeneratorAudioSinkARC(self)
            [RetVal, SinkARC] = self.upxHandle.GetHDMIGeneratorAudioSinkARC();
        end
        function [RetVal, GenChannels] = GetHDMIGeneratorChannelsMode(self, MeasChannel)
            % GetHDMIGeneratorChannelsMode
            % [RetVal, GenChannels] = GetHDMIGeneratorChannelsMode(self, MeasChannel)
            [RetVal, GenChannels] = self.upxHandle.GetHDMIGeneratorChannelsMode(MeasChannel);
        end
        function [RetVal, AVI] = GetHDMIGeneratorVideoAVI(self, BufferSize)
            % GetHDMIGeneratorVideoAVI
            % [RetVal, AVI] = GetHDMIGeneratorVideoAVI(self, BufferSize)
            AVI = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIGeneratorVideoAVI(BufferSize, AVI);
            AVI = char(AVI.ToString);
        end
        function [RetVal, CEC] = GetHDMIGeneratorVideoCEC(self, BufferSize)
            % GetHDMIGeneratorVideoCEC
            % [RetVal, CEC] = GetHDMIGeneratorVideoCEC(self, BufferSize)
            CEC = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIGeneratorVideoCEC(BufferSize, CEC);
            CEC = char(CEC.ToString);
        end
        function [RetVal, ColorDepth] = GetHDMIGeneratorVideoColorDepth(self)
            % GetHDMIGeneratorVideoColorDepth
            % [RetVal, ColorDepth] = GetHDMIGeneratorVideoColorDepth(self)
            [RetVal, ColorDepth] = self.upxHandle.GetHDMIGeneratorVideoColorDepth();
        end
        function [RetVal, ColorString] = GetHDMIGeneratorVideoColorString(self, BufferSize)
            % GetHDMIGeneratorVideoColorString
            % [RetVal, ColorString] = GetHDMIGeneratorVideoColorString(self, BufferSize)
            ColorString = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIGeneratorVideoColorString(BufferSize, ColorString);
            ColorString = char(ColorString.ToString);
        end
        function [RetVal, Content] = GetHDMIGeneratorVideoContent(self)
            % GetHDMIGeneratorVideoContent
            % [RetVal, Content] = GetHDMIGeneratorVideoContent(self)
            [RetVal, Content] = self.upxHandle.GetHDMIGeneratorVideoContent();
        end
        function [RetVal, EEDID] = GetHDMIGeneratorVideoEEDID(self, BufferSize)
            % GetHDMIGeneratorVideoEEDID
            % [RetVal, EEDID] = GetHDMIGeneratorVideoEEDID(self, BufferSize)
            EEDID = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIGeneratorVideoEEDID(BufferSize, EEDID);
            EEDID = char(EEDID.ToString);
        end
        function [RetVal, FormatFrequency] = GetHDMIGeneratorVideoFormatFrequency(self)
            % GetHDMIGeneratorVideoFormatFrequency
            % [RetVal, FormatFrequency] = GetHDMIGeneratorVideoFormatFrequency(self)
            [RetVal, FormatFrequency] = self.upxHandle.GetHDMIGeneratorVideoFormatFrequency();
        end
        function [RetVal, FormatNo] = GetHDMIGeneratorVideoFormatNo(self, BufferSize)
            % GetHDMIGeneratorVideoFormatNo
            % [RetVal, FormatNo] = GetHDMIGeneratorVideoFormatNo(self, BufferSize)
            FormatNo = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIGeneratorVideoFormatNo(BufferSize, FormatNo);
            FormatNo = char(FormatNo.ToString);
        end
        function [RetVal, FormatResolution] = GetHDMIGeneratorVideoFormatResolution(self)
            % GetHDMIGeneratorVideoFormatResolution
            % [RetVal, FormatResolution] = GetHDMIGeneratorVideoFormatResolution(self)
            [RetVal, FormatResolution] = self.upxHandle.GetHDMIGeneratorVideoFormatResolution();
        end
        function [RetVal, SPD] = GetHDMIGeneratorVideoSPD(self, BufferSize)
            % GetHDMIGeneratorVideoSPD
            % [RetVal, SPD] = GetHDMIGeneratorVideoSPD(self, BufferSize)
            SPD = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHDMIGeneratorVideoSPD(BufferSize, SPD);
            SPD = char(SPD.ToString);
        end
        function [RetVal, Source] = GetHDMIGeneratorVideoSource(self)
            % GetHDMIGeneratorVideoSource
            % [RetVal, Source] = GetHDMIGeneratorVideoSource(self)
            [RetVal, Source] = self.upxHandle.GetHDMIGeneratorVideoSource();
        end
        function [RetVal, DefineFooter] = GetHardcopyDefineFooter(self, BufferSize)
            % GetHardcopyDefineFooter
            % [RetVal, DefineFooter] = GetHardcopyDefineFooter(self, BufferSize)
            DefineFooter = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHardcopyDefineFooter(BufferSize, DefineFooter);
            DefineFooter = char(DefineFooter.ToString);
        end
        function [RetVal, DefineHeader] = GetHardcopyDefineHeader(self, BufferSize)
            % GetHardcopyDefineHeader
            % [RetVal, DefineHeader] = GetHardcopyDefineHeader(self, BufferSize)
            DefineHeader = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHardcopyDefineHeader(BufferSize, DefineHeader);
            DefineHeader = char(DefineHeader.ToString);
        end
        function [RetVal, Destination] = GetHardcopyDestination(self)
            % GetHardcopyDestination
            % [RetVal, Destination] = GetHardcopyDestination(self)
            [RetVal, Destination] = self.upxHandle.GetHardcopyDestination();
        end
        function [RetVal, FileName] = GetHardcopyFileName(self, BufferSize)
            % GetHardcopyFileName
            % [RetVal, FileName] = GetHardcopyFileName(self, BufferSize)
            FileName = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHardcopyFileName(BufferSize, FileName);
            FileName = char(FileName.ToString);
        end
        function [RetVal, HeaderFooter] = GetHardcopyHeaderFooterState(self)
            % GetHardcopyHeaderFooterState
            % [RetVal, HeaderFooter] = GetHardcopyHeaderFooterState(self)
            [RetVal, HeaderFooter] = self.upxHandle.GetHardcopyHeaderFooterState();
        end
        function [RetVal, Orientation] = GetHardcopyOrientation(self)
            % GetHardcopyOrientation
            % [RetVal, Orientation] = GetHardcopyOrientation(self)
            [RetVal, Orientation] = self.upxHandle.GetHardcopyOrientation();
        end
        function [RetVal, Size] = GetHardcopySize(self, BufferSize)
            % GetHardcopySize
            % [RetVal, Size] = GetHardcopySize(self, BufferSize)
            Size = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetHardcopySize(BufferSize, Size);
            Size = char(Size.ToString);
        end
        function [RetVal, Source] = GetHardcopySource(self)
            % GetHardcopySource
            % [RetVal, Source] = GetHardcopySource(self)
            [RetVal, Source] = self.upxHandle.GetHardcopySource();
        end
        function [RetVal, StoreMode] = GetHardcopyStoreMode(self)
            % GetHardcopyStoreMode
            % [RetVal, StoreMode] = GetHardcopyStoreMode(self)
            [RetVal, StoreMode] = self.upxHandle.GetHardcopyStoreMode();
        end
        function [RetVal] = GetHashCode(self)
            % GetHashCode
            % [RetVal] = GetHashCode(self)
            [RetVal] = self.upxHandle.GetHashCode();
        end
        function [RetVal, ChannelMode] = GetI2SAnalyzerChannelMode(self)
            % GetI2SAnalyzerChannelMode
            % [RetVal, ChannelMode] = GetI2SAnalyzerChannelMode(self)
            [RetVal, ChannelMode] = self.upxHandle.GetI2SAnalyzerChannelMode();
        end
        function [RetVal, Format] = GetI2SAnalyzerFormat(self)
            % GetI2SAnalyzerFormat
            % [RetVal, Format] = GetI2SAnalyzerFormat(self)
            [RetVal, Format] = self.upxHandle.GetI2SAnalyzerFormat();
        end
        function [RetVal, FsyncSlope] = GetI2SAnalyzerFsyncSlope(self)
            % GetI2SAnalyzerFsyncSlope
            % [RetVal, FsyncSlope] = GetI2SAnalyzerFsyncSlope(self)
            [RetVal, FsyncSlope] = self.upxHandle.GetI2SAnalyzerFsyncSlope();
        end
        function [RetVal, Input] = GetI2SAnalyzerInput(self)
            % GetI2SAnalyzerInput
            % [RetVal, Input] = GetI2SAnalyzerInput(self)
            [RetVal, Input] = self.upxHandle.GetI2SAnalyzerInput();
        end
        function [RetVal, SampleFrequency, SampleFrequencyValue] = GetI2SAnalyzerSampleFrequency(self)
            % GetI2SAnalyzerSampleFrequency
            % [RetVal, SampleFrequency, SampleFrequencyValue] = GetI2SAnalyzerSampleFrequency(self)
            [RetVal, SampleFrequency, SampleFrequencyValue] = self.upxHandle.GetI2SAnalyzerSampleFrequency();
        end
        function [RetVal, WordLength] = GetI2SAnalyzerWordLength(self)
            % GetI2SAnalyzerWordLength
            % [RetVal, WordLength] = GetI2SAnalyzerWordLength(self)
            [RetVal, WordLength] = self.upxHandle.GetI2SAnalyzerWordLength();
        end
        function [RetVal, WordOffset] = GetI2SAnalyzerWordOffset(self)
            % GetI2SAnalyzerWordOffset
            % [RetVal, WordOffset] = GetI2SAnalyzerWordOffset(self)
            [RetVal, WordOffset] = self.upxHandle.GetI2SAnalyzerWordOffset();
        end
        function [RetVal, AudioBits] = GetI2SGeneratorAudioBits(self)
            % GetI2SGeneratorAudioBits
            % [RetVal, AudioBits] = GetI2SGeneratorAudioBits(self)
            [RetVal, AudioBits] = self.upxHandle.GetI2SGeneratorAudioBits();
        end
        function [RetVal, BClkFreq] = GetI2SGeneratorBClkFrequency(self)
            % GetI2SGeneratorBClkFrequency
            % [RetVal, BClkFreq] = GetI2SGeneratorBClkFrequency(self)
            [RetVal, BClkFreq] = self.upxHandle.GetI2SGeneratorBClkFrequency();
        end
        function [RetVal, Format] = GetI2SGeneratorFormat(self)
            % GetI2SGeneratorFormat
            % [RetVal, Format] = GetI2SGeneratorFormat(self)
            [RetVal, Format] = self.upxHandle.GetI2SGeneratorFormat();
        end
        function [RetVal, FsyncPolarity] = GetI2SGeneratorFsyncPolarity(self)
            % GetI2SGeneratorFsyncPolarity
            % [RetVal, FsyncPolarity] = GetI2SGeneratorFsyncPolarity(self)
            [RetVal, FsyncPolarity] = self.upxHandle.GetI2SGeneratorFsyncPolarity();
        end
        function [RetVal, FsyncShape] = GetI2SGeneratorFsyncShape(self)
            % GetI2SGeneratorFsyncShape
            % [RetVal, FsyncShape] = GetI2SGeneratorFsyncShape(self)
            [RetVal, FsyncShape] = self.upxHandle.GetI2SGeneratorFsyncShape();
        end
        function [RetVal, MClkRatio] = GetI2SGeneratorMClkRatio(self)
            % GetI2SGeneratorMClkRatio
            % [RetVal, MClkRatio] = GetI2SGeneratorMClkRatio(self)
            [RetVal, MClkRatio] = self.upxHandle.GetI2SGeneratorMClkRatio();
        end
        function [RetVal, SampleFrequency, VariableSampleFrequency] = GetI2SGeneratorSampleFrequency(self)
            % GetI2SGeneratorSampleFrequency
            % [RetVal, SampleFrequency, VariableSampleFrequency] = GetI2SGeneratorSampleFrequency(self)
            [RetVal, SampleFrequency, VariableSampleFrequency] = self.upxHandle.GetI2SGeneratorSampleFrequency();
        end
        function [RetVal, SyncTo] = GetI2SGeneratorSyncTo(self)
            % GetI2SGeneratorSyncTo
            % [RetVal, SyncTo] = GetI2SGeneratorSyncTo(self)
            [RetVal, SyncTo] = self.upxHandle.GetI2SGeneratorSyncTo();
        end
        function [RetVal, WordLength] = GetI2SGeneratorWordLength(self)
            % GetI2SGeneratorWordLength
            % [RetVal, WordLength] = GetI2SGeneratorWordLength(self)
            [RetVal, WordLength] = self.upxHandle.GetI2SGeneratorWordLength();
        end
        function [RetVal, WordOffset] = GetI2SGeneratorWordOffset(self)
            % GetI2SGeneratorWordOffset
            % [RetVal, WordOffset] = GetI2SGeneratorWordOffset(self)
            [RetVal, WordOffset] = self.upxHandle.GetI2SGeneratorWordOffset();
        end
        function [RetVal, RGBString] = GetLipSyncAnalysisActiveColorHigh(self, BufferSize)
            % GetLipSyncAnalysisActiveColorHigh
            % [RetVal, RGBString] = GetLipSyncAnalysisActiveColorHigh(self, BufferSize)
            RGBString = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetLipSyncAnalysisActiveColorHigh(BufferSize, RGBString);
            RGBString = char(RGBString.ToString);
        end
        function [RetVal, RGBString] = GetLipSyncAnalysisActiveColorLow(self, BufferSize)
            % GetLipSyncAnalysisActiveColorLow
            % [RetVal, RGBString] = GetLipSyncAnalysisActiveColorLow(self, BufferSize)
            RGBString = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetLipSyncAnalysisActiveColorLow(BufferSize, RGBString);
            RGBString = char(RGBString.ToString);
        end
        function [RetVal, RGBString] = GetLipSyncAnalysisActivePatternColor(self, BufferSize)
            % GetLipSyncAnalysisActivePatternColor
            % [RetVal, RGBString] = GetLipSyncAnalysisActivePatternColor(self, BufferSize)
            RGBString = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetLipSyncAnalysisActivePatternColor(BufferSize, RGBString);
            RGBString = char(RGBString.ToString);
        end
        function [RetVal, Low, Units] = GetLipSyncAnalysisAudioTriggerThreshold(self)
            % GetLipSyncAnalysisAudioTriggerThreshold
            % [RetVal, Low, Units] = GetLipSyncAnalysisAudioTriggerThreshold(self)
            [RetVal, Low, Units] = self.upxHandle.GetLipSyncAnalysisAudioTriggerThreshold();
        end
        function [RetVal, RGBString] = GetLipSyncAnalysisMutePatternColor(self, BufferSize)
            % GetLipSyncAnalysisMutePatternColor
            % [RetVal, RGBString] = GetLipSyncAnalysisMutePatternColor(self, BufferSize)
            RGBString = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetLipSyncAnalysisMutePatternColor(BufferSize, RGBString);
            RGBString = char(RGBString.ToString);
        end
        function [RetVal, SettlingCount] = GetMeasurementFunctionSettlingCount(self)
            % GetMeasurementFunctionSettlingCount
            % [RetVal, SettlingCount] = GetMeasurementFunctionSettlingCount(self)
            [RetVal, SettlingCount] = self.upxHandle.GetMeasurementFunctionSettlingCount();
        end
        function [RetVal, Resolution] = GetMeasurementFunctionSettlingResolution(self)
            % GetMeasurementFunctionSettlingResolution
            % [RetVal, Resolution] = GetMeasurementFunctionSettlingResolution(self)
            [RetVal, Resolution] = self.upxHandle.GetMeasurementFunctionSettlingResolution();
        end
        function [RetVal, Timeout] = GetMeasurementFunctionSettlingTimeout(self)
            % GetMeasurementFunctionSettlingTimeout
            % [RetVal, Timeout] = GetMeasurementFunctionSettlingTimeout(self)
            [RetVal, Timeout] = self.upxHandle.GetMeasurementFunctionSettlingTimeout();
        end
        function [RetVal, Tolerance] = GetMeasurementFunctionSettlingTolerance(self)
            % GetMeasurementFunctionSettlingTolerance
            % [RetVal, Tolerance] = GetMeasurementFunctionSettlingTolerance(self)
            [RetVal, Tolerance] = self.upxHandle.GetMeasurementFunctionSettlingTolerance();
        end
        function [RetVal, FnctSettling] = GetMeasurementFunctionsSettling(self)
            % GetMeasurementFunctionsSettling
            % [RetVal, FnctSettling] = GetMeasurementFunctionsSettling(self)
            [RetVal, FnctSettling] = self.upxHandle.GetMeasurementFunctionsSettling();
        end
        function [RetVal, MeasurementMode] = GetMeasurementMode(self)
            % GetMeasurementMode
            % [RetVal, MeasurementMode] = GetMeasurementMode(self)
            [RetVal, MeasurementMode] = self.upxHandle.GetMeasurementMode();
        end
        function [RetVal, MeasurementTimeout] = GetMeasurementTimeout(self)
            % GetMeasurementTimeout
            % [RetVal, MeasurementTimeout] = GetMeasurementTimeout(self)
            [RetVal, MeasurementTimeout] = self.upxHandle.GetMeasurementTimeout();
        end
        function [RetVal, String] = GetMemoryString(self, StringNumber, BufferSize)
            % GetMemoryString
            % [RetVal, String] = GetMemoryString(self, StringNumber, BufferSize)
            String = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetMemoryString(StringNumber, BufferSize, String);
            String = char(String.ToString);
        end
        function [RetVal, Imped] = GetMultichannelAnalyzerChannelInputImpedance(self, Channel)
            % GetMultichannelAnalyzerChannelInputImpedance
            % [RetVal, Imped] = GetMultichannelAnalyzerChannelInputImpedance(self, Channel)
            [RetVal, Imped] = self.upxHandle.GetMultichannelAnalyzerChannelInputImpedance(Channel);
        end
        function [RetVal, Coupling] = GetMultichannelAnalyzerChannelRange(self)
            % GetMultichannelAnalyzerChannelRange
            % [RetVal, Coupling] = GetMultichannelAnalyzerChannelRange(self)
            [RetVal, Coupling] = self.upxHandle.GetMultichannelAnalyzerChannelRange();
        end
        function [RetVal, Coupling] = GetMultichannelAnalyzerCoupling(self, Channel)
            % GetMultichannelAnalyzerCoupling
            % [RetVal, Coupling] = GetMultichannelAnalyzerCoupling(self, Channel)
            [RetVal, Coupling] = self.upxHandle.GetMultichannelAnalyzerCoupling(Channel);
        end
        function [RetVal, Coupling] = GetMultichannelAnalyzerCouplingMode(self)
            % GetMultichannelAnalyzerCouplingMode
            % [RetVal, Coupling] = GetMultichannelAnalyzerCouplingMode(self)
            [RetVal, Coupling] = self.upxHandle.GetMultichannelAnalyzerCouplingMode();
        end
        function [RetVal, Impedance] = GetMultichannelAnalyzerImpedanceChannel(self, Channel)
            % GetMultichannelAnalyzerImpedanceChannel
            % [RetVal, Impedance] = GetMultichannelAnalyzerImpedanceChannel(self, Channel)
            [RetVal, Impedance] = self.upxHandle.GetMultichannelAnalyzerImpedanceChannel(Channel);
        end
        function [RetVal, ChannelState] = GetMultichannelAnalyzerMeasChannels(self, Channel)
            % GetMultichannelAnalyzerMeasChannels
            % [RetVal, ChannelState] = GetMultichannelAnalyzerMeasChannels(self, Channel)
            [RetVal, ChannelState] = self.upxHandle.GetMultichannelAnalyzerMeasChannels(Channel);
        end
        function [RetVal, Channel] = GetMultichannelAnalyzerReferenceChannel(self)
            % GetMultichannelAnalyzerReferenceChannel
            % [RetVal, Channel] = GetMultichannelAnalyzerReferenceChannel(self)
            [RetVal, Channel] = self.upxHandle.GetMultichannelAnalyzerReferenceChannel();
        end
        function [RetVal, Channel] = GetMultichannelAnalyzerTriggerChannel(self)
            % GetMultichannelAnalyzerTriggerChannel
            % [RetVal, Channel] = GetMultichannelAnalyzerTriggerChannel(self)
            [RetVal, Channel] = self.upxHandle.GetMultichannelAnalyzerTriggerChannel();
        end
        function [RetVal, Value] = GetProtocolAnalysisChannelByte(self, Channel, ByteValue)
            % GetProtocolAnalysisChannelByte
            % [RetVal, Value] = GetProtocolAnalysisChannelByte(self, Channel, ByteValue)
            [RetVal, Value] = self.upxHandle.GetProtocolAnalysisChannelByte(Channel, ByteValue);
        end
        function [RetVal, DisplayMode] = GetProtocolAnalysisDisplayMode(self)
            % GetProtocolAnalysisDisplayMode
            % [RetVal, DisplayMode] = GetProtocolAnalysisDisplayMode(self)
            [RetVal, DisplayMode] = self.upxHandle.GetProtocolAnalysisDisplayMode();
        end
        function [RetVal, ProtocolAnalysisDisplayState] = GetProtocolAnalysisDisplayState(self)
            % GetProtocolAnalysisDisplayState
            % [RetVal, ProtocolAnalysisDisplayState] = GetProtocolAnalysisDisplayState(self)
            [RetVal, ProtocolAnalysisDisplayState] = self.upxHandle.GetProtocolAnalysisDisplayState();
        end
        function [RetVal, ErrorCode, ErrorMessage] = GetProtocolAnalysisError(self, ArraySize)
            % GetProtocolAnalysisError
            % [RetVal, ErrorCode, ErrorMessage] = GetProtocolAnalysisError(self, ArraySize)
            ErrorMessage = System.Text.StringBuilder(256);
            [RetVal, ErrorCode] = self.upxHandle.GetProtocolAnalysisError(ArraySize, ErrorMessage);
            ErrorMessage = char(ErrorMessage.ToString);
        end
        function [RetVal, Highlight] = GetProtocolAnalysisHighlight(self)
            % GetProtocolAnalysisHighlight
            % [RetVal, Highlight] = GetProtocolAnalysisHighlight(self)
            [RetVal, Highlight] = self.upxHandle.GetProtocolAnalysisHighlight();
        end
        function [RetVal, Persistence] = GetProtocolAnalysisPersistence(self)
            % GetProtocolAnalysisPersistence
            % [RetVal, Persistence] = GetProtocolAnalysisPersistence(self)
            [RetVal, Persistence] = self.upxHandle.GetProtocolAnalysisPersistence();
        end
        function [RetVal, ProtocolAnalysisState] = GetProtocolAnalysisState(self)
            % GetProtocolAnalysisState
            % [RetVal, ProtocolAnalysisState] = GetProtocolAnalysisState(self)
            [RetVal, ProtocolAnalysisState] = self.upxHandle.GetProtocolAnalysisState();
        end
        function [RetVal, ViewMode] = GetProtocolAnalysisViewMode(self)
            % GetProtocolAnalysisViewMode
            % [RetVal, ViewMode] = GetProtocolAnalysisViewMode(self)
            [RetVal, ViewMode] = self.upxHandle.GetProtocolAnalysisViewMode();
        end
        function [RetVal, CRC] = GetProtocolGeneratorCRC(self)
            % GetProtocolGeneratorCRC
            % [RetVal, CRC] = GetProtocolGeneratorCRC(self)
            [RetVal, CRC] = self.upxHandle.GetProtocolGeneratorCRC();
        end
        function [RetVal, Value] = GetProtocolGeneratorChannelByte(self, Channel, ByteValue)
            % GetProtocolGeneratorChannelByte
            % [RetVal, Value] = GetProtocolGeneratorChannelByte(self, Channel, ByteValue)
            [RetVal, Value] = self.upxHandle.GetProtocolGeneratorChannelByte(Channel, ByteValue);
        end
        function [RetVal, Channels] = GetProtocolGeneratorChannels(self)
            % GetProtocolGeneratorChannels
            % [RetVal, Channels] = GetProtocolGeneratorChannels(self)
            [RetVal, Channels] = self.upxHandle.GetProtocolGeneratorChannels();
        end
        function [RetVal, CodingMode] = GetProtocolGeneratorCodingMode(self)
            % GetProtocolGeneratorCodingMode
            % [RetVal, CodingMode] = GetProtocolGeneratorCodingMode(self)
            [RetVal, CodingMode] = self.upxHandle.GetProtocolGeneratorCodingMode();
        end
        function [RetVal, Validity] = GetProtocolGeneratorValidity(self)
            % GetProtocolGeneratorValidity
            % [RetVal, Validity] = GetProtocolGeneratorValidity(self)
            [RetVal, Validity] = self.upxHandle.GetProtocolGeneratorValidity();
        end
        function [RetVal, SwitcherConnection] = GetSwitcherConnection(self)
            % GetSwitcherConnection
            % [RetVal, SwitcherConnection] = GetSwitcherConnection(self)
            [RetVal, SwitcherConnection] = self.upxHandle.GetSwitcherConnection();
        end
        function [RetVal, InputChannelNumber] = GetSwitcherInput(self, SwitcherInput)
            % GetSwitcherInput
            % [RetVal, InputChannelNumber] = GetSwitcherInput(self, SwitcherInput)
            [RetVal, InputChannelNumber] = self.upxHandle.GetSwitcherInput(SwitcherInput);
        end
        function [RetVal, OffsetValue] = GetSwitcherOffset(self, SwitcherOffset)
            % GetSwitcherOffset
            % [RetVal, OffsetValue] = GetSwitcherOffset(self, SwitcherOffset)
            [RetVal, OffsetValue] = self.upxHandle.GetSwitcherOffset(SwitcherOffset);
        end
        function [RetVal, OutputChannelNumber] = GetSwitcherOutput(self, SwitcherOutput)
            % GetSwitcherOutput
            % [RetVal, OutputChannelNumber] = GetSwitcherOutput(self, SwitcherOutput)
            [RetVal, OutputChannelNumber] = self.upxHandle.GetSwitcherOutput(SwitcherOutput);
        end
        function [RetVal, ComPort] = GetSwitcherPort(self)
            % GetSwitcherPort
            % [RetVal, ComPort] = GetSwitcherPort(self)
            [RetVal, ComPort] = self.upxHandle.GetSwitcherPort();
        end
        function [RetVal, SwitcherState] = GetSwitcherState(self)
            % GetSwitcherState
            % [RetVal, SwitcherState] = GetSwitcherState(self)
            [RetVal, SwitcherState] = self.upxHandle.GetSwitcherState();
        end
        function [RetVal, SwitcherTracking] = GetSwitcherTracking(self)
            % GetSwitcherTracking
            % [RetVal, SwitcherTracking] = GetSwitcherTracking(self)
            [RetVal, SwitcherTracking] = self.upxHandle.GetSwitcherTracking();
        end
        function [RetVal] = GetType(self)
            % GetType
            % [RetVal] = GetType(self)
            [RetVal] = self.upxHandle.GetType();
        end
        function [RetVal, AudioBits] = GetUSIAnalyzerAudioBits(self)
            % GetUSIAnalyzerAudioBits
            % [RetVal, AudioBits] = GetUSIAnalyzerAudioBits(self)
            [RetVal, AudioBits] = self.upxHandle.GetUSIAnalyzerAudioBits();
        end
        function [RetVal, BClkFrequency] = GetUSIAnalyzerBClkFrequency(self)
            % GetUSIAnalyzerBClkFrequency
            % [RetVal, BClkFrequency] = GetUSIAnalyzerBClkFrequency(self)
            [RetVal, BClkFrequency] = self.upxHandle.GetUSIAnalyzerBClkFrequency();
        end
        function [RetVal, BClkSlope] = GetUSIAnalyzerBClkSlope(self)
            % GetUSIAnalyzerBClkSlope
            % [RetVal, BClkSlope] = GetUSIAnalyzerBClkSlope(self)
            [RetVal, BClkSlope] = self.upxHandle.GetUSIAnalyzerBClkSlope();
        end
        function [RetVal, Clock] = GetUSIAnalyzerClock(self)
            % GetUSIAnalyzerClock
            % [RetVal, Clock] = GetUSIAnalyzerClock(self)
            [RetVal, Clock] = self.upxHandle.GetUSIAnalyzerClock();
        end
        function [RetVal, Coding] = GetUSIAnalyzerCoding(self)
            % GetUSIAnalyzerCoding
            % [RetVal, Coding] = GetUSIAnalyzerCoding(self)
            [RetVal, Coding] = self.upxHandle.GetUSIAnalyzerCoding();
        end
        function [RetVal, FirstBit] = GetUSIAnalyzerFirstBit(self)
            % GetUSIAnalyzerFirstBit
            % [RetVal, FirstBit] = GetUSIAnalyzerFirstBit(self)
            [RetVal, FirstBit] = self.upxHandle.GetUSIAnalyzerFirstBit();
        end
        function [RetVal, FsyncFrequency] = GetUSIAnalyzerFsyncFrequency(self)
            % GetUSIAnalyzerFsyncFrequency
            % [RetVal, FsyncFrequency] = GetUSIAnalyzerFsyncFrequency(self)
            [RetVal, FsyncFrequency] = self.upxHandle.GetUSIAnalyzerFsyncFrequency();
        end
        function [RetVal, FsyncOffset] = GetUSIAnalyzerFsyncOffset(self)
            % GetUSIAnalyzerFsyncOffset
            % [RetVal, FsyncOffset] = GetUSIAnalyzerFsyncOffset(self)
            [RetVal, FsyncOffset] = self.upxHandle.GetUSIAnalyzerFsyncOffset();
        end
        function [RetVal, FsyncSlope] = GetUSIAnalyzerFsyncSlope(self)
            % GetUSIAnalyzerFsyncSlope
            % [RetVal, FsyncSlope] = GetUSIAnalyzerFsyncSlope(self)
            [RetVal, FsyncSlope] = self.upxHandle.GetUSIAnalyzerFsyncSlope();
        end
        function [RetVal, FsyncWidth, VariableFsyncWidth] = GetUSIAnalyzerFsyncWidth(self)
            % GetUSIAnalyzerFsyncWidth
            % [RetVal, FsyncWidth, VariableFsyncWidth] = GetUSIAnalyzerFsyncWidth(self)
            [RetVal, FsyncWidth, VariableFsyncWidth] = self.upxHandle.GetUSIAnalyzerFsyncWidth();
        end
        function [RetVal, LeadBits] = GetUSIAnalyzerLeadBits(self)
            % GetUSIAnalyzerLeadBits
            % [RetVal, LeadBits] = GetUSIAnalyzerLeadBits(self)
            [RetVal, LeadBits] = self.upxHandle.GetUSIAnalyzerLeadBits();
        end
        function [RetVal, LogicVoltage] = GetUSIAnalyzerLogicVoltage(self)
            % GetUSIAnalyzerLogicVoltage
            % [RetVal, LogicVoltage] = GetUSIAnalyzerLogicVoltage(self)
            [RetVal, LogicVoltage] = self.upxHandle.GetUSIAnalyzerLogicVoltage();
        end
        function [RetVal, Ratio] = GetUSIAnalyzerMClkRatio(self)
            % GetUSIAnalyzerMClkRatio
            % [RetVal, Ratio] = GetUSIAnalyzerMClkRatio(self)
            [RetVal, Ratio] = self.upxHandle.GetUSIAnalyzerMClkRatio();
        end
        function [RetVal, State] = GetUSIAnalyzerMeasChannelState(self, MeasChannel)
            % GetUSIAnalyzerMeasChannelState
            % [RetVal, State] = GetUSIAnalyzerMeasChannelState(self, MeasChannel)
            [RetVal, State] = self.upxHandle.GetUSIAnalyzerMeasChannelState(MeasChannel);
        end
        function [RetVal, DataLink] = GetUSIAnalyzerMeasurementSource(self, MeasChannel)
            % GetUSIAnalyzerMeasurementSource
            % [RetVal, DataLink] = GetUSIAnalyzerMeasurementSource(self, MeasChannel)
            [RetVal, DataLink] = self.upxHandle.GetUSIAnalyzerMeasurementSource(MeasChannel);
        end
        function [RetVal, MixedSamplingFrequency] = GetUSIAnalyzerMixedSamplingFrequencyState(self)
            % GetUSIAnalyzerMixedSamplingFrequencyState
            % [RetVal, MixedSamplingFrequency] = GetUSIAnalyzerMixedSamplingFrequencyState(self)
            [RetVal, MixedSamplingFrequency] = self.upxHandle.GetUSIAnalyzerMixedSamplingFrequencyState();
        end
        function [RetVal, NumberOfSlots] = GetUSIAnalyzerNumberOfSlots(self)
            % GetUSIAnalyzerNumberOfSlots
            % [RetVal, NumberOfSlots] = GetUSIAnalyzerNumberOfSlots(self)
            [RetVal, NumberOfSlots] = self.upxHandle.GetUSIAnalyzerNumberOfSlots();
        end
        function [RetVal, Ratio] = GetUSIAnalyzerRatio(self)
            % GetUSIAnalyzerRatio
            % [RetVal, Ratio] = GetUSIAnalyzerRatio(self)
            [RetVal, Ratio] = self.upxHandle.GetUSIAnalyzerRatio();
        end
        function [RetVal, SampleFrequency, VariableSampleFrequency, Units] = GetUSIAnalyzerSampleFrequency(self)
            % GetUSIAnalyzerSampleFrequency
            % [RetVal, SampleFrequency, VariableSampleFrequency, Units] = GetUSIAnalyzerSampleFrequency(self)
            [RetVal, SampleFrequency, VariableSampleFrequency, Units] = self.upxHandle.GetUSIAnalyzerSampleFrequency();
        end
        function [RetVal, Samples] = GetUSIAnalyzerSamplesPerFrame(self)
            % GetUSIAnalyzerSamplesPerFrame
            % [RetVal, Samples] = GetUSIAnalyzerSamplesPerFrame(self)
            [RetVal, Samples] = self.upxHandle.GetUSIAnalyzerSamplesPerFrame();
        end
        function [RetVal, SamplingDelay] = GetUSIAnalyzerSamplingDelay(self)
            % GetUSIAnalyzerSamplingDelay
            % [RetVal, SamplingDelay] = GetUSIAnalyzerSamplingDelay(self)
            [RetVal, SamplingDelay] = self.upxHandle.GetUSIAnalyzerSamplingDelay();
        end
        function [RetVal, SlotLength] = GetUSIAnalyzerSlotLength(self)
            % GetUSIAnalyzerSlotLength
            % [RetVal, SlotLength] = GetUSIAnalyzerSlotLength(self)
            [RetVal, SlotLength] = self.upxHandle.GetUSIAnalyzerSlotLength();
        end
        function [RetVal, Slots] = GetUSIAnalyzerSlots(self, MeasChannel, ArraySize)
            % GetUSIAnalyzerSlots
            % [RetVal, Slots] = GetUSIAnalyzerSlots(self, MeasChannel, ArraySize)
            Slots = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetUSIAnalyzerSlots(MeasChannel, ArraySize, Slots);
            Slots = char(Slots.ToString);
        end
        function [RetVal, SyncTo] = GetUSIAnalyzerSyncTo(self)
            % GetUSIAnalyzerSyncTo
            % [RetVal, SyncTo] = GetUSIAnalyzerSyncTo(self)
            [RetVal, SyncTo] = self.upxHandle.GetUSIAnalyzerSyncTo();
        end
        function [RetVal, Timeout] = GetUSIAnalyzerTimeout(self)
            % GetUSIAnalyzerTimeout
            % [RetVal, Timeout] = GetUSIAnalyzerTimeout(self)
            [RetVal, Timeout] = self.upxHandle.GetUSIAnalyzerTimeout();
        end
        function [RetVal, AudioBits] = GetUSIGeneratorAudioBits(self)
            % GetUSIGeneratorAudioBits
            % [RetVal, AudioBits] = GetUSIGeneratorAudioBits(self)
            [RetVal, AudioBits] = self.upxHandle.GetUSIGeneratorAudioBits();
        end
        function [RetVal, BClkFrequency] = GetUSIGeneratorBClkFrequency(self)
            % GetUSIGeneratorBClkFrequency
            % [RetVal, BClkFrequency] = GetUSIGeneratorBClkFrequency(self)
            [RetVal, BClkFrequency] = self.upxHandle.GetUSIGeneratorBClkFrequency();
        end
        function [RetVal, BClkJitterAmplitude] = GetUSIGeneratorBClkJitterAmplitude(self)
            % GetUSIGeneratorBClkJitterAmplitude
            % [RetVal, BClkJitterAmplitude] = GetUSIGeneratorBClkJitterAmplitude(self)
            [RetVal, BClkJitterAmplitude] = self.upxHandle.GetUSIGeneratorBClkJitterAmplitude();
        end
        function [RetVal, BClkJitterFrequency] = GetUSIGeneratorBClkJitterFrequency(self)
            % GetUSIGeneratorBClkJitterFrequency
            % [RetVal, BClkJitterFrequency] = GetUSIGeneratorBClkJitterFrequency(self)
            [RetVal, BClkJitterFrequency] = self.upxHandle.GetUSIGeneratorBClkJitterFrequency();
        end
        function [RetVal, BClkSlope] = GetUSIGeneratorBClkSlope(self)
            % GetUSIGeneratorBClkSlope
            % [RetVal, BClkSlope] = GetUSIGeneratorBClkSlope(self)
            [RetVal, BClkSlope] = self.upxHandle.GetUSIGeneratorBClkSlope();
        end
        function [RetVal, Clock] = GetUSIGeneratorClock(self)
            % GetUSIGeneratorClock
            % [RetVal, Clock] = GetUSIGeneratorClock(self)
            [RetVal, Clock] = self.upxHandle.GetUSIGeneratorClock();
        end
        function [RetVal, Coding] = GetUSIGeneratorCoding(self)
            % GetUSIGeneratorCoding
            % [RetVal, Coding] = GetUSIGeneratorCoding(self)
            [RetVal, Coding] = self.upxHandle.GetUSIGeneratorCoding();
        end
        function [RetVal, FirstBit] = GetUSIGeneratorFirstBit(self)
            % GetUSIGeneratorFirstBit
            % [RetVal, FirstBit] = GetUSIGeneratorFirstBit(self)
            [RetVal, FirstBit] = self.upxHandle.GetUSIGeneratorFirstBit();
        end
        function [RetVal, FsyncFrequency] = GetUSIGeneratorFsyncFrequency(self)
            % GetUSIGeneratorFsyncFrequency
            % [RetVal, FsyncFrequency] = GetUSIGeneratorFsyncFrequency(self)
            [RetVal, FsyncFrequency] = self.upxHandle.GetUSIGeneratorFsyncFrequency();
        end
        function [RetVal, FsyncOffset] = GetUSIGeneratorFsyncOffset(self)
            % GetUSIGeneratorFsyncOffset
            % [RetVal, FsyncOffset] = GetUSIGeneratorFsyncOffset(self)
            [RetVal, FsyncOffset] = self.upxHandle.GetUSIGeneratorFsyncOffset();
        end
        function [RetVal, FsyncSlope] = GetUSIGeneratorFsyncSlope(self)
            % GetUSIGeneratorFsyncSlope
            % [RetVal, FsyncSlope] = GetUSIGeneratorFsyncSlope(self)
            [RetVal, FsyncSlope] = self.upxHandle.GetUSIGeneratorFsyncSlope();
        end
        function [RetVal, FsyncWidth, VariableFsyncWidth] = GetUSIGeneratorFsyncWidth(self)
            % GetUSIGeneratorFsyncWidth
            % [RetVal, FsyncWidth, VariableFsyncWidth] = GetUSIGeneratorFsyncWidth(self)
            [RetVal, FsyncWidth, VariableFsyncWidth] = self.upxHandle.GetUSIGeneratorFsyncWidth();
        end
        function [RetVal, LeadBits] = GetUSIGeneratorLeadBits(self)
            % GetUSIGeneratorLeadBits
            % [RetVal, LeadBits] = GetUSIGeneratorLeadBits(self)
            [RetVal, LeadBits] = self.upxHandle.GetUSIGeneratorLeadBits();
        end
        function [RetVal, LogicVoltage] = GetUSIGeneratorLogicVoltage(self)
            % GetUSIGeneratorLogicVoltage
            % [RetVal, LogicVoltage] = GetUSIGeneratorLogicVoltage(self)
            [RetVal, LogicVoltage] = self.upxHandle.GetUSIGeneratorLogicVoltage();
        end
        function [RetVal, MClkJitterAmplitude] = GetUSIGeneratorMClkJitterAmplitude(self)
            % GetUSIGeneratorMClkJitterAmplitude
            % [RetVal, MClkJitterAmplitude] = GetUSIGeneratorMClkJitterAmplitude(self)
            [RetVal, MClkJitterAmplitude] = self.upxHandle.GetUSIGeneratorMClkJitterAmplitude();
        end
        function [RetVal, MClkJitterFrequency] = GetUSIGeneratorMClkJitterFrequency(self)
            % GetUSIGeneratorMClkJitterFrequency
            % [RetVal, MClkJitterFrequency] = GetUSIGeneratorMClkJitterFrequency(self)
            [RetVal, MClkJitterFrequency] = self.upxHandle.GetUSIGeneratorMClkJitterFrequency();
        end
        function [RetVal, Ratio] = GetUSIGeneratorMClkRatio(self)
            % GetUSIGeneratorMClkRatio
            % [RetVal, Ratio] = GetUSIGeneratorMClkRatio(self)
            [RetVal, Ratio] = self.upxHandle.GetUSIGeneratorMClkRatio();
        end
        function [RetVal, MixedSamplingFrequency] = GetUSIGeneratorMixedSamplingFrequencyState(self)
            % GetUSIGeneratorMixedSamplingFrequencyState
            % [RetVal, MixedSamplingFrequency] = GetUSIGeneratorMixedSamplingFrequencyState(self)
            [RetVal, MixedSamplingFrequency] = self.upxHandle.GetUSIGeneratorMixedSamplingFrequencyState();
        end
        function [RetVal, NumberOfSlots] = GetUSIGeneratorNumberOfSlots(self)
            % GetUSIGeneratorNumberOfSlots
            % [RetVal, NumberOfSlots] = GetUSIGeneratorNumberOfSlots(self)
            [RetVal, NumberOfSlots] = self.upxHandle.GetUSIGeneratorNumberOfSlots();
        end
        function [RetVal, Ratio] = GetUSIGeneratorRatio(self)
            % GetUSIGeneratorRatio
            % [RetVal, Ratio] = GetUSIGeneratorRatio(self)
            [RetVal, Ratio] = self.upxHandle.GetUSIGeneratorRatio();
        end
        function [RetVal, SampleFrequency, VariableSampleFrequency, Units] = GetUSIGeneratorSampleFrequency(self)
            % GetUSIGeneratorSampleFrequency
            % [RetVal, SampleFrequency, VariableSampleFrequency, Units] = GetUSIGeneratorSampleFrequency(self)
            [RetVal, SampleFrequency, VariableSampleFrequency, Units] = self.upxHandle.GetUSIGeneratorSampleFrequency();
        end
        function [RetVal, Samples] = GetUSIGeneratorSamplesPerFrame(self)
            % GetUSIGeneratorSamplesPerFrame
            % [RetVal, Samples] = GetUSIGeneratorSamplesPerFrame(self)
            [RetVal, Samples] = self.upxHandle.GetUSIGeneratorSamplesPerFrame();
        end
        function [RetVal, SlClkOffset] = GetUSIGeneratorSlClkOffset(self)
            % GetUSIGeneratorSlClkOffset
            % [RetVal, SlClkOffset] = GetUSIGeneratorSlClkOffset(self)
            [RetVal, SlClkOffset] = self.upxHandle.GetUSIGeneratorSlClkOffset();
        end
        function [RetVal, SlClkSlope] = GetUSIGeneratorSlClkSlope(self)
            % GetUSIGeneratorSlClkSlope
            % [RetVal, SlClkSlope] = GetUSIGeneratorSlClkSlope(self)
            [RetVal, SlClkSlope] = self.upxHandle.GetUSIGeneratorSlClkSlope();
        end
        function [RetVal, SlClkWidth, VariableSlClkWidth] = GetUSIGeneratorSlClkWidth(self)
            % GetUSIGeneratorSlClkWidth
            % [RetVal, SlClkWidth, VariableSlClkWidth] = GetUSIGeneratorSlClkWidth(self)
            [RetVal, SlClkWidth, VariableSlClkWidth] = self.upxHandle.GetUSIGeneratorSlClkWidth();
        end
        function [RetVal, SlotLength] = GetUSIGeneratorSlotLength(self)
            % GetUSIGeneratorSlotLength
            % [RetVal, SlotLength] = GetUSIGeneratorSlotLength(self)
            [RetVal, SlotLength] = self.upxHandle.GetUSIGeneratorSlotLength();
        end
        function [RetVal, SyncTo] = GetUSIGeneratorSyncTo(self)
            % GetUSIGeneratorSyncTo
            % [RetVal, SyncTo] = GetUSIGeneratorSyncTo(self)
            [RetVal, SyncTo] = self.upxHandle.GetUSIGeneratorSyncTo();
        end
        function [RetVal, SignalType] = GetUSIGeneratorTxData(self, DataLine, ArraySize)
            % GetUSIGeneratorTxData
            % [RetVal, SignalType] = GetUSIGeneratorTxData(self, DataLine, ArraySize)
            SignalType = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.GetUSIGeneratorTxData(DataLine, ArraySize, SignalType);
            SignalType = char(SignalType.ToString);
        end
        function [RetVal, FileSelectorWindowStyle] = GetWindowStyle(self)
            % GetWindowStyle
            % [RetVal, FileSelectorWindowStyle] = GetWindowStyle(self)
            [RetVal, FileSelectorWindowStyle] = self.upxHandle.GetWindowStyle();
        end
        function [RetVal] = HardcopyImmediate(self)
            % HardcopyImmediate
            % [RetVal] = HardcopyImmediate(self)
            [RetVal] = self.upxHandle.HardcopyImmediate();
        end
        function [RetVal] = LoadSetup(self, Setup)
            % LoadSetup
            % [RetVal] = LoadSetup(self, Setup)
            [RetVal] = self.upxHandle.LoadSetup(Setup);
        end
        function [RetVal] = MeasurementControl(self, Measurement)
            % MeasurementControl
            % [RetVal] = MeasurementControl(self, Measurement)
            [RetVal] = self.upxHandle.MeasurementControl(Measurement);
        end
        function [RetVal] = ReadAxisData(self, Subsystem, SubsystemNumber, Axis, Channel, NumberOfResults, Output)
            % ReadAxisData
            % [RetVal] = ReadAxisData(self, Subsystem, SubsystemNumber, Axis, Channel, NumberOfResults, Output)
            [RetVal] = self.upxHandle.ReadAxisData(Subsystem, SubsystemNumber, Axis, Channel, NumberOfResults, Output);
        end
        function [RetVal, OutputCount] = ReadAxisDataCount(self, Subsystem, SubsystemNumber, Axis, Channel)
            % ReadAxisDataCount
            % [RetVal, OutputCount] = ReadAxisDataCount(self, Subsystem, SubsystemNumber, Axis, Channel)
            [RetVal, OutputCount] = self.upxHandle.ReadAxisDataCount(Subsystem, SubsystemNumber, Axis, Channel);
        end
        function [RetVal, MeasurementResult, Units] = ReadMeasurementResult(self, Channel, Measurement)
            % ReadMeasurementResult
            % [RetVal, MeasurementResult, Units] = ReadMeasurementResult(self, Channel, Measurement)
            Units = System.Text.StringBuilder(256);
            [RetVal, MeasurementResult] = self.upxHandle.ReadMeasurementResult(Channel, Measurement, Units);
            Units = char(Units.ToString);
        end
        function [RetVal, MeasurementResult, Units] = ReadMeasurementResultMinMax(self, Channel, Measurement, Modifier)
            % ReadMeasurementResultMinMax
            % [RetVal, MeasurementResult, Units] = ReadMeasurementResultMinMax(self, Channel, Measurement, Modifier)
            Units = System.Text.StringBuilder(256);
            [RetVal, MeasurementResult] = self.upxHandle.ReadMeasurementResultMinMax(Channel, Measurement, Modifier, Units);
            Units = char(Units.ToString);
        end
        function [RetVal] = ReadTraceDataList(self, Subsystem, SubsystemNumber, DataList, NumberOfResults, Output)
            % ReadTraceDataList
            % [RetVal] = ReadTraceDataList(self, Subsystem, SubsystemNumber, DataList, NumberOfResults, Output)
            [RetVal] = self.upxHandle.ReadTraceDataList(Subsystem, SubsystemNumber, DataList, NumberOfResults, Output);
        end
        function [RetVal, OutputCount] = ReadTraceDataListCount(self, Subsystem, SubsystemNumber, DataList)
            % ReadTraceDataListCount
            % [RetVal, OutputCount] = ReadTraceDataListCount(self, Subsystem, SubsystemNumber, DataList)
            [RetVal, OutputCount] = self.upxHandle.ReadTraceDataListCount(Subsystem, SubsystemNumber, DataList);
        end
        function [RetVal, OutputCount] = ReadTraceDataSetCount(self, Subsystem, SubsystemNumber, DataSet)
            % ReadTraceDataSetCount
            % [RetVal, OutputCount] = ReadTraceDataSetCount(self, Subsystem, SubsystemNumber, DataSet)
            [RetVal, OutputCount] = self.upxHandle.ReadTraceDataSetCount(Subsystem, SubsystemNumber, DataSet);
        end
        function [RetVal] = ReadTraceDataSets(self, Subsystem, SubsystemNumber, DataSet, NumberOfResults, Output)
            % ReadTraceDataSets
            % [RetVal] = ReadTraceDataSets(self, Subsystem, SubsystemNumber, DataSet, NumberOfResults, Output)
            [RetVal] = self.upxHandle.ReadTraceDataSets(Subsystem, SubsystemNumber, DataSet, NumberOfResults, Output);
        end
        function [RetVal] = ResetMemoryBuffers(self, FreeBuffers)
            % ResetMemoryBuffers
            % [RetVal] = ResetMemoryBuffers(self, FreeBuffers)
            [RetVal] = self.upxHandle.ResetMemoryBuffers(FreeBuffers);
        end
        function [RetVal] = SaveSetup(self, Setup)
            % SaveSetup
            % [RetVal] = SaveSetup(self, Setup)
            [RetVal] = self.upxHandle.SaveSetup(Setup);
        end
        function [RetVal] = SetAnalogAnalyzerChannelMode(self, ChannelMode)
            % SetAnalogAnalyzerChannelMode
            % [RetVal] = SetAnalogAnalyzerChannelMode(self, ChannelMode)
            [RetVal] = self.upxHandle.SetAnalogAnalyzerChannelMode(ChannelMode);
        end
        function [RetVal] = SetAnalyzerBandwidth(self, Bandwidth)
            % SetAnalyzerBandwidth
            % [RetVal] = SetAnalyzerBandwidth(self, Bandwidth)
            [RetVal] = self.upxHandle.SetAnalyzerBandwidth(Bandwidth);
        end
        function [RetVal] = SetAnalyzerBargraphState(self, BargraphState)
            % SetAnalyzerBargraphState
            % [RetVal] = SetAnalyzerBargraphState(self, BargraphState)
            [RetVal] = self.upxHandle.SetAnalyzerBargraphState(BargraphState);
        end
        function [RetVal] = SetAnalyzerChannelInput(self, Channel, Input)
            % SetAnalyzerChannelInput
            % [RetVal] = SetAnalyzerChannelInput(self, Channel, Input)
            [RetVal] = self.upxHandle.SetAnalyzerChannelInput(Channel, Input);
        end
        function [RetVal] = SetAnalyzerChannelInputCommon(self, Channel, Common)
            % SetAnalyzerChannelInputCommon
            % [RetVal] = SetAnalyzerChannelInputCommon(self, Channel, Common)
            [RetVal] = self.upxHandle.SetAnalyzerChannelInputCommon(Channel, Common);
        end
        function [RetVal] = SetAnalyzerChannelInputImpedance(self, Channel, Imped)
            % SetAnalyzerChannelInputImpedance
            % [RetVal] = SetAnalyzerChannelInputImpedance(self, Channel, Imped)
            [RetVal] = self.upxHandle.SetAnalyzerChannelInputImpedance(Channel, Imped);
        end
        function [RetVal] = SetAnalyzerChannelInputRange(self, Channel, Range)
            % SetAnalyzerChannelInputRange
            % [RetVal] = SetAnalyzerChannelInputRange(self, Channel, Range)
            [RetVal] = self.upxHandle.SetAnalyzerChannelInputRange(Channel, Range);
        end
        function [RetVal] = SetAnalyzerChannelInputRangeValue(self, Channel, RangeValue)
            % SetAnalyzerChannelInputRangeValue
            % [RetVal] = SetAnalyzerChannelInputRangeValue(self, Channel, RangeValue)
            [RetVal] = self.upxHandle.SetAnalyzerChannelInputRangeValue(Channel, RangeValue);
        end
        function [RetVal] = SetAnalyzerCombinedMeasurement(self, CombinedMeasurement)
            % SetAnalyzerCombinedMeasurement
            % [RetVal] = SetAnalyzerCombinedMeasurement(self, CombinedMeasurement)
            [RetVal] = self.upxHandle.SetAnalyzerCombinedMeasurement(CombinedMeasurement);
        end
        function [RetVal] = SetAnalyzerCoupling(self, Coupling)
            % SetAnalyzerCoupling
            % [RetVal] = SetAnalyzerCoupling(self, Coupling)
            [RetVal] = self.upxHandle.SetAnalyzerCoupling(Coupling);
        end
        function [RetVal] = SetAnalyzerDCSuppression(self, DCSuppression)
            % SetAnalyzerDCSuppression
            % [RetVal] = SetAnalyzerDCSuppression(self, DCSuppression)
            [RetVal] = self.upxHandle.SetAnalyzerDCSuppression(DCSuppression);
        end
        function [RetVal] = SetAnalyzerDFDMeasurementMode(self, MeasurementMode)
            % SetAnalyzerDFDMeasurementMode
            % [RetVal] = SetAnalyzerDFDMeasurementMode(self, MeasurementMode)
            [RetVal] = self.upxHandle.SetAnalyzerDFDMeasurementMode(MeasurementMode);
        end
        function [RetVal] = SetAnalyzerDynamicMode(self, DynamicMode)
            % SetAnalyzerDynamicMode
            % [RetVal] = SetAnalyzerDynamicMode(self, DynamicMode)
            [RetVal] = self.upxHandle.SetAnalyzerDynamicMode(DynamicMode);
        end
        function [RetVal] = SetAnalyzerFFTAvgCount(self, AvgCount)
            % SetAnalyzerFFTAvgCount
            % [RetVal] = SetAnalyzerFFTAvgCount(self, AvgCount)
            [RetVal] = self.upxHandle.SetAnalyzerFFTAvgCount(AvgCount);
        end
        function [RetVal] = SetAnalyzerFFTAvgMode(self, AvgMode)
            % SetAnalyzerFFTAvgMode
            % [RetVal] = SetAnalyzerFFTAvgMode(self, AvgMode)
            [RetVal] = self.upxHandle.SetAnalyzerFFTAvgMode(AvgMode);
        end
        function [RetVal] = SetAnalyzerFFTCompFactor(self, CompFactor)
            % SetAnalyzerFFTCompFactor
            % [RetVal] = SetAnalyzerFFTCompFactor(self, CompFactor)
            [RetVal] = self.upxHandle.SetAnalyzerFFTCompFactor(CompFactor);
        end
        function [RetVal] = SetAnalyzerFFTDelayCh1(self, DelayChannel1)
            % SetAnalyzerFFTDelayCh1
            % [RetVal] = SetAnalyzerFFTDelayCh1(self, DelayChannel1)
            [RetVal] = self.upxHandle.SetAnalyzerFFTDelayCh1(DelayChannel1);
        end
        function [RetVal] = SetAnalyzerFFTEqualizer(self, Equalizer)
            % SetAnalyzerFFTEqualizer
            % [RetVal] = SetAnalyzerFFTEqualizer(self, Equalizer)
            [RetVal] = self.upxHandle.SetAnalyzerFFTEqualizer(Equalizer);
        end
        function [RetVal] = SetAnalyzerFFTEqualizerFile(self, EqualFile)
            % SetAnalyzerFFTEqualizerFile
            % [RetVal] = SetAnalyzerFFTEqualizerFile(self, EqualFile)
            [RetVal] = self.upxHandle.SetAnalyzerFFTEqualizerFile(EqualFile);
        end
        function [RetVal] = SetAnalyzerFFTFrequencyLimitLow(self, FreqLimLow)
            % SetAnalyzerFFTFrequencyLimitLow
            % [RetVal] = SetAnalyzerFFTFrequencyLimitLow(self, FreqLimLow)
            [RetVal] = self.upxHandle.SetAnalyzerFFTFrequencyLimitLow(FreqLimLow);
        end
        function [RetVal] = SetAnalyzerFFTFrequencyLimitState(self, LimitEnable)
            % SetAnalyzerFFTFrequencyLimitState
            % [RetVal] = SetAnalyzerFFTFrequencyLimitState(self, LimitEnable)
            [RetVal] = self.upxHandle.SetAnalyzerFFTFrequencyLimitState(LimitEnable);
        end
        function [RetVal] = SetAnalyzerFFTFrequencyLimitUpp(self, FreqLimUpp)
            % SetAnalyzerFFTFrequencyLimitUpp
            % [RetVal] = SetAnalyzerFFTFrequencyLimitUpp(self, FreqLimUpp)
            [RetVal] = self.upxHandle.SetAnalyzerFFTFrequencyLimitUpp(FreqLimUpp);
        end
        function [RetVal] = SetAnalyzerFFTMaxSize(self, FFTSize)
            % SetAnalyzerFFTMaxSize
            % [RetVal] = SetAnalyzerFFTMaxSize(self, FFTSize)
            [RetVal] = self.upxHandle.SetAnalyzerFFTMaxSize(FFTSize);
        end
        function [RetVal] = SetAnalyzerFFTMonitorState(self, FFTMonitor)
            % SetAnalyzerFFTMonitorState
            % [RetVal] = SetAnalyzerFFTMonitorState(self, FFTMonitor)
            [RetVal] = self.upxHandle.SetAnalyzerFFTMonitorState(FFTMonitor);
        end
        function [RetVal] = SetAnalyzerFFTSize(self, FFTSize)
            % SetAnalyzerFFTSize
            % [RetVal] = SetAnalyzerFFTSize(self, FFTSize)
            [RetVal] = self.upxHandle.SetAnalyzerFFTSize(FFTSize);
        end
        function [RetVal] = SetAnalyzerFFTTriggeredState(self, TriggeredFFTEnable)
            % SetAnalyzerFFTTriggeredState
            % [RetVal] = SetAnalyzerFFTTriggeredState(self, TriggeredFFTEnable)
            [RetVal] = self.upxHandle.SetAnalyzerFFTTriggeredState(TriggeredFFTEnable);
        end
        function [RetVal] = SetAnalyzerFFTUndersampleState(self, Undersample)
            % SetAnalyzerFFTUndersampleState
            % [RetVal] = SetAnalyzerFFTUndersampleState(self, Undersample)
            [RetVal] = self.upxHandle.SetAnalyzerFFTUndersampleState(Undersample);
        end
        function [RetVal] = SetAnalyzerFFTWindow(self, Window)
            % SetAnalyzerFFTWindow
            % [RetVal] = SetAnalyzerFFTWindow(self, Window)
            [RetVal] = self.upxHandle.SetAnalyzerFFTWindow(Window);
        end
        function [RetVal] = SetAnalyzerFFTZoomCenter(self, Center)
            % SetAnalyzerFFTZoomCenter
            % [RetVal] = SetAnalyzerFFTZoomCenter(self, Center)
            [RetVal] = self.upxHandle.SetAnalyzerFFTZoomCenter(Center);
        end
        function [RetVal] = SetAnalyzerFilter(self, FilterNumber, Filter)
            % SetAnalyzerFilter
            % [RetVal] = SetAnalyzerFilter(self, FilterNumber, Filter)
            [RetVal] = self.upxHandle.SetAnalyzerFilter(FilterNumber, Filter);
        end
        function [RetVal] = SetAnalyzerFormatPhase(self, FormatPhase)
            % SetAnalyzerFormatPhase
            % [RetVal] = SetAnalyzerFormatPhase(self, FormatPhase)
            [RetVal] = self.upxHandle.SetAnalyzerFormatPhase(FormatPhase);
        end
        function [RetVal] = SetAnalyzerFrequencyPhaseReference(self, RefFrequency, RefPhase)
            % SetAnalyzerFrequencyPhaseReference
            % [RetVal] = SetAnalyzerFrequencyPhaseReference(self, RefFrequency, RefPhase)
            [RetVal] = self.upxHandle.SetAnalyzerFrequencyPhaseReference(RefFrequency, RefPhase);
        end
        function [RetVal] = SetAnalyzerFrequencyPhaseReferenceValue(self, RefFrequencyValue, FrequencyUnits, RefPhaseValue, PhaseUnits, GroupDelayRefValue, GroupDelayUnits)
            % SetAnalyzerFrequencyPhaseReferenceValue
            % [RetVal] = SetAnalyzerFrequencyPhaseReferenceValue(self, RefFrequencyValue, FrequencyUnits, RefPhaseValue, PhaseUnits, GroupDelayRefValue, GroupDelayUnits)
            [RetVal] = self.upxHandle.SetAnalyzerFrequencyPhaseReferenceValue(RefFrequencyValue, FrequencyUnits, RefPhaseValue, PhaseUnits, GroupDelayRefValue, GroupDelayUnits);
        end
        function [RetVal] = SetAnalyzerFrequencyPhaseUnitAuto(self, Channel, FrequencyUnitAuto, PhaseUnitAuto)
            % SetAnalyzerFrequencyPhaseUnitAuto
            % [RetVal] = SetAnalyzerFrequencyPhaseUnitAuto(self, Channel, FrequencyUnitAuto, PhaseUnitAuto)
            [RetVal] = self.upxHandle.SetAnalyzerFrequencyPhaseUnitAuto(Channel, FrequencyUnitAuto, PhaseUnitAuto);
        end
        function [RetVal] = SetAnalyzerFrequencyPhaseUserUnit(self, Channel, FrequencyUserUnit, PhaseUserUnit)
            % SetAnalyzerFrequencyPhaseUserUnit
            % [RetVal] = SetAnalyzerFrequencyPhaseUserUnit(self, Channel, FrequencyUserUnit, PhaseUserUnit)
            [RetVal] = self.upxHandle.SetAnalyzerFrequencyPhaseUserUnit(Channel, FrequencyUserUnit, PhaseUserUnit);
        end
        function [RetVal] = SetAnalyzerFrequencyUnit(self, Channel, Units)
            % SetAnalyzerFrequencyUnit
            % [RetVal] = SetAnalyzerFrequencyUnit(self, Channel, Units)
            [RetVal] = self.upxHandle.SetAnalyzerFrequencyUnit(Channel, Units);
        end
        function [RetVal] = SetAnalyzerFunction(self, Function)
            % SetAnalyzerFunction
            % [RetVal] = SetAnalyzerFunction(self, Function)
            [RetVal] = self.upxHandle.SetAnalyzerFunction(Function);
        end
        function [RetVal] = SetAnalyzerInputMonitor(self, InputMonitor)
            % SetAnalyzerInputMonitor
            % [RetVal] = SetAnalyzerInputMonitor(self, InputMonitor)
            [RetVal] = self.upxHandle.SetAnalyzerInputMonitor(InputMonitor);
        end
        function [RetVal] = SetAnalyzerInstrument(self, Instrument)
            % SetAnalyzerInstrument
            % [RetVal] = SetAnalyzerInstrument(self, Instrument)
            [RetVal] = self.upxHandle.SetAnalyzerInstrument(Instrument);
        end
        function [RetVal] = SetAnalyzerLevelDCMeasTime(self, MeasTime)
            % SetAnalyzerLevelDCMeasTime
            % [RetVal] = SetAnalyzerLevelDCMeasTime(self, MeasTime)
            [RetVal] = self.upxHandle.SetAnalyzerLevelDCMeasTime(MeasTime);
        end
        function [RetVal] = SetAnalyzerLevelMeasBandwidth(self, Bandwidth)
            % SetAnalyzerLevelMeasBandwidth
            % [RetVal] = SetAnalyzerLevelMeasBandwidth(self, Bandwidth)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasBandwidth(Bandwidth);
        end
        function [RetVal] = SetAnalyzerLevelMeasBandwidthValue(self, BandwidthValue)
            % SetAnalyzerLevelMeasBandwidthValue
            % [RetVal] = SetAnalyzerLevelMeasBandwidthValue(self, BandwidthValue)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasBandwidthValue(BandwidthValue);
        end
        function [RetVal] = SetAnalyzerLevelMeasFrequencyFactor(self, FrequencyFactor)
            % SetAnalyzerLevelMeasFrequencyFactor
            % [RetVal] = SetAnalyzerLevelMeasFrequencyFactor(self, FrequencyFactor)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasFrequencyFactor(FrequencyFactor);
        end
        function [RetVal] = SetAnalyzerLevelMeasFrequencyMode(self, FrequencyMode)
            % SetAnalyzerLevelMeasFrequencyMode
            % [RetVal] = SetAnalyzerLevelMeasFrequencyMode(self, FrequencyMode)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasFrequencyMode(FrequencyMode);
        end
        function [RetVal] = SetAnalyzerLevelMeasFrequencyStart(self, FrequencyStart)
            % SetAnalyzerLevelMeasFrequencyStart
            % [RetVal] = SetAnalyzerLevelMeasFrequencyStart(self, FrequencyStart)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasFrequencyStart(FrequencyStart);
        end
        function [RetVal] = SetAnalyzerLevelMeasFrequencyStop(self, FrequencyStop)
            % SetAnalyzerLevelMeasFrequencyStop
            % [RetVal] = SetAnalyzerLevelMeasFrequencyStop(self, FrequencyStop)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasFrequencyStop(FrequencyStop);
        end
        function [RetVal] = SetAnalyzerLevelMeasFrequencyValue(self, FrequencyValue)
            % SetAnalyzerLevelMeasFrequencyValue
            % [RetVal] = SetAnalyzerLevelMeasFrequencyValue(self, FrequencyValue)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasFrequencyValue(FrequencyValue);
        end
        function [RetVal] = SetAnalyzerLevelMeasTime(self, MeasTime)
            % SetAnalyzerLevelMeasTime
            % [RetVal] = SetAnalyzerLevelMeasTime(self, MeasTime)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasTime(MeasTime);
        end
        function [RetVal] = SetAnalyzerLevelMeasTimeValue(self, MeasTimeValue)
            % SetAnalyzerLevelMeasTimeValue
            % [RetVal] = SetAnalyzerLevelMeasTimeValue(self, MeasTimeValue)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMeasTimeValue(MeasTimeValue);
        end
        function [RetVal] = SetAnalyzerLevelMonitor(self, LevelMonitor)
            % SetAnalyzerLevelMonitor
            % [RetVal] = SetAnalyzerLevelMonitor(self, LevelMonitor)
            [RetVal] = self.upxHandle.SetAnalyzerLevelMonitor(LevelMonitor);
        end
        function [RetVal] = SetAnalyzerMeasurementTime(self, MeasTime)
            % SetAnalyzerMeasurementTime
            % [RetVal] = SetAnalyzerMeasurementTime(self, MeasTime)
            [RetVal] = self.upxHandle.SetAnalyzerMeasurementTime(MeasTime);
        end
        function [RetVal] = SetAnalyzerNOCTMeasMode(self, MeasMode)
            % SetAnalyzerNOCTMeasMode
            % [RetVal] = SetAnalyzerNOCTMeasMode(self, MeasMode)
            [RetVal] = self.upxHandle.SetAnalyzerNOCTMeasMode(MeasMode);
        end
        function [RetVal] = SetAnalyzerNotchCenterFrequency(self, NotchCenterFrequency)
            % SetAnalyzerNotchCenterFrequency
            % [RetVal] = SetAnalyzerNotchCenterFrequency(self, NotchCenterFrequency)
            [RetVal] = self.upxHandle.SetAnalyzerNotchCenterFrequency(NotchCenterFrequency);
        end
        function [RetVal] = SetAnalyzerNotchFrequency(self, NotchFrequency)
            % SetAnalyzerNotchFrequency
            % [RetVal] = SetAnalyzerNotchFrequency(self, NotchFrequency)
            [RetVal] = self.upxHandle.SetAnalyzerNotchFrequency(NotchFrequency);
        end
        function [RetVal] = SetAnalyzerNotchGain(self, NotchGain)
            % SetAnalyzerNotchGain
            % [RetVal] = SetAnalyzerNotchGain(self, NotchGain)
            [RetVal] = self.upxHandle.SetAnalyzerNotchGain(NotchGain);
        end
        function [RetVal] = SetAnalyzerPEAQFilename(self, Filename)
            % SetAnalyzerPEAQFilename
            % [RetVal] = SetAnalyzerPEAQFilename(self, Filename)
            [RetVal] = self.upxHandle.SetAnalyzerPEAQFilename(Filename);
        end
        function [RetVal] = SetAnalyzerPEAQMeasurementMode(self, MeasurementMode)
            % SetAnalyzerPEAQMeasurementMode
            % [RetVal] = SetAnalyzerPEAQMeasurementMode(self, MeasurementMode)
            [RetVal] = self.upxHandle.SetAnalyzerPEAQMeasurementMode(MeasurementMode);
        end
        function [RetVal] = SetAnalyzerPEAQModel(self, ModelVersion)
            % SetAnalyzerPEAQModel
            % [RetVal] = SetAnalyzerPEAQModel(self, ModelVersion)
            [RetVal] = self.upxHandle.SetAnalyzerPEAQModel(ModelVersion);
        end
        function [RetVal] = SetAnalyzerPEAQStoreWAVTo(self, StoreWAVTo)
            % SetAnalyzerPEAQStoreWAVTo
            % [RetVal] = SetAnalyzerPEAQStoreWAVTo(self, StoreWAVTo)
            [RetVal] = self.upxHandle.SetAnalyzerPEAQStoreWAVTo(StoreWAVTo);
        end
        function [RetVal] = SetAnalyzerPESQAccordingTo(self, AccordingTo)
            % SetAnalyzerPESQAccordingTo
            % [RetVal] = SetAnalyzerPESQAccordingTo(self, AccordingTo)
            [RetVal] = self.upxHandle.SetAnalyzerPESQAccordingTo(AccordingTo);
        end
        function [RetVal] = SetAnalyzerPESQFilename(self, Filename)
            % SetAnalyzerPESQFilename
            % [RetVal] = SetAnalyzerPESQFilename(self, Filename)
            [RetVal] = self.upxHandle.SetAnalyzerPESQFilename(Filename);
        end
        function [RetVal] = SetAnalyzerPESQMeasurementMode(self, MeasurementMode)
            % SetAnalyzerPESQMeasurementMode
            % [RetVal] = SetAnalyzerPESQMeasurementMode(self, MeasurementMode)
            [RetVal] = self.upxHandle.SetAnalyzerPESQMeasurementMode(MeasurementMode);
        end
        function [RetVal] = SetAnalyzerPESQStoreWAVTo(self, StoreWAVTo)
            % SetAnalyzerPESQStoreWAVTo
            % [RetVal] = SetAnalyzerPESQStoreWAVTo(self, StoreWAVTo)
            [RetVal] = self.upxHandle.SetAnalyzerPESQStoreWAVTo(StoreWAVTo);
        end
        function [RetVal] = SetAnalyzerPOLQABand(self, Band)
            % SetAnalyzerPOLQABand
            % [RetVal] = SetAnalyzerPOLQABand(self, Band)
            [RetVal] = self.upxHandle.SetAnalyzerPOLQABand(Band);
        end
        function [RetVal] = SetAnalyzerPOLQAGain(self, Gain)
            % SetAnalyzerPOLQAGain
            % [RetVal] = SetAnalyzerPOLQAGain(self, Gain)
            [RetVal] = self.upxHandle.SetAnalyzerPOLQAGain(Gain);
        end
        function [RetVal] = SetAnalyzerPOLQAMeasurementMode(self, MeasurementMode)
            % SetAnalyzerPOLQAMeasurementMode
            % [RetVal] = SetAnalyzerPOLQAMeasurementMode(self, MeasurementMode)
            [RetVal] = self.upxHandle.SetAnalyzerPOLQAMeasurementMode(MeasurementMode);
        end
        function [RetVal] = SetAnalyzerPeakMeasIntervalTime(self, IntervalTime)
            % SetAnalyzerPeakMeasIntervalTime
            % [RetVal] = SetAnalyzerPeakMeasIntervalTime(self, IntervalTime)
            [RetVal] = self.upxHandle.SetAnalyzerPeakMeasIntervalTime(IntervalTime);
        end
        function [RetVal] = SetAnalyzerPeakMeasIntervalTimeValue(self, IntervalTimeValue)
            % SetAnalyzerPeakMeasIntervalTimeValue
            % [RetVal] = SetAnalyzerPeakMeasIntervalTimeValue(self, IntervalTimeValue)
            [RetVal] = self.upxHandle.SetAnalyzerPeakMeasIntervalTimeValue(IntervalTimeValue);
        end
        function [RetVal] = SetAnalyzerPeakMeasMode(self, MeasMode)
            % SetAnalyzerPeakMeasMode
            % [RetVal] = SetAnalyzerPeakMeasMode(self, MeasMode)
            [RetVal] = self.upxHandle.SetAnalyzerPeakMeasMode(MeasMode);
        end
        function [RetVal] = SetAnalyzerPhaseUnit(self, Units)
            % SetAnalyzerPhaseUnit
            % [RetVal] = SetAnalyzerPhaseUnit(self, Units)
            [RetVal] = self.upxHandle.SetAnalyzerPhaseUnit(Units);
        end
        function [RetVal] = SetAnalyzerPostFFTState(self, PostFFT)
            % SetAnalyzerPostFFTState
            % [RetVal] = SetAnalyzerPostFFTState(self, PostFFT)
            [RetVal] = self.upxHandle.SetAnalyzerPostFFTState(PostFFT);
        end
        function [RetVal] = SetAnalyzerPrefilter(self, PrenFilter)
            % SetAnalyzerPrefilter
            % [RetVal] = SetAnalyzerPrefilter(self, PrenFilter)
            [RetVal] = self.upxHandle.SetAnalyzerPrefilter(PrenFilter);
        end
        function [RetVal] = SetAnalyzerRecordFile(self, RecordFile)
            % SetAnalyzerRecordFile
            % [RetVal] = SetAnalyzerRecordFile(self, RecordFile)
            [RetVal] = self.upxHandle.SetAnalyzerRecordFile(RecordFile);
        end
        function [RetVal] = SetAnalyzerRecordLength(self, RecordLength, Units)
            % SetAnalyzerRecordLength
            % [RetVal] = SetAnalyzerRecordLength(self, RecordLength, Units)
            [RetVal] = self.upxHandle.SetAnalyzerRecordLength(RecordLength, Units);
        end
        function [RetVal] = SetAnalyzerRecordPretrigger(self, RecordPretrigger, Units)
            % SetAnalyzerRecordPretrigger
            % [RetVal] = SetAnalyzerRecordPretrigger(self, RecordPretrigger, Units)
            [RetVal] = self.upxHandle.SetAnalyzerRecordPretrigger(RecordPretrigger, Units);
        end
        function [RetVal] = SetAnalyzerRecordTriggerLevel(self, TriggerLevel, Units)
            % SetAnalyzerRecordTriggerLevel
            % [RetVal] = SetAnalyzerRecordTriggerLevel(self, TriggerLevel, Units)
            [RetVal] = self.upxHandle.SetAnalyzerRecordTriggerLevel(TriggerLevel, Units);
        end
        function [RetVal] = SetAnalyzerRecordTriggerSlope(self, TriggerSlope)
            % SetAnalyzerRecordTriggerSlope
            % [RetVal] = SetAnalyzerRecordTriggerSlope(self, TriggerSlope)
            [RetVal] = self.upxHandle.SetAnalyzerRecordTriggerSlope(TriggerSlope);
        end
        function [RetVal] = SetAnalyzerRecordTriggerSource(self, TriggerSource)
            % SetAnalyzerRecordTriggerSource
            % [RetVal] = SetAnalyzerRecordTriggerSource(self, TriggerSource)
            [RetVal] = self.upxHandle.SetAnalyzerRecordTriggerSource(TriggerSource);
        end
        function [RetVal] = SetAnalyzerRefImpedance(self, RefImped)
            % SetAnalyzerRefImpedance
            % [RetVal] = SetAnalyzerRefImpedance(self, RefImped)
            [RetVal] = self.upxHandle.SetAnalyzerRefImpedance(RefImped);
        end
        function [RetVal] = SetAnalyzerReference(self, Channel, Measurement, Reference)
            % SetAnalyzerReference
            % [RetVal] = SetAnalyzerReference(self, Channel, Measurement, Reference)
            [RetVal] = self.upxHandle.SetAnalyzerReference(Channel, Measurement, Reference);
        end
        function [RetVal] = SetAnalyzerReferenceValue(self, Channel, Measurement, ReferenceValue, Units)
            % SetAnalyzerReferenceValue
            % [RetVal] = SetAnalyzerReferenceValue(self, Channel, Measurement, ReferenceValue, Units)
            [RetVal] = self.upxHandle.SetAnalyzerReferenceValue(Channel, Measurement, ReferenceValue, Units);
        end
        function [RetVal] = SetAnalyzerRefinement(self, Refinement)
            % SetAnalyzerRefinement
            % [RetVal] = SetAnalyzerRefinement(self, Refinement)
            [RetVal] = self.upxHandle.SetAnalyzerRefinement(Refinement);
        end
        function [RetVal] = SetAnalyzerSNMeasMode(self, MeasMode)
            % SetAnalyzerSNMeasMode
            % [RetVal] = SetAnalyzerSNMeasMode(self, MeasMode)
            [RetVal] = self.upxHandle.SetAnalyzerSNMeasMode(MeasMode);
        end
        function [RetVal] = SetAnalyzerSNMeasTime(self, MeasTime)
            % SetAnalyzerSNMeasTime
            % [RetVal] = SetAnalyzerSNMeasTime(self, MeasTime)
            [RetVal] = self.upxHandle.SetAnalyzerSNMeasTime(MeasTime);
        end
        function [RetVal] = SetAnalyzerSNSequenceState(self, SNEnable)
            % SetAnalyzerSNSequenceState
            % [RetVal] = SetAnalyzerSNSequenceState(self, SNEnable)
            [RetVal] = self.upxHandle.SetAnalyzerSNSequenceState(SNEnable);
        end
        function [RetVal] = SetAnalyzerSampleFrequency(self, SampleFrequency, SampleFrequencyValue)
            % SetAnalyzerSampleFrequency
            % [RetVal] = SetAnalyzerSampleFrequency(self, SampleFrequency, SampleFrequencyValue)
            [RetVal] = self.upxHandle.SetAnalyzerSampleFrequency(SampleFrequency, SampleFrequencyValue);
        end
        function [RetVal] = SetAnalyzerStartCondition(self, StartCondition)
            % SetAnalyzerStartCondition
            % [RetVal] = SetAnalyzerStartCondition(self, StartCondition)
            [RetVal] = self.upxHandle.SetAnalyzerStartCondition(StartCondition);
        end
        function [RetVal] = SetAnalyzerStartDelay(self, StartDelay)
            % SetAnalyzerStartDelay
            % [RetVal] = SetAnalyzerStartDelay(self, StartDelay)
            [RetVal] = self.upxHandle.SetAnalyzerStartDelay(StartDelay);
        end
        function [RetVal] = SetAnalyzerSweepControl(self, SweepControl)
            % SetAnalyzerSweepControl
            % [RetVal] = SetAnalyzerSweepControl(self, SweepControl)
            [RetVal] = self.upxHandle.SetAnalyzerSweepControl(SweepControl);
        end
        function [RetVal] = SetAnalyzerSweepPoints(self, Points)
            % SetAnalyzerSweepPoints
            % [RetVal] = SetAnalyzerSweepPoints(self, Points)
            [RetVal] = self.upxHandle.SetAnalyzerSweepPoints(Points);
        end
        function [RetVal] = SetAnalyzerSweepSpacing(self, Spacing)
            % SetAnalyzerSweepSpacing
            % [RetVal] = SetAnalyzerSweepSpacing(self, Spacing)
            [RetVal] = self.upxHandle.SetAnalyzerSweepSpacing(Spacing);
        end
        function [RetVal] = SetAnalyzerSweepStart(self, Start, Units)
            % SetAnalyzerSweepStart
            % [RetVal] = SetAnalyzerSweepStart(self, Start, Units)
            [RetVal] = self.upxHandle.SetAnalyzerSweepStart(Start, Units);
        end
        function [RetVal] = SetAnalyzerSweepSteps(self, Step, Units)
            % SetAnalyzerSweepSteps
            % [RetVal] = SetAnalyzerSweepSteps(self, Step, Units)
            [RetVal] = self.upxHandle.SetAnalyzerSweepSteps(Step, Units);
        end
        function [RetVal] = SetAnalyzerSweepStop(self, Stop, Units)
            % SetAnalyzerSweepStop
            % [RetVal] = SetAnalyzerSweepStop(self, Stop, Units)
            [RetVal] = self.upxHandle.SetAnalyzerSweepStop(Stop, Units);
        end
        function [RetVal] = SetAnalyzerTHDFundamental(self, Fundamental)
            % SetAnalyzerTHDFundamental
            % [RetVal] = SetAnalyzerTHDFundamental(self, Fundamental)
            [RetVal] = self.upxHandle.SetAnalyzerTHDFundamental(Fundamental);
        end
        function [RetVal] = SetAnalyzerTHDFundamentalValue(self, FundamentalValue)
            % SetAnalyzerTHDFundamentalValue
            % [RetVal] = SetAnalyzerTHDFundamentalValue(self, FundamentalValue)
            [RetVal] = self.upxHandle.SetAnalyzerTHDFundamentalValue(FundamentalValue);
        end
        function [RetVal] = SetAnalyzerTHDHarmonicState(self, Harmonic, HarmonicState)
            % SetAnalyzerTHDHarmonicState
            % [RetVal] = SetAnalyzerTHDHarmonicState(self, Harmonic, HarmonicState)
            [RetVal] = self.upxHandle.SetAnalyzerTHDHarmonicState(Harmonic, HarmonicState);
        end
        function [RetVal] = SetAnalyzerTHDMeasMode(self, MeasMode)
            % SetAnalyzerTHDMeasMode
            % [RetVal] = SetAnalyzerTHDMeasMode(self, MeasMode)
            [RetVal] = self.upxHandle.SetAnalyzerTHDMeasMode(MeasMode);
        end
        function [RetVal] = SetAnalyzerTHDNEqualizer(self, Equalizer)
            % SetAnalyzerTHDNEqualizer
            % [RetVal] = SetAnalyzerTHDNEqualizer(self, Equalizer)
            [RetVal] = self.upxHandle.SetAnalyzerTHDNEqualizer(Equalizer);
        end
        function [RetVal] = SetAnalyzerTHDNEqualizerFile(self, EqualFile)
            % SetAnalyzerTHDNEqualizerFile
            % [RetVal] = SetAnalyzerTHDNEqualizerFile(self, EqualFile)
            [RetVal] = self.upxHandle.SetAnalyzerTHDNEqualizerFile(EqualFile);
        end
        function [RetVal] = SetAnalyzerTHDNFrequencyLimLow(self, FreqLimLow)
            % SetAnalyzerTHDNFrequencyLimLow
            % [RetVal] = SetAnalyzerTHDNFrequencyLimLow(self, FreqLimLow)
            [RetVal] = self.upxHandle.SetAnalyzerTHDNFrequencyLimLow(FreqLimLow);
        end
        function [RetVal] = SetAnalyzerTHDNFrequencyLimUpp(self, FreqLimUpp)
            % SetAnalyzerTHDNFrequencyLimUpp
            % [RetVal] = SetAnalyzerTHDNFrequencyLimUpp(self, FreqLimUpp)
            [RetVal] = self.upxHandle.SetAnalyzerTHDNFrequencyLimUpp(FreqLimUpp);
        end
        function [RetVal] = SetAnalyzerTHDNMeasurementMode(self, MeasurementMode)
            % SetAnalyzerTHDNMeasurementMode
            % [RetVal] = SetAnalyzerTHDNMeasurementMode(self, MeasurementMode)
            [RetVal] = self.upxHandle.SetAnalyzerTHDNMeasurementMode(MeasurementMode);
        end
        function [RetVal] = SetAnalyzerTHDNRejectBandwidth(self, RejectBandwidth)
            % SetAnalyzerTHDNRejectBandwidth
            % [RetVal] = SetAnalyzerTHDNRejectBandwidth(self, RejectBandwidth)
            [RetVal] = self.upxHandle.SetAnalyzerTHDNRejectBandwidth(RejectBandwidth);
        end
        function [RetVal] = SetAnalyzerTHDNRejection(self, Rejection)
            % SetAnalyzerTHDNRejection
            % [RetVal] = SetAnalyzerTHDNRejection(self, Rejection)
            [RetVal] = self.upxHandle.SetAnalyzerTHDNRejection(Rejection);
        end
        function [RetVal] = SetAnalyzerTriggerSettlingCount(self, Samples)
            % SetAnalyzerTriggerSettlingCount
            % [RetVal] = SetAnalyzerTriggerSettlingCount(self, Samples)
            [RetVal] = self.upxHandle.SetAnalyzerTriggerSettlingCount(Samples);
        end
        function [RetVal] = SetAnalyzerTriggerSettlingMode(self, Settling)
            % SetAnalyzerTriggerSettlingMode
            % [RetVal] = SetAnalyzerTriggerSettlingMode(self, Settling)
            [RetVal] = self.upxHandle.SetAnalyzerTriggerSettlingMode(Settling);
        end
        function [RetVal] = SetAnalyzerTriggerSettlingResolution(self, Resolution)
            % SetAnalyzerTriggerSettlingResolution
            % [RetVal] = SetAnalyzerTriggerSettlingResolution(self, Resolution)
            [RetVal] = self.upxHandle.SetAnalyzerTriggerSettlingResolution(Resolution);
        end
        function [RetVal] = SetAnalyzerTriggerSettlingTolerance(self, Tolerance)
            % SetAnalyzerTriggerSettlingTolerance
            % [RetVal] = SetAnalyzerTriggerSettlingTolerance(self, Tolerance)
            [RetVal] = self.upxHandle.SetAnalyzerTriggerSettlingTolerance(Tolerance);
        end
        function [RetVal] = SetAnalyzerUnit(self, Channel, Measurement, Units)
            % SetAnalyzerUnit
            % [RetVal] = SetAnalyzerUnit(self, Channel, Measurement, Units)
            [RetVal] = self.upxHandle.SetAnalyzerUnit(Channel, Measurement, Units);
        end
        function [RetVal] = SetAnalyzerUnitAuto(self, Channel, Measurement, UnitAuto)
            % SetAnalyzerUnitAuto
            % [RetVal] = SetAnalyzerUnitAuto(self, Channel, Measurement, UnitAuto)
            [RetVal] = self.upxHandle.SetAnalyzerUnitAuto(Channel, Measurement, UnitAuto);
        end
        function [RetVal] = SetAnalyzerUserUnit(self, Channel, Measurement, UserUnit)
            % SetAnalyzerUserUnit
            % [RetVal] = SetAnalyzerUserUnit(self, Channel, Measurement, UserUnit)
            [RetVal] = self.upxHandle.SetAnalyzerUserUnit(Channel, Measurement, UserUnit);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorAutotrigger(self, Autotrigger)
            % SetAnalyzerWaveformMonitorAutotrigger
            % [RetVal] = SetAnalyzerWaveformMonitorAutotrigger(self, Autotrigger)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorAutotrigger(Autotrigger);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorCompressionFactor(self, CompressionFactor)
            % SetAnalyzerWaveformMonitorCompressionFactor
            % [RetVal] = SetAnalyzerWaveformMonitorCompressionFactor(self, CompressionFactor)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorCompressionFactor(CompressionFactor);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorMeasMode(self, MeasMode)
            % SetAnalyzerWaveformMonitorMeasMode
            % [RetVal] = SetAnalyzerWaveformMonitorMeasMode(self, MeasMode)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorMeasMode(MeasMode);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorPretrigger(self, Pretrigger)
            % SetAnalyzerWaveformMonitorPretrigger
            % [RetVal] = SetAnalyzerWaveformMonitorPretrigger(self, Pretrigger)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorPretrigger(Pretrigger);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorState(self, WaveformMonitor)
            % SetAnalyzerWaveformMonitorState
            % [RetVal] = SetAnalyzerWaveformMonitorState(self, WaveformMonitor)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorState(WaveformMonitor);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorTraceLength(self, TraceLength)
            % SetAnalyzerWaveformMonitorTraceLength
            % [RetVal] = SetAnalyzerWaveformMonitorTraceLength(self, TraceLength)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorTraceLength(TraceLength);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorTriggerLevel(self, TriggerLevel, Units)
            % SetAnalyzerWaveformMonitorTriggerLevel
            % [RetVal] = SetAnalyzerWaveformMonitorTriggerLevel(self, TriggerLevel, Units)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorTriggerLevel(TriggerLevel, Units);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorTriggerSlope(self, TriggerSlope)
            % SetAnalyzerWaveformMonitorTriggerSlope
            % [RetVal] = SetAnalyzerWaveformMonitorTriggerSlope(self, TriggerSlope)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorTriggerSlope(TriggerSlope);
        end
        function [RetVal] = SetAnalyzerWaveformMonitorTriggerSource(self, TriggerSource)
            % SetAnalyzerWaveformMonitorTriggerSource
            % [RetVal] = SetAnalyzerWaveformMonitorTriggerSource(self, TriggerSource)
            [RetVal] = self.upxHandle.SetAnalyzerWaveformMonitorTriggerSource(TriggerSource);
        end
        function [RetVal] = SetAuxAnalogOutput(self, AnalogAuxOutput)
            % SetAuxAnalogOutput
            % [RetVal] = SetAuxAnalogOutput(self, AnalogAuxOutput)
            [RetVal] = self.upxHandle.SetAuxAnalogOutput(AnalogAuxOutput);
        end
        function [RetVal] = SetAuxAudioMonitor(self, AudioMonitor)
            % SetAuxAudioMonitor
            % [RetVal] = SetAuxAudioMonitor(self, AudioMonitor)
            [RetVal] = self.upxHandle.SetAuxAudioMonitor(AudioMonitor);
        end
        function [RetVal] = SetAuxDCVoltage(self, DCValue, Units)
            % SetAuxDCVoltage
            % [RetVal] = SetAuxDCVoltage(self, DCValue, Units)
            [RetVal] = self.upxHandle.SetAuxDCVoltage(DCValue, Units);
        end
        function [RetVal] = SetAuxMonitoringChannel(self, MonitoringChannel)
            % SetAuxMonitoringChannel
            % [RetVal] = SetAuxMonitoringChannel(self, MonitoringChannel)
            [RetVal] = self.upxHandle.SetAuxMonitoringChannel(MonitoringChannel);
        end
        function [RetVal] = SetAuxPhoneOutput(self, PhoneOut)
            % SetAuxPhoneOutput
            % [RetVal] = SetAuxPhoneOutput(self, PhoneOut)
            [RetVal] = self.upxHandle.SetAuxPhoneOutput(PhoneOut);
        end
        function [RetVal] = SetAuxPhonePermanentState(self, AuxPhonePermanentState)
            % SetAuxPhonePermanentState
            % [RetVal] = SetAuxPhonePermanentState(self, AuxPhonePermanentState)
            [RetVal] = self.upxHandle.SetAuxPhonePermanentState(AuxPhonePermanentState);
        end
        function [RetVal] = SetAuxPhoneState(self, PhoneState)
            % SetAuxPhoneState
            % [RetVal] = SetAuxPhoneState(self, PhoneState)
            [RetVal] = self.upxHandle.SetAuxPhoneState(PhoneState);
        end
        function [RetVal] = SetAuxSignalSource(self, SignalSource)
            % SetAuxSignalSource
            % [RetVal] = SetAuxSignalSource(self, SignalSource)
            [RetVal] = self.upxHandle.SetAuxSignalSource(SignalSource);
        end
        function [RetVal] = SetAuxSpeaker(self, Speaker)
            % SetAuxSpeaker
            % [RetVal] = SetAuxSpeaker(self, Speaker)
            [RetVal] = self.upxHandle.SetAuxSpeaker(Speaker);
        end
        function [RetVal] = SetAuxSpeakerMonitor(self, MonitorNumber, MonitoredChannel)
            % SetAuxSpeakerMonitor
            % [RetVal] = SetAuxSpeakerMonitor(self, MonitorNumber, MonitoredChannel)
            [RetVal] = self.upxHandle.SetAuxSpeakerMonitor(MonitorNumber, MonitoredChannel);
        end
        function [RetVal] = SetAuxTriggerInputEdge(self, TriggerInputEdge)
            % SetAuxTriggerInputEdge
            % [RetVal] = SetAuxTriggerInputEdge(self, TriggerInputEdge)
            [RetVal] = self.upxHandle.SetAuxTriggerInputEdge(TriggerInputEdge);
        end
        function [RetVal] = SetAuxTriggerInputEnable(self, TriggerInput)
            % SetAuxTriggerInputEnable
            % [RetVal] = SetAuxTriggerInputEnable(self, TriggerInput)
            [RetVal] = self.upxHandle.SetAuxTriggerInputEnable(TriggerInput);
        end
        function [RetVal] = SetAuxTriggerInputMode(self, TriggerInputMode)
            % SetAuxTriggerInputMode
            % [RetVal] = SetAuxTriggerInputMode(self, TriggerInputMode)
            [RetVal] = self.upxHandle.SetAuxTriggerInputMode(TriggerInputMode);
        end
        function [RetVal] = SetAuxTriggerOutputEdge(self, TriggerOutputEdge)
            % SetAuxTriggerOutputEdge
            % [RetVal] = SetAuxTriggerOutputEdge(self, TriggerOutputEdge)
            [RetVal] = self.upxHandle.SetAuxTriggerOutputEdge(TriggerOutputEdge);
        end
        function [RetVal] = SetAuxTriggerOutputEnable(self, TriggerOutput)
            % SetAuxTriggerOutputEnable
            % [RetVal] = SetAuxTriggerOutputEnable(self, TriggerOutput)
            [RetVal] = self.upxHandle.SetAuxTriggerOutputEnable(TriggerOutput);
        end
        function [RetVal] = SetAuxTriggerOutputFrequency(self, TriggerOutputFrequency)
            % SetAuxTriggerOutputFrequency
            % [RetVal] = SetAuxTriggerOutputFrequency(self, TriggerOutputFrequency)
            [RetVal] = self.upxHandle.SetAuxTriggerOutputFrequency(TriggerOutputFrequency);
        end
        function [RetVal] = SetAuxTriggerOutputMode(self, TriggerOutputMode)
            % SetAuxTriggerOutputMode
            % [RetVal] = SetAuxTriggerOutputMode(self, TriggerOutputMode)
            [RetVal] = self.upxHandle.SetAuxTriggerOutputMode(TriggerOutputMode);
        end
        function [RetVal] = SetAuxVolume(self, Volume)
            % SetAuxVolume
            % [RetVal] = SetAuxVolume(self, Volume)
            [RetVal] = self.upxHandle.SetAuxVolume(Volume);
        end
        function [RetVal] = SetDigBitstreamAnalyzerAlignment(self, Alignment)
            % SetDigBitstreamAnalyzerAlignment
            % [RetVal] = SetDigBitstreamAnalyzerAlignment(self, Alignment)
            [RetVal] = self.upxHandle.SetDigBitstreamAnalyzerAlignment(Alignment);
        end
        function [RetVal] = SetDigBitstreamAnalyzerChannelMode(self, ChannelMode)
            % SetDigBitstreamAnalyzerChannelMode
            % [RetVal] = SetDigBitstreamAnalyzerChannelMode(self, ChannelMode)
            [RetVal] = self.upxHandle.SetDigBitstreamAnalyzerChannelMode(ChannelMode);
        end
        function [RetVal] = SetDigBitstreamAnalyzerClockFrequency(self, ClockFrequency)
            % SetDigBitstreamAnalyzerClockFrequency
            % [RetVal] = SetDigBitstreamAnalyzerClockFrequency(self, ClockFrequency)
            [RetVal] = self.upxHandle.SetDigBitstreamAnalyzerClockFrequency(ClockFrequency);
        end
        function [RetVal] = SetDigBitstreamAnalyzerClockSource(self, ClockSource)
            % SetDigBitstreamAnalyzerClockSource
            % [RetVal] = SetDigBitstreamAnalyzerClockSource(self, ClockSource)
            [RetVal] = self.upxHandle.SetDigBitstreamAnalyzerClockSource(ClockSource);
        end
        function [RetVal] = SetDigBitstreamAnalyzerDownSamplingFactor(self, DwnsmplFact)
            % SetDigBitstreamAnalyzerDownSamplingFactor
            % [RetVal] = SetDigBitstreamAnalyzerDownSamplingFactor(self, DwnsmplFact)
            [RetVal] = self.upxHandle.SetDigBitstreamAnalyzerDownSamplingFactor(DwnsmplFact);
        end
        function [RetVal] = SetDigBitstreamAnalyzerDutyCycle(self, DutyCycle)
            % SetDigBitstreamAnalyzerDutyCycle
            % [RetVal] = SetDigBitstreamAnalyzerDutyCycle(self, DutyCycle)
            [RetVal] = self.upxHandle.SetDigBitstreamAnalyzerDutyCycle(DutyCycle);
        end
        function [RetVal] = SetDigitalAnalyzerAudioBits(self, AudioBits)
            % SetDigitalAnalyzerAudioBits
            % [RetVal] = SetDigitalAnalyzerAudioBits(self, AudioBits)
            [RetVal] = self.upxHandle.SetDigitalAnalyzerAudioBits(AudioBits);
        end
        function [RetVal] = SetDigitalAnalyzerAudioInput(self, Input)
            % SetDigitalAnalyzerAudioInput
            % [RetVal] = SetDigitalAnalyzerAudioInput(self, Input)
            [RetVal] = self.upxHandle.SetDigitalAnalyzerAudioInput(Input);
        end
        function [RetVal] = SetDigitalAnalyzerChannelMode(self, ChannelMode)
            % SetDigitalAnalyzerChannelMode
            % [RetVal] = SetDigitalAnalyzerChannelMode(self, ChannelMode)
            [RetVal] = self.upxHandle.SetDigitalAnalyzerChannelMode(ChannelMode);
        end
        function [RetVal] = SetDigitalAnalyzerJitterRef(self, JitterRef)
            % SetDigitalAnalyzerJitterRef
            % [RetVal] = SetDigitalAnalyzerJitterRef(self, JitterRef)
            [RetVal] = self.upxHandle.SetDigitalAnalyzerJitterRef(JitterRef);
        end
        function [RetVal] = SetDigitalAnalyzerMeasMode(self, MeasMode)
            % SetDigitalAnalyzerMeasMode
            % [RetVal] = SetDigitalAnalyzerMeasMode(self, MeasMode)
            [RetVal] = self.upxHandle.SetDigitalAnalyzerMeasMode(MeasMode);
        end
        function [RetVal] = SetDigitalGeneratorAddImpairment(self, AddImpairment)
            % SetDigitalGeneratorAddImpairment
            % [RetVal] = SetDigitalGeneratorAddImpairment(self, AddImpairment)
            [RetVal] = self.upxHandle.SetDigitalGeneratorAddImpairment(AddImpairment);
        end
        function [RetVal] = SetDigitalGeneratorAudioBits(self, AudioBits)
            % SetDigitalGeneratorAudioBits
            % [RetVal] = SetDigitalGeneratorAudioBits(self, AudioBits)
            [RetVal] = self.upxHandle.SetDigitalGeneratorAudioBits(AudioBits);
        end
        function [RetVal] = SetDigitalGeneratorAuxOutput(self, AuxOutput)
            % SetDigitalGeneratorAuxOutput
            % [RetVal] = SetDigitalGeneratorAuxOutput(self, AuxOutput)
            [RetVal] = self.upxHandle.SetDigitalGeneratorAuxOutput(AuxOutput);
        end
        function [RetVal] = SetDigitalGeneratorBalancedAmplitude(self, BalancedAmplitude, Units)
            % SetDigitalGeneratorBalancedAmplitude
            % [RetVal] = SetDigitalGeneratorBalancedAmplitude(self, BalancedAmplitude, Units)
            [RetVal] = self.upxHandle.SetDigitalGeneratorBalancedAmplitude(BalancedAmplitude, Units);
        end
        function [RetVal] = SetDigitalGeneratorBalancedImpedance(self, BalancedImpedance)
            % SetDigitalGeneratorBalancedImpedance
            % [RetVal] = SetDigitalGeneratorBalancedImpedance(self, BalancedImpedance)
            [RetVal] = self.upxHandle.SetDigitalGeneratorBalancedImpedance(BalancedImpedance);
        end
        function [RetVal] = SetDigitalGeneratorCableSimulation(self, CableSimulation)
            % SetDigitalGeneratorCableSimulation
            % [RetVal] = SetDigitalGeneratorCableSimulation(self, CableSimulation)
            [RetVal] = self.upxHandle.SetDigitalGeneratorCableSimulation(CableSimulation);
        end
        function [RetVal] = SetDigitalGeneratorChannelMode(self, Channel)
            % SetDigitalGeneratorChannelMode
            % [RetVal] = SetDigitalGeneratorChannelMode(self, Channel)
            [RetVal] = self.upxHandle.SetDigitalGeneratorChannelMode(Channel);
        end
        function [RetVal] = SetDigitalGeneratorChannels(self, MeasChannel, GenChannels)
            % SetDigitalGeneratorChannels
            % [RetVal] = SetDigitalGeneratorChannels(self, MeasChannel, GenChannels)
            [RetVal] = self.upxHandle.SetDigitalGeneratorChannels(MeasChannel, GenChannels);
        end
        function [RetVal] = SetDigitalGeneratorFramePhase(self, FramePhase, Units)
            % SetDigitalGeneratorFramePhase
            % [RetVal] = SetDigitalGeneratorFramePhase(self, FramePhase, Units)
            [RetVal] = self.upxHandle.SetDigitalGeneratorFramePhase(FramePhase, Units);
        end
        function [RetVal] = SetDigitalGeneratorInternalClockFrequency(self, InternalClockFrequency)
            % SetDigitalGeneratorInternalClockFrequency
            % [RetVal] = SetDigitalGeneratorInternalClockFrequency(self, InternalClockFrequency)
            [RetVal] = self.upxHandle.SetDigitalGeneratorInternalClockFrequency(InternalClockFrequency);
        end
        function [RetVal] = SetDigitalGeneratorPhaseToRef(self, PhaseToRef)
            % SetDigitalGeneratorPhaseToRef
            % [RetVal] = SetDigitalGeneratorPhaseToRef(self, PhaseToRef)
            [RetVal] = self.upxHandle.SetDigitalGeneratorPhaseToRef(PhaseToRef);
        end
        function [RetVal] = SetDigitalGeneratorRefGeneratorData(self, RefGeneratorData)
            % SetDigitalGeneratorRefGeneratorData
            % [RetVal] = SetDigitalGeneratorRefGeneratorData(self, RefGeneratorData)
            [RetVal] = self.upxHandle.SetDigitalGeneratorRefGeneratorData(RefGeneratorData);
        end
        function [RetVal] = SetDigitalGeneratorSampleFrequency(self, SampleFrequency, VariableSampleFrequency)
            % SetDigitalGeneratorSampleFrequency
            % [RetVal] = SetDigitalGeneratorSampleFrequency(self, SampleFrequency, VariableSampleFrequency)
            [RetVal] = self.upxHandle.SetDigitalGeneratorSampleFrequency(SampleFrequency, VariableSampleFrequency);
        end
        function [RetVal] = SetDigitalGeneratorSourceMode(self, SourceMode)
            % SetDigitalGeneratorSourceMode
            % [RetVal] = SetDigitalGeneratorSourceMode(self, SourceMode)
            [RetVal] = self.upxHandle.SetDigitalGeneratorSourceMode(SourceMode);
        end
        function [RetVal] = SetDigitalGeneratorSyncOutType(self, SyncOutputType)
            % SetDigitalGeneratorSyncOutType
            % [RetVal] = SetDigitalGeneratorSyncOutType(self, SyncOutputType)
            [RetVal] = self.upxHandle.SetDigitalGeneratorSyncOutType(SyncOutputType);
        end
        function [RetVal] = SetDigitalGeneratorSyncOutput(self, SyncOutput)
            % SetDigitalGeneratorSyncOutput
            % [RetVal] = SetDigitalGeneratorSyncOutput(self, SyncOutput)
            [RetVal] = self.upxHandle.SetDigitalGeneratorSyncOutput(SyncOutput);
        end
        function [RetVal] = SetDigitalGeneratorSyncTo(self, SyncTo)
            % SetDigitalGeneratorSyncTo
            % [RetVal] = SetDigitalGeneratorSyncTo(self, SyncTo)
            [RetVal] = self.upxHandle.SetDigitalGeneratorSyncTo(SyncTo);
        end
        function [RetVal] = SetDigitalGeneratorUnbalancedAmplitude(self, UnbalancedAmplitude, Units)
            % SetDigitalGeneratorUnbalancedAmplitude
            % [RetVal] = SetDigitalGeneratorUnbalancedAmplitude(self, UnbalancedAmplitude, Units)
            [RetVal] = self.upxHandle.SetDigitalGeneratorUnbalancedAmplitude(UnbalancedAmplitude, Units);
        end
        function [RetVal] = SetDigitalGeneratorUnbalancedImpedance(self, UnbalancedImpedance)
            % SetDigitalGeneratorUnbalancedImpedance
            % [RetVal] = SetDigitalGeneratorUnbalancedImpedance(self, UnbalancedImpedance)
            [RetVal] = self.upxHandle.SetDigitalGeneratorUnbalancedImpedance(UnbalancedImpedance);
        end
        function [RetVal] = SetDigitalGeneratorUnbalancedOutput(self, UnbalancedOutput)
            % SetDigitalGeneratorUnbalancedOutput
            % [RetVal] = SetDigitalGeneratorUnbalancedOutput(self, UnbalancedOutput)
            [RetVal] = self.upxHandle.SetDigitalGeneratorUnbalancedOutput(UnbalancedOutput);
        end
        function [RetVal] = SetDisplayAxisLabelAuto(self, Subsystem, SubsystemNumber, Trace, AxisLabelAuto)
            % SetDisplayAxisLabelAuto
            % [RetVal] = SetDisplayAxisLabelAuto(self, Subsystem, SubsystemNumber, Trace, AxisLabelAuto)
            [RetVal] = self.upxHandle.SetDisplayAxisLabelAuto(Subsystem, SubsystemNumber, Trace, AxisLabelAuto);
        end
        function [RetVal] = SetDisplayAxisLabelUserString(self, Subsystem, SubsystemNumber, Trace, AxisLabelUserString)
            % SetDisplayAxisLabelUserString
            % [RetVal] = SetDisplayAxisLabelUserString(self, Subsystem, SubsystemNumber, Trace, AxisLabelUserString)
            [RetVal] = self.upxHandle.SetDisplayAxisLabelUserString(Subsystem, SubsystemNumber, Trace, AxisLabelUserString);
        end
        function [RetVal] = SetDisplayBargraphMultichannelYSource(self, SubsystemNumber, Trace, YSource)
            % SetDisplayBargraphMultichannelYSource
            % [RetVal] = SetDisplayBargraphMultichannelYSource(self, SubsystemNumber, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplayBargraphMultichannelYSource(SubsystemNumber, Trace, YSource);
        end
        function [RetVal] = SetDisplayBargraphYSource(self, SubsystemNumber, Trace, YSource)
            % SetDisplayBargraphYSource
            % [RetVal] = SetDisplayBargraphYSource(self, SubsystemNumber, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplayBargraphYSource(SubsystemNumber, Trace, YSource);
        end
        function [RetVal] = SetDisplayChannel(self, SubsystemNumber, Subsystem, Trace, ChannelNumber)
            % SetDisplayChannel
            % [RetVal] = SetDisplayChannel(self, SubsystemNumber, Subsystem, Trace, ChannelNumber)
            [RetVal] = self.upxHandle.SetDisplayChannel(SubsystemNumber, Subsystem, Trace, ChannelNumber);
        end
        function [RetVal] = SetDisplayCopyLimitSettings(self, Subsystem, SubsystemNumber, CopyLimitSettings)
            % SetDisplayCopyLimitSettings
            % [RetVal] = SetDisplayCopyLimitSettings(self, Subsystem, SubsystemNumber, CopyLimitSettings)
            [RetVal] = self.upxHandle.SetDisplayCopyLimitSettings(Subsystem, SubsystemNumber, CopyLimitSettings);
        end
        function [RetVal] = SetDisplayCopyReferenceSettings(self, Subsystem, SubsystemNumber, CopyReferenceSettings)
            % SetDisplayCopyReferenceSettings
            % [RetVal] = SetDisplayCopyReferenceSettings(self, Subsystem, SubsystemNumber, CopyReferenceSettings)
            [RetVal] = self.upxHandle.SetDisplayCopyReferenceSettings(Subsystem, SubsystemNumber, CopyReferenceSettings);
        end
        function [RetVal] = SetDisplayCopyScalingSettings(self, Subsystem, SubsystemNumber, CopyScalingSettings)
            % SetDisplayCopyScalingSettings
            % [RetVal] = SetDisplayCopyScalingSettings(self, Subsystem, SubsystemNumber, CopyScalingSettings)
            [RetVal] = self.upxHandle.SetDisplayCopyScalingSettings(Subsystem, SubsystemNumber, CopyScalingSettings);
        end
        function [RetVal] = SetDisplayCursorMode(self, Subsystem, SubsystemNumber, CursorType, CursorMode)
            % SetDisplayCursorMode
            % [RetVal] = SetDisplayCursorMode(self, Subsystem, SubsystemNumber, CursorType, CursorMode)
            [RetVal] = self.upxHandle.SetDisplayCursorMode(Subsystem, SubsystemNumber, CursorType, CursorMode);
        end
        function [RetVal] = SetDisplayCursorMoveTo(self, Subsystem, SubsystemNumber, CursorType, SetCursorTo)
            % SetDisplayCursorMoveTo
            % [RetVal] = SetDisplayCursorMoveTo(self, Subsystem, SubsystemNumber, CursorType, SetCursorTo)
            [RetVal] = self.upxHandle.SetDisplayCursorMoveTo(Subsystem, SubsystemNumber, CursorType, SetCursorTo);
        end
        function [RetVal] = SetDisplayCursorMovement(self, Subsystem, SubsystemNumber, CursorType, CursorPositionMode)
            % SetDisplayCursorMovement
            % [RetVal] = SetDisplayCursorMovement(self, Subsystem, SubsystemNumber, CursorType, CursorPositionMode)
            [RetVal] = self.upxHandle.SetDisplayCursorMovement(Subsystem, SubsystemNumber, CursorType, CursorPositionMode);
        end
        function [RetVal] = SetDisplayCursorState(self, Subsystem, SubsystemNumber, CursorType, CursorState)
            % SetDisplayCursorState
            % [RetVal] = SetDisplayCursorState(self, Subsystem, SubsystemNumber, CursorType, CursorState)
            [RetVal] = self.upxHandle.SetDisplayCursorState(Subsystem, SubsystemNumber, CursorType, CursorState);
        end
        function [RetVal] = SetDisplayCursorXPosition(self, Subsystem, SubsystemNumber, CursorType, CursorXPosition, Units)
            % SetDisplayCursorXPosition
            % [RetVal] = SetDisplayCursorXPosition(self, Subsystem, SubsystemNumber, CursorType, CursorXPosition, Units)
            [RetVal] = self.upxHandle.SetDisplayCursorXPosition(Subsystem, SubsystemNumber, CursorType, CursorXPosition, Units);
        end
        function [RetVal] = SetDisplayCursorYPosition(self, Subsystem, SubsystemNumber, CursorType, CursorYPosition, Units)
            % SetDisplayCursorYPosition
            % [RetVal] = SetDisplayCursorYPosition(self, Subsystem, SubsystemNumber, CursorType, CursorYPosition, Units)
            [RetVal] = self.upxHandle.SetDisplayCursorYPosition(Subsystem, SubsystemNumber, CursorType, CursorYPosition, Units);
        end
        function [RetVal] = SetDisplayDataListFilter(self, Subsystem, SubsystemNumber, DataListFilterType)
            % SetDisplayDataListFilter
            % [RetVal] = SetDisplayDataListFilter(self, Subsystem, SubsystemNumber, DataListFilterType)
            [RetVal] = self.upxHandle.SetDisplayDataListFilter(Subsystem, SubsystemNumber, DataListFilterType);
        end
        function [RetVal] = SetDisplayFFTGraphMultichannelYSource(self, SubsystemNumber, Trace, YSource)
            % SetDisplayFFTGraphMultichannelYSource
            % [RetVal] = SetDisplayFFTGraphMultichannelYSource(self, SubsystemNumber, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplayFFTGraphMultichannelYSource(SubsystemNumber, Trace, YSource);
        end
        function [RetVal] = SetDisplayFFTGraphYSource(self, SubsystemNumber, Trace, YSource)
            % SetDisplayFFTGraphYSource
            % [RetVal] = SetDisplayFFTGraphYSource(self, SubsystemNumber, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplayFFTGraphYSource(SubsystemNumber, Trace, YSource);
        end
        function [RetVal] = SetDisplayInvertEqu(self, Subsystem, SubsystemNumber, InvertEqualization)
            % SetDisplayInvertEqu
            % [RetVal] = SetDisplayInvertEqu(self, Subsystem, SubsystemNumber, InvertEqualization)
            [RetVal] = self.upxHandle.SetDisplayInvertEqu(Subsystem, SubsystemNumber, InvertEqualization);
        end
        function [RetVal] = SetDisplayLegend(self, Subsystem, SubsystemNumber, Trace, LegendString)
            % SetDisplayLegend
            % [RetVal] = SetDisplayLegend(self, Subsystem, SubsystemNumber, Trace, LegendString)
            [RetVal] = self.upxHandle.SetDisplayLegend(Subsystem, SubsystemNumber, Trace, LegendString);
        end
        function [RetVal] = SetDisplayLegendState(self, Subsystem, SubsystemNumber, Trace, Legend)
            % SetDisplayLegendState
            % [RetVal] = SetDisplayLegendState(self, Subsystem, SubsystemNumber, Trace, Legend)
            [RetVal] = self.upxHandle.SetDisplayLegendState(Subsystem, SubsystemNumber, Trace, Legend);
        end
        function [RetVal] = SetDisplayLimitOffset(self, Subsystem, SubsystemNumber, LimitOffset)
            % SetDisplayLimitOffset
            % [RetVal] = SetDisplayLimitOffset(self, Subsystem, SubsystemNumber, LimitOffset)
            [RetVal] = self.upxHandle.SetDisplayLimitOffset(Subsystem, SubsystemNumber, LimitOffset);
        end
        function [RetVal] = SetDisplayLimitOffsetValue(self, Subsystem, SubsystemNumber, LimitOffsetValue)
            % SetDisplayLimitOffsetValue
            % [RetVal] = SetDisplayLimitOffsetValue(self, Subsystem, SubsystemNumber, LimitOffsetValue)
            [RetVal] = self.upxHandle.SetDisplayLimitOffsetValue(Subsystem, SubsystemNumber, LimitOffsetValue);
        end
        function [RetVal] = SetDisplayLimitShift(self, Subsystem, SubsystemNumber, Trace, LimitShift)
            % SetDisplayLimitShift
            % [RetVal] = SetDisplayLimitShift(self, Subsystem, SubsystemNumber, Trace, LimitShift)
            [RetVal] = self.upxHandle.SetDisplayLimitShift(Subsystem, SubsystemNumber, Trace, LimitShift);
        end
        function [RetVal] = SetDisplayLimitShiftParallel(self, Subsystem, SubsystemNumber, Trace, LimitShiftParallel, Units)
            % SetDisplayLimitShiftParallel
            % [RetVal] = SetDisplayLimitShiftParallel(self, Subsystem, SubsystemNumber, Trace, LimitShiftParallel, Units)
            [RetVal] = self.upxHandle.SetDisplayLimitShiftParallel(Subsystem, SubsystemNumber, Trace, LimitShiftParallel, Units);
        end
        function [RetVal] = SetDisplayLimitShiftSymmetrical(self, Subsystem, SubsystemNumber, Trace, LimitShiftSymmetrical, Units)
            % SetDisplayLimitShiftSymmetrical
            % [RetVal] = SetDisplayLimitShiftSymmetrical(self, Subsystem, SubsystemNumber, Trace, LimitShiftSymmetrical, Units)
            [RetVal] = self.upxHandle.SetDisplayLimitShiftSymmetrical(Subsystem, SubsystemNumber, Trace, LimitShiftSymmetrical, Units);
        end
        function [RetVal] = SetDisplayLimitSource(self, Subsystem, SubsystemNumber, Trace, LimitType, LimitSource)
            % SetDisplayLimitSource
            % [RetVal] = SetDisplayLimitSource(self, Subsystem, SubsystemNumber, Trace, LimitType, LimitSource)
            [RetVal] = self.upxHandle.SetDisplayLimitSource(Subsystem, SubsystemNumber, Trace, LimitType, LimitSource);
        end
        function [RetVal] = SetDisplayLimitSourceFilename(self, Subsystem, SubsystemNumber, Trace, LimitType, LimitSourceFilename)
            % SetDisplayLimitSourceFilename
            % [RetVal] = SetDisplayLimitSourceFilename(self, Subsystem, SubsystemNumber, Trace, LimitType, LimitSourceFilename)
            [RetVal] = self.upxHandle.SetDisplayLimitSourceFilename(Subsystem, SubsystemNumber, Trace, LimitType, LimitSourceFilename);
        end
        function [RetVal] = SetDisplayLimitSourceValue(self, Subsystem, SubsystemNumber, Trace, LimitType, LimitSourceValue, Units)
            % SetDisplayLimitSourceValue
            % [RetVal] = SetDisplayLimitSourceValue(self, Subsystem, SubsystemNumber, Trace, LimitType, LimitSourceValue, Units)
            [RetVal] = self.upxHandle.SetDisplayLimitSourceValue(Subsystem, SubsystemNumber, Trace, LimitType, LimitSourceValue, Units);
        end
        function [RetVal] = SetDisplayLimitState(self, Subsystem, SubsystemNumber, Trace, LimitType, LimitState)
            % SetDisplayLimitState
            % [RetVal] = SetDisplayLimitState(self, Subsystem, SubsystemNumber, Trace, LimitType, LimitState)
            [RetVal] = self.upxHandle.SetDisplayLimitState(Subsystem, SubsystemNumber, Trace, LimitType, LimitState);
        end
        function [RetVal] = SetDisplayMarkerHarmonics(self, Subsystem, SubsystemNumber, Trace, Harmonics)
            % SetDisplayMarkerHarmonics
            % [RetVal] = SetDisplayMarkerHarmonics(self, Subsystem, SubsystemNumber, Trace, Harmonics)
            [RetVal] = self.upxHandle.SetDisplayMarkerHarmonics(Subsystem, SubsystemNumber, Trace, Harmonics);
        end
        function [RetVal] = SetDisplayMarkerMode(self, Subsystem, SubsystemNumber, Trace, MarkerMode)
            % SetDisplayMarkerMode
            % [RetVal] = SetDisplayMarkerMode(self, Subsystem, SubsystemNumber, Trace, MarkerMode)
            [RetVal] = self.upxHandle.SetDisplayMarkerMode(Subsystem, SubsystemNumber, Trace, MarkerMode);
        end
        function [RetVal] = SetDisplayMarkerMoveTo(self, Subsystem, SubsystemNumber, Trace, MoveTo)
            % SetDisplayMarkerMoveTo
            % [RetVal] = SetDisplayMarkerMoveTo(self, Subsystem, SubsystemNumber, Trace, MoveTo)
            [RetVal] = self.upxHandle.SetDisplayMarkerMoveTo(Subsystem, SubsystemNumber, Trace, MoveTo);
        end
        function [RetVal] = SetDisplayMarkerXPosition(self, Subsystem, SubsystemNumber, Trace, MarkerXPosition, Units)
            % SetDisplayMarkerXPosition
            % [RetVal] = SetDisplayMarkerXPosition(self, Subsystem, SubsystemNumber, Trace, MarkerXPosition, Units)
            [RetVal] = self.upxHandle.SetDisplayMarkerXPosition(Subsystem, SubsystemNumber, Trace, MarkerXPosition, Units);
        end
        function [RetVal] = SetDisplayMaxChannels(self, MaxChannelsDisplay)
            % SetDisplayMaxChannels
            % [RetVal] = SetDisplayMaxChannels(self, MaxChannelsDisplay)
            [RetVal] = self.upxHandle.SetDisplayMaxChannels(MaxChannelsDisplay);
        end
        function [RetVal] = SetDisplayModifyEqu(self, Subsystem, SubsystemNumber, ModifyEqulization)
            % SetDisplayModifyEqu
            % [RetVal] = SetDisplayModifyEqu(self, Subsystem, SubsystemNumber, ModifyEqulization)
            [RetVal] = self.upxHandle.SetDisplayModifyEqu(Subsystem, SubsystemNumber, ModifyEqulization);
        end
        function [RetVal] = SetDisplayNormalization(self, Subsystem, SubsystemNumber, Trace, Normalization)
            % SetDisplayNormalization
            % [RetVal] = SetDisplayNormalization(self, Subsystem, SubsystemNumber, Trace, Normalization)
            [RetVal] = self.upxHandle.SetDisplayNormalization(Subsystem, SubsystemNumber, Trace, Normalization);
        end
        function [RetVal] = SetDisplayNormalizationFrequency(self, Subsystem, SubsystemNumber, NormalizationFrequency, Units)
            % SetDisplayNormalizationFrequency
            % [RetVal] = SetDisplayNormalizationFrequency(self, Subsystem, SubsystemNumber, NormalizationFrequency, Units)
            [RetVal] = self.upxHandle.SetDisplayNormalizationFrequency(Subsystem, SubsystemNumber, NormalizationFrequency, Units);
        end
        function [RetVal] = SetDisplayNormalizeValue(self, Subsystem, SubsystemNumber, Trace, NormalizeValue)
            % SetDisplayNormalizeValue
            % [RetVal] = SetDisplayNormalizeValue(self, Subsystem, SubsystemNumber, Trace, NormalizeValue)
            [RetVal] = self.upxHandle.SetDisplayNormalizeValue(Subsystem, SubsystemNumber, Trace, NormalizeValue);
        end
        function [RetVal] = SetDisplayPESQYSource(self, SubsystemNumber, Trace, YSource)
            % SetDisplayPESQYSource
            % [RetVal] = SetDisplayPESQYSource(self, SubsystemNumber, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplayPESQYSource(SubsystemNumber, Trace, YSource);
        end
        function [RetVal] = SetDisplayReference(self, Subsystem, SubsystemNumber, Trace, Reference)
            % SetDisplayReference
            % [RetVal] = SetDisplayReference(self, Subsystem, SubsystemNumber, Trace, Reference)
            [RetVal] = self.upxHandle.SetDisplayReference(Subsystem, SubsystemNumber, Trace, Reference);
        end
        function [RetVal] = SetDisplayReferenceFile(self, Subsystem, SubsystemNumber, Trace, ReferenceFile)
            % SetDisplayReferenceFile
            % [RetVal] = SetDisplayReferenceFile(self, Subsystem, SubsystemNumber, Trace, ReferenceFile)
            [RetVal] = self.upxHandle.SetDisplayReferenceFile(Subsystem, SubsystemNumber, Trace, ReferenceFile);
        end
        function [RetVal] = SetDisplayReferenceValue(self, Subsystem, SubsystemNumber, Trace, ReferenceValue, Units)
            % SetDisplayReferenceValue
            % [RetVal] = SetDisplayReferenceValue(self, Subsystem, SubsystemNumber, Trace, ReferenceValue, Units)
            [RetVal] = self.upxHandle.SetDisplayReferenceValue(Subsystem, SubsystemNumber, Trace, ReferenceValue, Units);
        end
        function [RetVal] = SetDisplayScanOffset(self, Subsystem, SubsystemNumber, ScanOffset)
            % SetDisplayScanOffset
            % [RetVal] = SetDisplayScanOffset(self, Subsystem, SubsystemNumber, ScanOffset)
            [RetVal] = self.upxHandle.SetDisplayScanOffset(Subsystem, SubsystemNumber, ScanOffset);
        end
        function [RetVal] = SetDisplayScreen(self, ScreenNumber)
            % SetDisplayScreen
            % [RetVal] = SetDisplayScreen(self, ScreenNumber)
            [RetVal] = self.upxHandle.SetDisplayScreen(ScreenNumber);
        end
        function [RetVal] = SetDisplayShowMinMax(self, Subsystem, SubsystemNumber, ShowMinMax)
            % SetDisplayShowMinMax
            % [RetVal] = SetDisplayShowMinMax(self, Subsystem, SubsystemNumber, ShowMinMax)
            [RetVal] = self.upxHandle.SetDisplayShowMinMax(Subsystem, SubsystemNumber, ShowMinMax);
        end
        function [RetVal] = SetDisplayStoreTraceAs(self, Subsystem, SubsystemNumber, StoreTraceAs)
            % SetDisplayStoreTraceAs
            % [RetVal] = SetDisplayStoreTraceAs(self, Subsystem, SubsystemNumber, StoreTraceAs)
            [RetVal] = self.upxHandle.SetDisplayStoreTraceAs(Subsystem, SubsystemNumber, StoreTraceAs);
        end
        function [RetVal] = SetDisplayStoreTraceToFile(self, Subsystem, SubsystemNumber, StoreTraceToFile)
            % SetDisplayStoreTraceToFile
            % [RetVal] = SetDisplayStoreTraceToFile(self, Subsystem, SubsystemNumber, StoreTraceToFile)
            [RetVal] = self.upxHandle.SetDisplayStoreTraceToFile(Subsystem, SubsystemNumber, StoreTraceToFile);
        end
        function [RetVal] = SetDisplaySweepGraphXAxis(self, SweepGraphNumber, XAxis)
            % SetDisplaySweepGraphXAxis
            % [RetVal] = SetDisplaySweepGraphXAxis(self, SweepGraphNumber, XAxis)
            [RetVal] = self.upxHandle.SetDisplaySweepGraphXAxis(SweepGraphNumber, XAxis);
        end
        function [RetVal] = SetDisplaySweepGraphXSource(self, SweepGraphNumber, XSource)
            % SetDisplaySweepGraphXSource
            % [RetVal] = SetDisplaySweepGraphXSource(self, SweepGraphNumber, XSource)
            [RetVal] = self.upxHandle.SetDisplaySweepGraphXSource(SweepGraphNumber, XSource);
        end
        function [RetVal] = SetDisplaySweepMultichannelYSource(self, SubsystemNumber, Trace, YSource)
            % SetDisplaySweepMultichannelYSource
            % [RetVal] = SetDisplaySweepMultichannelYSource(self, SubsystemNumber, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplaySweepMultichannelYSource(SubsystemNumber, Trace, YSource);
        end
        function [RetVal] = SetDisplaySweepYSource(self, SubsystemNumber, Trace, YSource)
            % SetDisplaySweepYSource
            % [RetVal] = SetDisplaySweepYSource(self, SubsystemNumber, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplaySweepYSource(SubsystemNumber, Trace, YSource);
        end
        function [RetVal] = SetDisplayTraceSelect(self, Subsystem, SubsystemNumber, Trace)
            % SetDisplayTraceSelect
            % [RetVal] = SetDisplayTraceSelect(self, Subsystem, SubsystemNumber, Trace)
            [RetVal] = self.upxHandle.SetDisplayTraceSelect(Subsystem, SubsystemNumber, Trace);
        end
        function [RetVal] = SetDisplayTraceUpdate(self, Subsystem, SubsystemNumber, Trace, TraceUpdateType)
            % SetDisplayTraceUpdate
            % [RetVal] = SetDisplayTraceUpdate(self, Subsystem, SubsystemNumber, Trace, TraceUpdateType)
            [RetVal] = self.upxHandle.SetDisplayTraceUpdate(Subsystem, SubsystemNumber, Trace, TraceUpdateType);
        end
        function [RetVal] = SetDisplayUnit(self, Subsystem, SubsystemNumber, Trace, Units)
            % SetDisplayUnit
            % [RetVal] = SetDisplayUnit(self, Subsystem, SubsystemNumber, Trace, Units)
            [RetVal] = self.upxHandle.SetDisplayUnit(Subsystem, SubsystemNumber, Trace, Units);
        end
        function [RetVal] = SetDisplayUnitAuto(self, Subsystem, SubsystemNumber, Trace, UnitAuto)
            % SetDisplayUnitAuto
            % [RetVal] = SetDisplayUnitAuto(self, Subsystem, SubsystemNumber, Trace, UnitAuto)
            [RetVal] = self.upxHandle.SetDisplayUnitAuto(Subsystem, SubsystemNumber, Trace, UnitAuto);
        end
        function [RetVal] = SetDisplayUnitFunctionTrack(self, Subsystem, SubsystemNumber, Trace, UnitFunctionTrack)
            % SetDisplayUnitFunctionTrack
            % [RetVal] = SetDisplayUnitFunctionTrack(self, Subsystem, SubsystemNumber, Trace, UnitFunctionTrack)
            [RetVal] = self.upxHandle.SetDisplayUnitFunctionTrack(Subsystem, SubsystemNumber, Trace, UnitFunctionTrack);
        end
        function [RetVal] = SetDisplayUnitUserString(self, Subsystem, SubsystemNumber, Trace, UnitUserString)
            % SetDisplayUnitUserString
            % [RetVal] = SetDisplayUnitUserString(self, Subsystem, SubsystemNumber, Trace, UnitUserString)
            [RetVal] = self.upxHandle.SetDisplayUnitUserString(Subsystem, SubsystemNumber, Trace, UnitUserString);
        end
        function [RetVal] = SetDisplayWaveformMultichannelYSource(self, Trace, YSource)
            % SetDisplayWaveformMultichannelYSource
            % [RetVal] = SetDisplayWaveformMultichannelYSource(self, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplayWaveformMultichannelYSource(Trace, YSource);
        end
        function [RetVal] = SetDisplayWaveformYSource(self, Trace, YSource)
            % SetDisplayWaveformYSource
            % [RetVal] = SetDisplayWaveformYSource(self, Trace, YSource)
            [RetVal] = self.upxHandle.SetDisplayWaveformYSource(Trace, YSource);
        end
        function [RetVal] = SetDisplayXAxisLeft(self, Subsystem, SubsystemNumber, Left, Units)
            % SetDisplayXAxisLeft
            % [RetVal] = SetDisplayXAxisLeft(self, Subsystem, SubsystemNumber, Left, Units)
            [RetVal] = self.upxHandle.SetDisplayXAxisLeft(Subsystem, SubsystemNumber, Left, Units);
        end
        function [RetVal] = SetDisplayXAxisReferenceValue(self, Subsystem, SubsystemNumber, ReferenceValue, Units)
            % SetDisplayXAxisReferenceValue
            % [RetVal] = SetDisplayXAxisReferenceValue(self, Subsystem, SubsystemNumber, ReferenceValue, Units)
            [RetVal] = self.upxHandle.SetDisplayXAxisReferenceValue(Subsystem, SubsystemNumber, ReferenceValue, Units);
        end
        function [RetVal] = SetDisplayXAxisRight(self, Subsystem, SubsystemNumber, Right, Units)
            % SetDisplayXAxisRight
            % [RetVal] = SetDisplayXAxisRight(self, Subsystem, SubsystemNumber, Right, Units)
            [RetVal] = self.upxHandle.SetDisplayXAxisRight(Subsystem, SubsystemNumber, Right, Units);
        end
        function [RetVal] = SetDisplayXAxisScaling(self, Subsystem, SubsystemNumber, Scaling)
            % SetDisplayXAxisScaling
            % [RetVal] = SetDisplayXAxisScaling(self, Subsystem, SubsystemNumber, Scaling)
            [RetVal] = self.upxHandle.SetDisplayXAxisScaling(Subsystem, SubsystemNumber, Scaling);
        end
        function [RetVal] = SetDisplayXAxisSpacing(self, Subsystem, SubsystemNumber, Spacing)
            % SetDisplayXAxisSpacing
            % [RetVal] = SetDisplayXAxisSpacing(self, Subsystem, SubsystemNumber, Spacing)
            [RetVal] = self.upxHandle.SetDisplayXAxisSpacing(Subsystem, SubsystemNumber, Spacing);
        end
        function [RetVal] = SetDisplayYAxisBottom(self, Subsystem, SubsystemNumber, Trace, Bottom, Units)
            % SetDisplayYAxisBottom
            % [RetVal] = SetDisplayYAxisBottom(self, Subsystem, SubsystemNumber, Trace, Bottom, Units)
            [RetVal] = self.upxHandle.SetDisplayYAxisBottom(Subsystem, SubsystemNumber, Trace, Bottom, Units);
        end
        function [RetVal] = SetDisplayYAxisSpacing(self, Subsystem, SubsystemNumber, Trace, Spacing)
            % SetDisplayYAxisSpacing
            % [RetVal] = SetDisplayYAxisSpacing(self, Subsystem, SubsystemNumber, Trace, Spacing)
            [RetVal] = self.upxHandle.SetDisplayYAxisSpacing(Subsystem, SubsystemNumber, Trace, Spacing);
        end
        function [RetVal] = SetDisplayYAxisTop(self, Subsystem, SubsystemNumber, Trace, Top, Units)
            % SetDisplayYAxisTop
            % [RetVal] = SetDisplayYAxisTop(self, Subsystem, SubsystemNumber, Trace, Top, Units)
            [RetVal] = self.upxHandle.SetDisplayYAxisTop(Subsystem, SubsystemNumber, Trace, Top, Units);
        end
        function [RetVal] = SetDisplayYSourceFile(self, Subsystem, SubsystemNumber, Trace, YSourceFile)
            % SetDisplayYSourceFile
            % [RetVal] = SetDisplayYSourceFile(self, Subsystem, SubsystemNumber, Trace, YSourceFile)
            [RetVal] = self.upxHandle.SetDisplayYSourceFile(Subsystem, SubsystemNumber, Trace, YSourceFile);
        end
        function [RetVal] = SetExternalSweepMinimumLevel(self, MinVolt)
            % SetExternalSweepMinimumLevel
            % [RetVal] = SetExternalSweepMinimumLevel(self, MinVolt)
            [RetVal] = self.upxHandle.SetExternalSweepMinimumLevel(MinVolt);
        end
        function [RetVal] = SetExternalSweepStartValue(self, SweepControl, Start, Units)
            % SetExternalSweepStartValue
            % [RetVal] = SetExternalSweepStartValue(self, SweepControl, Start, Units)
            [RetVal] = self.upxHandle.SetExternalSweepStartValue(SweepControl, Start, Units);
        end
        function [RetVal] = SetExternalSweepStopValue(self, SweepControl, Stop, Units)
            % SetExternalSweepStopValue
            % [RetVal] = SetExternalSweepStopValue(self, SweepControl, Stop, Units)
            [RetVal] = self.upxHandle.SetExternalSweepStopValue(SweepControl, Stop, Units);
        end
        function [RetVal] = SetExternalSweepVariation(self, SweepControl, Variation)
            % SetExternalSweepVariation
            % [RetVal] = SetExternalSweepVariation(self, SweepControl, Variation)
            [RetVal] = self.upxHandle.SetExternalSweepVariation(SweepControl, Variation);
        end
        function [RetVal] = SetFilterAttenuation(self, FilterNumber, FilterAttenuation)
            % SetFilterAttenuation
            % [RetVal] = SetFilterAttenuation(self, FilterNumber, FilterAttenuation)
            [RetVal] = self.upxHandle.SetFilterAttenuation(FilterNumber, FilterAttenuation);
        end
        function [RetVal] = SetFilterCenterFreq(self, FilterNumber, CenterFreq)
            % SetFilterCenterFreq
            % [RetVal] = SetFilterCenterFreq(self, FilterNumber, CenterFreq)
            [RetVal] = self.upxHandle.SetFilterCenterFreq(FilterNumber, CenterFreq);
        end
        function [RetVal] = SetFilterDelay(self, FilterNumber, FilterDelay)
            % SetFilterDelay
            % [RetVal] = SetFilterDelay(self, FilterNumber, FilterDelay)
            [RetVal] = self.upxHandle.SetFilterDelay(FilterNumber, FilterDelay);
        end
        function [RetVal] = SetFilterFileDefined(self, FilterNumber, FileDefFilter)
            % SetFilterFileDefined
            % [RetVal] = SetFilterFileDefined(self, FilterNumber, FileDefFilter)
            [RetVal] = self.upxHandle.SetFilterFileDefined(FilterNumber, FileDefFilter);
        end
        function [RetVal] = SetFilterOrder(self, FilterNumber, FilterOrder)
            % SetFilterOrder
            % [RetVal] = SetFilterOrder(self, FilterNumber, FilterOrder)
            [RetVal] = self.upxHandle.SetFilterOrder(FilterNumber, FilterOrder);
        end
        function [RetVal] = SetFilterPassband(self, FilterNumber, Passband)
            % SetFilterPassband
            % [RetVal] = SetFilterPassband(self, FilterNumber, Passband)
            [RetVal] = self.upxHandle.SetFilterPassband(FilterNumber, Passband);
        end
        function [RetVal] = SetFilterPassbandLow(self, FilterNumber, PassbandLow)
            % SetFilterPassbandLow
            % [RetVal] = SetFilterPassbandLow(self, FilterNumber, PassbandLow)
            [RetVal] = self.upxHandle.SetFilterPassbandLow(FilterNumber, PassbandLow);
        end
        function [RetVal] = SetFilterPassbandUpp(self, FilterNumber, PassbandUpp)
            % SetFilterPassbandUpp
            % [RetVal] = SetFilterPassbandUpp(self, FilterNumber, PassbandUpp)
            [RetVal] = self.upxHandle.SetFilterPassbandUpp(FilterNumber, PassbandUpp);
        end
        function [RetVal] = SetFilterType(self, FilterNumber, FilterType)
            % SetFilterType
            % [RetVal] = SetFilterType(self, FilterNumber, FilterType)
            [RetVal] = self.upxHandle.SetFilterType(FilterNumber, FilterType);
        end
        function [RetVal] = SetFilterWidth(self, FilterNumber, FilterWidth)
            % SetFilterWidth
            % [RetVal] = SetFilterWidth(self, FilterNumber, FilterWidth)
            [RetVal] = self.upxHandle.SetFilterWidth(FilterNumber, FilterWidth);
        end
        function [RetVal] = SetGPIBAddress(self, GPIBAddress)
            % SetGPIBAddress
            % [RetVal] = SetGPIBAddress(self, GPIBAddress)
            [RetVal] = self.upxHandle.SetGPIBAddress(GPIBAddress);
        end
        function [RetVal] = SetGeneratorAVModulationFrequency(self, ModulationFrequency, Units)
            % SetGeneratorAVModulationFrequency
            % [RetVal] = SetGeneratorAVModulationFrequency(self, ModulationFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorAVModulationFrequency(ModulationFrequency, Units);
        end
        function [RetVal] = SetGeneratorAllChannelSine(self, AllChannelSine)
            % SetGeneratorAllChannelSine
            % [RetVal] = SetGeneratorAllChannelSine(self, AllChannelSine)
            [RetVal] = self.upxHandle.SetGeneratorAllChannelSine(AllChannelSine);
        end
        function [RetVal] = SetGeneratorAmplitudeVariation(self, AmplitudeVariation)
            % SetGeneratorAmplitudeVariation
            % [RetVal] = SetGeneratorAmplitudeVariation(self, AmplitudeVariation)
            [RetVal] = self.upxHandle.SetGeneratorAmplitudeVariation(AmplitudeVariation);
        end
        function [RetVal] = SetGeneratorArbitraryShapeFile(self, ShapeFile)
            % SetGeneratorArbitraryShapeFile
            % [RetVal] = SetGeneratorArbitraryShapeFile(self, ShapeFile)
            [RetVal] = self.upxHandle.SetGeneratorArbitraryShapeFile(ShapeFile);
        end
        function [RetVal] = SetGeneratorBandwidth(self, Bandwidth)
            % SetGeneratorBandwidth
            % [RetVal] = SetGeneratorBandwidth(self, Bandwidth)
            [RetVal] = self.upxHandle.SetGeneratorBandwidth(Bandwidth);
        end
        function [RetVal] = SetGeneratorChannelMode(self, Channel)
            % SetGeneratorChannelMode
            % [RetVal] = SetGeneratorChannelMode(self, Channel)
            [RetVal] = self.upxHandle.SetGeneratorChannelMode(Channel);
        end
        function [RetVal] = SetGeneratorChannelPhaseRatio(self, PhaseCh21)
            % SetGeneratorChannelPhaseRatio
            % [RetVal] = SetGeneratorChannelPhaseRatio(self, PhaseCh21)
            [RetVal] = self.upxHandle.SetGeneratorChannelPhaseRatio(PhaseCh21);
        end
        function [RetVal] = SetGeneratorChannelVoltageRatio(self, VoltCh21)
            % SetGeneratorChannelVoltageRatio
            % [RetVal] = SetGeneratorChannelVoltageRatio(self, VoltCh21)
            [RetVal] = self.upxHandle.SetGeneratorChannelVoltageRatio(VoltCh21);
        end
        function [RetVal] = SetGeneratorCommon(self, Common)
            % SetGeneratorCommon
            % [RetVal] = SetGeneratorCommon(self, Common)
            [RetVal] = self.upxHandle.SetGeneratorCommon(Common);
        end
        function [RetVal] = SetGeneratorCrestFactor(self, CrestFactor)
            % SetGeneratorCrestFactor
            % [RetVal] = SetGeneratorCrestFactor(self, CrestFactor)
            [RetVal] = self.upxHandle.SetGeneratorCrestFactor(CrestFactor);
        end
        function [RetVal] = SetGeneratorCrestFactorValue(self, CrestFactor)
            % SetGeneratorCrestFactorValue
            % [RetVal] = SetGeneratorCrestFactorValue(self, CrestFactor)
            [RetVal] = self.upxHandle.SetGeneratorCrestFactorValue(CrestFactor);
        end
        function [RetVal] = SetGeneratorDCOffset(self, DCOffset)
            % SetGeneratorDCOffset
            % [RetVal] = SetGeneratorDCOffset(self, DCOffset)
            [RetVal] = self.upxHandle.SetGeneratorDCOffset(DCOffset);
        end
        function [RetVal] = SetGeneratorDCOffsetChannelValue(self, Channel, DCOffset, Units)
            % SetGeneratorDCOffsetChannelValue
            % [RetVal] = SetGeneratorDCOffsetChannelValue(self, Channel, DCOffset, Units)
            [RetVal] = self.upxHandle.SetGeneratorDCOffsetChannelValue(Channel, DCOffset, Units);
        end
        function [RetVal] = SetGeneratorDCOffsetCoupling(self, DCOffset)
            % SetGeneratorDCOffsetCoupling
            % [RetVal] = SetGeneratorDCOffsetCoupling(self, DCOffset)
            [RetVal] = self.upxHandle.SetGeneratorDCOffsetCoupling(DCOffset);
        end
        function [RetVal] = SetGeneratorDCOffsetValue(self, DCOffset, Units)
            % SetGeneratorDCOffsetValue
            % [RetVal] = SetGeneratorDCOffsetValue(self, DCOffset, Units)
            [RetVal] = self.upxHandle.SetGeneratorDCOffsetValue(DCOffset, Units);
        end
        function [RetVal] = SetGeneratorDFDDiffFrequency(self, DiffFrequency, Units)
            % SetGeneratorDFDDiffFrequency
            % [RetVal] = SetGeneratorDFDDiffFrequency(self, DiffFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorDFDDiffFrequency(DiffFrequency, Units);
        end
        function [RetVal] = SetGeneratorDFDMeanFrequency(self, MeanFrequency, Units)
            % SetGeneratorDFDMeanFrequency
            % [RetVal] = SetGeneratorDFDMeanFrequency(self, MeanFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorDFDMeanFrequency(MeanFrequency, Units);
        end
        function [RetVal] = SetGeneratorDIMBandwidth(self, Bandwidth)
            % SetGeneratorDIMBandwidth
            % [RetVal] = SetGeneratorDIMBandwidth(self, Bandwidth)
            [RetVal] = self.upxHandle.SetGeneratorDIMBandwidth(Bandwidth);
        end
        function [RetVal] = SetGeneratorDIMSquareToSine(self, SquareSine)
            % SetGeneratorDIMSquareToSine
            % [RetVal] = SetGeneratorDIMSquareToSine(self, SquareSine)
            [RetVal] = self.upxHandle.SetGeneratorDIMSquareToSine(SquareSine);
        end
        function [RetVal] = SetGeneratorDither(self, Dither)
            % SetGeneratorDither
            % [RetVal] = SetGeneratorDither(self, Dither)
            [RetVal] = self.upxHandle.SetGeneratorDither(Dither);
        end
        function [RetVal] = SetGeneratorDitherValue(self, Value, Units)
            % SetGeneratorDitherValue
            % [RetVal] = SetGeneratorDitherValue(self, Value, Units)
            [RetVal] = self.upxHandle.SetGeneratorDitherValue(Value, Units);
        end
        function [RetVal] = SetGeneratorEqualizer(self, Equalizer)
            % SetGeneratorEqualizer
            % [RetVal] = SetGeneratorEqualizer(self, Equalizer)
            [RetVal] = self.upxHandle.SetGeneratorEqualizer(Equalizer);
        end
        function [RetVal] = SetGeneratorEqualizerCoupling(self, Equalizer)
            % SetGeneratorEqualizerCoupling
            % [RetVal] = SetGeneratorEqualizerCoupling(self, Equalizer)
            [RetVal] = self.upxHandle.SetGeneratorEqualizerCoupling(Equalizer);
        end
        function [RetVal] = SetGeneratorEqualizerFile(self, EqualizerFile)
            % SetGeneratorEqualizerFile
            % [RetVal] = SetGeneratorEqualizerFile(self, EqualizerFile)
            [RetVal] = self.upxHandle.SetGeneratorEqualizerFile(EqualizerFile);
        end
        function [RetVal] = SetGeneratorFilter(self, Filter)
            % SetGeneratorFilter
            % [RetVal] = SetGeneratorFilter(self, Filter)
            [RetVal] = self.upxHandle.SetGeneratorFilter(Filter);
        end
        function [RetVal] = SetGeneratorFreqFile(self, FreqFile)
            % SetGeneratorFreqFile
            % [RetVal] = SetGeneratorFreqFile(self, FreqFile)
            [RetVal] = self.upxHandle.SetGeneratorFreqFile(FreqFile);
        end
        function [RetVal] = SetGeneratorFrequency(self, Channel, Frequency, Units)
            % SetGeneratorFrequency
            % [RetVal] = SetGeneratorFrequency(self, Channel, Frequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorFrequency(Channel, Frequency, Units);
        end
        function [RetVal] = SetGeneratorFrequencySpacing(self, FrequencySpacing)
            % SetGeneratorFrequencySpacing
            % [RetVal] = SetGeneratorFrequencySpacing(self, FrequencySpacing)
            [RetVal] = self.upxHandle.SetGeneratorFrequencySpacing(FrequencySpacing);
        end
        function [RetVal] = SetGeneratorFrequencySpacingValue(self, FrequencySpacingValue, Units)
            % SetGeneratorFrequencySpacingValue
            % [RetVal] = SetGeneratorFrequencySpacingValue(self, FrequencySpacingValue, Units)
            [RetVal] = self.upxHandle.SetGeneratorFrequencySpacingValue(FrequencySpacingValue, Units);
        end
        function [RetVal] = SetGeneratorFunction(self, GeneratorFunction)
            % SetGeneratorFunction
            % [RetVal] = SetGeneratorFunction(self, GeneratorFunction)
            [RetVal] = self.upxHandle.SetGeneratorFunction(GeneratorFunction);
        end
        function [RetVal] = SetGeneratorFunctionMode(self, FunctionMode)
            % SetGeneratorFunctionMode
            % [RetVal] = SetGeneratorFunctionMode(self, FunctionMode)
            [RetVal] = self.upxHandle.SetGeneratorFunctionMode(FunctionMode);
        end
        function [RetVal] = SetGeneratorImpedance(self, Impedance)
            % SetGeneratorImpedance
            % [RetVal] = SetGeneratorImpedance(self, Impedance)
            [RetVal] = self.upxHandle.SetGeneratorImpedance(Impedance);
        end
        function [RetVal] = SetGeneratorInstrument(self, Instrument)
            % SetGeneratorInstrument
            % [RetVal] = SetGeneratorInstrument(self, Instrument)
            [RetVal] = self.upxHandle.SetGeneratorInstrument(Instrument);
        end
        function [RetVal] = SetGeneratorIntervalFile(self, IntervalFile)
            % SetGeneratorIntervalFile
            % [RetVal] = SetGeneratorIntervalFile(self, IntervalFile)
            [RetVal] = self.upxHandle.SetGeneratorIntervalFile(IntervalFile);
        end
        function [RetVal] = SetGeneratorMaxVoltage(self, MaxVoltage, Units)
            % SetGeneratorMaxVoltage
            % [RetVal] = SetGeneratorMaxVoltage(self, MaxVoltage, Units)
            [RetVal] = self.upxHandle.SetGeneratorMaxVoltage(MaxVoltage, Units);
        end
        function [RetVal] = SetGeneratorModDistLevelRatio(self, VoltageLFUF)
            % SetGeneratorModDistLevelRatio
            % [RetVal] = SetGeneratorModDistLevelRatio(self, VoltageLFUF)
            [RetVal] = self.upxHandle.SetGeneratorModDistLevelRatio(VoltageLFUF);
        end
        function [RetVal] = SetGeneratorModDistLowerFrequency(self, LowerFrequency, Units)
            % SetGeneratorModDistLowerFrequency
            % [RetVal] = SetGeneratorModDistLowerFrequency(self, LowerFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorModDistLowerFrequency(LowerFrequency, Units);
        end
        function [RetVal] = SetGeneratorModDistUpperFrequency(self, UpperFrequency, Units)
            % SetGeneratorModDistUpperFrequency
            % [RetVal] = SetGeneratorModDistUpperFrequency(self, UpperFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorModDistUpperFrequency(UpperFrequency, Units);
        end
        function [RetVal] = SetGeneratorModulationCarrierFrequency(self, CarrierFrequency, Units)
            % SetGeneratorModulationCarrierFrequency
            % [RetVal] = SetGeneratorModulationCarrierFrequency(self, CarrierFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorModulationCarrierFrequency(CarrierFrequency, Units);
        end
        function [RetVal] = SetGeneratorModulationCarrierVoltage(self, CarrierVoltage, Units)
            % SetGeneratorModulationCarrierVoltage
            % [RetVal] = SetGeneratorModulationCarrierVoltage(self, CarrierVoltage, Units)
            [RetVal] = self.upxHandle.SetGeneratorModulationCarrierVoltage(CarrierVoltage, Units);
        end
        function [RetVal] = SetGeneratorModulationDepth(self, ModulationDepth)
            % SetGeneratorModulationDepth
            % [RetVal] = SetGeneratorModulationDepth(self, ModulationDepth)
            [RetVal] = self.upxHandle.SetGeneratorModulationDepth(ModulationDepth);
        end
        function [RetVal] = SetGeneratorModulationDeviation(self, Deviation)
            % SetGeneratorModulationDeviation
            % [RetVal] = SetGeneratorModulationDeviation(self, Deviation)
            [RetVal] = self.upxHandle.SetGeneratorModulationDeviation(Deviation);
        end
        function [RetVal] = SetGeneratorModulationFrequency(self, ModulationFrequency, Units)
            % SetGeneratorModulationFrequency
            % [RetVal] = SetGeneratorModulationFrequency(self, ModulationFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorModulationFrequency(ModulationFrequency, Units);
        end
        function [RetVal] = SetGeneratorMultichannelAllChanSine(self, Channel, AllChanSine)
            % SetGeneratorMultichannelAllChanSine
            % [RetVal] = SetGeneratorMultichannelAllChanSine(self, Channel, AllChanSine)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelAllChanSine(Channel, AllChanSine);
        end
        function [RetVal] = SetGeneratorMultichannelDCOffset(self, Channel, DCOffset)
            % SetGeneratorMultichannelDCOffset
            % [RetVal] = SetGeneratorMultichannelDCOffset(self, Channel, DCOffset)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelDCOffset(Channel, DCOffset);
        end
        function [RetVal] = SetGeneratorMultichannelDCOffsetValue(self, Channel, DCOffset, Units)
            % SetGeneratorMultichannelDCOffsetValue
            % [RetVal] = SetGeneratorMultichannelDCOffsetValue(self, Channel, DCOffset, Units)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelDCOffsetValue(Channel, DCOffset, Units);
        end
        function [RetVal] = SetGeneratorMultichannelFilter(self, Channel, Filter)
            % SetGeneratorMultichannelFilter
            % [RetVal] = SetGeneratorMultichannelFilter(self, Channel, Filter)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelFilter(Channel, Filter);
        end
        function [RetVal] = SetGeneratorMultichannelGain(self, Channel, Gain)
            % SetGeneratorMultichannelGain
            % [RetVal] = SetGeneratorMultichannelGain(self, Channel, Gain)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelGain(Channel, Gain);
        end
        function [RetVal] = SetGeneratorMultichannelLimitToFS(self, Channel, LimitToFS)
            % SetGeneratorMultichannelLimitToFS
            % [RetVal] = SetGeneratorMultichannelLimitToFS(self, Channel, LimitToFS)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelLimitToFS(Channel, LimitToFS);
        end
        function [RetVal] = SetGeneratorMultichannelSine(self, Channel, AddToChannel)
            % SetGeneratorMultichannelSine
            % [RetVal] = SetGeneratorMultichannelSine(self, Channel, AddToChannel)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSine(Channel, AddToChannel);
        end
        function [RetVal] = SetGeneratorMultichannelSineArbitrary(self, Channel, Arbitrary)
            % SetGeneratorMultichannelSineArbitrary
            % [RetVal] = SetGeneratorMultichannelSineArbitrary(self, Channel, Arbitrary)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSineArbitrary(Channel, Arbitrary);
        end
        function [RetVal] = SetGeneratorMultichannelSineArbitraryFilename(self, Channel, ArbitraryFile)
            % SetGeneratorMultichannelSineArbitraryFilename
            % [RetVal] = SetGeneratorMultichannelSineArbitraryFilename(self, Channel, ArbitraryFile)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSineArbitraryFilename(Channel, ArbitraryFile);
        end
        function [RetVal] = SetGeneratorMultichannelSineEqualizer(self, Channel, Equalizer)
            % SetGeneratorMultichannelSineEqualizer
            % [RetVal] = SetGeneratorMultichannelSineEqualizer(self, Channel, Equalizer)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSineEqualizer(Channel, Equalizer);
        end
        function [RetVal] = SetGeneratorMultichannelSineEqualizerFilename(self, Channel, EqualFile)
            % SetGeneratorMultichannelSineEqualizerFilename
            % [RetVal] = SetGeneratorMultichannelSineEqualizerFilename(self, Channel, EqualFile)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSineEqualizerFilename(Channel, EqualFile);
        end
        function [RetVal] = SetGeneratorMultichannelSineFrequency(self, Channel, SineFrequency, Units)
            % SetGeneratorMultichannelSineFrequency
            % [RetVal] = SetGeneratorMultichannelSineFrequency(self, Channel, SineFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSineFrequency(Channel, SineFrequency, Units);
        end
        function [RetVal] = SetGeneratorMultichannelSinePhase(self, Channel, SinePhase, Units)
            % SetGeneratorMultichannelSinePhase
            % [RetVal] = SetGeneratorMultichannelSinePhase(self, Channel, SinePhase, Units)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSinePhase(Channel, SinePhase, Units);
        end
        function [RetVal] = SetGeneratorMultichannelSineVoltPeak(self, Channel, VoltPeak, Units)
            % SetGeneratorMultichannelSineVoltPeak
            % [RetVal] = SetGeneratorMultichannelSineVoltPeak(self, Channel, VoltPeak, Units)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSineVoltPeak(Channel, VoltPeak, Units);
        end
        function [RetVal] = SetGeneratorMultichannelSineVoltage(self, Channel, SineVoltage, Units)
            % SetGeneratorMultichannelSineVoltage
            % [RetVal] = SetGeneratorMultichannelSineVoltage(self, Channel, SineVoltage, Units)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelSineVoltage(Channel, SineVoltage, Units);
        end
        function [RetVal] = SetGeneratorMultichannelTotalGain(self, Channel, TotalGain)
            % SetGeneratorMultichannelTotalGain
            % [RetVal] = SetGeneratorMultichannelTotalGain(self, Channel, TotalGain)
            [RetVal] = self.upxHandle.SetGeneratorMultichannelTotalGain(Channel, TotalGain);
        end
        function [RetVal] = SetGeneratorMultisineNoOfSine(self, NoofSine)
            % SetGeneratorMultisineNoOfSine
            % [RetVal] = SetGeneratorMultisineNoOfSine(self, NoofSine)
            [RetVal] = self.upxHandle.SetGeneratorMultisineNoOfSine(NoofSine);
        end
        function [RetVal] = SetGeneratorMultisinePhaseNoi(self, Number, PhaseNoi, Units)
            % SetGeneratorMultisinePhaseNoi
            % [RetVal] = SetGeneratorMultisinePhaseNoi(self, Number, PhaseNoi, Units)
            [RetVal] = self.upxHandle.SetGeneratorMultisinePhaseNoi(Number, PhaseNoi, Units);
        end
        function [RetVal] = SetGeneratorMultisineTotalGain(self, TotalGain)
            % SetGeneratorMultisineTotalGain
            % [RetVal] = SetGeneratorMultisineTotalGain(self, TotalGain)
            [RetVal] = self.upxHandle.SetGeneratorMultisineTotalGain(TotalGain);
        end
        function [RetVal] = SetGeneratorOnTimeFile(self, OnTimeFile)
            % SetGeneratorOnTimeFile
            % [RetVal] = SetGeneratorOnTimeFile(self, OnTimeFile)
            [RetVal] = self.upxHandle.SetGeneratorOnTimeFile(OnTimeFile);
        end
        function [RetVal] = SetGeneratorOutputState(self, State)
            % SetGeneratorOutputState
            % [RetVal] = SetGeneratorOutputState(self, State)
            [RetVal] = self.upxHandle.SetGeneratorOutputState(State);
        end
        function [RetVal] = SetGeneratorOutputType(self, OutputType)
            % SetGeneratorOutputType
            % [RetVal] = SetGeneratorOutputType(self, OutputType)
            [RetVal] = self.upxHandle.SetGeneratorOutputType(OutputType);
        end
        function [RetVal] = SetGeneratorPDF(self, PDF)
            % SetGeneratorPDF
            % [RetVal] = SetGeneratorPDF(self, PDF)
            [RetVal] = self.upxHandle.SetGeneratorPDF(PDF);
        end
        function [RetVal] = SetGeneratorPhaseFile(self, PhaseFile)
            % SetGeneratorPhaseFile
            % [RetVal] = SetGeneratorPhaseFile(self, PhaseFile)
            [RetVal] = self.upxHandle.SetGeneratorPhaseFile(PhaseFile);
        end
        function [RetVal] = SetGeneratorPlayAnalyzerLoopChannel(self, LoopChannel)
            % SetGeneratorPlayAnalyzerLoopChannel
            % [RetVal] = SetGeneratorPlayAnalyzerLoopChannel(self, LoopChannel)
            [RetVal] = self.upxHandle.SetGeneratorPlayAnalyzerLoopChannel(LoopChannel);
        end
        function [RetVal] = SetGeneratorPlayAnalyzerLoopGain(self, LoopGain, Units)
            % SetGeneratorPlayAnalyzerLoopGain
            % [RetVal] = SetGeneratorPlayAnalyzerLoopGain(self, LoopGain, Units)
            [RetVal] = self.upxHandle.SetGeneratorPlayAnalyzerLoopGain(LoopGain, Units);
        end
        function [RetVal] = SetGeneratorPlayChannel(self, Channel)
            % SetGeneratorPlayChannel
            % [RetVal] = SetGeneratorPlayChannel(self, Channel)
            [RetVal] = self.upxHandle.SetGeneratorPlayChannel(Channel);
        end
        function [RetVal] = SetGeneratorPlayMode(self, Mode)
            % SetGeneratorPlayMode
            % [RetVal] = SetGeneratorPlayMode(self, Mode)
            [RetVal] = self.upxHandle.SetGeneratorPlayMode(Mode);
        end
        function [RetVal] = SetGeneratorPlayRestart(self, Restart)
            % SetGeneratorPlayRestart
            % [RetVal] = SetGeneratorPlayRestart(self, Restart)
            [RetVal] = self.upxHandle.SetGeneratorPlayRestart(Restart);
        end
        function [RetVal] = SetGeneratorPlayScalePkToFS(self, ScalePkToFS)
            % SetGeneratorPlayScalePkToFS
            % [RetVal] = SetGeneratorPlayScalePkToFS(self, ScalePkToFS)
            [RetVal] = self.upxHandle.SetGeneratorPlayScalePkToFS(ScalePkToFS);
        end
        function [RetVal] = SetGeneratorPlayShapeFile(self, ShapeFile)
            % SetGeneratorPlayShapeFile
            % [RetVal] = SetGeneratorPlayShapeFile(self, ShapeFile)
            [RetVal] = self.upxHandle.SetGeneratorPlayShapeFile(ShapeFile);
        end
        function [RetVal] = SetGeneratorPlayTime(self, Time)
            % SetGeneratorPlayTime
            % [RetVal] = SetGeneratorPlayTime(self, Time)
            [RetVal] = self.upxHandle.SetGeneratorPlayTime(Time);
        end
        function [RetVal] = SetGeneratorRandomDomain(self, Domain)
            % SetGeneratorRandomDomain
            % [RetVal] = SetGeneratorRandomDomain(self, Domain)
            [RetVal] = self.upxHandle.SetGeneratorRandomDomain(Domain);
        end
        function [RetVal] = SetGeneratorRandomLowerFrequency(self, LowerFrequency, Units)
            % SetGeneratorRandomLowerFrequency
            % [RetVal] = SetGeneratorRandomLowerFrequency(self, LowerFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorRandomLowerFrequency(LowerFrequency, Units);
        end
        function [RetVal] = SetGeneratorRandomShape(self, Shape)
            % SetGeneratorRandomShape
            % [RetVal] = SetGeneratorRandomShape(self, Shape)
            [RetVal] = self.upxHandle.SetGeneratorRandomShape(Shape);
        end
        function [RetVal] = SetGeneratorRandomShapeFile(self, ShapeFile)
            % SetGeneratorRandomShapeFile
            % [RetVal] = SetGeneratorRandomShapeFile(self, ShapeFile)
            [RetVal] = self.upxHandle.SetGeneratorRandomShapeFile(ShapeFile);
        end
        function [RetVal] = SetGeneratorRandomUpperFrequency(self, UpperFrequency, Units)
            % SetGeneratorRandomUpperFrequency
            % [RetVal] = SetGeneratorRandomUpperFrequency(self, UpperFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorRandomUpperFrequency(UpperFrequency, Units);
        end
        function [RetVal] = SetGeneratorRefFrequency(self, RefFrequency, Units)
            % SetGeneratorRefFrequency
            % [RetVal] = SetGeneratorRefFrequency(self, RefFrequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorRefFrequency(RefFrequency, Units);
        end
        function [RetVal] = SetGeneratorRefVoltage(self, RefVoltage, Units)
            % SetGeneratorRefVoltage
            % [RetVal] = SetGeneratorRefVoltage(self, RefVoltage, Units)
            [RetVal] = self.upxHandle.SetGeneratorRefVoltage(RefVoltage, Units);
        end
        function [RetVal] = SetGeneratorSineBurstInterval(self, Interval, Units)
            % SetGeneratorSineBurstInterval
            % [RetVal] = SetGeneratorSineBurstInterval(self, Interval, Units)
            [RetVal] = self.upxHandle.SetGeneratorSineBurstInterval(Interval, Units);
        end
        function [RetVal] = SetGeneratorSineBurstLowLevel(self, LowLevel, Units)
            % SetGeneratorSineBurstLowLevel
            % [RetVal] = SetGeneratorSineBurstLowLevel(self, LowLevel, Units)
            [RetVal] = self.upxHandle.SetGeneratorSineBurstLowLevel(LowLevel, Units);
        end
        function [RetVal] = SetGeneratorSineBurstOnDelay(self, BurstonDelay, Units)
            % SetGeneratorSineBurstOnDelay
            % [RetVal] = SetGeneratorSineBurstOnDelay(self, BurstonDelay, Units)
            [RetVal] = self.upxHandle.SetGeneratorSineBurstOnDelay(BurstonDelay, Units);
        end
        function [RetVal] = SetGeneratorSineBurstOnTime(self, OnTime, Units)
            % SetGeneratorSineBurstOnTime
            % [RetVal] = SetGeneratorSineBurstOnTime(self, OnTime, Units)
            [RetVal] = self.upxHandle.SetGeneratorSineBurstOnTime(OnTime, Units);
        end
        function [RetVal] = SetGeneratorSineFrequency(self, Frequency, Units)
            % SetGeneratorSineFrequency
            % [RetVal] = SetGeneratorSineFrequency(self, Frequency, Units)
            [RetVal] = self.upxHandle.SetGeneratorSineFrequency(Frequency, Units);
        end
        function [RetVal] = SetGeneratorSineLowDistortion(self, LowDistortion)
            % SetGeneratorSineLowDistortion
            % [RetVal] = SetGeneratorSineLowDistortion(self, LowDistortion)
            [RetVal] = self.upxHandle.SetGeneratorSineLowDistortion(LowDistortion);
        end
        function [RetVal] = SetGeneratorSineVoltage(self, Voltage, Units)
            % SetGeneratorSineVoltage
            % [RetVal] = SetGeneratorSineVoltage(self, Voltage, Units)
            [RetVal] = self.upxHandle.SetGeneratorSineVoltage(Voltage, Units);
        end
        function [RetVal] = SetGeneratorSingleChannel(self, Channel)
            % SetGeneratorSingleChannel
            % [RetVal] = SetGeneratorSingleChannel(self, Channel)
            [RetVal] = self.upxHandle.SetGeneratorSingleChannel(Channel);
        end
        function [RetVal] = SetGeneratorSingleChannelTrackToOtherChannel(self, TrackToOtherChannel)
            % SetGeneratorSingleChannelTrackToOtherChannel
            % [RetVal] = SetGeneratorSingleChannelTrackToOtherChannel(self, TrackToOtherChannel)
            [RetVal] = self.upxHandle.SetGeneratorSingleChannelTrackToOtherChannel(TrackToOtherChannel);
        end
        function [RetVal] = SetGeneratorStereoChannelFilter(self, Filter)
            % SetGeneratorStereoChannelFilter
            % [RetVal] = SetGeneratorStereoChannelFilter(self, Filter)
            [RetVal] = self.upxHandle.SetGeneratorStereoChannelFilter(Filter);
        end
        function [RetVal] = SetGeneratorStereoChannelFilterCoupling(self, Filter)
            % SetGeneratorStereoChannelFilterCoupling
            % [RetVal] = SetGeneratorStereoChannelFilterCoupling(self, Filter)
            [RetVal] = self.upxHandle.SetGeneratorStereoChannelFilterCoupling(Filter);
        end
        function [RetVal] = SetGeneratorStereoEqualizer(self, Equalizer)
            % SetGeneratorStereoEqualizer
            % [RetVal] = SetGeneratorStereoEqualizer(self, Equalizer)
            [RetVal] = self.upxHandle.SetGeneratorStereoEqualizer(Equalizer);
        end
        function [RetVal] = SetGeneratorStereoEqualizerFile(self, EqualFile)
            % SetGeneratorStereoEqualizerFile
            % [RetVal] = SetGeneratorStereoEqualizerFile(self, EqualFile)
            [RetVal] = self.upxHandle.SetGeneratorStereoEqualizerFile(EqualFile);
        end
        function [RetVal] = SetGeneratorStereoFrequencyCh2(self, FrequencyCh2, Units)
            % SetGeneratorStereoFrequencyCh2
            % [RetVal] = SetGeneratorStereoFrequencyCh2(self, FrequencyCh2, Units)
            [RetVal] = self.upxHandle.SetGeneratorStereoFrequencyCh2(FrequencyCh2, Units);
        end
        function [RetVal] = SetGeneratorStereoFrequencyMode(self, FrequencyMode)
            % SetGeneratorStereoFrequencyMode
            % [RetVal] = SetGeneratorStereoFrequencyMode(self, FrequencyMode)
            [RetVal] = self.upxHandle.SetGeneratorStereoFrequencyMode(FrequencyMode);
        end
        function [RetVal] = SetGeneratorStereoVoltageCh2(self, VoltageCh2, Units)
            % SetGeneratorStereoVoltageCh2
            % [RetVal] = SetGeneratorStereoVoltageCh2(self, VoltageCh2, Units)
            [RetVal] = self.upxHandle.SetGeneratorStereoVoltageCh2(VoltageCh2, Units);
        end
        function [RetVal] = SetGeneratorStereoVoltageMode(self, VoltageMode)
            % SetGeneratorStereoVoltageMode
            % [RetVal] = SetGeneratorStereoVoltageMode(self, VoltageMode)
            [RetVal] = self.upxHandle.SetGeneratorStereoVoltageMode(VoltageMode);
        end
        function [RetVal] = SetGeneratorSweepCtrl(self, SweepCtrl)
            % SetGeneratorSweepCtrl
            % [RetVal] = SetGeneratorSweepCtrl(self, SweepCtrl)
            [RetVal] = self.upxHandle.SetGeneratorSweepCtrl(SweepCtrl);
        end
        function [RetVal] = SetGeneratorSweepDwellFile(self, DwellFile)
            % SetGeneratorSweepDwellFile
            % [RetVal] = SetGeneratorSweepDwellFile(self, DwellFile)
            [RetVal] = self.upxHandle.SetGeneratorSweepDwellFile(DwellFile);
        end
        function [RetVal] = SetGeneratorSweepDwellTime(self, Dwell, Units)
            % SetGeneratorSweepDwellTime
            % [RetVal] = SetGeneratorSweepDwellTime(self, Dwell, Units)
            [RetVal] = self.upxHandle.SetGeneratorSweepDwellTime(Dwell, Units);
        end
        function [RetVal] = SetGeneratorSweepHalt(self, Axis, Halt, HaltValue, Units)
            % SetGeneratorSweepHalt
            % [RetVal] = SetGeneratorSweepHalt(self, Axis, Halt, HaltValue, Units)
            [RetVal] = self.upxHandle.SetGeneratorSweepHalt(Axis, Halt, HaltValue, Units);
        end
        function [RetVal] = SetGeneratorSweepNextStep(self, NextStep)
            % SetGeneratorSweepNextStep
            % [RetVal] = SetGeneratorSweepNextStep(self, NextStep)
            [RetVal] = self.upxHandle.SetGeneratorSweepNextStep(NextStep);
        end
        function [RetVal] = SetGeneratorSweepPoints(self, Axis, Points)
            % SetGeneratorSweepPoints
            % [RetVal] = SetGeneratorSweepPoints(self, Axis, Points)
            [RetVal] = self.upxHandle.SetGeneratorSweepPoints(Axis, Points);
        end
        function [RetVal] = SetGeneratorSweepSpacing(self, Axis, Spacing)
            % SetGeneratorSweepSpacing
            % [RetVal] = SetGeneratorSweepSpacing(self, Axis, Spacing)
            [RetVal] = self.upxHandle.SetGeneratorSweepSpacing(Axis, Spacing);
        end
        function [RetVal] = SetGeneratorSweepStart(self, Axis, Start, Units)
            % SetGeneratorSweepStart
            % [RetVal] = SetGeneratorSweepStart(self, Axis, Start, Units)
            [RetVal] = self.upxHandle.SetGeneratorSweepStart(Axis, Start, Units);
        end
        function [RetVal] = SetGeneratorSweepSteps(self, Axis, Steps, Units)
            % SetGeneratorSweepSteps
            % [RetVal] = SetGeneratorSweepSteps(self, Axis, Steps, Units)
            [RetVal] = self.upxHandle.SetGeneratorSweepSteps(Axis, Steps, Units);
        end
        function [RetVal] = SetGeneratorSweepStop(self, Axis, Stop, Units)
            % SetGeneratorSweepStop
            % [RetVal] = SetGeneratorSweepStop(self, Axis, Stop, Units)
            [RetVal] = self.upxHandle.SetGeneratorSweepStop(Axis, Stop, Units);
        end
        function [RetVal] = SetGeneratorSweepXAxis(self, XAxis)
            % SetGeneratorSweepXAxis
            % [RetVal] = SetGeneratorSweepXAxis(self, XAxis)
            [RetVal] = self.upxHandle.SetGeneratorSweepXAxis(XAxis);
        end
        function [RetVal] = SetGeneratorSweepZAxis(self, ZAxis)
            % SetGeneratorSweepZAxis
            % [RetVal] = SetGeneratorSweepZAxis(self, ZAxis)
            [RetVal] = self.upxHandle.SetGeneratorSweepZAxis(ZAxis);
        end
        function [RetVal] = SetGeneratorTotVoltFile(self, VoltFile)
            % SetGeneratorTotVoltFile
            % [RetVal] = SetGeneratorTotVoltFile(self, VoltFile)
            [RetVal] = self.upxHandle.SetGeneratorTotVoltFile(VoltFile);
        end
        function [RetVal] = SetGeneratorTotalVoltage(self, VoltageValue, Units)
            % SetGeneratorTotalVoltage
            % [RetVal] = SetGeneratorTotalVoltage(self, VoltageValue, Units)
            [RetVal] = self.upxHandle.SetGeneratorTotalVoltage(VoltageValue, Units);
        end
        function [RetVal] = SetGeneratorVariation(self, Variation)
            % SetGeneratorVariation
            % [RetVal] = SetGeneratorVariation(self, Variation)
            [RetVal] = self.upxHandle.SetGeneratorVariation(Variation);
        end
        function [RetVal] = SetGeneratorVoltage(self, Channel, Voltage, Units)
            % SetGeneratorVoltage
            % [RetVal] = SetGeneratorVoltage(self, Channel, Voltage, Units)
            [RetVal] = self.upxHandle.SetGeneratorVoltage(Channel, Voltage, Units);
        end
        function [RetVal] = SetGeneratorVoltageRMS(self, VoltageRMS, Units)
            % SetGeneratorVoltageRMS
            % [RetVal] = SetGeneratorVoltageRMS(self, VoltageRMS, Units)
            [RetVal] = self.upxHandle.SetGeneratorVoltageRMS(VoltageRMS, Units);
        end
        function [RetVal] = SetGeneratorVoltageRange(self, VoltRange)
            % SetGeneratorVoltageRange
            % [RetVal] = SetGeneratorVoltageRange(self, VoltRange)
            [RetVal] = self.upxHandle.SetGeneratorVoltageRange(VoltRange);
        end
        function [RetVal] = SetHDMIAnalyzerAudioChannel(self, Channel)
            % SetHDMIAnalyzerAudioChannel
            % [RetVal] = SetHDMIAnalyzerAudioChannel(self, Channel)
            [RetVal] = self.upxHandle.SetHDMIAnalyzerAudioChannel(Channel);
        end
        function [RetVal] = SetHDMIAnalyzerAudioCoding(self, AudioCoding)
            % SetHDMIAnalyzerAudioCoding
            % [RetVal] = SetHDMIAnalyzerAudioCoding(self, AudioCoding)
            [RetVal] = self.upxHandle.SetHDMIAnalyzerAudioCoding(AudioCoding);
        end
        function [RetVal] = SetHDMIAnalyzerAudioInput(self, Input)
            % SetHDMIAnalyzerAudioInput
            % [RetVal] = SetHDMIAnalyzerAudioInput(self, Input)
            [RetVal] = self.upxHandle.SetHDMIAnalyzerAudioInput(Input);
        end
        function [RetVal] = SetHDMIAnalyzerAudioMeasChannelState(self, MeasChannel, State)
            % SetHDMIAnalyzerAudioMeasChannelState
            % [RetVal] = SetHDMIAnalyzerAudioMeasChannelState(self, MeasChannel, State)
            [RetVal] = self.upxHandle.SetHDMIAnalyzerAudioMeasChannelState(MeasChannel, State);
        end
        function [RetVal] = SetHDMIGeneratorAudioFormat(self, AudioFormat)
            % SetHDMIGeneratorAudioFormat
            % [RetVal] = SetHDMIGeneratorAudioFormat(self, AudioFormat)
            [RetVal] = self.upxHandle.SetHDMIGeneratorAudioFormat(AudioFormat);
        end
        function [RetVal] = SetHDMIGeneratorAudioSinkARC(self, SinkARC)
            % SetHDMIGeneratorAudioSinkARC
            % [RetVal] = SetHDMIGeneratorAudioSinkARC(self, SinkARC)
            [RetVal] = self.upxHandle.SetHDMIGeneratorAudioSinkARC(SinkARC);
        end
        function [RetVal] = SetHDMIGeneratorChannelsMode(self, MeasChannel, GenChannels)
            % SetHDMIGeneratorChannelsMode
            % [RetVal] = SetHDMIGeneratorChannelsMode(self, MeasChannel, GenChannels)
            [RetVal] = self.upxHandle.SetHDMIGeneratorChannelsMode(MeasChannel, GenChannels);
        end
        function [RetVal] = SetHDMIGeneratorVideoColorDepth(self, ColorDepth)
            % SetHDMIGeneratorVideoColorDepth
            % [RetVal] = SetHDMIGeneratorVideoColorDepth(self, ColorDepth)
            [RetVal] = self.upxHandle.SetHDMIGeneratorVideoColorDepth(ColorDepth);
        end
        function [RetVal] = SetHDMIGeneratorVideoContent(self, Content)
            % SetHDMIGeneratorVideoContent
            % [RetVal] = SetHDMIGeneratorVideoContent(self, Content)
            [RetVal] = self.upxHandle.SetHDMIGeneratorVideoContent(Content);
        end
        function [RetVal] = SetHDMIGeneratorVideoFormatFrequency(self, FormatFrequency)
            % SetHDMIGeneratorVideoFormatFrequency
            % [RetVal] = SetHDMIGeneratorVideoFormatFrequency(self, FormatFrequency)
            [RetVal] = self.upxHandle.SetHDMIGeneratorVideoFormatFrequency(FormatFrequency);
        end
        function [RetVal] = SetHDMIGeneratorVideoFormatResolution(self, FormatResolution)
            % SetHDMIGeneratorVideoFormatResolution
            % [RetVal] = SetHDMIGeneratorVideoFormatResolution(self, FormatResolution)
            [RetVal] = self.upxHandle.SetHDMIGeneratorVideoFormatResolution(FormatResolution);
        end
        function [RetVal] = SetHDMIGeneratorVideoSource(self, Source)
            % SetHDMIGeneratorVideoSource
            % [RetVal] = SetHDMIGeneratorVideoSource(self, Source)
            [RetVal] = self.upxHandle.SetHDMIGeneratorVideoSource(Source);
        end
        function [RetVal] = SetHardcopyDefineFooter(self, DefineFooter)
            % SetHardcopyDefineFooter
            % [RetVal] = SetHardcopyDefineFooter(self, DefineFooter)
            [RetVal] = self.upxHandle.SetHardcopyDefineFooter(DefineFooter);
        end
        function [RetVal] = SetHardcopyDefineHeader(self, DefineHeader)
            % SetHardcopyDefineHeader
            % [RetVal] = SetHardcopyDefineHeader(self, DefineHeader)
            [RetVal] = self.upxHandle.SetHardcopyDefineHeader(DefineHeader);
        end
        function [RetVal] = SetHardcopyDestination(self, Destination)
            % SetHardcopyDestination
            % [RetVal] = SetHardcopyDestination(self, Destination)
            [RetVal] = self.upxHandle.SetHardcopyDestination(Destination);
        end
        function [RetVal] = SetHardcopyFileName(self, FileName)
            % SetHardcopyFileName
            % [RetVal] = SetHardcopyFileName(self, FileName)
            [RetVal] = self.upxHandle.SetHardcopyFileName(FileName);
        end
        function [RetVal] = SetHardcopyHeaderFooterState(self, HeaderFooter)
            % SetHardcopyHeaderFooterState
            % [RetVal] = SetHardcopyHeaderFooterState(self, HeaderFooter)
            [RetVal] = self.upxHandle.SetHardcopyHeaderFooterState(HeaderFooter);
        end
        function [RetVal] = SetHardcopyOrientation(self, Orientation)
            % SetHardcopyOrientation
            % [RetVal] = SetHardcopyOrientation(self, Orientation)
            [RetVal] = self.upxHandle.SetHardcopyOrientation(Orientation);
        end
        function [RetVal] = SetHardcopySize(self, Size)
            % SetHardcopySize
            % [RetVal] = SetHardcopySize(self, Size)
            [RetVal] = self.upxHandle.SetHardcopySize(Size);
        end
        function [RetVal] = SetHardcopySource(self, Source)
            % SetHardcopySource
            % [RetVal] = SetHardcopySource(self, Source)
            [RetVal] = self.upxHandle.SetHardcopySource(Source);
        end
        function [RetVal] = SetHardcopyStoreMode(self, StoreMode)
            % SetHardcopyStoreMode
            % [RetVal] = SetHardcopyStoreMode(self, StoreMode)
            [RetVal] = self.upxHandle.SetHardcopyStoreMode(StoreMode);
        end
        function [RetVal] = SetI2SAnalyzerChannelMode(self, ChannelMode)
            % SetI2SAnalyzerChannelMode
            % [RetVal] = SetI2SAnalyzerChannelMode(self, ChannelMode)
            [RetVal] = self.upxHandle.SetI2SAnalyzerChannelMode(ChannelMode);
        end
        function [RetVal] = SetI2SAnalyzerFormat(self, Format)
            % SetI2SAnalyzerFormat
            % [RetVal] = SetI2SAnalyzerFormat(self, Format)
            [RetVal] = self.upxHandle.SetI2SAnalyzerFormat(Format);
        end
        function [RetVal] = SetI2SAnalyzerFsyncSlope(self, FsyncSlope)
            % SetI2SAnalyzerFsyncSlope
            % [RetVal] = SetI2SAnalyzerFsyncSlope(self, FsyncSlope)
            [RetVal] = self.upxHandle.SetI2SAnalyzerFsyncSlope(FsyncSlope);
        end
        function [RetVal] = SetI2SAnalyzerInput(self, Input)
            % SetI2SAnalyzerInput
            % [RetVal] = SetI2SAnalyzerInput(self, Input)
            [RetVal] = self.upxHandle.SetI2SAnalyzerInput(Input);
        end
        function [RetVal] = SetI2SAnalyzerSampleFrequency(self, SampleFrequency, SampleFrequencyValue)
            % SetI2SAnalyzerSampleFrequency
            % [RetVal] = SetI2SAnalyzerSampleFrequency(self, SampleFrequency, SampleFrequencyValue)
            [RetVal] = self.upxHandle.SetI2SAnalyzerSampleFrequency(SampleFrequency, SampleFrequencyValue);
        end
        function [RetVal] = SetI2SAnalyzerWordLength(self, WordLength)
            % SetI2SAnalyzerWordLength
            % [RetVal] = SetI2SAnalyzerWordLength(self, WordLength)
            [RetVal] = self.upxHandle.SetI2SAnalyzerWordLength(WordLength);
        end
        function [RetVal] = SetI2SAnalyzerWordOffset(self, WordOffset)
            % SetI2SAnalyzerWordOffset
            % [RetVal] = SetI2SAnalyzerWordOffset(self, WordOffset)
            [RetVal] = self.upxHandle.SetI2SAnalyzerWordOffset(WordOffset);
        end
        function [RetVal] = SetI2SGeneratorAudioBits(self, AudioBits)
            % SetI2SGeneratorAudioBits
            % [RetVal] = SetI2SGeneratorAudioBits(self, AudioBits)
            [RetVal] = self.upxHandle.SetI2SGeneratorAudioBits(AudioBits);
        end
        function [RetVal] = SetI2SGeneratorFormat(self, Format)
            % SetI2SGeneratorFormat
            % [RetVal] = SetI2SGeneratorFormat(self, Format)
            [RetVal] = self.upxHandle.SetI2SGeneratorFormat(Format);
        end
        function [RetVal] = SetI2SGeneratorFsyncPolarity(self, FsyncPolarity)
            % SetI2SGeneratorFsyncPolarity
            % [RetVal] = SetI2SGeneratorFsyncPolarity(self, FsyncPolarity)
            [RetVal] = self.upxHandle.SetI2SGeneratorFsyncPolarity(FsyncPolarity);
        end
        function [RetVal] = SetI2SGeneratorFsyncShape(self, FsyncShape)
            % SetI2SGeneratorFsyncShape
            % [RetVal] = SetI2SGeneratorFsyncShape(self, FsyncShape)
            [RetVal] = self.upxHandle.SetI2SGeneratorFsyncShape(FsyncShape);
        end
        function [RetVal] = SetI2SGeneratorMClkRatio(self, MClkRatio)
            % SetI2SGeneratorMClkRatio
            % [RetVal] = SetI2SGeneratorMClkRatio(self, MClkRatio)
            [RetVal] = self.upxHandle.SetI2SGeneratorMClkRatio(MClkRatio);
        end
        function [RetVal] = SetI2SGeneratorSampleFrequency(self, SampleFrequency, VariableSampleFrequency)
            % SetI2SGeneratorSampleFrequency
            % [RetVal] = SetI2SGeneratorSampleFrequency(self, SampleFrequency, VariableSampleFrequency)
            [RetVal] = self.upxHandle.SetI2SGeneratorSampleFrequency(SampleFrequency, VariableSampleFrequency);
        end
        function [RetVal] = SetI2SGeneratorSyncTo(self, SyncTo)
            % SetI2SGeneratorSyncTo
            % [RetVal] = SetI2SGeneratorSyncTo(self, SyncTo)
            [RetVal] = self.upxHandle.SetI2SGeneratorSyncTo(SyncTo);
        end
        function [RetVal] = SetI2SGeneratorWordLength(self, WordLength)
            % SetI2SGeneratorWordLength
            % [RetVal] = SetI2SGeneratorWordLength(self, WordLength)
            [RetVal] = self.upxHandle.SetI2SGeneratorWordLength(WordLength);
        end
        function [RetVal] = SetI2SGeneratorWordOffset(self, WordOffset)
            % SetI2SGeneratorWordOffset
            % [RetVal] = SetI2SGeneratorWordOffset(self, WordOffset)
            [RetVal] = self.upxHandle.SetI2SGeneratorWordOffset(WordOffset);
        end
        function [RetVal] = SetLipSyncAnalysisActiveColorHigh(self, RGBString)
            % SetLipSyncAnalysisActiveColorHigh
            % [RetVal] = SetLipSyncAnalysisActiveColorHigh(self, RGBString)
            [RetVal] = self.upxHandle.SetLipSyncAnalysisActiveColorHigh(RGBString);
        end
        function [RetVal] = SetLipSyncAnalysisActiveColorLow(self, RGBString)
            % SetLipSyncAnalysisActiveColorLow
            % [RetVal] = SetLipSyncAnalysisActiveColorLow(self, RGBString)
            [RetVal] = self.upxHandle.SetLipSyncAnalysisActiveColorLow(RGBString);
        end
        function [RetVal] = SetLipSyncAnalysisActivePatternColor(self, RGBString)
            % SetLipSyncAnalysisActivePatternColor
            % [RetVal] = SetLipSyncAnalysisActivePatternColor(self, RGBString)
            [RetVal] = self.upxHandle.SetLipSyncAnalysisActivePatternColor(RGBString);
        end
        function [RetVal] = SetLipSyncAnalysisAudioTriggerThreshold(self, Low, Units)
            % SetLipSyncAnalysisAudioTriggerThreshold
            % [RetVal] = SetLipSyncAnalysisAudioTriggerThreshold(self, Low, Units)
            [RetVal] = self.upxHandle.SetLipSyncAnalysisAudioTriggerThreshold(Low, Units);
        end
        function [RetVal] = SetLipSyncAnalysisMutePatternColor(self, RGBString)
            % SetLipSyncAnalysisMutePatternColor
            % [RetVal] = SetLipSyncAnalysisMutePatternColor(self, RGBString)
            [RetVal] = self.upxHandle.SetLipSyncAnalysisMutePatternColor(RGBString);
        end
        function [RetVal] = SetMeasurementFunctionSettlingCount(self, Samples)
            % SetMeasurementFunctionSettlingCount
            % [RetVal] = SetMeasurementFunctionSettlingCount(self, Samples)
            [RetVal] = self.upxHandle.SetMeasurementFunctionSettlingCount(Samples);
        end
        function [RetVal] = SetMeasurementFunctionSettlingResolution(self, Resolution)
            % SetMeasurementFunctionSettlingResolution
            % [RetVal] = SetMeasurementFunctionSettlingResolution(self, Resolution)
            [RetVal] = self.upxHandle.SetMeasurementFunctionSettlingResolution(Resolution);
        end
        function [RetVal] = SetMeasurementFunctionSettlingTimeout(self, Timeout)
            % SetMeasurementFunctionSettlingTimeout
            % [RetVal] = SetMeasurementFunctionSettlingTimeout(self, Timeout)
            [RetVal] = self.upxHandle.SetMeasurementFunctionSettlingTimeout(Timeout);
        end
        function [RetVal] = SetMeasurementFunctionSettlingTolerance(self, Tolerance)
            % SetMeasurementFunctionSettlingTolerance
            % [RetVal] = SetMeasurementFunctionSettlingTolerance(self, Tolerance)
            [RetVal] = self.upxHandle.SetMeasurementFunctionSettlingTolerance(Tolerance);
        end
        function [RetVal] = SetMeasurementFunctionsSettling(self, FnctSettling)
            % SetMeasurementFunctionsSettling
            % [RetVal] = SetMeasurementFunctionsSettling(self, FnctSettling)
            [RetVal] = self.upxHandle.SetMeasurementFunctionsSettling(FnctSettling);
        end
        function [RetVal] = SetMeasurementMode(self, MeasurementMode)
            % SetMeasurementMode
            % [RetVal] = SetMeasurementMode(self, MeasurementMode)
            [RetVal] = self.upxHandle.SetMeasurementMode(MeasurementMode);
        end
        function [RetVal] = SetMeasurementTimeout(self, MeasurementTimeout)
            % SetMeasurementTimeout
            % [RetVal] = SetMeasurementTimeout(self, MeasurementTimeout)
            [RetVal] = self.upxHandle.SetMeasurementTimeout(MeasurementTimeout);
        end
        function [RetVal] = SetMemoryString(self, StringNumber, String)
            % SetMemoryString
            % [RetVal] = SetMemoryString(self, StringNumber, String)
            [RetVal] = self.upxHandle.SetMemoryString(StringNumber, String);
        end
        function [RetVal] = SetMultichannelAnalyzerChannelInputImpedance(self, Channel, Imped)
            % SetMultichannelAnalyzerChannelInputImpedance
            % [RetVal] = SetMultichannelAnalyzerChannelInputImpedance(self, Channel, Imped)
            [RetVal] = self.upxHandle.SetMultichannelAnalyzerChannelInputImpedance(Channel, Imped);
        end
        function [RetVal] = SetMultichannelAnalyzerChannelRange(self, Coupling)
            % SetMultichannelAnalyzerChannelRange
            % [RetVal] = SetMultichannelAnalyzerChannelRange(self, Coupling)
            [RetVal] = self.upxHandle.SetMultichannelAnalyzerChannelRange(Coupling);
        end
        function [RetVal] = SetMultichannelAnalyzerCoupling(self, Channel, Coupling)
            % SetMultichannelAnalyzerCoupling
            % [RetVal] = SetMultichannelAnalyzerCoupling(self, Channel, Coupling)
            [RetVal] = self.upxHandle.SetMultichannelAnalyzerCoupling(Channel, Coupling);
        end
        function [RetVal] = SetMultichannelAnalyzerCouplingMode(self, Coupling)
            % SetMultichannelAnalyzerCouplingMode
            % [RetVal] = SetMultichannelAnalyzerCouplingMode(self, Coupling)
            [RetVal] = self.upxHandle.SetMultichannelAnalyzerCouplingMode(Coupling);
        end
        function [RetVal] = SetMultichannelAnalyzerImpedanceChannel(self, Channel, Impedance)
            % SetMultichannelAnalyzerImpedanceChannel
            % [RetVal] = SetMultichannelAnalyzerImpedanceChannel(self, Channel, Impedance)
            [RetVal] = self.upxHandle.SetMultichannelAnalyzerImpedanceChannel(Channel, Impedance);
        end
        function [RetVal] = SetMultichannelAnalyzerMeasChannels(self, Channel, ChannelState)
            % SetMultichannelAnalyzerMeasChannels
            % [RetVal] = SetMultichannelAnalyzerMeasChannels(self, Channel, ChannelState)
            [RetVal] = self.upxHandle.SetMultichannelAnalyzerMeasChannels(Channel, ChannelState);
        end
        function [RetVal] = SetMultichannelAnalyzerReferenceChannel(self, Channel)
            % SetMultichannelAnalyzerReferenceChannel
            % [RetVal] = SetMultichannelAnalyzerReferenceChannel(self, Channel)
            [RetVal] = self.upxHandle.SetMultichannelAnalyzerReferenceChannel(Channel);
        end
        function [RetVal] = SetMultichannelAnalyzerTriggerChannel(self, Channel)
            % SetMultichannelAnalyzerTriggerChannel
            % [RetVal] = SetMultichannelAnalyzerTriggerChannel(self, Channel)
            [RetVal] = self.upxHandle.SetMultichannelAnalyzerTriggerChannel(Channel);
        end
        function [RetVal] = SetProtocolAnalysisDisplayMode(self, DisplayMode)
            % SetProtocolAnalysisDisplayMode
            % [RetVal] = SetProtocolAnalysisDisplayMode(self, DisplayMode)
            [RetVal] = self.upxHandle.SetProtocolAnalysisDisplayMode(DisplayMode);
        end
        function [RetVal] = SetProtocolAnalysisDisplayState(self, ProtocolAnalysisDisplayState)
            % SetProtocolAnalysisDisplayState
            % [RetVal] = SetProtocolAnalysisDisplayState(self, ProtocolAnalysisDisplayState)
            [RetVal] = self.upxHandle.SetProtocolAnalysisDisplayState(ProtocolAnalysisDisplayState);
        end
        function [RetVal] = SetProtocolAnalysisHighlight(self, Highlight)
            % SetProtocolAnalysisHighlight
            % [RetVal] = SetProtocolAnalysisHighlight(self, Highlight)
            [RetVal] = self.upxHandle.SetProtocolAnalysisHighlight(Highlight);
        end
        function [RetVal] = SetProtocolAnalysisPersistence(self, Persistence)
            % SetProtocolAnalysisPersistence
            % [RetVal] = SetProtocolAnalysisPersistence(self, Persistence)
            [RetVal] = self.upxHandle.SetProtocolAnalysisPersistence(Persistence);
        end
        function [RetVal] = SetProtocolAnalysisState(self, ProtocolAnalysisState)
            % SetProtocolAnalysisState
            % [RetVal] = SetProtocolAnalysisState(self, ProtocolAnalysisState)
            [RetVal] = self.upxHandle.SetProtocolAnalysisState(ProtocolAnalysisState);
        end
        function [RetVal] = SetProtocolAnalysisViewMode(self, ViewMode)
            % SetProtocolAnalysisViewMode
            % [RetVal] = SetProtocolAnalysisViewMode(self, ViewMode)
            [RetVal] = self.upxHandle.SetProtocolAnalysisViewMode(ViewMode);
        end
        function [RetVal] = SetProtocolGeneratorAllBitsToZero(self)
            % SetProtocolGeneratorAllBitsToZero
            % [RetVal] = SetProtocolGeneratorAllBitsToZero(self)
            [RetVal] = self.upxHandle.SetProtocolGeneratorAllBitsToZero();
        end
        function [RetVal] = SetProtocolGeneratorCRC(self, CRC)
            % SetProtocolGeneratorCRC
            % [RetVal] = SetProtocolGeneratorCRC(self, CRC)
            [RetVal] = self.upxHandle.SetProtocolGeneratorCRC(CRC);
        end
        function [RetVal] = SetProtocolGeneratorChannelByte(self, Channel, ByteValue, Value)
            % SetProtocolGeneratorChannelByte
            % [RetVal] = SetProtocolGeneratorChannelByte(self, Channel, ByteValue, Value)
            [RetVal] = self.upxHandle.SetProtocolGeneratorChannelByte(Channel, ByteValue, Value);
        end
        function [RetVal] = SetProtocolGeneratorChannels(self, Channels)
            % SetProtocolGeneratorChannels
            % [RetVal] = SetProtocolGeneratorChannels(self, Channels)
            [RetVal] = self.upxHandle.SetProtocolGeneratorChannels(Channels);
        end
        function [RetVal] = SetProtocolGeneratorCodingFile(self, ProtocolFile)
            % SetProtocolGeneratorCodingFile
            % [RetVal] = SetProtocolGeneratorCodingFile(self, ProtocolFile)
            [RetVal] = self.upxHandle.SetProtocolGeneratorCodingFile(ProtocolFile);
        end
        function [RetVal] = SetProtocolGeneratorCodingMode(self, CodingMode)
            % SetProtocolGeneratorCodingMode
            % [RetVal] = SetProtocolGeneratorCodingMode(self, CodingMode)
            [RetVal] = self.upxHandle.SetProtocolGeneratorCodingMode(CodingMode);
        end
        function [RetVal] = SetProtocolGeneratorValidity(self, Validity)
            % SetProtocolGeneratorValidity
            % [RetVal] = SetProtocolGeneratorValidity(self, Validity)
            [RetVal] = self.upxHandle.SetProtocolGeneratorValidity(Validity);
        end
        function [RetVal] = SetSwitcherConnection(self, SwitcherConnection)
            % SetSwitcherConnection
            % [RetVal] = SetSwitcherConnection(self, SwitcherConnection)
            [RetVal] = self.upxHandle.SetSwitcherConnection(SwitcherConnection);
        end
        function [RetVal] = SetSwitcherInput(self, SwitcherInput, InputChannelNumber)
            % SetSwitcherInput
            % [RetVal] = SetSwitcherInput(self, SwitcherInput, InputChannelNumber)
            [RetVal] = self.upxHandle.SetSwitcherInput(SwitcherInput, InputChannelNumber);
        end
        function [RetVal] = SetSwitcherOffset(self, SwitcherOffset, OffsetValue)
            % SetSwitcherOffset
            % [RetVal] = SetSwitcherOffset(self, SwitcherOffset, OffsetValue)
            [RetVal] = self.upxHandle.SetSwitcherOffset(SwitcherOffset, OffsetValue);
        end
        function [RetVal] = SetSwitcherOutput(self, SwitcherOutput, OutputChannelNumber)
            % SetSwitcherOutput
            % [RetVal] = SetSwitcherOutput(self, SwitcherOutput, OutputChannelNumber)
            [RetVal] = self.upxHandle.SetSwitcherOutput(SwitcherOutput, OutputChannelNumber);
        end
        function [RetVal] = SetSwitcherPort(self, ComPort)
            % SetSwitcherPort
            % [RetVal] = SetSwitcherPort(self, ComPort)
            [RetVal] = self.upxHandle.SetSwitcherPort(ComPort);
        end
        function [RetVal] = SetSwitcherState(self, SwitcherState)
            % SetSwitcherState
            % [RetVal] = SetSwitcherState(self, SwitcherState)
            [RetVal] = self.upxHandle.SetSwitcherState(SwitcherState);
        end
        function [RetVal] = SetSwitcherTracking(self, SwitcherTracking)
            % SetSwitcherTracking
            % [RetVal] = SetSwitcherTracking(self, SwitcherTracking)
            [RetVal] = self.upxHandle.SetSwitcherTracking(SwitcherTracking);
        end
        function [RetVal] = SetUSIAnalyzerAudioBits(self, AudioBits)
            % SetUSIAnalyzerAudioBits
            % [RetVal] = SetUSIAnalyzerAudioBits(self, AudioBits)
            [RetVal] = self.upxHandle.SetUSIAnalyzerAudioBits(AudioBits);
        end
        function [RetVal] = SetUSIAnalyzerBClkSlope(self, BClkSlope)
            % SetUSIAnalyzerBClkSlope
            % [RetVal] = SetUSIAnalyzerBClkSlope(self, BClkSlope)
            [RetVal] = self.upxHandle.SetUSIAnalyzerBClkSlope(BClkSlope);
        end
        function [RetVal] = SetUSIAnalyzerClock(self, Clock)
            % SetUSIAnalyzerClock
            % [RetVal] = SetUSIAnalyzerClock(self, Clock)
            [RetVal] = self.upxHandle.SetUSIAnalyzerClock(Clock);
        end
        function [RetVal] = SetUSIAnalyzerCoding(self, Coding)
            % SetUSIAnalyzerCoding
            % [RetVal] = SetUSIAnalyzerCoding(self, Coding)
            [RetVal] = self.upxHandle.SetUSIAnalyzerCoding(Coding);
        end
        function [RetVal] = SetUSIAnalyzerFirstBit(self, FirstBit)
            % SetUSIAnalyzerFirstBit
            % [RetVal] = SetUSIAnalyzerFirstBit(self, FirstBit)
            [RetVal] = self.upxHandle.SetUSIAnalyzerFirstBit(FirstBit);
        end
        function [RetVal] = SetUSIAnalyzerFsyncOffset(self, FsyncOffset)
            % SetUSIAnalyzerFsyncOffset
            % [RetVal] = SetUSIAnalyzerFsyncOffset(self, FsyncOffset)
            [RetVal] = self.upxHandle.SetUSIAnalyzerFsyncOffset(FsyncOffset);
        end
        function [RetVal] = SetUSIAnalyzerFsyncSlope(self, FsyncSlope)
            % SetUSIAnalyzerFsyncSlope
            % [RetVal] = SetUSIAnalyzerFsyncSlope(self, FsyncSlope)
            [RetVal] = self.upxHandle.SetUSIAnalyzerFsyncSlope(FsyncSlope);
        end
        function [RetVal] = SetUSIAnalyzerFsyncWidth(self, FsyncWidth, VariableFsyncWidth)
            % SetUSIAnalyzerFsyncWidth
            % [RetVal] = SetUSIAnalyzerFsyncWidth(self, FsyncWidth, VariableFsyncWidth)
            [RetVal] = self.upxHandle.SetUSIAnalyzerFsyncWidth(FsyncWidth, VariableFsyncWidth);
        end
        function [RetVal] = SetUSIAnalyzerLeadBits(self, LeadBits)
            % SetUSIAnalyzerLeadBits
            % [RetVal] = SetUSIAnalyzerLeadBits(self, LeadBits)
            [RetVal] = self.upxHandle.SetUSIAnalyzerLeadBits(LeadBits);
        end
        function [RetVal] = SetUSIAnalyzerLogicVoltage(self, LogicVoltage)
            % SetUSIAnalyzerLogicVoltage
            % [RetVal] = SetUSIAnalyzerLogicVoltage(self, LogicVoltage)
            [RetVal] = self.upxHandle.SetUSIAnalyzerLogicVoltage(LogicVoltage);
        end
        function [RetVal] = SetUSIAnalyzerMClkRatio(self, Ratio)
            % SetUSIAnalyzerMClkRatio
            % [RetVal] = SetUSIAnalyzerMClkRatio(self, Ratio)
            [RetVal] = self.upxHandle.SetUSIAnalyzerMClkRatio(Ratio);
        end
        function [RetVal] = SetUSIAnalyzerMeasChannelState(self, MeasChannel, State)
            % SetUSIAnalyzerMeasChannelState
            % [RetVal] = SetUSIAnalyzerMeasChannelState(self, MeasChannel, State)
            [RetVal] = self.upxHandle.SetUSIAnalyzerMeasChannelState(MeasChannel, State);
        end
        function [RetVal] = SetUSIAnalyzerMeasurementSource(self, MeasChannel, DataLink)
            % SetUSIAnalyzerMeasurementSource
            % [RetVal] = SetUSIAnalyzerMeasurementSource(self, MeasChannel, DataLink)
            [RetVal] = self.upxHandle.SetUSIAnalyzerMeasurementSource(MeasChannel, DataLink);
        end
        function [RetVal] = SetUSIAnalyzerMixedSamplingFrequencyState(self, MixedSamplingFrequency)
            % SetUSIAnalyzerMixedSamplingFrequencyState
            % [RetVal] = SetUSIAnalyzerMixedSamplingFrequencyState(self, MixedSamplingFrequency)
            [RetVal] = self.upxHandle.SetUSIAnalyzerMixedSamplingFrequencyState(MixedSamplingFrequency);
        end
        function [RetVal] = SetUSIAnalyzerNumberOfSlots(self, NumberOfSlots)
            % SetUSIAnalyzerNumberOfSlots
            % [RetVal] = SetUSIAnalyzerNumberOfSlots(self, NumberOfSlots)
            [RetVal] = self.upxHandle.SetUSIAnalyzerNumberOfSlots(NumberOfSlots);
        end
        function [RetVal] = SetUSIAnalyzerRatio(self, Ratio)
            % SetUSIAnalyzerRatio
            % [RetVal] = SetUSIAnalyzerRatio(self, Ratio)
            [RetVal] = self.upxHandle.SetUSIAnalyzerRatio(Ratio);
        end
        function [RetVal] = SetUSIAnalyzerSampleFrequency(self, SampleFrequency, VariableSampleFrequency, Units)
            % SetUSIAnalyzerSampleFrequency
            % [RetVal] = SetUSIAnalyzerSampleFrequency(self, SampleFrequency, VariableSampleFrequency, Units)
            [RetVal] = self.upxHandle.SetUSIAnalyzerSampleFrequency(SampleFrequency, VariableSampleFrequency, Units);
        end
        function [RetVal] = SetUSIAnalyzerSamplesPerFrame(self, Samples)
            % SetUSIAnalyzerSamplesPerFrame
            % [RetVal] = SetUSIAnalyzerSamplesPerFrame(self, Samples)
            [RetVal] = self.upxHandle.SetUSIAnalyzerSamplesPerFrame(Samples);
        end
        function [RetVal] = SetUSIAnalyzerSamplingDelay(self, SamplingDelay)
            % SetUSIAnalyzerSamplingDelay
            % [RetVal] = SetUSIAnalyzerSamplingDelay(self, SamplingDelay)
            [RetVal] = self.upxHandle.SetUSIAnalyzerSamplingDelay(SamplingDelay);
        end
        function [RetVal] = SetUSIAnalyzerSlotLength(self, SlotLength)
            % SetUSIAnalyzerSlotLength
            % [RetVal] = SetUSIAnalyzerSlotLength(self, SlotLength)
            [RetVal] = self.upxHandle.SetUSIAnalyzerSlotLength(SlotLength);
        end
        function [RetVal] = SetUSIAnalyzerSlots(self, MeasChannel, Slots)
            % SetUSIAnalyzerSlots
            % [RetVal] = SetUSIAnalyzerSlots(self, MeasChannel, Slots)
            [RetVal] = self.upxHandle.SetUSIAnalyzerSlots(MeasChannel, Slots);
        end
        function [RetVal] = SetUSIAnalyzerSyncTo(self, SyncTo)
            % SetUSIAnalyzerSyncTo
            % [RetVal] = SetUSIAnalyzerSyncTo(self, SyncTo)
            [RetVal] = self.upxHandle.SetUSIAnalyzerSyncTo(SyncTo);
        end
        function [RetVal] = SetUSIAnalyzerTimeout(self, Timeout)
            % SetUSIAnalyzerTimeout
            % [RetVal] = SetUSIAnalyzerTimeout(self, Timeout)
            [RetVal] = self.upxHandle.SetUSIAnalyzerTimeout(Timeout);
        end
        function [RetVal] = SetUSIGeneratorAudioBits(self, AudioBits)
            % SetUSIGeneratorAudioBits
            % [RetVal] = SetUSIGeneratorAudioBits(self, AudioBits)
            [RetVal] = self.upxHandle.SetUSIGeneratorAudioBits(AudioBits);
        end
        function [RetVal] = SetUSIGeneratorBClkJitterAmplitude(self, BClkJitterAmplitude)
            % SetUSIGeneratorBClkJitterAmplitude
            % [RetVal] = SetUSIGeneratorBClkJitterAmplitude(self, BClkJitterAmplitude)
            [RetVal] = self.upxHandle.SetUSIGeneratorBClkJitterAmplitude(BClkJitterAmplitude);
        end
        function [RetVal] = SetUSIGeneratorBClkJitterFrequency(self, BClkJitterFrequency)
            % SetUSIGeneratorBClkJitterFrequency
            % [RetVal] = SetUSIGeneratorBClkJitterFrequency(self, BClkJitterFrequency)
            [RetVal] = self.upxHandle.SetUSIGeneratorBClkJitterFrequency(BClkJitterFrequency);
        end
        function [RetVal] = SetUSIGeneratorBClkSlope(self, BClkSlope)
            % SetUSIGeneratorBClkSlope
            % [RetVal] = SetUSIGeneratorBClkSlope(self, BClkSlope)
            [RetVal] = self.upxHandle.SetUSIGeneratorBClkSlope(BClkSlope);
        end
        function [RetVal] = SetUSIGeneratorClock(self, Clock)
            % SetUSIGeneratorClock
            % [RetVal] = SetUSIGeneratorClock(self, Clock)
            [RetVal] = self.upxHandle.SetUSIGeneratorClock(Clock);
        end
        function [RetVal] = SetUSIGeneratorCoding(self, Coding)
            % SetUSIGeneratorCoding
            % [RetVal] = SetUSIGeneratorCoding(self, Coding)
            [RetVal] = self.upxHandle.SetUSIGeneratorCoding(Coding);
        end
        function [RetVal] = SetUSIGeneratorFirstBit(self, FirstBit)
            % SetUSIGeneratorFirstBit
            % [RetVal] = SetUSIGeneratorFirstBit(self, FirstBit)
            [RetVal] = self.upxHandle.SetUSIGeneratorFirstBit(FirstBit);
        end
        function [RetVal] = SetUSIGeneratorFsyncOffset(self, FsyncOffset)
            % SetUSIGeneratorFsyncOffset
            % [RetVal] = SetUSIGeneratorFsyncOffset(self, FsyncOffset)
            [RetVal] = self.upxHandle.SetUSIGeneratorFsyncOffset(FsyncOffset);
        end
        function [RetVal] = SetUSIGeneratorFsyncSlope(self, FsyncSlope)
            % SetUSIGeneratorFsyncSlope
            % [RetVal] = SetUSIGeneratorFsyncSlope(self, FsyncSlope)
            [RetVal] = self.upxHandle.SetUSIGeneratorFsyncSlope(FsyncSlope);
        end
        function [RetVal] = SetUSIGeneratorFsyncWidth(self, FsyncWidth, VariableFsyncWidth)
            % SetUSIGeneratorFsyncWidth
            % [RetVal] = SetUSIGeneratorFsyncWidth(self, FsyncWidth, VariableFsyncWidth)
            [RetVal] = self.upxHandle.SetUSIGeneratorFsyncWidth(FsyncWidth, VariableFsyncWidth);
        end
        function [RetVal] = SetUSIGeneratorLeadBits(self, LeadBits)
            % SetUSIGeneratorLeadBits
            % [RetVal] = SetUSIGeneratorLeadBits(self, LeadBits)
            [RetVal] = self.upxHandle.SetUSIGeneratorLeadBits(LeadBits);
        end
        function [RetVal] = SetUSIGeneratorLogicVoltage(self, LogicVoltage)
            % SetUSIGeneratorLogicVoltage
            % [RetVal] = SetUSIGeneratorLogicVoltage(self, LogicVoltage)
            [RetVal] = self.upxHandle.SetUSIGeneratorLogicVoltage(LogicVoltage);
        end
        function [RetVal] = SetUSIGeneratorMClkJitterAmplitude(self, MClkJitterAmplitude)
            % SetUSIGeneratorMClkJitterAmplitude
            % [RetVal] = SetUSIGeneratorMClkJitterAmplitude(self, MClkJitterAmplitude)
            [RetVal] = self.upxHandle.SetUSIGeneratorMClkJitterAmplitude(MClkJitterAmplitude);
        end
        function [RetVal] = SetUSIGeneratorMClkJitterFrequency(self, MClkJitterFrequency)
            % SetUSIGeneratorMClkJitterFrequency
            % [RetVal] = SetUSIGeneratorMClkJitterFrequency(self, MClkJitterFrequency)
            [RetVal] = self.upxHandle.SetUSIGeneratorMClkJitterFrequency(MClkJitterFrequency);
        end
        function [RetVal] = SetUSIGeneratorMClkRatio(self, Ratio)
            % SetUSIGeneratorMClkRatio
            % [RetVal] = SetUSIGeneratorMClkRatio(self, Ratio)
            [RetVal] = self.upxHandle.SetUSIGeneratorMClkRatio(Ratio);
        end
        function [RetVal] = SetUSIGeneratorMixedSamplingFrequencyState(self, MixedSamplingFrequency)
            % SetUSIGeneratorMixedSamplingFrequencyState
            % [RetVal] = SetUSIGeneratorMixedSamplingFrequencyState(self, MixedSamplingFrequency)
            [RetVal] = self.upxHandle.SetUSIGeneratorMixedSamplingFrequencyState(MixedSamplingFrequency);
        end
        function [RetVal] = SetUSIGeneratorNumberOfSlots(self, NumberOfSlots)
            % SetUSIGeneratorNumberOfSlots
            % [RetVal] = SetUSIGeneratorNumberOfSlots(self, NumberOfSlots)
            [RetVal] = self.upxHandle.SetUSIGeneratorNumberOfSlots(NumberOfSlots);
        end
        function [RetVal] = SetUSIGeneratorRatio(self, Ratio)
            % SetUSIGeneratorRatio
            % [RetVal] = SetUSIGeneratorRatio(self, Ratio)
            [RetVal] = self.upxHandle.SetUSIGeneratorRatio(Ratio);
        end
        function [RetVal] = SetUSIGeneratorSampleFrequency(self, SampleFrequency, VariableSampleFrequency, Units)
            % SetUSIGeneratorSampleFrequency
            % [RetVal] = SetUSIGeneratorSampleFrequency(self, SampleFrequency, VariableSampleFrequency, Units)
            [RetVal] = self.upxHandle.SetUSIGeneratorSampleFrequency(SampleFrequency, VariableSampleFrequency, Units);
        end
        function [RetVal] = SetUSIGeneratorSamplesPerFrame(self, Samples)
            % SetUSIGeneratorSamplesPerFrame
            % [RetVal] = SetUSIGeneratorSamplesPerFrame(self, Samples)
            [RetVal] = self.upxHandle.SetUSIGeneratorSamplesPerFrame(Samples);
        end
        function [RetVal] = SetUSIGeneratorSlClkOffset(self, SlClkOffset)
            % SetUSIGeneratorSlClkOffset
            % [RetVal] = SetUSIGeneratorSlClkOffset(self, SlClkOffset)
            [RetVal] = self.upxHandle.SetUSIGeneratorSlClkOffset(SlClkOffset);
        end
        function [RetVal] = SetUSIGeneratorSlClkSlope(self, SlClkSlope)
            % SetUSIGeneratorSlClkSlope
            % [RetVal] = SetUSIGeneratorSlClkSlope(self, SlClkSlope)
            [RetVal] = self.upxHandle.SetUSIGeneratorSlClkSlope(SlClkSlope);
        end
        function [RetVal] = SetUSIGeneratorSlClkWidth(self, SlClkWidth, VariableSlClkWidth)
            % SetUSIGeneratorSlClkWidth
            % [RetVal] = SetUSIGeneratorSlClkWidth(self, SlClkWidth, VariableSlClkWidth)
            [RetVal] = self.upxHandle.SetUSIGeneratorSlClkWidth(SlClkWidth, VariableSlClkWidth);
        end
        function [RetVal] = SetUSIGeneratorSlotLength(self, SlotLength)
            % SetUSIGeneratorSlotLength
            % [RetVal] = SetUSIGeneratorSlotLength(self, SlotLength)
            [RetVal] = self.upxHandle.SetUSIGeneratorSlotLength(SlotLength);
        end
        function [RetVal] = SetUSIGeneratorSyncTo(self, SyncTo)
            % SetUSIGeneratorSyncTo
            % [RetVal] = SetUSIGeneratorSyncTo(self, SyncTo)
            [RetVal] = self.upxHandle.SetUSIGeneratorSyncTo(SyncTo);
        end
        function [RetVal] = SetUSIGeneratorTxData(self, DataLine, SignalType)
            % SetUSIGeneratorTxData
            % [RetVal] = SetUSIGeneratorTxData(self, DataLine, SignalType)
            [RetVal] = self.upxHandle.SetUSIGeneratorTxData(DataLine, SignalType);
        end
        function [RetVal] = SetWindowStyle(self, FileSelectorWindowStyle)
            % SetWindowStyle
            % [RetVal] = SetWindowStyle(self, FileSelectorWindowStyle)
            [RetVal] = self.upxHandle.SetWindowStyle(FileSelectorWindowStyle);
        end
        function [RetVal] = StartMeasurement(self)
            % StartMeasurement
            % [RetVal] = StartMeasurement(self)
            [RetVal] = self.upxHandle.StartMeasurement();
        end
        function [RetVal] = StartMeasurementWaitOPC(self, Timeout)
            % StartMeasurementWaitOPC
            % [RetVal] = StartMeasurementWaitOPC(self, Timeout)
            [RetVal] = self.upxHandle.StartMeasurementWaitOPC(Timeout);
        end
        function [RetVal] = StoreMemoryDataBinary(self, StringNumber, BinaryLength, BinaryBlockData)
            % StoreMemoryDataBinary
            % [RetVal] = StoreMemoryDataBinary(self, StringNumber, BinaryLength, BinaryBlockData)
            [RetVal] = self.upxHandle.StoreMemoryDataBinary(StringNumber, BinaryLength, BinaryBlockData);
        end
        function [RetVal] = StoreMemoryDataNumeric(self, StringNumber, NumberOfData, Data)
            % StoreMemoryDataNumeric
            % [RetVal] = StoreMemoryDataNumeric(self, StringNumber, NumberOfData, Data)
            [RetVal] = self.upxHandle.StoreMemoryDataNumeric(StringNumber, NumberOfData, Data);
        end
        function [RetVal] = SystemShutdown(self, Time)
            % SystemShutdown
            % [RetVal] = SystemShutdown(self, Time)
            [RetVal] = self.upxHandle.SystemShutdown(Time);
        end
        function [RetVal] = ToString(self)
            % ToString
            % [RetVal] = ToString(self)
            [RetVal] = self.upxHandle.ToString();
        end
        function [RetVal] = USIAnalyzerResync(self)
            % USIAnalyzerResync
            % [RetVal] = USIAnalyzerResync(self)
            [RetVal] = self.upxHandle.USIAnalyzerResync();
        end
        function [RetVal] = USIGeneratorResync(self)
            % USIGeneratorResync
            % [RetVal] = USIGeneratorResync(self)
            [RetVal] = self.upxHandle.USIGeneratorResync();
        end
        function [RetVal] = WriteTraceDataSets(self, Subsystem, SubsystemNumber, DataSet, NumberOfDataSets, DataSets)
            % WriteTraceDataSets
            % [RetVal] = WriteTraceDataSets(self, Subsystem, SubsystemNumber, DataSet, NumberOfDataSets, DataSets)
            [RetVal] = self.upxHandle.WriteTraceDataSets(Subsystem, SubsystemNumber, DataSet, NumberOfDataSets, DataSets);
        end
        function [RetVal, EOF] = contHugeFile(self, FileHandle, uOffset, uBlockLength)
            % contHugeFile
            % [RetVal, EOF] = contHugeFile(self, FileHandle, uOffset, uBlockLength)
            [RetVal, EOF] = self.upxHandle.contHugeFile(FileHandle, uOffset, uBlockLength);
        end
        function [RetVal] = errorCheckState(self, StateChecking)
            % errorCheckState
            % [RetVal] = errorCheckState(self, StateChecking)
            [RetVal] = self.upxHandle.errorCheckState(StateChecking);
        end
        function [RetVal, ErrorCode, ErrorMessage] = errorquery(self)
            % errorquery
            % [RetVal, ErrorCode, ErrorMessage] = errorquery(self)
            ErrorMessage = System.Text.StringBuilder(256);
            [RetVal, ErrorCode] = self.upxHandle.error_query(ErrorMessage);
            ErrorMessage = char(ErrorMessage.ToString);
        end
        function [RetVal, RegisterValue] = getStatusRegister(self, StatusRegistersQuery)
            % getStatusRegister
            % [RetVal, RegisterValue] = getStatusRegister(self, StatusRegistersQuery)
            [RetVal, RegisterValue] = self.upxHandle.getStatusRegister(StatusRegistersQuery);
        end
        function [RetVal, Timeout] = getTimeOut(self)
            % getTimeOut
            % [RetVal, Timeout] = getTimeOut(self)
            [RetVal, Timeout] = self.upxHandle.getTimeOut();
        end
        function [RetVal, NumBytesRead, ReadBuffer] = readInstrData(self, NumberBytesToRead)
            % readInstrData
            % [RetVal, NumBytesRead, ReadBuffer] = readInstrData(self, NumberBytesToRead)
            ReadBuffer = System.Text.StringBuilder(256);
            [RetVal, NumBytesRead] = self.upxHandle.readInstrData(NumberBytesToRead, ReadBuffer);
            ReadBuffer = char(ReadBuffer.ToString);
        end
        function [RetVal] = readToFile(self, Source, Destination)
            % readToFile
            % [RetVal] = readToFile(self, Source, Destination)
            [RetVal] = self.upxHandle.readToFile(Source, Destination);
        end
        function [RetVal] = reset(self)
            % reset
            % [RetVal] = reset(self)
            [RetVal] = self.upxHandle.reset();
        end
        function [RetVal, InstrumentDriverRevision, FirmwareRevision] = revisionquery(self)
            % revisionquery
            % [RetVal, InstrumentDriverRevision, FirmwareRevision] = revisionquery(self)
            InstrumentDriverRevision = System.Text.StringBuilder(256);
            FirmwareRevision = System.Text.StringBuilder(256);
            [RetVal] = self.upxHandle.revision_query(InstrumentDriverRevision, FirmwareRevision);
            InstrumentDriverRevision = char(InstrumentDriverRevision.ToString);
            FirmwareRevision = char(FirmwareRevision.ToString);
        end
        function [RetVal, SelfTestResult, SelfTestMessage] = selftest(self)
            % selftest
            % [RetVal, SelfTestResult, SelfTestMessage] = selftest(self)
            SelfTestMessage = System.Text.StringBuilder(256);
            [RetVal, SelfTestResult] = self.upxHandle.self_test(SelfTestMessage);
            SelfTestMessage = char(SelfTestMessage.ToString);
        end
        function [RetVal] = setStatusRegister(self, RegisterOperation, QuestionableRegister, Enable, PTransition, NTransition)
            % setStatusRegister
            % [RetVal] = setStatusRegister(self, RegisterOperation, QuestionableRegister, Enable, PTransition, NTransition)
            [RetVal] = self.upxHandle.setStatusRegister(RegisterOperation, QuestionableRegister, Enable, PTransition, NTransition);
        end
        function [RetVal] = setTimeOut(self, Timeout)
            % setTimeOut
            % [RetVal] = setTimeOut(self, Timeout)
            [RetVal] = self.upxHandle.setTimeOut(Timeout);
        end
        function [RetVal] = writeFromFile(self, Source, Destination)
            % writeFromFile
            % [RetVal] = writeFromFile(self, Source, Destination)
            [RetVal] = self.upxHandle.writeFromFile(Source, Destination);
        end
        function [RetVal, FileHandle] = writeHugeFileStart(self, Source, Destination)
            % writeHugeFileStart
            % [RetVal, FileHandle] = writeHugeFileStart(self, Source, Destination)
            [RetVal, FileHandle] = self.upxHandle.writeHugeFileStart(Source, Destination);
        end
        function [RetVal] = writeInstrData(self, WriteBuffer)
            % writeInstrData
            % [RetVal] = writeInstrData(self, WriteBuffer)
            [RetVal] = self.upxHandle.writeInstrData(WriteBuffer);
        end
        
    end
end
