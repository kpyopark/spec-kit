---
description: Create or update the feature specification from a natural language feature description.
scripts:
  sh: scripts/bash/create-new-feature.sh --json "{ARGS}"
  ps: scripts/powershell/create-new-feature.ps1 -Json "{ARGS}"
---

Given the feature description provided as an argument, do this:

1. **Check for MIL-STD-498 structure**: Look for existing `docs/mil-std-498/` directory created by constitution command.
   - If MIL-STD-498 structure exists, use enhanced MIL-STD-498 workflow
   - If not found, use standard spec.md workflow

2. Run the script `{SCRIPT}` from repo root and parse its JSON output for BRANCH_NAME and SPEC_FILE. All file paths must be absolute.
   **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output - always refer to it to get the actual content you're looking for.

3. **For Standard Workflow** (if no MIL-STD-498 structure):
   - Load `templates/spec-template.md` to understand required sections
   - Write the specification to SPEC_FILE using template structure
   - Report completion with branch name and spec file path

4. **For MIL-STD-498 Workflow** (if structure exists):
   - Load constitution at `/memory/constitution.md` to understand defined CSCIs and document structure
   - Identify which functional CSCI(s) this feature belongs to from the feature description
   - Create/update the following documents with feature-specific content:

     **System-Level Documents:**
     - Update `docs/mil-std-498/system-level/ocd.md` with operational scenarios from feature description
     - Update `docs/mil-std-498/system-level/ssdd.md` with system-wide design implications

     **CSCI-Level Documents** (for identified functional area):
     - Update `docs/mil-std-498/csci/[CSCI_NAME]/srs-frontend.md` with UI/UX requirements from feature description
     - Update `docs/mil-std-498/csci/[CSCI_NAME]/srs-backend.md` with business logic requirements from feature description
     - Update `docs/mil-std-498/csci/[CSCI_NAME]/idd-shared.md` with interface requirements from feature description

   - **Also create traditional spec.md** in specs/[BRANCH_NAME]/ for backward compatibility
   - Use templates from `templates/mil-std-498/system-level/` and `templates/mil-std-498/csci/` directories

5. Report completion with:
   - Branch name and created/updated file paths
   - Whether MIL-STD-498 workflow was used
   - Functional CSCI areas identified and updated
   - Readiness for next phase (/plan)

**CSCI Identification Guidelines:**
- Authentication/Login/User management features → "authentication" CSCI
- Financial/Payment features → "finance" CSCI
- HR/Employee features → "hr" CSCI
- If unclear, ask user to specify the functional CSCI area or create a new one based on feature domain

Note: The script creates and checks out the new branch and initializes the spec file before writing.
