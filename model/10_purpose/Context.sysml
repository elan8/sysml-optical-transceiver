package TransceiverContext {
  doc /*
    EI-001 operational context. The optical transceiver is modelled as a black
    box. Internal transmitter, receiver, PIC, electronics, and package parts
    are intentionally deferred.
  */

  private import ProjectLibrary::*;
  private import Elan8::Method::Core::*;
  private import Elan8::Electronics::Interconnection::PowerRailPort;

  part def ContinuousWaveLaser {
    port opticalCarrier : OpticalCarrierPort;
  }

  part def ElectricalDataSource {
    port transmitData : DigitalDataPort;
  }

  part def ElectricalDataSink {
    port receivedData : ~DigitalDataPort;
  }

  part def OpticalNetwork {
    port transmitterInput : ~OpticalDataPort;
    port receiverOutput : OpticalDataPort;
  }

  part def ExternalPowerSource {
    port powerOutput : PowerRailPort;
  }

  part def ManagementController {
    port management : ManagementPort;
  }

  part def OpticalTransceiverModule {
    port opticalCarrierInput : ~OpticalCarrierPort;
    port electricalTxDataInput : ~DigitalDataPort;
    port opticalTxOutput : OpticalDataPort;
    port opticalRxInput : ~OpticalDataPort;
    port electricalRxDataOutput : DigitalDataPort;
    port powerInput : ~PowerRailPort;
    port management : ~ManagementPort;
  }

  part def OpticalTransceiverOperationalContext {
    @EngineeringConcern { concern = purpose; }
    @AbstractionLevel { level = operational; }

    ref part transceiver : OpticalTransceiverModule;
    part laser : ContinuousWaveLaser;
    part transmitDataSource : ElectricalDataSource;
    part receiveDataSink : ElectricalDataSink;
    part opticalNetwork : OpticalNetwork;
    part powerSource : ExternalPowerSource;
    part managementController : ManagementController;

    connect laser.opticalCarrier to transceiver.opticalCarrierInput;
    connect transmitDataSource.transmitData to transceiver.electricalTxDataInput;
    connect transceiver.opticalTxOutput to opticalNetwork.transmitterInput;
    connect opticalNetwork.receiverOutput to transceiver.opticalRxInput;
    connect transceiver.electricalRxDataOutput to receiveDataSink.receivedData;
    connect powerSource.powerOutput to transceiver.powerInput;
    connect managementController.management to transceiver.management;

    doc /*
      The transceiver module is the system of interest. The laser, data source,
      data sink, optical network, power source, and management controller are
      external. Every external exchange crosses an explicit typed port.
    */
  }

  part operationalContext : OpticalTransceiverOperationalContext;
}
