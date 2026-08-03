package Architecture {
  doc /* EI-002 selected transmitter-first logical architecture. */

  private import TransceiverContext::*;
  private import TransmitRequirements::*;
  private import Behavior::*;
  private import ProjectLibrary::*;
  private import Elan8::Method::Core::*;

  part def TransmitElectronics {
    @EngineeringConcern { concern = architecture; }
    @AbstractionLevel { level = logical; }

    port txDataInput : ~DigitalDataPort;
    port modulatorDriveOutput : ModulatorDrivePort;

    perform action encodeData : EncodeTransmitData;
    perform action generateDrive : GenerateModulatorDrive;
  }

  part def MachZehnderModulator {
    @EngineeringConcern { concern = architecture; }
    @AbstractionLevel { level = logical; }

    port carrierInput : ~OpticalCarrierPort;
    port driveInput : ~ModulatorDrivePort;
    port modulatedOutput : OpticalDataPort;

    perform action modulateCarrier : ModulateOpticalCarrier;
  }

  part def OutputFibreCoupler {
    @EngineeringConcern { concern = architecture; }
    @AbstractionLevel { level = logical; }

    port picInput : ~OpticalDataPort;
    port fibreOutput : OpticalDataPort;

    perform action coupleOutput : CoupleModulatedOpticalOutput;
  }

  part def OpticalTransmitter {
    @EngineeringConcern { concern = architecture; }
    @AbstractionLevel { level = logical; }
    @DecisionRecord {
      decisionId = "ADR-001";
      title = "Use an NRZ/OOK Mach-Zehnder transmitter";
      rationale = "Provides a focused transmitter-first path with explicit electrical drive, optical modulation, and replaceable fibre coupling responsibilities.";
    }
    @Assumption {
      assumptionId = "ASM-001";
      statement = "The external laser supplies a suitable continuous-wave carrier near 1550 nm; carrier generation and laser control remain outside the module.";
      valid = true;
    }

    port electricalDataInput : ~DigitalDataPort;
    port opticalCarrierInput : ~OpticalCarrierPort;
    port modulatedOpticalOutput : OpticalDataPort;

    part transmitElectronics : TransmitElectronics;
    part modulator : MachZehnderModulator;
    part outputCoupler : OutputFibreCoupler;

    connect transmitElectronics.modulatorDriveOutput to modulator.driveInput;
    connect modulator.modulatedOutput to outputCoupler.picInput;

    perform action transmitOpticalData : TransmitOpticalData;
    allocate transmitOpticalData.encodeData to transmitElectronics;
    allocate transmitOpticalData.generateDrive to transmitElectronics;
    allocate transmitOpticalData.modulateCarrier to modulator;
    allocate transmitOpticalData.coupleOutput to outputCoupler;
  }

  part def TransmitterFirstOpticalTransceiver :> OpticalTransceiverModule {
    @EngineeringConcern { concern = architecture; }
    @AbstractionLevel { level = system; }

    part transmitter : OpticalTransmitter {
      bind electricalDataInput = transmitElectronics.txDataInput;
      bind opticalCarrierInput = modulator.carrierInput;
      bind outputCoupler.fibreOutput = modulatedOpticalOutput;
    }
  }

  part transceiverSystem : TransmitterFirstOpticalTransceiver {
    attribute :>> acceptsExternalOpticalCarrier = true;
    attribute :>> acceptsElectricalTransmitData = true;
    attribute :>> emitsModulatedOpticalSignal = true;

    bind electricalTxDataInput = transmitter.electricalDataInput;
    bind opticalCarrierInput = transmitter.opticalCarrierInput;
    bind transmitter.modulatedOpticalOutput = opticalTxOutput;
  }

  satisfy transmitConversionSpecification by transceiverSystem;
}
