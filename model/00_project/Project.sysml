package Project {
  doc /*
    Project metadata and Elan8 Method tailoring. Process ownership, increment
    identity, review, and releases remain in Git.
  */

  private import Elan8::Method::Core::*;

  part projectInfo : ProjectInfo {
    attribute :>> projectName = "SysmlOpticalTransceiver";
    attribute :>> profile = medium;
    attribute :>> notes = "Medium-lite tailoring: explicit interfaces, structured analysis and verification, and evidence provenance without a regulated lifecycle workflow.";
  }
}
