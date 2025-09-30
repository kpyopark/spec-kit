---
description: "Implementation plan template for feature development"
scripts:
  sh: scripts/bash/update-agent-context.sh __AGENT__
  ps: scripts/powershell/update-agent-context.ps1 -AgentType __AGENT__
---

# Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Feature specification from `/specs/[###-feature-name]/spec.md`

## Execution Flow (/plan command scope)
```
1. Check for MIL-STD-498 structure and load context:
   → Look for existing docs/mil-std-498/ directory
   → If exists: Enable MIL-STD-498 workflow, load constitution for CSCI definitions
   → If not: Use standard workflow
   → Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"

2. Fill Technical Context (scan for NEEDS CLARIFICATION):
   → Detect Project Type from context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
   → If MIL-STD-498 enabled: Identify target CSCI(s) from feature description
   → Plan CSCI-based architecture considerations

3. Fill the Constitution Check section based on the content of the constitution document.

4. Evaluate Constitution Check section:
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check

5. Execute Phase 0 → Enhanced research.md:
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
   → If MIL-STD-498 enabled: Include CSCI architecture considerations

6. Execute Phase 1 → Enhanced artifact generation:
   → Standard: contracts, data-model.md, quickstart.md, agent-specific template file
   → If MIL-STD-498 enabled: Also update relevant MIL-STD-498 documents:
     * docs/mil-std-498/system-level/ssdd.md (architecture decisions)
     * docs/mil-std-498/csci/[CSCI_NAME]/srs-frontend.md (frontend tech specs)
     * docs/mil-std-498/csci/[CSCI_NAME]/srs-backend.md (backend tech specs)
     * docs/mil-std-498/csci/[CSCI_NAME]/idd-shared.md (interface tech specs)

7. Re-evaluate Constitution Check section:
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check

8. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md):
   → If MIL-STD-498 enabled: Plan CSCI-based task generation strategy
   → Consider Frontend/Backend parallel development within CSCIs
   → Identify cross-CSCI integration points

9. STOP - Ready for /tasks command (with CSCI context if applicable)
```

**IMPORTANT**: The /plan command STOPS at step 7. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
[Extract from feature spec: primary requirement + technical approach from research]

## Technical Context
**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION]
**Primary Dependencies**: [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION]
**Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION]
**Target Platform**: [e.g., Linux server, iOS 15+, WASM or NEEDS CLARIFICATION]
**Project Type**: [single/web/mobile - determines source structure]
**Performance Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION]
**Constraints**: [domain-specific, e.g., <200ms p95, <100MB memory, offline-capable or NEEDS CLARIFICATION]
**Scale/Scope**: [domain-specific, e.g., 10k users, 1M LOC, 50 screens or NEEDS CLARIFICATION]

### MIL-STD-498 Context (if enabled)
**MIL-STD-498 Structure**: [enabled/disabled]
**Target CSCI(s)**: [e.g., authentication, hr, finance or N/A if disabled]
**CSCI Architecture Considerations**:
- **Frontend/Backend Separation**: [How this feature separates concerns within CSCI]
- **Cross-CSCI Integration**: [Integration points with other functional areas]
- **Interface Requirements**: [API contracts between Frontend/Backend within CSCI]
- **Parallel Development Strategy**: [How Frontend/Backend teams can work simultaneously]

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

[Gates determined based on constitution file]

## Project Structure

### Documentation (this feature)
```
specs/[###-feature]/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### MIL-STD-498 Documentation (if enabled)
```
docs/mil-std-498/
├── system-level/
│   ├── ocd.md           # Operational Concept Document (updated by /specify)
│   └── ssdd.md          # System/Subsystem Design Document (updated by /plan)
└── csci/
    ├── [TARGET_CSCI]/
    │   ├── srs-frontend.md    # Frontend requirements (updated by /specify & /plan)
    │   ├── srs-backend.md     # Backend requirements (updated by /specify & /plan)
    │   └── idd-shared.md      # Interface specifications (updated by /specify & /plan)
    └── [OTHER_CSCI]/
        ├── srs-frontend.md
        ├── srs-backend.md
        └── idd-shared.md
```

### Source Code (repository root)
```
# Option 1: Single project (DEFAULT)
src/
├── models/
├── services/
├── cli/
└── lib/

tests/
├── contract/
├── integration/
└── unit/

# Option 2: Web application (when "frontend" + "backend" detected)
backend/
├── src/
│   ├── models/
│   ├── services/
│   └── api/
└── tests/

frontend/
├── src/
│   ├── components/
│   ├── pages/
│   └── services/
└── tests/

# Option 3: Mobile + API (when "iOS/Android" detected)
api/
└── [same as backend above]

ios/ or android/
└── [platform-specific structure]

# Option 4: CSCI-Based Structure (when MIL-STD-498 enabled)
backend/
├── src/
│   ├── [CSCI_NAME]/        # e.g., authentication/
│   │   ├── models/
│   │   ├── services/
│   │   └── controllers/
│   ├── shared/             # Cross-CSCI shared components
│   └── integration/        # Cross-CSCI integration layer
└── tests/
    ├── csci/
    │   └── [CSCI_NAME]/
    ├── integration/
    └── unit/

