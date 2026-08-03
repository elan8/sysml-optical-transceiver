package ProjectViews {
  doc /* Focused EI-001 view over the authoritative context graph. */

  private import Views::*;
  private import TransceiverContext::*;
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
}
