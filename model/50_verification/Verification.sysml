package Verification {
  doc /* Verification intent for the boundary contract and EI-002 transmitter path. */

  private import TransceiverContext::*;
  private import BoundaryRequirements::*;
  private import TransmitRequirements::*;
  private import Architecture::*;

  verification def BoundaryContractInspection {
    subject transceiver : OpticalTransceiverModule;
    objective {
      verify requirement transceiverBoundarySpecification;
    }
    doc /* Inspect the external actors, typed ports, directions, and context connections. */
  }

  verification def TransmitPathInspection {
    subject transceiver : TransmitterFirstOpticalTransceiver;
    objective {
      verify requirement transmitConversionSpecification;
    }
    doc /*
      Inspection method and pass criterion: the selected design passes when a
      reviewer can trace electrical data and the external optical carrier through
      encoding, drive generation, MZI modulation, output coupling, and the module
      optical-output boundary without an untyped interface or missing allocation.
    */
  }
}
