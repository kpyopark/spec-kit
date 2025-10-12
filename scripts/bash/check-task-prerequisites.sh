#!/usr/bin/env bash
# Check prerequisites for task generation in CSCI-based structure
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

# Check prerequisites
if [[ ! -d "$FEATURE_DIR" ]]; then
    echo "ERROR: Feature directory not found: $FEATURE_DIR" >&2
    echo "Run /specify first." >&2
    exit 1
fi

if [[ ! -f "$IMPL_PLAN" ]]; then
    echo "ERROR: plan.md not found in $FEATURE_DIR" >&2
    echo "Run /plan first." >&2
    exit 1
fi

# Check if MIL-STD-498 structure exists
MIL_STD_498_ENABLED=false
if check_mil_std_498; then
    MIL_STD_498_ENABLED=true
fi

if $JSON_MODE; then
    # Collect available documents
    docs=()
    [[ -f "$RESEARCH" ]] && docs+=("research.md")
    [[ -f "$DATA_MODEL" ]] && docs+=("data-model.md")
    ([[ -d "$CONTRACTS_DIR" ]] && [[ -n "$(ls -A "$CONTRACTS_DIR" 2>/dev/null)" ]]) && docs+=("contracts/")
    [[ -f "$QUICKSTART" ]] && docs+=("quickstart.md")

    # Add MIL-STD-498 documents if available
    mil_std_docs=()
    if [ "$MIL_STD_498_ENABLED" = "true" ]; then
        # System-level documents
        [[ -f "$SYSTEM_DOCS_DIR/ocd.md" ]] && mil_std_docs+=("system/ocd.md")
        [[ -f "$SYSTEM_DOCS_DIR/ssdd.md" ]] && mil_std_docs+=("system/ssdd.md")

        # CSCI-level documents for current CSCI
        [[ -f "$CSCI_DOCS_DIR/srs-frontend.md" ]] && mil_std_docs+=("$CSCI_NAME/srs-frontend.md")
        [[ -f "$CSCI_DOCS_DIR/srs-backend.md" ]] && mil_std_docs+=("$CSCI_NAME/srs-backend.md")
        [[ -f "$CSCI_DOCS_DIR/idd-shared.md" ]] && mil_std_docs+=("$CSCI_NAME/idd-shared.md")
    fi

    # Format as JSON arrays
    json_docs=$(printf '"%s",' "${docs[@]}")
    json_docs="[${json_docs%,}]"
    json_mil_docs=$(printf '"%s",' "${mil_std_docs[@]}")
    json_mil_docs="[${json_mil_docs%,}]"

    printf '{"FEATURE_DIR":"%s","AVAILABLE_DOCS":%s,"MIL_STD_498_ENABLED":%s,"CSCI_NAME":"%s","CSCI_DOCS_DIR":"%s","SYSTEM_DOCS_DIR":"%s","MIL_STD_498_DOCS":%s}\n' \
        "$FEATURE_DIR" "$json_docs" "$MIL_STD_498_ENABLED" "$CSCI_NAME" "$CSCI_DOCS_DIR" "$SYSTEM_DOCS_DIR" "$json_mil_docs"
else
    echo "FEATURE_DIR: $FEATURE_DIR"
    echo "CSCI_NAME: $CSCI_NAME"
    echo "AVAILABLE_DOCS:"
    check_file "$RESEARCH" "research.md"
    check_file "$DATA_MODEL" "data-model.md"
    check_dir "$CONTRACTS_DIR" "contracts/"
    check_file "$QUICKSTART" "quickstart.md"

    echo "MIL_STD_498_ENABLED: $MIL_STD_498_ENABLED"
    if [ "$MIL_STD_498_ENABLED" = "true" ]; then
        echo "CSCI_DOCS_DIR: $CSCI_DOCS_DIR"
        echo "SYSTEM_DOCS_DIR: $SYSTEM_DOCS_DIR"
        echo "MIL_STD_498_DOCS:"
        check_file "$SYSTEM_DOCS_DIR/ocd.md" "  system/ocd.md"
        check_file "$SYSTEM_DOCS_DIR/ssdd.md" "  system/ssdd.md"
        check_file "$CSCI_DOCS_DIR/srs-frontend.md" "  $CSCI_NAME/srs-frontend.md"
        check_file "$CSCI_DOCS_DIR/srs-backend.md" "  $CSCI_NAME/srs-backend.md"
        check_file "$CSCI_DOCS_DIR/idd-shared.md" "  $CSCI_NAME/idd-shared.md"
    fi
fi
