#!/usr/bin/env pwsh
# Setup plan.md for CSCI-based feature
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

# Create feature and artifacts directories
New-Item -ItemType Directory -Path $paths.FEATURE_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $paths.ARTIFACTS_DIR -Force | Out-Null

# Copy plan template
$template = Join-Path $paths.REPO_ROOT 'templates/plan-template.md'
if (Test-Path $template) {
    Copy-Item $template $paths.IMPL_PLAN -Force
}

# Check if MIL-STD-498 structure exists
$milStd498Enabled = Test-MilStd498

# Output JSON or human-readable format
if ($Json) {
    [PSCustomObject]@{
        FEATURE_SPEC = $paths.FEATURE_SPEC
        IMPL_PLAN = $paths.IMPL_PLAN
        SPECS_DIR = $paths.FEATURE_DIR
        BRANCH = $paths.CURRENT_BRANCH
        CSCI_NAME = $paths.CSCI_NAME
        CSCI_DIR = $paths.CSCI_DIR
        ARTIFACTS_DIR = $paths.ARTIFACTS_DIR
        MIL_STD_498_ENABLED = $milStd498Enabled
    } | ConvertTo-Json -Compress
} else {
    Write-Output "FEATURE_SPEC: $($paths.FEATURE_SPEC)"
    Write-Output "IMPL_PLAN: $($paths.IMPL_PLAN)"
    Write-Output "SPECS_DIR: $($paths.FEATURE_DIR)"
    Write-Output "BRANCH: $($paths.CURRENT_BRANCH)"
    Write-Output "CSCI_NAME: $($paths.CSCI_NAME)"
    Write-Output "CSCI_DIR: $($paths.CSCI_DIR)"
    Write-Output "ARTIFACTS_DIR: $($paths.ARTIFACTS_DIR)"
    Write-Output "MIL_STD_498_ENABLED: $milStd498Enabled"
}
