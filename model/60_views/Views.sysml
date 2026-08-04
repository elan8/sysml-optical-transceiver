package ProjectViews {
  doc /* Focused Engineering Increment views over the authoritative model graph. */

  private import Views::*;
  private import TransceiverContext::*;
  private import Behavior::*;
  private import Architecture::*;
  private import TransmitRequirements::*;
  private import Analysis::*;
  private import Verification::*;
  private import Elan8::Method::Viewpoints::*;

  view transceiverContextView : InterconnectionView {
    satisfy MissionAndContextViewpoint;
    expose operationalContext;
    expose operationalContext.transceiver;
    expose operationalContext.laser;
    expose operationalContext.transmitDataSource;
    expose operationalContext.receiveDataSink;
    expose operationalContext.opticalNetwork;
    expose operationalContext.powerSource;
    expose operationalContext.managementController;
  }

  view transmitBehaviorView : ActionFlowView {
    satisfy ScenarioViewpoint;
    expose TransmitOpticalData;
  }

  view transmitArchitectureView : InterconnectionView {
    satisfy ArchitectureViewpoint;
    expose transceiverSystem;
    expose transceiverSystem.transmitter;
    expose transceiverSystem.transmitter.transmitElectronics;
    expose transceiverSystem.transmitter.modulator;
    expose transceiverSystem.transmitter.outputCoupler;
  }

  view transmitPowerBudgetView : GeneralView {
    satisfy TraceabilityViewpoint;
    expose minimumTransmitOutputPower;
    expose transceiverSystem;
    expose nominalTransmitPowerBudget;
    expose nominalOpticalPowerBudgetVerification;
  }
}
