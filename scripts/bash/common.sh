#!/usr/bin/env bash
# CSCI-based common functions and variables for all scripts

# Basic Git functions
get_repo_root() { git rev-parse --show-toplevel; }
get_current_branch() { git rev-parse --abbrev-ref HEAD; }

# Check if branch follows CSCI naming convention
check_feature_branch() {
    local branch="$1"
    if [[ ! "$branch" =~ ^[a-z0-9_-]+/[0-9]{3}-[a-z0-9-]+$ ]]; then
        echo "ERROR: Branch must follow format: csci-name/NNN-feature-name" >&2
        echo "Current branch: $branch" >&2
        echo "Examples:" >&2
        echo "  - authentication/001-login" >&2
        echo "  - hr/001-employee-profile" >&2
        echo "  - common/001-logging-infrastructure" >&2
        return 1
    fi
    return 0
}

# Parse CSCI and feature part from branch name
parse_csci_branch() {
    local branch="$1"
    if [[ $branch =~ ^([a-z0-9_-]+)/([0-9]{3}-[a-z0-9-]+)$ ]]; then
        echo "CSCI_NAME='${BASH_REMATCH[1]}'"
        echo "FEATURE_PART='${BASH_REMATCH[2]}'"
        return 0
    else
        echo "ERROR: Could not parse CSCI from branch: $branch" >&2
        return 1
    fi
}

# Get available CSCIs from constitution
get_available_cscis() {
    local repo_root=$(get_repo_root)
    local constitution="$repo_root/memory/constitution.md"
    local cscis=()

    if [[ -f "$constitution" ]]; then
        while IFS= read -r line; do
            if [[ $line =~ \*\*CSCI\ ID\*\*:\ \`([a-z0-9_-]+)\` ]]; then
                cscis+=("${BASH_REMATCH[1]}")
            fi
        done < "$constitution"
    fi

    printf '%s\n' "${cscis[@]}"
}

# Validate CSCI exists in constitution and filesystem
validate_csci() {
    local csci_name="$1"
    local repo_root=$(get_repo_root)

    # Check constitution
    local available_cscis=$(get_available_cscis)
    local found=false

    while IFS= read -r csci; do
        if [[ "$csci" == "$csci_name" ]]; then
            found=true
            break
        fi
    done <<< "$available_cscis"

    if [[ "$found" != "true" ]]; then
        echo "ERROR: CSCI '$csci_name' not found in constitution" >&2
        echo "Available CSCIs:" >&2
        while IFS= read -r csci; do
            echo "  - $csci" >&2
        done <<< "$available_cscis"
        return 1
    fi

    # Check directory exists
    local csci_dir="$repo_root/csci/$csci_name"
    if [[ ! -d "$csci_dir" ]]; then
        echo "ERROR: CSCI directory not found: $csci_dir" >&2
        echo "Run /constitution to create CSCI structure" >&2
        return 1
    fi

    return 0
}

# Get all feature paths based on current CSCI branch
get_feature_paths() {
    local repo_root=$(get_repo_root)
    local current_branch=$(get_current_branch)

    # Validate and parse branch
    if ! check_feature_branch "$current_branch"; then
        return 1
    fi

    eval $(parse_csci_branch "$current_branch")

    if [[ -z "$CSCI_NAME" ]]; then
        echo "ERROR: Could not parse CSCI from branch: $current_branch" >&2
        return 1
    fi

    # Construct CSCI-based paths
    local csci_dir="$repo_root/csci/$CSCI_NAME"
    local feature_dir="$csci_dir/features/$FEATURE_PART"
    local artifacts_dir="$feature_dir/artifacts"
    local csci_docs_dir="$csci_dir/docs"
    local system_docs_dir="$repo_root/csci/system/docs"

    # Output all paths as environment variables
    cat <<EOF
REPO_ROOT='$repo_root'
CURRENT_BRANCH='$current_branch'
CSCI_NAME='$CSCI_NAME'
FEATURE_PART='$FEATURE_PART'
CSCI_DIR='$csci_dir'
CSCI_DOCS_DIR='$csci_docs_dir'
SYSTEM_DOCS_DIR='$system_docs_dir'
FEATURE_DIR='$feature_dir'
ARTIFACTS_DIR='$artifacts_dir'
FEATURE_SPEC='$feature_dir/spec.md'
IMPL_PLAN='$feature_dir/plan.md'
TASKS='$feature_dir/tasks.md'
RESEARCH='$artifacts_dir/research.md'
DATA_MODEL='$artifacts_dir/data-model.md'
QUICKSTART='$artifacts_dir/quickstart.md'
CONTRACTS_DIR='$artifacts_dir/contracts'
EOF
}

# File/directory check utilities
check_file() {
    [[ -f "$1" ]] && echo "  ✓ $2" || echo "  ✗ $2"
}

check_dir() {
    [[ -d "$1" && -n $(ls -A "$1" 2>/dev/null) ]] && echo "  ✓ $2" || echo "  ✗ $2"
}

# Check if MIL-STD-498 structure exists
check_mil_std_498() {
    local repo_root=$(get_repo_root)
    local system_docs="$repo_root/csci/system/docs"

    if [[ -d "$system_docs" ]] && [[ -f "$system_docs/ocd.md" || -f "$system_docs/ssdd.md" ]]; then
        return 0
    else
        return 1
    fi
}
