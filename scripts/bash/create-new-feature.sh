#!/usr/bin/env bash
# Create a new feature with CSCI-based branch, directory structure, and template
set -e

JSON_MODE=false
CSCI_NAME=""
FEATURE_DESCRIPTION=""
ARGS=()

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --json)
            JSON_MODE=true
            shift
            ;;
        --csci)
            CSCI_NAME="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [--json] [--csci <csci-name>] <feature_description>"
            echo "Example: $0 --csci authentication 'Add login functionality'"
            echo "If --csci is not provided, available CSCIs will be returned for AI selection"
            exit 0
            ;;
        *)
            ARGS+=("$1")
            shift
            ;;
    esac
done

FEATURE_DESCRIPTION="${ARGS[*]}"
if [ -z "$FEATURE_DESCRIPTION" ]; then
    echo "Error: Feature description required" >&2
    echo "Usage: $0 [--json] [--csci <csci-name>] <feature_description>" >&2
    exit 1
fi

REPO_ROOT=$(git rev-parse --show-toplevel)
CONSTITUTION="$REPO_ROOT/memory/constitution.md"
CSCI_BASE_DIR="$REPO_ROOT/csci"

# Extract available CSCIs from constitution
AVAILABLE_CSCIS=()
if [ -f "$CONSTITUTION" ]; then
    while IFS= read -r line; do
        if [[ $line =~ \*\*CSCI\ ID\*\*:\ \`([a-z0-9_-]+)\` ]]; then
            AVAILABLE_CSCIS+=("${BASH_REMATCH[1]}")
        fi
    done < "$CONSTITUTION"
fi

# If no CSCI specified, return available CSCIs for AI to choose
if [ -z "$CSCI_NAME" ]; then
    if $JSON_MODE; then
        CSCI_LIST=$(printf ',"%s"' "${AVAILABLE_CSCIS[@]}")
        CSCI_LIST="[${CSCI_LIST:1}]"
        printf '{"ERROR":"CSCI_REQUIRED","AVAILABLE_CSCIS":%s,"FEATURE_DESCRIPTION":"%s"}\n' "$CSCI_LIST" "$FEATURE_DESCRIPTION"
    else
        echo "Error: CSCI must be specified with --csci flag" >&2
        echo "Available CSCIs:" >&2
        printf "  - %s\n" "${AVAILABLE_CSCIS[@]}" >&2
    fi
    exit 1
fi

# Validate CSCI exists
CSCI_VALID=false
for csci in "${AVAILABLE_CSCIS[@]}"; do
    if [ "$csci" = "$CSCI_NAME" ]; then
        CSCI_VALID=true
        break
    fi
done

if [ "$CSCI_VALID" = "false" ]; then
    echo "Error: CSCI '$CSCI_NAME' not found in constitution" >&2
    echo "Available CSCIs: ${AVAILABLE_CSCIS[*]}" >&2
    exit 1
fi

# Check if CSCI directory exists, create if needed
CSCI_DIR="$CSCI_BASE_DIR/$CSCI_NAME"
CSCI_DOCS_DIR="$CSCI_DIR/docs"
FEATURES_DIR="$CSCI_DIR/features"

mkdir -p "$CSCI_DOCS_DIR"
mkdir -p "$FEATURES_DIR"

# Get next feature number for this CSCI
HIGHEST=0
if [ -d "$FEATURES_DIR" ]; then
    for dir in "$FEATURES_DIR"/*; do
        [ -d "$dir" ] || continue
        dirname=$(basename "$dir")
        number=$(echo "$dirname" | grep -o '^[0-9]\+' || echo "0")
        number=$((10#$number))
        if [ "$number" -gt "$HIGHEST" ]; then HIGHEST=$number; fi
    done
fi

NEXT=$((HIGHEST + 1))
FEATURE_NUM=$(printf "%03d" "$NEXT")

# Generate feature name slug
FEATURE_SLUG=$(echo "$FEATURE_DESCRIPTION" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
WORDS=$(echo "$FEATURE_SLUG" | tr '-' '\n' | grep -v '^$' | head -3 | tr '\n' '-' | sed 's/-$//')

# Branch name: csci/number-name
BRANCH_NAME="${CSCI_NAME}/${FEATURE_NUM}-${WORDS}"
git checkout -b "$BRANCH_NAME"

# Create feature directory
FEATURE_DIR="$FEATURES_DIR/${FEATURE_NUM}-${WORDS}"
mkdir -p "$FEATURE_DIR"
mkdir -p "$FEATURE_DIR/artifacts"

# Copy spec template
TEMPLATE="$REPO_ROOT/templates/spec-template.md"
SPEC_FILE="$FEATURE_DIR/spec.md"
if [ -f "$TEMPLATE" ]; then
    cp "$TEMPLATE" "$SPEC_FILE"
else
    touch "$SPEC_FILE"
fi

# Check if CSCI has MIL-STD-498 docs
MIL_STD_498_ENABLED=false
if [ -f "$CSCI_DOCS_DIR/srs-frontend.md" ] || [ -d "$CSCI_BASE_DIR/system/docs" ]; then
    MIL_STD_498_ENABLED=true
fi

# Output JSON
if $JSON_MODE; then
    printf '{"BRANCH_NAME":"%s","SPEC_FILE":"%s","CSCI_NAME":"%s","CSCI_DIR":"%s","FEATURE_NUM":"%s","FEATURE_DIR":"%s","MIL_STD_498_ENABLED":%s,"CSCI_DOCS_DIR":"%s"}\n' \
        "$BRANCH_NAME" "$SPEC_FILE" "$CSCI_NAME" "$CSCI_DIR" "$FEATURE_NUM" "$FEATURE_DIR" "$MIL_STD_498_ENABLED" "$CSCI_DOCS_DIR"
else
    echo "BRANCH_NAME: $BRANCH_NAME"
    echo "SPEC_FILE: $SPEC_FILE"
    echo "CSCI_NAME: $CSCI_NAME"
    echo "CSCI_DIR: $CSCI_DIR"
    echo "FEATURE_NUM: $FEATURE_NUM"
    echo "FEATURE_DIR: $FEATURE_DIR"
    echo "MIL_STD_498_ENABLED: $MIL_STD_498_ENABLED"
    echo "CSCI_DOCS_DIR: $CSCI_DOCS_DIR"
fi
