package Analysis {
  doc /* EI-003 executable transmitter optical power budget. */

  private import ProjectLibrary::*;
  private import TransmitRequirements::*;
  private import Architecture::*;
  private import Elan8::Method::Core::*;

  analysis nominalTransmitPowerBudget {
    subject transceiver : TransmitterFirstOpticalTransceiver;

    attribute carrierInputPowerDbm : OpticalPowerLevelDbm = 3.0;
    attribute minimumOutputPowerDbm : OpticalPowerLevelDbm = -6.0;

    attribute modulatorInsertionLossDb : OpticalLossDb =
      transceiver.transmitter.modulator.insertionLossDb;
    attribute internalRoutingLossDb : OpticalLossDb =
      transceiver.transmitter.internalRoutingLossDb;
    attribute outputCouplerInsertionLossDb : OpticalLossDb =
      transceiver.transmitter.outputCoupler.insertionLossDb;

    attribute fibreOutputPowerDbm : OpticalPowerLevelDbm =
      carrierInputPowerDbm
      - modulatorInsertionLossDb
      - internalRoutingLossDb
      - outputCouplerInsertionLossDb;
    attribute outputPowerMarginDb : OpticalLossDb =
      fibreOutputPowerDbm - minimumOutputPowerDbm;

    objective outputPowerObjective {
      doc /* Determine whether the selected transmitter meets SYS-TX-002 under nominal conditions. */
    }

    return ref sufficientOutputPower {
      return outputPowerMarginDb >= 0.0;
    }

    @EngineeringConcern { concern = evidence; }
    @Assumption {
      assumptionId = "ASM-002";
      statement = "The external laser delivers 3 dBm at the module carrier input under nominal conditions.";
      valid = true;
    }

    doc /*
      Nominal result: 3.0 - 4.5 - 1.0 - 2.0 = -4.5 dBm, leaving
      1.5 dB margin to the -6 dBm boundary requirement.
    */
  }

  dependency nominalPowerBudgetEvaluatesRequirement
    from nominalTransmitPowerBudget to minimumTransmitOutputPower;
}
