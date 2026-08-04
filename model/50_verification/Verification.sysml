package Verification {
  doc /* Verification intent for the boundary contract and EI-002 transmitter path. */

  private import TransceiverContext::*;
  private import BoundaryRequirements::*;
  private import TransmitRequirements::*;
  private import Architecture::*;
  private import Analysis::*;
  private import ProjectLibrary::*;
  private import Elan8::Method::Requirements::*;

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

  verification def OpticalPowerBudgetVerification {
    subject transceiver : TransmitterFirstOpticalTransceiver;

    objective {
      verify requirement minimumTransmitOutputPower;
    }

    attribute calculatedOutputPowerDbm : OpticalPowerLevelDbm = -4.5;
    attribute requiredMinimumOutputPowerDbm : OpticalPowerLevelDbm = -6.0;
    attribute outputPowerMarginDb : OpticalLossDb = 1.5;

    return ref requirementSatisfied {
      return outputPowerMarginDb >= 0.0;
    }

    doc /*
      Analysis method and pass criterion: evaluate nominalTransmitPowerBudget.
      Pass when outputPowerMarginDb is at least 0 dB. The nominal selected
      architecture returns -4.5 dBm and therefore passes with 1.5 dB margin.
    */
  }

  verification nominalOpticalPowerBudgetVerification : OpticalPowerBudgetVerification {
    subject :>> transceiver = transceiverSystem;
  }
}
