# [PROJECT_NAME] Constitution
<!-- Example: Spec Constitution, TaskFlow Constitution, etc. -->

## Core Principles

### [PRINCIPLE_1_NAME]
<!-- Example: I. Library-First -->
[PRINCIPLE_1_DESCRIPTION]
<!-- Example: Every feature starts as a standalone library; Libraries must be self-contained, independently testable, documented; Clear purpose required - no organizational-only libraries -->

### [PRINCIPLE_2_NAME]
<!-- Example: II. CLI Interface -->
[PRINCIPLE_2_DESCRIPTION]
<!-- Example: Every library exposes functionality via CLI; Text in/out protocol: stdin/args → stdout, errors → stderr; Support JSON + human-readable formats -->

### [PRINCIPLE_3_NAME]
<!-- Example: III. Test-First (NON-NEGOTIABLE) -->
[PRINCIPLE_3_DESCRIPTION]
<!-- Example: TDD mandatory: Tests written → User approved → Tests fail → Then implement; Red-Green-Refactor cycle strictly enforced -->

### [PRINCIPLE_4_NAME]
<!-- Example: IV. Integration Testing -->
[PRINCIPLE_4_DESCRIPTION]
<!-- Example: Focus areas requiring integration tests: New library contract tests, Contract changes, Inter-service communication, Shared schemas -->

### [PRINCIPLE_5_NAME]
<!-- Example: V. Observability, VI. Versioning & Breaking Changes, VII. Simplicity -->
[PRINCIPLE_5_DESCRIPTION]
<!-- Example: Text I/O ensures debuggability; Structured logging required; Or: MAJOR.MINOR.BUILD format; Or: Start simple, YAGNI principles -->

## Document Structure Framework (MIL-STD-498 Based)

### Document Architecture
[DOCUMENT_ARCHITECTURE]
<!-- Example: This project follows a 6-document MIL-STD-498 based structure optimized for Frontend/Backend separation and LLM efficiency -->

### Required Documents

#### System-Level Documents
- **OCD (Operational Concept Document)** - [OCD_DESCRIPTION]
  <!-- Example: Provides business context and scenarios for LLM understanding -->
- **SSDD (System/Subsystem Design Document)** - [SSDD_DESCRIPTION]
  <!-- Example: Defines common architecture, technology stack, and cross-cutting standards -->

#### CSCI-Level Documents (Per Feature)
Each functional CSCI (Computer Software Configuration Item) contains:
- **SRS-Frontend** - [SRS_FRONTEND_DESCRIPTION]
  <!-- Example: Frontend-specific requirements for UI/UX and client-side logic -->
- **SRS-Backend** - [SRS_BACKEND_DESCRIPTION]
  <!-- Example: Backend-specific requirements for business logic and data handling -->
- **IDD-Shared** - [IDD_SHARED_DESCRIPTION]
  <!-- Example: Unified interface specification for Frontend ↔ Backend communication -->

### Document Standards
[DOCUMENT_STANDARDS]
<!-- Example: All documents must follow MIL-STD-498 principles with templates optimized for LLM code generation -->

### CSCI Directory Structure
When MIL-STD-498 document structure is enabled, the following directory structure will be created:

```
docs/
├── mil-std-498/
│   ├── system-level/
│   │   ├── ocd.md                    # Operational Concept Document
│   │   └── ssdd.md                   # System/Subsystem Design Document
│   └── csci/
│       ├── [CSCI_1_NAME]/            # Example: authentication
│       │   ├── srs-frontend.md       # Frontend Requirements
│       │   ├── srs-backend.md        # Backend Requirements
│       │   └── idd-shared.md         # Interface Specification
│       ├── [CSCI_2_NAME]/            # Example: hr
│       │   ├── srs-frontend.md
│       │   ├── srs-backend.md
│       │   └── idd-shared.md
│       ├── [CSCI_3_NAME]/            # Example: finance
│       │   ├── srs-frontend.md
│       │   ├── srs-backend.md
│       │   └── idd-shared.md
│       └── [ADDITIONAL_CSCI]/        # Additional functional CSCIs
│           ├── srs-frontend.md
│           ├── srs-backend.md
│           └── idd-shared.md
```

[CSCI_STRUCTURE_RATIONALE]
<!-- Example: Feature-based CSCI structure enables modular development with clear separation of concerns while maintaining Frontend/Backend/Interface documentation for each functional area -->

## [SECTION_2_NAME]
<!-- Example: Additional Constraints, Security Requirements, Performance Standards, etc. -->

[SECTION_2_CONTENT]
<!-- Example: Technology stack requirements, compliance standards, deployment policies, etc. -->

## [SECTION_3_NAME]
<!-- Example: Development Workflow, Review Process, Quality Gates, etc. -->

[SECTION_3_CONTENT]
<!-- Example: Code review requirements, testing gates, deployment approval process, etc. -->

## Governance
<!-- Example: Constitution supersedes all other practices; Amendments require documentation, approval, migration plan -->

[GOVERNANCE_RULES]
<!-- Example: All PRs/reviews must verify compliance; Complexity must be justified; Use [GUIDANCE_FILE] for runtime development guidance -->

**Version**: [CONSTITUTION_VERSION] | **Ratified**: [RATIFICATION_DATE] | **Last Amended**: [LAST_AMENDED_DATE]
<!-- Example: Version: 2.1.1 | Ratified: 2025-06-13 | Last Amended: 2025-07-16 -->