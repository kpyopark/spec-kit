---
description: Execute the implementation plan by processing and executing all tasks defined in tasks.md with enhanced MIL-STD-498 and CSCI support
scripts:
  sh: scripts/bash/check-implementation-prerequisites.sh --json
  ps: scripts/powershell/check-implementation-prerequisites.ps1 -Json
---

Given the current feature context, do this:

1. **Check for MIL-STD-498 structure**: Look for existing `docs/mil-std-498/` directory and constitution.
   - If MIL-STD-498 structure exists, use enhanced CSCI-based implementation workflow
   - If not found, use standard implementation workflow

2. Run `{SCRIPT}` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute.

3. **Load and analyze the implementation context**:
   - **REQUIRED**: Read tasks.md for the complete task list and execution plan
   - **REQUIRED**: Read plan.md for tech stack, architecture, and file structure
   - **IF EXISTS**: Read data-model.md for entities and relationships
   - **IF EXISTS**: Read contracts/ for API specifications and test requirements
   - **IF EXISTS**: Read research.md for technical decisions and constraints
   - **IF EXISTS**: Read quickstart.md for integration scenarios

4. **For MIL-STD-498 Workflow** (if structure exists):
   - Load constitution at `/memory/constitution.md` to understand defined CSCIs
   - Read available MIL-STD-498 documents for additional context:
     * `docs/mil-std-498/system-level/ocd.md` for operational scenarios
     * `docs/mil-std-498/system-level/ssdd.md` for system architecture
     * `docs/mil-std-498/csci/[CSCI_NAME]/srs-frontend.md` for Frontend requirements
     * `docs/mil-std-498/csci/[CSCI_NAME]/srs-backend.md` for Backend requirements
     * `docs/mil-std-498/csci/[CSCI_NAME]/idd-shared.md` for interface specifications
   - Identify which CSCIs are involved in this feature implementation

5. **Parse tasks.md structure and extract**:
   - **Task phases**: Setup, Tests, Core, Integration, Polish
   - **Task dependencies**: Sequential vs parallel execution rules
   - **Task details**: ID, description, file paths, parallel markers [P]
   - **Execution flow**: Order and dependency requirements
   - **CSCI organization** (if MIL-STD-498 enabled): CSCI-based task grouping and coordination

6. **Execute implementation following the enhanced task plan**:

   **For MIL-STD-498 Workflow:**
   - **CSCI-aware execution**: Coordinate tasks across functional areas (authentication, hr, finance)
   - **Enhanced parallel execution**:
     * Different CSCIs can execute in parallel [P]
     * Frontend/Backend within same CSCI can execute in parallel [P]
     * Cross-CSCI integration tasks must be sequential
   - **CSCI validation checkpoints**: Verify each CSCI completion before cross-CSCI integration

   **For Standard Workflow:**
   - **Phase-by-phase execution**: Complete each phase before moving to the next
   - **Basic parallel execution**: Tasks marked [P] can run together if no file conflicts

   **Universal Rules:**
   - **Respect dependencies**: Run sequential tasks in order
   - **Follow TDD approach**: Execute test tasks before their corresponding implementation tasks
   - **File-based coordination**: Tasks affecting the same files must run sequentially
   - **Validation checkpoints**: Verify each phase completion before proceeding

7. **Enhanced implementation execution rules**:

   **For MIL-STD-498 Workflow:**
   - **CSCI Setup**: Initialize CSCI-based project structure, dependencies, configuration
   - **CSCI Tests first**: Write and execute tests for each CSCI (Frontend/Backend/Interface)
   - **CSCI Core development**: Implement models, services, controllers per functional area
   - **Cross-CSCI Integration**: Database connections, middleware, logging, external services
   - **CSCI Polish and validation**: Unit tests, performance optimization, CSCI-specific documentation

   **For Standard Workflow:**
   - **Setup first**: Initialize project structure, dependencies, configuration
   - **Tests before code**: Write tests for contracts, entities, and integration scenarios
   - **Core development**: Implement models, services, CLI commands, endpoints
   - **Integration work**: Database connections, middleware, logging, external services
   - **Polish and validation**: Unit tests, performance optimization, documentation

8. **Enhanced progress tracking and error handling**:
   - **CSCI-aware progress reporting**: Report progress per CSCI and overall feature progress
   - **CSCI coordination**: Handle dependencies between different functional areas
   - **Enhanced parallel execution**: Coordinate Frontend/Backend teams within CSCIs
   - **Error isolation**: Isolate errors to specific CSCIs to prevent blocking other areas
   - **Progress tracking**:
     * Report progress after each completed task
     * For CSCI tasks: Report CSCI completion status
     * Halt execution if critical CSCI dependencies fail
     * For parallel tasks [P], continue with successful tasks, report failed ones
     * Provide clear error messages with CSCI context for debugging
     * Suggest next steps with CSCI-specific guidance
   - **IMPORTANT** For completed tasks, mark as [X] in the tasks file and update CSCI status

9. **Enhanced completion validation**:
   - **Standard validation**:
     * Verify all required tasks are completed
     * Check that implemented features match the original specification
     * Validate that tests pass and coverage meets requirements
     * Confirm the implementation follows the technical plan

   - **MIL-STD-498 enhanced validation** (if enabled):
     * Verify all target CSCIs are fully implemented
     * Validate Frontend/Backend integration within each CSCI
     * Confirm Cross-CSCI integration points are working
     * Verify compliance with MIL-STD-498 interface specifications
     * Validate that implementation matches CSCI requirements documents

   - **Final reporting**:
     * Standard: Report final status with summary of completed work
     * MIL-STD-498: Include CSCI completion status, integration validation, and compliance summary

Note: This command assumes a complete task breakdown exists in tasks.md. If tasks are incomplete or missing, suggest running `/tasks` first to regenerate the task list.