#!/usr/bin/env pwsh
# Check prerequisites for implementation in CSCI-based structure
[CmdletBinding()]
param([switch]$Json)

$ErrorActionPreference = 'Stop'

# Load common functions
. "$PSScriptRoot/common.ps1"

# Get CSCI-based feature paths
$paths = Get-FeaturePathsEnv
if ($null -eq $paths) {
    exit 1
}

# Validate we're on a proper CSCI branch
if (-not (Test-FeatureBranch -Branch $paths.CURRENT_BRANCH)) {
    exit 1
}

# Check prerequisites
if (-not (Test-Path $paths.FEATURE_DIR -PathType Container)) {
    Write-Error "ERROR: Feature directory not found: $($paths.FEATURE_DIR)"
    Write-Error "Run /specify first."
    exit 1
}

if (-not (Test-Path $paths.IMPL_PLAN -PathType Leaf)) {
    Write-Error "ERROR: plan.md not found in $($paths.FEATURE_DIR)"
    Write-Error "Run /plan first."
    exit 1
}

if (-not (Test-Path $paths.TASKS -PathType Leaf)) {
    Write-Error "ERROR: tasks.md not found in $($paths.FEATURE_DIR)"
    Write-Error "Run /tasks first."
    exit 1
}

# Check if MIL-STD-498 structure exists
$milStd498Enabled = Test-MilStd498

if ($Json) {
    # Collect available documents
    $docs = @()
    if (Test-Path $paths.RESEARCH) { $docs += 'research.md' }
    if (Test-Path $paths.DATA_MODEL) { $docs += 'data-model.md' }
    if ((Test-Path $paths.CONTRACTS_DIR) -and
        (Get-ChildItem -Path $paths.CONTRACTS_DIR -ErrorAction SilentlyContinue |
         Select-Object -First 1)) {
        $docs += 'contracts/'
    }
    if (Test-Path $paths.QUICKSTART) { $docs += 'quickstart.md' }
    if (Test-Path $paths.TASKS) { $docs += 'tasks.md' }

    # Add MIL-STD-498 documents if available
    $milStdDocs = @()
    if ($milStd498Enabled) {
        # System-level documents
        $ocdPath = Join-Path $paths.SYSTEM_DOCS_DIR 'ocd.md'
        $ssddPath = Join-Path $paths.SYSTEM_DOCS_DIR 'ssdd.md'
        if (Test-Path $ocdPath) { $milStdDocs += 'system/ocd.md' }
        if (Test-Path $ssddPath) { $milStdDocs += 'system/ssdd.md' }

        # CSCI-level documents for current CSCI
        $srsFePath = Join-Path $paths.CSCI_DOCS_DIR 'srs-frontend.md'
        $srsBePath = Join-Path $paths.CSCI_DOCS_DIR 'srs-backend.md'
        $iddPath = Join-Path $paths.CSCI_DOCS_DIR 'idd-shared.md'
        if (Test-Path $srsFePath) { $milStdDocs += "$($paths.CSCI_NAME)/srs-frontend.md" }
        if (Test-Path $srsBePath) { $milStdDocs += "$($paths.CSCI_NAME)/srs-backend.md" }
        if (Test-Path $iddPath) { $milStdDocs += "$($paths.CSCI_NAME)/idd-shared.md" }
    }

    [PSCustomObject]@{
        FEATURE_DIR = $paths.FEATURE_DIR
        AVAILABLE_DOCS = $docs
        MIL_STD_498_ENABLED = $milStd498Enabled
        CSCI_NAME = $paths.CSCI_NAME
        CSCI_DOCS_DIR = $paths.CSCI_DOCS_DIR
        SYSTEM_DOCS_DIR = $paths.SYSTEM_DOCS_DIR
        MIL_STD_498_DOCS = $milStdDocs
    } | ConvertTo-Json -Compress
} else {
    Write-Output "FEATURE_DIR: $($paths.FEATURE_DIR)"
    Write-Output "CSCI_NAME: $($paths.CSCI_NAME)"
    Write-Output "AVAILABLE_DOCS:"
    Test-FileExists -Path $paths.RESEARCH -Description 'research.md' | Out-Null
    Test-FileExists -Path $paths.DATA_MODEL -Description 'data-model.md' | Out-Null
    Test-DirHasFiles -Path $paths.CONTRACTS_DIR -Description 'contracts/' | Out-Null
    Test-FileExists -Path $paths.QUICKSTART -Description 'quickstart.md' | Out-Null
    Test-FileExists -Path $paths.TASKS -Description 'tasks.md' | Out-Null

    Write-Output "MIL_STD_498_ENABLED: $milStd498Enabled"
    if ($milStd498Enabled) {
        Write-Output "CSCI_DOCS_DIR: $($paths.CSCI_DOCS_DIR)"
        Write-Output "SYSTEM_DOCS_DIR: $($paths.SYSTEM_DOCS_DIR)"
        Write-Output "MIL_STD_498_DOCS:"

        $ocdPath = Join-Path $paths.SYSTEM_DOCS_DIR 'ocd.md'
        $ssddPath = Join-Path $paths.SYSTEM_DOCS_DIR 'ssdd.md'
        Test-FileExists -Path $ocdPath -Description '  system/ocd.md' | Out-Null
        Test-FileExists -Path $ssddPath -Description '  system/ssdd.md' | Out-Null

        $srsFePath = Join-Path $paths.CSCI_DOCS_DIR 'srs-frontend.md'
        $srsBePath = Join-Path $paths.CSCI_DOCS_DIR 'srs-backend.md'
        $iddPath = Join-Path $paths.CSCI_DOCS_DIR 'idd-shared.md'
        Test-FileExists -Path $srsFePath -Description "  $($paths.CSCI_NAME)/srs-frontend.md" | Out-Null
        Test-FileExists -Path $srsBePath -Description "  $($paths.CSCI_NAME)/srs-backend.md" | Out-Null
        Test-FileExists -Path $iddPath -Description "  $($paths.CSCI_NAME)/idd-shared.md" | Out-Null
    }
}
