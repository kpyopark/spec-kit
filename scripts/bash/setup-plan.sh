#!/usr/bin/env bash
# Setup plan.md for CSCI-based feature
set -e

JSON_MODE=false
for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json]"; exit 0 ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Get CSCI-based feature paths
eval $(get_feature_paths) || exit 1

# Validate we're on a proper CSCI branch
check_feature_branch "$CURRENT_BRANCH" || exit 1

# Create feature and artifacts directories
mkdir -p "$FEATURE_DIR"
mkdir -p "$ARTIFACTS_DIR"

# Copy plan template
TEMPLATE="$REPO_ROOT/templates/plan-template.md"
if [[ -f "$TEMPLATE" ]]; then
    cp "$TEMPLATE" "$IMPL_PLAN"
fi

# Check if MIL-STD-498 structure exists
MIL_STD_498_ENABLED=false
if check_mil_std_498; then
    MIL_STD_498_ENABLED=true
fi

# Output JSON or human-readable format
if $JSON_MODE; then
    printf '{"FEATURE_SPEC":"%s","IMPL_PLAN":"%s","SPECS_DIR":"%s","BRANCH":"%s","CSCI_NAME":"%s","CSCI_DIR":"%s","ARTIFACTS_DIR":"%s","MIL_STD_498_ENABLED":%s}\n' \
        "$FEATURE_SPEC" "$IMPL_PLAN" "$FEATURE_DIR" "$CURRENT_BRANCH" "$CSCI_NAME" "$CSCI_DIR" "$ARTIFACTS_DIR" "$MIL_STD_498_ENABLED"
else
    echo "FEATURE_SPEC: $FEATURE_SPEC"
    echo "IMPL_PLAN: $IMPL_PLAN"
    echo "SPECS_DIR: $FEATURE_DIR"
    echo "BRANCH: $CURRENT_BRANCH"
    echo "CSCI_NAME: $CSCI_NAME"
    echo "CSCI_DIR: $CSCI_DIR"
    echo "ARTIFACTS_DIR: $ARTIFACTS_DIR"
    echo "MIL_STD_498_ENABLED: $MIL_STD_498_ENABLED"
fi
