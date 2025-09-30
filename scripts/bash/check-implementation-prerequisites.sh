#!/usr/bin/env bash
set -e
JSON_MODE=false
for arg in "$@"; do case "$arg" in --json) JSON_MODE=true ;; --help|-h) echo "Usage: $0 [--json]"; exit 0 ;; esac; done
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"
eval $(get_feature_paths)
check_feature_branch "$CURRENT_BRANCH" || exit 1

# Check for MIL-STD-498 structure
MIL_STD_498_DIR="$REPO_ROOT/docs/mil-std-498"
MIL_STD_498_ENABLED=false
if [ -d "$MIL_STD_498_DIR" ]; then
    MIL_STD_498_ENABLED=true
fi

if [[ ! -d "$FEATURE_DIR" ]]; then echo "ERROR: Feature directory not found: $FEATURE_DIR"; echo "Run /specify first."; exit 1; fi
if [[ ! -f "$IMPL_PLAN" ]]; then echo "ERROR: plan.md not found in $FEATURE_DIR"; echo "Run /plan first."; exit 1; fi
if [[ ! -f "$TASKS" ]]; then echo "ERROR: tasks.md not found in $FEATURE_DIR"; echo "Run /tasks first."; exit 1; fi

if $JSON_MODE; then
  docs=(); [[ -f "$RESEARCH" ]] && docs+=("research.md"); [[ -f "$DATA_MODEL" ]] && docs+=("data-model.md"); ([[ -d "$CONTRACTS_DIR" ]] && [[ -n "$(ls -A "$CONTRACTS_DIR" 2>/dev/null)" ]]) && docs+=("contracts/"); [[ -f "$QUICKSTART" ]] && docs+=("quickstart.md"); [[ -f "$TASKS" ]] && docs+=("tasks.md");

  # Add MIL-STD-498 documents if available
  mil_std_docs=()
  if [ "$MIL_STD_498_ENABLED" = "true" ]; then
    [[ -f "$MIL_STD_498_DIR/system-level/ocd.md" ]] && mil_std_docs+=("ocd.md")
    [[ -f "$MIL_STD_498_DIR/system-level/ssdd.md" ]] && mil_std_docs+=("ssdd.md")
    # Find CSCI documents
    if [ -d "$MIL_STD_498_DIR/csci" ]; then
      for csci_dir in "$MIL_STD_498_DIR/csci"/*; do
        if [ -d "$csci_dir" ]; then
          csci_name=$(basename "$csci_dir")
          [[ -f "$csci_dir/srs-frontend.md" ]] && mil_std_docs+=("csci/$csci_name/srs-frontend.md")
          [[ -f "$csci_dir/srs-backend.md" ]] && mil_std_docs+=("csci/$csci_name/srs-backend.md")
          [[ -f "$csci_dir/idd-shared.md" ]] && mil_std_docs+=("csci/$csci_name/idd-shared.md")
        fi
      done
    fi
  fi

  json_docs=$(printf '"%s",' "${docs[@]}"); json_docs="[${json_docs%,}]"
  json_mil_docs=$(printf '"%s",' "${mil_std_docs[@]}"); json_mil_docs="[${json_mil_docs%,}]"
  printf '{"FEATURE_DIR":"%s","AVAILABLE_DOCS":%s,"MIL_STD_498_ENABLED":%s,"MIL_STD_498_DIR":"%s","MIL_STD_498_DOCS":%s}\n' \
    "$FEATURE_DIR" "$json_docs" "$MIL_STD_498_ENABLED" "$MIL_STD_498_DIR" "$json_mil_docs"
else
  echo "FEATURE_DIR:$FEATURE_DIR"; echo "AVAILABLE_DOCS:"; check_file "$RESEARCH" "research.md"; check_file "$DATA_MODEL" "data-model.md"; check_dir "$CONTRACTS_DIR" "contracts/"; check_file "$QUICKSTART" "quickstart.md"; check_file "$TASKS" "tasks.md"
  echo "MIL_STD_498_ENABLED: $MIL_STD_498_ENABLED"
  if [ "$MIL_STD_498_ENABLED" = "true" ]; then
    echo "MIL_STD_498_DIR: $MIL_STD_498_DIR"
    echo "MIL_STD_498_DOCS:"
    check_file "$MIL_STD_498_DIR/system-level/ocd.md" "  ocd.md"
    check_file "$MIL_STD_498_DIR/system-level/ssdd.md" "  ssdd.md"
    if [ -d "$MIL_STD_498_DIR/csci" ]; then
      for csci_dir in "$MIL_STD_498_DIR/csci"/*; do
        if [ -d "$csci_dir" ]; then
          csci_name=$(basename "$csci_dir")
          check_file "$csci_dir/srs-frontend.md" "  csci/$csci_name/srs-frontend.md"
          check_file "$csci_dir/srs-backend.md" "  csci/$csci_name/srs-backend.md"
          check_file "$csci_dir/idd-shared.md" "  csci/$csci_name/idd-shared.md"
        fi
      done
    fi
  fi
fi