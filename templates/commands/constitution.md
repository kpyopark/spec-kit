---
description: Create or update the project constitution from interactive or provided principle inputs, ensuring all dependent templates stay in sync.
# (No scripts section: constitution edits are manual authoring assisted by the agent)
---

You are updating the project constitution at `/memory/constitution.md`. This file is a TEMPLATE containing placeholder tokens in square brackets (e.g. `[PROJECT_NAME]`, `[PRINCIPLE_1_NAME]`). Your job is to (a) collect/derive concrete values, (b) fill the template precisely, and (c) propagate any amendments across dependent artifacts.

Follow this execution flow:

1. Load the existing constitution template at `/memory/constitution.md`.
   - Identify every placeholder token of the form `[ALL_CAPS_IDENTIFIER]`.
   **IMPORTANT**: The user might require less or more principles than the ones used in the template. If a number is specified, respect that - follow the general template. You will update the doc accordingly.

2. Check if MIL-STD-498 document structure is requested:
   - If user mentions "MIL-STD-498", "document structure", "OCD", "SSDD", "SRS", "IDD", or "CSCI", enable MIL-STD-498 framework
   - If enabled, create CSCI-centric directory structure
   - If user specifies CSCI names (e.g., "authentication", "hr", "finance", "common"), create those CSCIs
   - If no specific CSCIs mentioned, use default set: authentication, hr, finance, common
   - **Important**: "common" CSCI is ALWAYS created for shared infrastructure

3. Collect/derive values for placeholders:
   - If user input (conversation) supplies a value, use it.
   - Otherwise infer from existing repo context (README, docs, prior constitution versions if embedded).
   - For governance dates: `RATIFICATION_DATE` is the original adoption date (if unknown ask or mark TODO), `LAST_AMENDED_DATE` is today if changes are made, otherwise keep previous.
   - `CONSTITUTION_VERSION` must increment according to semantic versioning rules:
     * MAJOR: Backward incompatible governance/principle removals or redefinitions.
     * MINOR: New principle/section added or materially expanded guidance.
     * PATCH: Clarifications, wording, typo fixes, non-semantic refinements.
   - If version bump type ambiguous, propose reasoning before finalizing.

4. Create MIL-STD-498 CSCI structure if enabled:
   - **System-Level Documents**:
     * Create `csci/system/docs/ocd.md` from `templates/mil-std-498/system-level/ocd-template.md`
     * Create `csci/system/docs/ssdd.md` from `templates/mil-std-498/system-level/ssdd-template.md`

   - **For each CSCI** (authentication, hr, finance, common, etc.):
     * Create directory structure: `csci/[CSCI_NAME]/docs/`, `csci/[CSCI_NAME]/features/`, `csci/[CSCI_NAME]/src/`
     * Create `csci/[CSCI_NAME]/docs/srs-frontend.md` from template
     * Create `csci/[CSCI_NAME]/docs/srs-backend.md` from template
     * Create `csci/[CSCI_NAME]/docs/idd-shared.md` from template

   - Replace template placeholders with project-specific values in all created documents
   - Each CSCI is a self-contained functional area with its own docs, features, and implementation code

5. Draft the updated constitution content:
   - Replace every placeholder with concrete text (no bracketed tokens left except intentionally retained template slots that the project has chosen not to define yet—explicitly justify any left).
   - Preserve heading hierarchy and comments can be removed once replaced unless they still add clarifying guidance.
   - Ensure each Principle section: succinct name line, paragraph (or bullet list) capturing non‑negotiable rules, explicit rationale if not obvious.
   - Ensure Governance section lists amendment procedure, versioning policy, and compliance review expectations.
   - If MIL-STD-498 enabled, update CSCI_STRUCTURE_RATIONALE and list created CSCIs

6. Consistency propagation checklist (convert prior checklist into active validations):
   - Read `/templates/plan-template.md` and ensure any "Constitution Check" or rules align with updated principles.
   - Read `/templates/spec-template.md` for scope/requirements alignment—update if constitution adds/removes mandatory sections or constraints.
   - Read `/templates/tasks-template.md` and ensure task categorization reflects new or removed principle-driven task types (e.g., observability, versioning, testing discipline).
   - Read each command file in `/templates/commands/*.md` (including this one) to verify no outdated references (agent-specific names like CLAUDE only) remain when generic guidance is required.
   - Read any runtime guidance docs (e.g., `README.md`, `docs/quickstart.md`, or agent-specific guidance files if present). Update references to principles changed.

7. Produce a Sync Impact Report (prepend as an HTML comment at top of the constitution file after update):
   - Version change: old → new
   - List of modified principles (old title → new title if renamed)
   - Added sections
   - Removed sections
   - Templates requiring updates (✅ updated / ⚠ pending) with file paths
   - MIL-STD-498 documents created (if any) with file paths and CSCI names
   - Follow-up TODOs if any placeholders intentionally deferred.

8. Validation before final output:
   - No remaining unexplained bracket tokens.
   - Version line matches report.
   - Dates ISO format YYYY-MM-DD.
   - Principles are declarative, testable, and free of vague language ("should" → replace with MUST/SHOULD rationale where appropriate).

9. Write the completed constitution back to `/memory/constitution.md` (overwrite).

10. Output a final summary to the user with:
   - New version and bump rationale.
   - MIL-STD-498 documents created (if any) with directory structure overview
   - CSCI functional areas created (if any)
   - Any files flagged for manual follow-up.
   - Suggested commit message (e.g., `docs: amend constitution to vX.Y.Z (principle additions + MIL-STD-498 structure)`).

Formatting & Style Requirements:
- Use Markdown headings exactly as in the template (do not demote/promote levels).
- Wrap long rationale lines to keep readability (<100 chars ideally) but do not hard enforce with awkward breaks.
- Keep a single blank line between sections.
- Avoid trailing whitespace.

If the user supplies partial updates (e.g., only one principle revision), still perform validation and version decision steps.

If critical info missing (e.g., ratification date truly unknown), insert `TODO(<FIELD_NAME>): explanation` and include in the Sync Impact Report under deferred items.

Do not create a new template; always operate on the existing `/memory/constitution.md` file.
