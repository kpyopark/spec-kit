---
description: Execute the implementation planning workflow using the plan template to generate design artifacts with enhanced MIL-STD-498 and CSCI support.
scripts:
  sh: scripts/bash/setup-plan.sh --json
  ps: scripts/powershell/setup-plan.ps1 -Json
---

Given the implementation details provided as an argument, do this:

1. **Check for MIL-STD-498 structure**: Look for existing `docs/mil-std-498/` directory and constitution.
   - If MIL-STD-498 structure exists, use enhanced CSCI-based planning workflow
   - If not found, use standard planning workflow

2. Run `{SCRIPT}` from the repo root and parse JSON for FEATURE_SPEC, IMPL_PLAN, SPECS_DIR, BRANCH. All future file paths must be absolute.

3. **Load context and analyze feature specification**:
   - Read and analyze the feature specification to understand:
     * Feature requirements and user stories
     * Functional and non-functional requirements
     * Success criteria and acceptance criteria
     * Technical constraints or dependencies mentioned
   - Read the constitution at `/memory/constitution.md` to understand constitutional requirements

4. **For MIL-STD-498 Workflow** (if structure exists):
   - Load constitution to understand defined CSCIs and document structure
   - Identify which functional CSCI(s) this feature belongs to from the specification
   - Consider CSCI-based architecture implications:
     * Frontend/Backend separation within functional areas
     * Cross-CSCI integration requirements
     * Interface specifications between CSCIs
     * Parallel development opportunities

5. **For Standard Workflow** (if no MIL-STD-498 structure):
   - Follow traditional planning approach
   - Focus on single project organization
   - Generate standard artifacts

6. **Execute the implementation plan template**:
   - Load `/templates/plan-template.md` (already copied to IMPL_PLAN path)
   - Set Input path to FEATURE_SPEC
   - Run the Execution Flow (main) function steps 1-9
   - The template is self-contained and executable
   - Follow error handling and gate checks as specified
   - **Enhanced artifact generation in $SPECS_DIR:**

     **For MIL-STD-498 Workflow:**
     * Phase 0: Enhanced research.md with CSCI considerations
     * Phase 1: CSCI-aware data-model.md, contracts/, quickstart.md
     * Phase 1: Update relevant MIL-STD-498 documents with technical decisions:
       - `docs/mil-std-498/system-level/ssdd.md` for architecture decisions
       - `docs/mil-std-498/csci/[CSCI_NAME]/srs-frontend.md` for frontend technical specs
       - `docs/mil-std-498/csci/[CSCI_NAME]/srs-backend.md` for backend technical specs
       - `docs/mil-std-498/csci/[CSCI_NAME]/idd-shared.md` for interface technical specs

     **For Standard Workflow:**
     * Phase 0: research.md
     * Phase 1: data-model.md, contracts/, quickstart.md

   - Incorporate user-provided details from arguments into Technical Context: {ARGS}
   - Update Progress Tracking as you complete each phase

7. **Enhanced project type detection and structure**:
   - **Project Type Detection**: Automatically detect web/mobile/CLI projects from specification and user input
   - **CSCI Structure Planning**: If MIL-STD-498 enabled, plan CSCI-based directory organization
   - **Parallel Development Planning**: Identify opportunities for Frontend/Backend parallel work within CSCIs
   - **Cross-CSCI Integration Planning**: Plan integration points between different functional areas

8. **Verify execution completed**:
   - Check Progress Tracking shows all phases complete
   - Ensure all required artifacts were generated
   - Confirm no ERROR states in execution
   - **MIL-STD-498 Verification**: If enabled, verify MIL-STD-498 documents are updated with technical details

9. **Enhanced reporting with CSCI context**:
   - Report results with branch name, file paths, and generated artifacts
   - **If MIL-STD-498 enabled**: Report CSCI identification and mapping
   - **Technical Architecture Summary**: Include project type, CSCI organization, and parallel development opportunities
   - **Readiness for next phase**: Confirm readiness for `/tasks` command with CSCI context

**CSCI Integration Guidelines:**
- **Authentication/Login features** → Technical planning for "authentication" CSCI
- **HR/Employee features** → Technical planning for "hr" CSCI
- **Financial/Payment features** → Technical planning for "finance" CSCI
- **Cross-CSCI features** → Plan integration architecture and shared components

Use absolute paths with the repository root for all file operations to avoid path issues.
