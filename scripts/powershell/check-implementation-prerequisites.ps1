#!/usr/bin/env pwsh
[CmdletBinding()]
param([switch]$Json)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot/common.ps1"

$paths = Get-FeaturePathsEnv
if (-not (Test-FeatureBranch -Branch $paths.CURRENT_BRANCH)) { exit 1 }

# Check for MIL-STD-498 structure
$milStd498Dir = Join-Path $paths.REPO_ROOT 'docs/mil-std-498'
$milStd498Enabled = Test-Path $milStd498Dir

if (-not (Test-Path $paths.FEATURE_DIR -PathType Container)) {
    Write-Output "ERROR: Feature directory not found: $($paths.FEATURE_DIR)"
    Write-Output "Run /specify first to create the feature structure."
    exit 1
}
if (-not (Test-Path $paths.IMPL_PLAN -PathType Leaf)) {
    Write-Output "ERROR: plan.md not found in $($paths.FEATURE_DIR)"
    Write-Output "Run /plan first to create the plan."
    exit 1
}
if (-not (Test-Path $paths.TASKS -PathType Leaf)) {
    Write-Output "ERROR: tasks.md not found in $($paths.FEATURE_DIR)"
    Write-Output "Run /tasks first to create the task list."
    exit 1
}

if ($Json) {
    $docs = @()
    if (Test-Path $paths.RESEARCH) { $docs += 'research.md' }
    if (Test-Path $paths.DATA_MODEL) { $docs += 'data-model.md' }
    if ((Test-Path $paths.CONTRACTS_DIR) -and (Get-ChildItem -Path $paths.CONTRACTS_DIR -ErrorAction SilentlyContinue | Select-Object -First 1)) { $docs += 'contracts/' }
    if (Test-Path $paths.QUICKSTART) { $docs += 'quickstart.md' }
    if (Test-Path $paths.TASKS) { $docs += 'tasks.md' }

    # Add MIL-STD-498 documents if available
    $milStdDocs = @()
    if ($milStd498Enabled) {
        $ocdPath = Join-Path $milStd498Dir 'system-level/ocd.md'
        $ssddPath = Join-Path $milStd498Dir 'system-level/ssdd.md'
        if (Test-Path $ocdPath) { $milStdDocs += 'ocd.md' }
        if (Test-Path $ssddPath) { $milStdDocs += 'ssdd.md' }

        # Find CSCI documents
        $csciDir = Join-Path $milStd498Dir 'csci'
        if (Test-Path $csciDir) {
            Get-ChildItem -Path $csciDir -Directory | ForEach-Object {
                $csciName = $_.Name
                $srsFeFile = Join-Path $_.FullName 'srs-frontend.md'
                $srsBeFile = Join-Path $_.FullName 'srs-backend.md'
                $iddFile = Join-Path $_.FullName 'idd-shared.md'
                if (Test-Path $srsFeFile) { $milStdDocs += "csci/$csciName/srs-frontend.md" }
                if (Test-Path $srsBeFile) { $milStdDocs += "csci/$csciName/srs-backend.md" }
                if (Test-Path $iddFile) { $milStdDocs += "csci/$csciName/idd-shared.md" }
            }
        }
    }

    [PSCustomObject]@{
        FEATURE_DIR=$paths.FEATURE_DIR;
        AVAILABLE_DOCS=$docs;
        MIL_STD_498_ENABLED=$milStd498Enabled;
        MIL_STD_498_DIR=if ($milStd498Enabled) { $milStd498Dir } else { $null };
        MIL_STD_498_DOCS=$milStdDocs
    } | ConvertTo-Json -Compress
} else {
    Write-Output "FEATURE_DIR:$($paths.FEATURE_DIR)"
    Write-Output "AVAILABLE_DOCS:"
    Test-FileExists -Path $paths.RESEARCH -Description 'research.md' | Out-Null
    Test-FileExists -Path $paths.DATA_MODEL -Description 'data-model.md' | Out-Null
    Test-DirHasFiles -Path $paths.CONTRACTS_DIR -Description 'contracts/' | Out-Null
    Test-FileExists -Path $paths.QUICKSTART -Description 'quickstart.md' | Out-Null
    Test-FileExists -Path $paths.TASKS -Description 'tasks.md' | Out-Null
    Write-Output "MIL_STD_498_ENABLED: $milStd498Enabled"
    if ($milStd498Enabled) {
        Write-Output "MIL_STD_498_DIR: $milStd498Dir"
        Write-Output "MIL_STD_498_DOCS:"
        $ocdPath = Join-Path $milStd498Dir 'system-level/ocd.md'
        $ssddPath = Join-Path $milStd498Dir 'system-level/ssdd.md'
        Test-FileExists -Path $ocdPath -Description '  ocd.md' | Out-Null
        Test-FileExists -Path $ssddPath -Description '  ssdd.md' | Out-Null

        $csciDir = Join-Path $milStd498Dir 'csci'
        if (Test-Path $csciDir) {
            Get-ChildItem -Path $csciDir -Directory | ForEach-Object {
                $csciName = $_.Name
                $srsFeFile = Join-Path $_.FullName 'srs-frontend.md'
                $srsBeFile = Join-Path $_.FullName 'srs-backend.md'
                $iddFile = Join-Path $_.FullName 'idd-shared.md'
                Test-FileExists -Path $srsFeFile -Description "  csci/$csciName/srs-frontend.md" | Out-Null
                Test-FileExists -Path $srsBeFile -Description "  csci/$csciName/srs-backend.md" | Out-Null
                Test-FileExists -Path $iddFile -Description "  csci/$csciName/idd-shared.md" | Out-Null
            }
        }
    }
}