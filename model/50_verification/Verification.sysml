package Verification {
  doc /* EI-001 verification intent for the external boundary contract. */

  private import TransceiverContext::*;
  private import BoundaryRequirements::*;

  verification case def BoundaryContractInspection {
    subject transceiver : OpticalTransceiverModule;
    objective {
      verify requirement transceiverBoundarySpecification;
    }
    doc /* Inspect the external actors, typed ports, directions, and context connections. */
  }
}
