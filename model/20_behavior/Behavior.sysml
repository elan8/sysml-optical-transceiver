package Behavior {
  doc /*
    EI-002 transmitter behavior from electrical data and an external optical
    carrier to modulated optical output.
  */

  private import ProjectLibrary::*;

  action def EncodeTransmitData {
    in rawData : DigitalData;
    out encodedData : DigitalData;
    doc /* Encode the electrical input as the selected NRZ/OOK symbol stream. */
  }

  action def GenerateModulatorDrive {
    in encodedData : DigitalData;
    out driveSignal : ModulatorDriveSignal;
    doc /* Generate the electrical drive signal required by the optical modulator. */
  }

  action def ModulateOpticalCarrier {
    in opticalCarrier : ContinuousWaveOpticalSignal;
    in driveSignal : ModulatorDriveSignal;
    out modulatedSignal : ModulatedOpticalSignal;
    doc /* Impress the electrical data onto the continuous-wave optical carrier. */
  }

  action def CoupleModulatedOpticalOutput {
    in picSignal : ModulatedOpticalSignal;
    out fibreSignal : ModulatedOpticalSignal;
    doc /* Transfer the modulated signal from the PIC to the external optical interface. */
  }

  action def TransmitOpticalData {
    in electricalData : DigitalData;
    in opticalCarrier : ContinuousWaveOpticalSignal;
    out opticalData : ModulatedOpticalSignal;

    action encodeData : EncodeTransmitData;
    action generateDrive : GenerateModulatorDrive;
    action modulateCarrier : ModulateOpticalCarrier;
    action coupleOutput : CoupleModulatedOpticalOutput;

    flow electricalData to encodeData.rawData;
    succession flow encodeData.encodedData to generateDrive.encodedData;
    succession flow generateDrive.driveSignal to modulateCarrier.driveSignal;
    flow opticalCarrier to modulateCarrier.opticalCarrier;
    succession flow modulateCarrier.modulatedSignal to coupleOutput.picSignal;
    flow coupleOutput.fibreSignal to opticalData;

    doc /*
      Nominal transmitter scenario. Data encoding and drive generation are
      electrical responsibilities; carrier modulation and fibre coupling are
      photonic responsibilities.
    */
  }
}
