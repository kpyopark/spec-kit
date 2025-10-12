# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Setup and Installation
```bash
# Direct CLI execution (fastest feedback)
python -m src.specify_cli --help
python -m src.specify_cli init demo-project --ai claude --ignore-agent-tools

# Editable install for development
uv venv && source .venv/bin/activate
uv pip install -e .
specify --help

# Run from current directory using uvx
uvx --from . specify init demo --ai claude --ignore-agent-tools

# Build wheel for testing
uv build
```

### Testing
```bash
# Basic import check
python -c "import specify_cli; print('Import OK')"

# Test script permissions (Linux/macOS only)
ls -l scripts/bash/*.sh  # Should show execute permissions

# Test init command variations
specify init --here --ai claude --ignore-agent-tools --script sh
specify check  # Verify required tools are available
```

## Architecture Overview

### Core Components

**CLI Module** (`src/specify_cli/__init__.py`):
- Single-file CLI application built with Typer and Rich
- Handles project initialization, template download from GitHub releases, and tool checking
- Cross-platform support with both bash (.sh) and PowerShell (.ps1) script variants
- Uses httpx with SSL context for secure downloads

**Spec-Driven Development Workflow**:
1. `/constitution` - Establish project principles and optionally create MIL-STD-498 structure
2. `/specify` - Create feature specifications (enhanced with MIL-STD-498 if available)
3. `/plan` - Generate technical implementation plans
4. `/tasks` - Break down plans into actionable tasks
5. `/implement` - Execute the task list systematically

**CSCI-Centric MIL-STD-498 Workflow**:
When MIL-STD-498 structure exists, the workflow is CSCI-centric:
- `/constitution` creates `csci/` directory structure with system-level and CSCI-level docs
- `/specify` requires CSCI selection (authentication, hr, finance, or common)
  - AI analyzes feature and suggests appropriate CSCI
  - Creates feature in `csci/[CSCI]/features/[NUM]-[name]/`
  - Updates `csci/[CSCI]/docs/` MIL-STD-498 documents
  - Updates `csci/system/docs/` for system-wide impacts
- Branch naming follows `csci-name/number-name` pattern (e.g., `authentication/001-login`)
- Each CSCI is self-contained with docs, features, and optional src directories

**Script System** (`scripts/`):
- Cross-platform automation with bash and PowerShell variants
- CSCI-based branch management (expects `csci-name/NNN-feature-name` pattern)
- Constitution parsing to extract available CSCIs
- Template-driven document generation and validation

**Template System** (`templates/`):
- Structured templates for specifications, plans, and tasks
- Placeholder-based token replacement system using `[PLACEHOLDER]` syntax
- Command definitions linking scripts to AI agent workflows
- Constitution template with governance and principles structure
- **MIL-STD-498 Templates** (`templates/mil-std-498/`):
  - System-level: OCD (Operational Concept Document), SSDD (System/Subsystem Design Document)
  - CSCI-level: SRS-Frontend, SRS-Backend, IDD-Shared templates for each functional area

### Key Architecture Patterns

**CSCI-Based Branch Workflow**:
- Features are developed on CSCI-scoped branches (`csci-name/NNN-feature-name`)
- Each feature gets its own directory in `csci/[CSCI]/features/NNN-feature-name/`
- Branch name determines both CSCI and feature directory path
- Scripts parse branch to extract CSCI and validate naming convention
- Feature numbering is independent per CSCI (authentication/001, hr/001, etc.)

**Template-Driven Development**:
- All documents follow structured templates with token replacement
- Templates contain both structure and example content
- AI agents fill templates by replacing `[PLACEHOLDER]` tokens
- Cross-references maintained between related documents

**Cross-Platform Script Design**:
- Both `.sh` and `.ps1` variants for all automation
- Common JSON output format for script results
- Auto-detection of script type based on OS
- Executable permissions managed automatically on POSIX systems

## File Organization

```
├── src/specify_cli/          # Main CLI application (single Python file)
├── scripts/
│   ├── bash/                 # POSIX shell automation scripts
│   └── powershell/          # Windows PowerShell scripts
├── templates/
│   ├── commands/            # AI agent command definitions
│   ├── mil-std-498/         # MIL-STD-498 document templates
│   │   ├── system-level/    # OCD, SSDD templates
│   │   └── csci/            # SRS-Frontend, SRS-Backend, IDD-Shared templates
│   └── *-template.md        # Other document templates with placeholders
├── memory/
│   └── constitution.md      # Project governance template (with CSCI definitions)
└── csci/                    # CSCI-centric organization (created by constitution)
    ├── system/
    │   └── docs/            # System-wide OCD, SSDD documents
    ├── authentication/      # Authentication CSCI
    │   ├── docs/            # SRS-Frontend, SRS-Backend, IDD-Shared
    │   ├── features/        # Feature specifications and plans
    │   │   ├── 001-login/
    │   │   │   ├── spec.md
    │   │   │   ├── plan.md
    │   │   │   ├── tasks.md
    │   │   │   └── artifacts/  # research.md, data-model.md, contracts/
    │   │   └── 002-password-reset/
    │   └── src/             # Implementation code (optional)
    │       ├── frontend/
    │       └── backend/
    ├── hr/                  # HR CSCI (same structure)
    ├── finance/             # Finance CSCI (same structure)
    └── common/              # Common/shared infrastructure CSCI
```

## Key Development Conventions

**Script Integration**:
- Scripts output JSON for programmatic parsing by AI agents
- All file paths in script output must be absolute
- Scripts handle git branch creation, checkout, and file initialization
- Error conditions return non-zero exit codes with descriptive messages

**Template Token System**:
- Placeholders use `[ALL_CAPS_IDENTIFIER]` format
- Templates include example content in comments
- Version numbers follow semantic versioning (MAJOR.MINOR.PATCH)
- Dates use ISO format (YYYY-MM-DD)

**AI Agent Command Structure**:
- Each command has YAML frontmatter with description and script paths
- Commands specify both bash and PowerShell script variants
- Scripts are executed from repository root
- JSON output is parsed for file paths and workflow state

**MIL-STD-498 CSCI Integration**:
- Constitution command detects MIL-STD-498 keywords and creates CSCI-centric structure
- Creates `csci/system/docs/` for system-wide OCD and SSDD documents
- Creates `csci/[CSCI]/` for each functional area with docs, features, and src directories
- Default CSCIs: authentication, hr, finance, and common (always created)
- CSCI selection required for /specify - AI suggests based on feature description
- Templates use placeholder token system for consistent document generation
- Each CSCI is self-contained for independent development and deployment

## Development Workflow

**Local Development Loop**:
1. Make changes to CLI code in `src/specify_cli/__init__.py`
2. Test with `python -m src.specify_cli` or editable install
3. Validate cross-platform behavior with both script types
4. Test template download and extraction functionality
5. Verify script permissions are set correctly

**Adding New Features**:
1. Update CLI argument parsing if needed
2. Add corresponding script variants in `scripts/bash/` and `scripts/powershell/`
3. Create or update templates in `templates/`
4. Add command definition in `templates/commands/`
5. Test the complete workflow with AI agent integration

**Release Process**:
- Built wheels are published to GitHub releases
- Templates are packaged as zip files per AI assistant type
- Cross-platform script bundles included in release assets
- Version updates in `pyproject.toml` drive release automation