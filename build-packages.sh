#!/bin/bash
# Build template packages for all AI assistants and script types
# Version: 0.0.11

set -e

VERSION="0.0.12"
AI_ASSISTANTS=("claude" "copilot" "cursor" "gemini" "qwen" "opencode")
SCRIPT_TYPES=("sh" "ps")

echo "Building spec-kit template packages v${VERSION}"
echo "=============================================="

for ai in "${AI_ASSISTANTS[@]}"; do
    for script in "${SCRIPT_TYPES[@]}"; do
        PACKAGE_NAME="spec-kit-template-${ai}-${script}-v${VERSION}"
        PACKAGE_DIR="sdd-${ai}-package-${script}"
        ZIP_FILE="${PACKAGE_NAME}.zip"

        echo ""
        echo "Building: ${PACKAGE_NAME}"

        # Clean up old package directory if it exists
        if [ -d "${PACKAGE_DIR}" ]; then
            rm -rf "${PACKAGE_DIR}"
        fi

        # Create package structure
        mkdir -p "${PACKAGE_DIR}/.specify/templates"
        mkdir -p "${PACKAGE_DIR}/.specify/memory"
        mkdir -p "${PACKAGE_DIR}/.claude/commands"

        # Determine script directory based on script type
        if [ "${script}" == "sh" ]; then
            SCRIPT_SOURCE="scripts/bash"
            mkdir -p "${PACKAGE_DIR}/.specify/scripts/bash"
        else
            SCRIPT_SOURCE="scripts/powershell"
            mkdir -p "${PACKAGE_DIR}/.specify/scripts/powershell"
        fi

        # Copy templates
        cp -r templates/* "${PACKAGE_DIR}/.specify/templates/"

        # Copy command definitions to .claude/commands/ for Claude Code
        if [ -d "templates/commands" ]; then
            cp templates/commands/*.md "${PACKAGE_DIR}/.claude/commands/"
        fi

        # Copy scripts
        cp -r ${SCRIPT_SOURCE}/* "${PACKAGE_DIR}/.specify/scripts/$(basename ${SCRIPT_SOURCE})/"

        # Copy memory/constitution template
        cp memory/constitution.md "${PACKAGE_DIR}/.specify/memory/"

        # Copy Claude configuration if it exists
        if [ -f ".claude/CLAUDE.md" ]; then
            cp .claude/CLAUDE.md "${PACKAGE_DIR}/.claude/"
        fi

        # Set executable permissions for shell scripts (POSIX only)
        if [ "${script}" == "sh" ]; then
            find "${PACKAGE_DIR}/.specify/scripts/bash" -name "*.sh" -type f -exec chmod +x {} \;
        fi

        # Create zip file
        echo "Creating ${ZIP_FILE}..."
        (cd "${PACKAGE_DIR}" && zip -r "../${ZIP_FILE}" .claude .specify)

        # Get file size
        SIZE=$(ls -lh "${ZIP_FILE}" | awk '{print $5}')
        echo "✓ Created: ${ZIP_FILE} (${SIZE})"

        # Optionally keep the package directory for inspection
        # Uncomment the next line to remove package directories after zipping
        # rm -rf "${PACKAGE_DIR}"
    done
done

echo ""
echo "=============================================="
echo "✓ All packages built successfully!"
echo ""
echo "Package list:"
ls -lh spec-kit-template-*-v${VERSION}.zip | awk '{print "  " $9 " (" $5 ")"}'