frontend/
├── src/
│   ├── [CSCI_NAME]/        # e.g., authentication/
│   │   ├── components/
│   │   ├── pages/
│   │   └── services/
│   ├── shared/             # Cross-CSCI shared components
│   └── integration/        # Cross-CSCI integration layer
└── tests/
    ├── csci/
    │   └── [CSCI_NAME]/
    ├── integration/
    └── unit/
```

**Structure Decision**: [DEFAULT to Option 1 unless Technical Context indicates web/mobile app or MIL-STD-498 CSCI structure]

## Phase 0: Outline & Research
1. **Extract unknowns from Technical Context** above:
   - For each NEEDS CLARIFICATION → research task
   - For each dependency → best practices task
   - For each integration → patterns task

2. **Generate and dispatch research agents**:
   ```
   For each unknown in Technical Context:
     Task: "Research {unknown} for {feature context}"
   For each technology choice:
     Task: "Find best practices for {tech} in {domain}"
   ```

3. **Consolidate findings** in `research.md` using format:
   - Decision: [what was chosen]
   - Rationale: [why chosen]
   - Alternatives considered: [what else evaluated]

**Output**: research.md with all NEEDS CLARIFICATION resolved

## Phase 1: Design & Contracts
*Prerequisites: research.md complete*

1. **Extract entities from feature spec** → `data-model.md`:
   - Entity name, fields, relationships
   - Validation rules from requirements
   - State transitions if applicable

2. **Generate API contracts** from functional requirements:
   - For each user action → endpoint
   - Use standard REST/GraphQL patterns
   - Output OpenAPI/GraphQL schema to `/contracts/`

3. **Generate contract tests** from contracts:
   - One test file per endpoint
   - Assert request/response schemas
   - Tests must fail (no implementation yet)

4. **Extract test scenarios** from user stories:
   - Each story → integration test scenario
   - Quickstart test = story validation steps

5. **Update agent file incrementally** (O(1) operation):
   - Run `{SCRIPT}` for your AI assistant
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

6. **Update MIL-STD-498 documents** (if enabled):
   - **System-Level Updates**:
     * Update `docs/mil-std-498/system-level/ssdd.md` with:
       - Architecture decisions from research.md
       - Technology stack selections
       - System-wide design patterns
       - Integration architecture decisions

   - **CSCI-Level Updates** (for target CSCI):
     * Update `docs/mil-std-498/csci/[CSCI_NAME]/srs-frontend.md` with:
       - Frontend technology specifications
       - UI architecture decisions
       - Client-side data flow patterns
       - Frontend performance considerations

     * Update `docs/mil-std-498/csci/[CSCI_NAME]/srs-backend.md` with:
       - Backend technology specifications
       - Business logic architecture
       - Data persistence decisions
       - Backend performance considerations

     * Update `docs/mil-std-498/csci/[CSCI_NAME]/idd-shared.md` with:
       - API contract specifications
       - Interface technology decisions
       - Communication protocols
       - Error handling patterns

**Standard Output**: data-model.md, /contracts/*, failing tests, quickstart.md, agent-specific file
**MIL-STD-498 Output** (if enabled): Updated SSDD and CSCI documents with technical specifications

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Standard Task Generation Strategy**:
- Load `templates/tasks-template.md` as base
- Generate tasks from Phase 1 design docs (contracts, data model, quickstart)
- Each contract → contract test task [P]
- Each entity → model creation task [P]
- Each user story → integration test task
- Implementation tasks to make tests pass

**MIL-STD-498 CSCI-Based Task Generation Strategy** (if enabled):
- Use enhanced tasks-template.md with CSCI support
- Generate CSCI-based task groups:
  * **CSCI Test tasks [P]**: Contract tests for Frontend/Backend/Interface per CSCI
  * **CSCI Implementation tasks [P]**: Frontend and Backend tasks per CSCI (parallel within CSCI)
  * **Interface tasks**: API implementation based on IDD-Shared specifications
  * **Integration tasks**: Cross-CSCI communication and coordination
  * **Polish tasks [P]**: CSCI-specific unit tests, performance, documentation

**Enhanced Ordering Strategy**:
- **Standard**: TDD order → Models → Services → UI → Polish
- **MIL-STD-498**: Setup → CSCI Tests → CSCI Implementation → CSCI Integration → Polish
- **Parallel Execution**:
  * Different CSCIs can run in parallel [P]
  * Frontend/Backend within same CSCI can run in parallel [P]
  * Cross-CSCI dependencies are sequential

**Estimated Output**:
- **Standard**: 25-30 numbered, ordered tasks
- **MIL-STD-498**: 30-50 CSCI-organized tasks with parallel execution markers

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)  
**Phase 4**: Implementation (execute tasks.md following constitutional principles)  
**Phase 5**: Validation (run tests, execute quickstart.md, performance validation)

## Complexity Tracking
*Fill ONLY if Constitution Check has violations that must be justified*

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [ ] Phase 0: Research complete (/plan command)
- [ ] Phase 1: Design complete (/plan command)
- [ ] Phase 2: Task planning complete (/plan command - describe approach only)
- [ ] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [ ] Initial Constitution Check: PASS
- [ ] Post-Design Constitution Check: PASS
- [ ] All NEEDS CLARIFICATION resolved
- [ ] Complexity deviations documented

---
*Based on Constitution v2.1.1 - See `/memory/constitution.md`*
