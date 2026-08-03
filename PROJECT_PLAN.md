# Optical Transceiver Reference Project Plan

## Primary demonstration

Show that replacing a fibre coupler with a higher-loss alternative propagates through the SysML v2 model into the optical power budget, requirement verdict, evidence freshness, architecture decision, PIC IR, layout, and connectivity evidence.

Three result streams support this demonstration:

1. **Reference model** — a multidisciplinary SysML v2 product model.
2. **Method experiment** — a practical evaluation of Elan8 Engineering Increments.
3. **Toolchain demonstrator** — a reproducible Spec42 → `pic42` → gdsfactory evidence workflow.

## Initial scope

- Single-channel silicon-photonics transceiver module.
- External continuous-wave laser at approximately 1550 nm.
- Transmitter-first vertical slice using NRZ/OOK and a Mach-Zehnder modulator.
- Generic PDK and gdsfactory for the initial layout skeleton.
- Receiver, packaging, thermal control, calibration, and firmware as later extensions.

## Engineering Increments

| Increment | Engineering question | Result |
| --- | --- | --- |
| EI-001 ✓ | What crosses the system boundary? | Actors, needs, typed external interfaces, context view |
| EI-002 (current) | How is electrical data converted to modulated optical output? | Transmit behavior and architecture |
| EI-003 | Is sufficient optical power available at the fibre output? | Executable power-budget golden thread |
| EI-004 | Can the selected transmitter PIC project to technology-neutral PIC IR? | L0 semantic connectivity |
| EI-005 | Does an L1 generated layout preserve intended connectivity? | GDS/OASIS, netlist, verdict, provenance |
| EI-006 | What is the impact of a higher-loss fibre coupler? | Requirement failure and stale-evidence demonstration |
| EI-007 | Can the receive path recover usable electrical data? | Receiver golden thread |
| EI-008 | How do other disciplines constrain the PIC? | Multidisciplinary module integration |

Each increment is normally one reviewable PR. The PR carries its identity, ownership, review, method hypothesis, and completion criteria. Product meaning remains in SysML.

## Baselines

- **Baseline A — Model golden thread:** EI-001 through EI-003.
- **Baseline B — Executable PIC projection:** EI-004 and EI-005.
- **Baseline C — Change-impact demonstration:** EI-006.
- **Roadmap extension:** EI-007 and EI-008.

## Fidelity

| Level | Meaning | Status |
| --- | --- | --- |
| L0 | Semantic components, ports, parameters, and nets | Planned for EI-004 |
| L1 | Generic-PDK layout skeleton | Planned for EI-005 |
| L2 | Technology-specific DRC and simulation | Later |
| L3 | Foundry-ready sign-off | Out of scope |

## Method tailoring

The model records the standard `medium` profile with notes describing the intended medium-lite tailoring: explicit interface contracts, structured analysis and verification, assumptions, decisions, and evidence provenance, without a regulated lifecycle workflow.

## Current acceptance gate

EI-002 is complete when the nominal electrical-to-optical behavior is explicit, responsibilities are allocated to logical components, all peer connections use compatible typed ports, boundary delegation is explicit, both focused views answer the engineering question, verification intent has a reviewable pass criterion, Spec42 validation is green, and quantitative power-budget claims remain deferred to EI-003.
