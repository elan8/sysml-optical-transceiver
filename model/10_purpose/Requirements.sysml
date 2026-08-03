package StakeholdersAndNeeds {
  doc /* Initial stakeholder roles, concerns, and needs for EI-001. */

  private import TransceiverContext::*;
  private import Elan8::Method::Core::*;
  private import Elan8::Method::Metadata::*;

  part def ProductUser;
  part def SystemsEngineer;
  part def PhotonicsEngineer;
  part def ElectronicsEngineer;
  part def VerificationEngineer;

  part productUser : ProductUser;
  part systemsEngineer : SystemsEngineer;
  part photonicsEngineer : PhotonicsEngineer;
  part electronicsEngineer : ElectronicsEngineer;
  part verificationEngineer : VerificationEngineer;

  concern clearSystemBoundary {
    doc /* The module boundary and every external exchange must be unambiguous. */
    subject transceiver : OpticalTransceiverModule;
    stakeholder :>> systemsEngineer;
    stakeholder :>> photonicsEngineer;
    stakeholder :>> electronicsEngineer;
  }

  concern interoperableExternalInterfaces {
    doc /* External optical, electrical, power, and management contracts must be reviewable independently of internal implementation. */
    subject transceiver : OpticalTransceiverModule;
    stakeholder :>> productUser;
    stakeholder :>> systemsEngineer;
    stakeholder :>> verificationEngineer;
  }

  concern traceableEngineeringChange {
    doc /* A component change must expose its effect on requirements, evidence, and implementation results. */
    subject transceiver : OpticalTransceiverModule;
    stakeholder :>> systemsEngineer;
    stakeholder :>> verificationEngineer;
  }

  requirement transferDigitalData {
    @RequirementRole { role = user; }
    @RequirementIdentity { requirementId = "NEED-001"; }
    frame concern interoperableExternalInterfaces;
    doc /* Transfer digital data through optical fibre using explicit external contracts. */
  }

  requirement exposeReviewableBoundary {
    @RequirementRole { role = user; }
    @RequirementIdentity { requirementId = "NEED-002"; }
    frame concern clearSystemBoundary;
    doc /* Make the module boundary and all external exchanges independently reviewable. */
  }

  requirement supportTraceableChange {
    @RequirementRole { role = user; }
    @RequirementIdentity { requirementId = "NEED-003"; }
    frame concern traceableEngineeringChange;
    doc /* Trace engineering changes to affected claims and evidence. */
  }
}

package BoundaryRequirements {
  doc /* Initial system requirements that constrain the black-box boundary. */

  private import TransceiverContext::*;
  private import StakeholdersAndNeeds::*;
  private import Elan8::Method::Core::*;
  private import Elan8::Method::Metadata::*;

  requirement transceiverBoundarySpecification {
    subject transceiver : OpticalTransceiverModule;
    @RequirementRole { role = system; }

    doc /*
      The typed ports of OpticalTransceiverModule define the structural
      boundary contract. The nested requirements state the intended exchanges;
      evidence that an implementation supports them is provided by later
      verification increments rather than Boolean proxy attributes.
    */

    requirement acceptExternalCarrier {
      @RequirementRole { role = interface; }
      @RequirementIdentity { requirementId = "SYS-IF-001"; }
      doc /* Accept the continuous-wave optical carrier through the module boundary. */
    }

    requirement acceptTransmitData {
      @RequirementRole { role = interface; }
      @RequirementIdentity { requirementId = "SYS-IF-002"; }
      doc /* Accept electrical transmit data through the module boundary. */
    }

    requirement provideTransmitOpticalOutput {
      @RequirementRole { role = interface; }
      @RequirementIdentity { requirementId = "SYS-IF-003"; }
      doc /* Emit a modulated optical signal through the transmit fibre boundary. */
    }

    requirement acceptReceiveOpticalInput {
      @RequirementRole { role = interface; }
      @RequirementIdentity { requirementId = "SYS-IF-004"; }
      doc /* Accept the received optical signal through the receive fibre boundary. */
    }

    requirement provideReceiveElectricalData {
      @RequirementRole { role = interface; }
      @RequirementIdentity { requirementId = "SYS-IF-005"; }
      doc /* Emit recovered electrical receive data through the module boundary. */
    }

    requirement acceptExternalPower {
      @RequirementRole { role = interface; }
      @RequirementIdentity { requirementId = "SYS-IF-006"; }
      doc /* Accept electrical power through the module boundary. */
    }

    requirement supportManagement {
      @RequirementRole { role = interface; }
      @RequirementIdentity { requirementId = "SYS-IF-007"; }
      doc /* Exchange management commands and status through a bidirectional interface. */
    }
  }

  dependency transferNeedRefinement
    from transceiverBoundarySpecification to transferDigitalData {
    @Refinement;
  }

  dependency boundaryNeedRefinement
    from transceiverBoundarySpecification to exposeReviewableBoundary {
    @Refinement;
  }
}

package TransmitRequirements {
  doc /* EI-002 behavioral contract for the transmitter-first vertical slice. */

  private import TransceiverContext::*;
  private import StakeholdersAndNeeds::*;
  private import Elan8::Method::Core::*;
  private import Elan8::Method::Metadata::*;

  requirement transmitConversionSpecification {
    subject transceiver : OpticalTransceiverModule;
    @RequirementRole { role = system; }
    @RequirementIdentity { requirementId = "SYS-TX-001"; }

    doc /*
      Convert accepted electrical transmit data into modulation of the accepted
      continuous-wave optical carrier and emit the resulting optical signal at
      the transmit boundary.
    */
  }

  dependency transmitNeedRefinement
    from transmitConversionSpecification to transferDigitalData {
    @Refinement;
  }
}
