---
description: Create or update the feature specification from a natural language feature description with CSCI selection.
scripts:
  sh: scripts/bash/create-new-feature.sh --json --csci {CSCI} "{ARGS}"
  ps: scripts/powershell/create-new-feature.ps1 -Json -Csci {CSCI} "{ARGS}"
---

Given the feature description provided as an argument, do this:

1. **CSCI Selection** (REQUIRED):
   - Load constitution at `/memory/constitution.md`
   - Extract available CSCIs by looking for `**CSCI ID**: \`csci-name\`` patterns
   - Analyze feature description to identify most appropriate CSCI:
     * Authentication/Login/User management → "authentication" CSCI
     * HR/Employee/Payroll features → "hr" CSCI
     * Financial/Payment/Billing features → "finance" CSCI
     * Infrastructure/Logging/Shared components → "common" CSCI
   - If ambiguous, present CSCI options to user for selection
   - If user provided explicit CSCI preference, use that

2. **Run script with selected CSCI**:
   - First attempt: Run `{SCRIPT}` WITHOUT --csci flag to get available CSCIs
   - If script returns ERROR="CSCI_REQUIRED", use AVAILABLE_CSCIS list
   - Second run: Execute script with `--csci [SELECTED_CSCI]` parameter
   - Parse JSON output for: BRANCH_NAME, SPEC_FILE, CSCI_NAME, CSCI_DIR, FEATURE_DIR, CSCI_DOCS_DIR
   - All file paths must be absolute
   - **IMPORTANT**: Only run script twice maximum (once for CSCI list, once for creation)

3. **For Standard Workflow** (if no MIL-STD-498 structure):
   - Load `templates/spec-template.md` to understand required sections
   - Write the specification to SPEC_FILE using template structure
   - Report completion with branch name and spec file path

3. **Write Feature Specification**:
   - Load `templates/spec-template.md` to understand required sections
   - Add CSCI context section at the top:
     ```markdown
     ## CSCI Context
     - **Primary CSCI**: [CSCI_NAME]
     - **CSCI Location**: csci/[CSCI_NAME]/
     - **Feature Directory**: csci/[CSCI_NAME]/features/[FEATURE_NUM]-[name]/
     ```
   - Write complete specification to FEATURE_DIR/spec.md

4. **Update CSCI MIL-STD-498 Documents** (if MIL_STD_498_ENABLED=true):
   - **System-Level Documents**:
     * Update `csci/system/docs/ocd.md` with operational scenarios from feature description
     * Update `csci/system/docs/ssdd.md` with system-wide design implications

   - **CSCI-Level Documents** (for selected CSCI):
     * Update `csci/[CSCI_NAME]/docs/srs-frontend.md` with Frontend requirements
     * Update `csci/[CSCI_NAME]/docs/srs-backend.md` with Backend requirements
     * Update `csci/[CSCI_NAME]/docs/idd-shared.md` with Interface specifications

   - Use templates from `templates/mil-std-498/` directories
   - Each update should add new sections/requirements, not replace entire documents

5. **Report completion**:
   - Branch name: [CSCI]/[NUM]-[name]
   - Spec file: csci/[CSCI]/features/[NUM]-[name]/spec.md
   - CSCI: [CSCI_NAME]
   - Updated CSCI docs: [list of updated files]
   - Readiness for next phase: /plan

**Note**: The script creates the CSCI-based branch, directory structure, and initializes spec.md before AI processing.
