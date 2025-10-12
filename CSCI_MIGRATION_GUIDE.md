# CSCI Migration Guide

## Overview

Spec-kit has been upgraded from Feature-centric to CSCI-centric organization following MIL-STD-498 standards.

## What Changed

### Directory Structure

**Before:**
```
specs/001-login/
├── spec.md
├── plan.md
└── tasks.md

docs/mil-std-498/
├── system-level/
└── csci/authentication/
```

**After:**
```
csci/
├── system/docs/          # OCD, SSDD
├── authentication/
│   ├── docs/            # SRS-Frontend, SRS-Backend, IDD-Shared
│   ├── features/001-login/
│   │   ├── spec.md
│   │   ├── plan.md
│   │   ├── tasks.md
│   │   └── artifacts/
│   └── src/             # Implementation (optional)
├── hr/
├── finance/
└── common/
```

### Git Branch Strategy

**Before:** `001-login`, `002-payroll`
**After:** `authentication/001-login`, `hr/001-employee-profile`, `common/001-logging`

### Workflow Changes

#### 1. /constitution
- Creates `csci/system/docs/` for OCD, SSDD
- Creates `csci/[name]/docs/` for each CSCI with SRS-Frontend, SRS-Backend, IDD-Shared
- Creates `csci/[name]/features/` and `csci/[name]/src/` directories

#### 2. /specify
**New Behavior:**
- AI analyzes feature description and selects appropriate CSCI
- If unclear, presents CSCI options to user
- Script returns ERROR="CSCI_REQUIRED" with AVAILABLE_CSCIS if --csci not provided
- Creates feature in `csci/[CSCI]/features/[NUM]-[name]/`
- Updates `csci/[CSCI]/docs/` MIL-STD-498 documents

**Example:**
```bash
User: /specify "Add login functionality"
AI: Detected CSCI: authentication
     Creating: csci/authentication/features/001-login/
     Branch: authentication/001-login
```

#### 3. /plan, /tasks, /implement
- Extract CSCI from current branch name
- Work within CSCI feature directory
- Reference CSCI-specific documentation

## Updated Files

### Core Templates & Commands
- ✅ `memory/constitution.md` - CSCI structure definition
- ✅ `templates/commands/constitution.md` - CSCI creation paths
- ✅ `templates/commands/specify.md` - CSCI selection logic
- ⚠️ `templates/commands/plan.md` - CSCI context (pattern below)
- ⚠️ `templates/commands/tasks.md` - CSCI paths (pattern below)
- ⚠️ `templates/commands/implement.md` - CSCI execution (pattern below)

### Scripts
- ✅ `scripts/bash/create-new-feature.sh` - CSCI-based rewrite
- ✅ `scripts/powershell/create-new-feature.ps1` - CSCI-based rewrite
- ⚠️ `scripts/bash/setup-plan.sh` - Branch parsing (pattern below)
- ⚠️ `scripts/bash/check-task-prerequisites.sh` - CSCI paths (pattern below)
- ⚠️ `scripts/bash/check-implementation-prerequisites.sh` - CSCI paths (pattern below)
- ⚠️ `scripts/powershell/*.ps1` - Same patterns as bash

## Remaining File Update Patterns

### Pattern 1: Branch Parsing (setup-plan.sh, check-*.sh)

```bash
# Extract CSCI from branch name
CURRENT_BRANCH=$(git branch --show-current)

if [[ ! $CURRENT_BRANCH =~ ^([^/]+)/([0-9]+-[a-z0-9-]+)$ ]]; then
    echo "Error: Branch must follow format: csci-name/NNN-feature-name"
    exit 1
fi

CSCI_NAME="${BASH_REMATCH[1]}"
FEATURE_PART="${BASH_REMATCH[2]}"

CSCI_DIR="$REPO_ROOT/csci/$CSCI_NAME"
FEATURE_DIR="$CSCI_DIR/features/$FEATURE_PART"
CSCI_DOCS_DIR="$CSCI_DIR/docs"
```

### Pattern 2: Command Templates (plan.md, tasks.md, implement.md)

**Add CSCI Context Section:**
```markdown
1. **Extract CSCI from current branch**:
   - Current branch format: csci-name/NNN-feature-name
   - Parse to get CSCI_NAME and FEATURE_PART
   - Validate branch format, error if incorrect

2. **Set CSCI-based paths**:
   - FEATURE_DIR: csci/[CSCI]/features/[NUM]-[name]/
   - CSCI_DOCS: csci/[CSCI]/docs/
   - SYSTEM_DOCS: csci/system/docs/

3. **Update document references**:
   - Read csci/[CSCI]/docs/srs-frontend.md (not docs/mil-std-498/...)
   - Update csci/system/docs/ssdd.md (not docs/mil-std-498/...)
```

### Pattern 3: PowerShell Scripts

```powershell
# Parse branch name
$currentBranch = git branch --show-current
if ($currentBranch -notmatch '^([^/]+)/(\d{3}-[a-z0-9-]+)$') {
    Write-Error "Branch must follow format: csci-name/NNN-feature-name"
    exit 1
}
$csciName = $matches[1]
$featurePart = $matches[2]

$csciDir = Join-Path $repoRoot "csci/$csciName"
$featureDir = Join-Path $csciDir "features/$featurePart"
```

## CSCI Types

### Specific CSCIs
- **authentication**: Login, auth, session management
- **hr**: Employee, payroll, org charts
- **finance**: Payments, billing, accounting

### Common CSCI
- Shared UI components (design system)
- Infrastructure (logging, monitoring, config)
- Cross-CSCI integration features
- Build/deployment scripts

## Migration for Existing Projects

### Option 1: Start Fresh (Recommended for new projects)
1. Run `/constitution` with MIL-STD-498 keywords
2. Spec-kit creates csci/ structure automatically
3. All new features follow CSCI workflow

### Option 2: Migrate Existing Features
1. Create csci/ structure: Run `/constitution`
2. Move existing features:
   ```bash
   # Example
   git mv specs/001-login csci/authentication/features/001-login
   git mv docs/mil-std-498/csci/authentication csci/authentication/docs
   ```
3. Update branch names:
   ```bash
   git branch -m 001-login authentication/001-login
   ```

## Benefits

✅ **True modular development** - Each CSCI is self-contained
✅ **Clear separation of concerns** - Functional areas isolated
✅ **Independent CSCI development** - Parallel team work
✅ **Better MIL-STD-498 compliance** - Document structure matches implementation
✅ **Scalable architecture** - Add CSCIs without affecting existing ones

## Common CSCI Use Cases

**When to use common CSCI:**
- Shared logger implementation
- Design system components
- API client utilities
- Cross-CSCI dashboard features
- Build/deploy infrastructure

**Example:**
```bash
/specify "Add shared error handling middleware"
AI: Detected CSCI: common (cross-cutting infrastructure concern)
    Creating: csci/common/features/001-error-handling/
    Branch: common/001-error-handling
```

## Next Steps

1. Complete remaining script updates using patterns above
2. Test workflow with new CSCI structure
3. Update project README if needed
4. Train team on CSCI selection guidelines
