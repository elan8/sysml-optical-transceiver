package Elan8 {
  package Photonics {
    doc /*
      Experimental photonics concepts introduced by the optical-transceiver
      reference project. API stability is not guaranteed before promotion to
      sysml-domain-libraries.
    */

    private import ISQ::*;

    item def OpticalSignal {
      attribute wavelength : LengthValue;
    }

    item def ContinuousWaveOpticalSignal :> OpticalSignal;
    item def ModulatedOpticalSignal :> OpticalSignal;
    item def DigitalData;
    item def ManagementCommand;
    item def ManagementStatus;

    port def OpticalCarrierPort {
      out item carrier : ContinuousWaveOpticalSignal;
    }

    port def OpticalDataPort {
      out item opticalData : ModulatedOpticalSignal;
    }

    port def DigitalDataPort {
      out item data : DigitalData;
    }

    port def ManagementPort {
      out item command : ManagementCommand;
      in item status : ManagementStatus;
    }
  }
}
