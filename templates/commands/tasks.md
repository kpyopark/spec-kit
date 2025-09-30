---
description: Generate an actionable, dependency-ordered tasks.md for the feature based on available design artifacts.
scripts:
  sh: scripts/bash/check-task-prerequisites.sh --json
  ps: scripts/powershell/check-task-prerequisites.ps1 -Json
---

Given the context provided as an argument, do this:

1. **Check for MIL-STD-498 structure**: Look for existing `docs/mil-std-498/` directory and constitution.
   - If MIL-STD-498 structure exists, use enhanced CSCI-based task generation
   - If not found, use standard task generation workflow

2. Run `{SCRIPT}` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute.

3. **For MIL-STD-498 Workflow** (if structure exists):
   - Load constitution at `/memory/constitution.md` to understand defined CSCIs
   - Read available MIL-STD-498 documents:
     * `docs/mil-std-498/system-level/ocd.md` for operational context
     * `docs/mil-std-498/system-level/ssdd.md` for system architecture
     * `docs/mil-std-498/csci/[CSCI_NAME]/srs-frontend.md` for Frontend requirements
     * `docs/mil-std-498/csci/[CSCI_NAME]/srs-backend.md` for Backend requirements
     * `docs/mil-std-498/csci/[CSCI_NAME]/idd-shared.md` for interface specifications
   - Identify which CSCIs are relevant to this feature from the design documents

4. **For Standard Workflow** (if no MIL-STD-498 structure):
   - Always read plan.md for tech stack and libraries
   - IF EXISTS: Read data-model.md for entities
   - IF EXISTS: Read contracts/ for API endpoints
   - IF EXISTS: Read research.md for technical decisions
   - IF EXISTS: Read quickstart.md for test scenarios

   Note: Not all projects have all documents. For example:
   - CLI tools might not have contracts/
   - Simple libraries might not need data-model.md
   - Generate tasks based on what's available

5. **Generate tasks following the enhanced template**:
   - Use `/templates/tasks-template.md` as the base
   - **For MIL-STD-498 Workflow**:
     * **Setup tasks**: Project init, dependencies, linting, CSCI directory structure
     * **CSCI Test tasks [P]**: Contract tests for each CSCI (Frontend/Backend/Interface)
     * **CSCI Implementation tasks [P]**: Frontend and Backend tasks per CSCI (can be parallel)
     * **Interface tasks**: API implementation based on IDD-Shared specifications
     * **Integration tasks**: Cross-CSCI communication, system integration
     * **Polish tasks [P]**: CSCI-specific unit tests, performance, documentation
   - **For Standard Workflow**:
     * **Setup tasks**: Project init, dependencies, linting
     * **Test tasks [P]**: One per contract, one per integration scenario
     * **Core tasks**: One per entity, service, CLI command, endpoint
     * **Integration tasks**: DB connections, middleware, logging
     * **Polish tasks [P]**: Unit tests, performance, docs

6. **Enhanced task generation rules**:
   - **For MIL-STD-498**:
     * Each CSCI → separate Frontend/Backend task groups [P]
     * Each SRS-Frontend requirement → Frontend component task [P]
     * Each SRS-Backend requirement → Backend service task [P]
     * Each IDD-Shared interface → contract test + implementation task
     * Different CSCIs = can be parallel [P]
     * Frontend/Backend within same CSCI = can be parallel [P]
   - **For Standard**:
     * Each contract file → contract test task marked [P]
     * Each entity in data-model → model creation task marked [P]
     * Each endpoint → implementation task (not parallel if shared files)
     * Each user story → integration test marked [P]
     * Different files = can be parallel [P]
     * Same file = sequential (no [P])

7. **Order tasks by dependencies**:
   - **For MIL-STD-498**: Setup → CSCI Tests → CSCI Implementation → CSCI Integration → Polish
   - **For Standard**: Setup → Tests → Models → Services → Endpoints → Polish
   - Tests always before implementation (TDD)
   - Dependencies block parallel execution

8. **Include parallel execution examples**:
   - Group [P] tasks that can run together
   - Show CSCI-based parallelization if applicable
   - Show actual Task agent commands

9. **Create FEATURE_DIR/tasks.md with**:
   - Correct feature name from implementation plan
   - CSCI identification and mapping (if MIL-STD-498 enabled)
   - Numbered tasks (T001, T002, etc.)
   - Clear file paths for each task with CSCI organization
   - Dependency notes including CSCI dependencies
   - Parallel execution guidance with CSCI coordination

Context for task generation: {ARGS}

The tasks.md should be immediately executable - each task must be specific enough that an LLM can complete it without additional context.
