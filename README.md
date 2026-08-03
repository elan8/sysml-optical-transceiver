# SysML Optical Transceiver

A SysML v2 reference project for a silicon-photonics optical transceiver, developed with the Elan8 Method.

The initial scope is deliberately transmitter-first. The project begins with the module boundary and external interfaces, then develops one electrical-to-optical golden thread through requirements, architecture, analysis, verification, PIC projection, and generated layout evidence.

## Current increment

**EI-001 — Define the transceiver boundary**

Engineering question:

> What does the optical transceiver exchange with its environment, and where is its system boundary?

The model currently contains only the black-box module, external actors, typed boundary ports, initial needs and interface requirements, verification intent, and a context view. Internal transmitter and receiver components are intentionally deferred.

## Repository map

| Path | Purpose |
| --- | --- |
| `model/00_project/` | Elan8 Method tailoring |
| `model/10_purpose/` | Stakeholders, needs, requirements, and operational context |
| `model/20_behavior/` | Scenarios and behavior, starting in EI-002 |
| `model/30_architecture/` | Selected system usage and later architecture |
| `model/40_analysis/` | Executable analyses, starting in EI-003 |
| `model/50_verification/` | Verification intent and evidence links |
| `model/60_views/` | Views over the authoritative model graph |
| `model/90_library/` | Project-local import hub |
| `library/photonics/` | Experimental reusable photonics definitions |
| `PROJECT_PLAN.md` | Tracked delivery plan and baseline strategy |

## Validation

Requires sibling checkouts of `mbse-methodology`, `sysml-domain-libraries`, and a Spec42 executable:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate.ps1
```

Environment overrides are supported through `SPEC42_EXE`, `ELAN8_METHOD_LIBRARY_ROOT`, and `SYSML_DOMAIN_LIBRARIES_ROOT`.

## Scope boundary

The continuous-wave laser is external to the initial module. Generated layout will initially target semantic connectivity and an L1 generic-PDK layout skeleton; it is not a foundry-ready implementation.
