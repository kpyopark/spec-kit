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

## CSCI Structure Definition

### Project CSCI Organization
This project follows MIL-STD-498 CSCI-based organization. All features must be developed within a designated CSCI (Computer Software Configuration Item). Each CSCI represents a functional area with independent Frontend, Backend, and Interface specifications.

### Defined CSCIs

#### 1. Authentication CSCI
**CSCI ID**: `authentication`
**Purpose**: User authentication, authorization, and session management
**Scope**:
- Frontend: Login UI, authentication state management, protected routes
- Backend: JWT generation, user verification, session APIs, password management
- Interfaces: Authentication tokens, user session data, login/logout endpoints

#### 2. HR CSCI
**CSCI ID**: `hr`
**Purpose**: Human resources and employee management
**Scope**:
- Frontend: Employee profiles, org charts, HR dashboards
- Backend: Employee data management, HR workflows, payroll processing
- Interfaces: Employee data APIs, HR event notifications, org structure endpoints

#### 3. Finance CSCI
**CSCI ID**: `finance`
**Purpose**: Financial transactions, billing, and accounting
**Scope**:
- Frontend: Payment UI, transaction history, financial reports
- Backend: Payment processing, invoice generation, accounting logic
- Interfaces: Payment APIs, transaction events, financial data endpoints

#### 4. Common CSCI
**CSCI ID**: `common`
**Purpose**: Shared infrastructure and cross-cutting concerns
**Scope**:
- Frontend: Design system, shared UI components, common utilities
- Backend: Logging, monitoring, configuration, middleware, error handling
- Interfaces: Common types, shared utilities, infrastructure APIs
- Cross-CSCI: Integration features spanning multiple functional CSCIs

### CSCI Selection Guidelines

**Rule 1**: Single-domain feature → Use specific CSCI (authentication, hr, finance)
**Rule 2**: Infrastructure/tooling → Use common CSCI
**Rule 3**: Cross-cutting concerns (logging, monitoring, config) → Use common CSCI
**Rule 4**: Multi-domain integration feature → Use common CSCI, coordinate updates to related CSCIs

### CSCI-Based Git Workflow

**Branch Naming**: `[csci-id]/[number]-[feature-name]`
Examples:
- `authentication/001-login`
- `hr/001-employee-profile`
- `common/001-logging-infrastructure`

Each CSCI maintains independent feature numbering for better organization.

## Document Structure Framework (MIL-STD-498 Based)

### Document Architecture
[DOCUMENT_ARCHITECTURE]
<!-- Example: This project follows MIL-STD-498 CSCI-based structure with system-level and CSCI-level documentation optimized for modular development and LLM code generation -->

### Required Documents

#### System-Level Documents
- **OCD (Operational Concept Document)** - [OCD_DESCRIPTION]
  <!-- Example: Provides business context and operational scenarios for the entire system -->
- **SSDD (System/Subsystem Design Document)** - [SSDD_DESCRIPTION]
  <!-- Example: Defines system-wide architecture, technology stack, and design principles -->

#### CSCI-Level Documents (Per Functional Area)
Each CSCI contains three synchronized documents:
- **SRS-Frontend** - [SRS_FRONTEND_DESCRIPTION]
  <!-- Example: Frontend-specific requirements for UI/UX and client-side logic -->
- **SRS-Backend** - [SRS_BACKEND_DESCRIPTION]
  <!-- Example: Backend-specific requirements for business logic and data processing -->
- **IDD-Shared** - [IDD_SHARED_DESCRIPTION]
  <!-- Example: Interface specification defining Frontend ↔ Backend communication contracts -->

### Document Standards
[DOCUMENT_STANDARDS]
<!-- Example: All documents follow MIL-STD-498 principles with CSCI-based modular organization for independent development and testing -->

### CSCI Directory Structure
When MIL-STD-498 document structure is enabled, the following CSCI-centric directory structure will be created:

```
csci/
├── system/
│   └── docs/
│       ├── ocd.md                         # Operational Concept Document (system-wide)
│       └── ssdd.md                        # System/Subsystem Design Document (system-wide)
├── authentication/
│   ├── docs/
│   │   ├── srs-frontend.md                # Frontend Requirements
│   │   ├── srs-backend.md                 # Backend Requirements
│   │   └── idd-shared.md                  # Interface Specification
│   ├── features/
│   │   ├── 001-login/
│   │   │   ├── spec.md                    # Feature specification
│   │   │   ├── plan.md                    # Implementation plan
│   │   │   ├── tasks.md                   # Task breakdown
│   │   │   └── artifacts/                 # Supporting documents
│   │   └── 002-password-reset/
│   └── src/                               # Implementation code (optional)
│       ├── frontend/
│       └── backend/
├── hr/
│   ├── docs/
│   ├── features/
│   └── src/
├── finance/
│   ├── docs/
│   ├── features/
│   └── src/
└── common/
    ├── docs/
    ├── features/
    └── src/
```

[CSCI_STRUCTURE_RATIONALE]
<!-- Example: CSCI-centric structure enables true modular development where each functional area (authentication, hr, finance, common) is self-contained with its own documentation, features, and implementation code. This supports independent development, testing, and deployment of CSCIs while maintaining clear separation of concerns. -->

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