# Elan8 Method Tour

This document will grow with one short chapter per accepted Engineering Increment. It explains the engineering spine rather than duplicating the SysML model.

## EI-001 — Define the transceiver boundary

Engineering question:

> What does the optical transceiver exchange with its environment, and where is its system boundary?

Method hypothesis:

> A focused context increment can establish scope and interface contracts without prematurely modelling internal implementation detail.

The system of interest is `Architecture::transceiverSystem`. The operational context is `TransceiverContext::operationalContext`. The external continuous-wave laser supplies an optical carrier through an explicit conjugated port and is not owned by the module.

The context also exposes transmit and receive data boundaries, electrical power, and bidirectional management. These interfaces establish the complete module boundary, while only the transmitter path will be elaborated in the first vertical slice.

The dedicated `ProjectViews::transceiverContextView` projects the context from the same authoritative model graph.

### Review checklist

- Is the system of interest distinguishable from its environment?
- Is the continuous-wave laser clearly external?
- Does every external exchange use a typed port?
- Can later increments add internals without changing the context contract unnecessarily?
- Has the model avoided premature MZI, waveguide, detector, and packaging detail?

### Method observations

The focused context slice kept the external contract stable while exposing a tooling gap for referential parts. Resolving that gap in Spec42 preserved the intended `ref part` semantics instead of forcing a composite-model workaround.

## EI-002 — Define the transmitter behavior and logical architecture

Engineering question:

> How is electrical data converted to modulated optical output?

Method hypothesis:

> A behavior-and-architecture increment can assign the transmitter's essential responsibilities without introducing the quantitative loss model reserved for the next increment.

`Behavior::TransmitOpticalData` defines the nominal chain:

1. encode the accepted electrical data as an NRZ/OOK stream;
2. generate the modulator drive signal;
3. modulate the external continuous-wave optical carrier;
4. couple the modulated PIC signal to the external fibre output.

The selected `Architecture::transceiverSystem` realizes this chain with `TransmitElectronics`, `MachZehnderModulator`, and `OutputFibreCoupler`. Performances and allocations make the responsibility split explicit. Peer components communicate through connections between conforming original/conjugated port usages. Same-oriented system and nested boundary ports are delegated with bindings in the selected usage context.

`ADR-001` records the NRZ/OOK Mach–Zehnder transmitter choice. `ASM-001` keeps carrier generation and laser control outside the module and assumes a suitable external carrier near 1550 nm. No insertion-loss or link-margin values are claimed yet.

`ProjectViews::transmitBehaviorView` projects the action flow, while `ProjectViews::transmitArchitectureView` projects the selected logical decomposition and its internal connections. `Verification::TransmitPathInspection` defines the inspection method and pass criterion for the increment.

### Review checklist

- Does the action flow have an unbroken data/carrier-to-optical-output spine?
- Are electrical and photonic responsibilities distinguishable?
- Are component connections typed and directionally conforming?
- Is boundary delegation explicit without changing the EI-001 external contract?
- Are the MZI/NRZ-OOK decision and external-laser assumption visible?
- Has EI-002 avoided making unsupported optical-power claims?

### Method observations

To be completed during PR review.
