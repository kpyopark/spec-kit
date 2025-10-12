#!/usr/bin/env pwsh
# CSCI-based common functions and variables for all PowerShell scripts

# Basic Git functions
function Get-RepoRoot {
    git rev-parse --show-toplevel
}

function Get-CurrentBranch {
    git rev-parse --abbrev-ref HEAD
}

# Check if branch follows CSCI naming convention
function Test-FeatureBranch {
    param([string]$Branch)

    if ($Branch -notmatch '^[a-z0-9_-]+/[0-9]{3}-[a-z0-9-]+$') {
        Write-Error "ERROR: Branch must follow format: csci-name/NNN-feature-name"
        Write-Error "Current branch: $Branch"
        Write-Error "Examples:"
        Write-Error "  - authentication/001-login"
        Write-Error "  - hr/001-employee-profile"
        Write-Error "  - common/001-logging-infrastructure"
        return $false
    }
    return $true
}

# Parse CSCI and feature part from branch name
function Parse-CsciBranch {
    param([string]$Branch)

    if ($Branch -match '^([a-z0-9_-]+)/([0-9]{3}-[a-z0-9-]+)$') {
        return @{
            CSCI_NAME = $Matches[1]
            FEATURE_PART = $Matches[2]
        }
    } else {
        Write-Error "ERROR: Could not parse CSCI from branch: $Branch"
        return $null
    }
}

# Get available CSCIs from constitution
function Get-AvailableCscis {
    $repoRoot = Get-RepoRoot
    $constitution = Join-Path $repoRoot "memory/constitution.md"
    $cscis = @()

    if (Test-Path $constitution) {
        $content = Get-Content $constitution
        foreach ($line in $content) {
            if ($line -match '\*\*CSCI ID\*\*: `([a-z0-9_-]+)`') {
                $cscis += $Matches[1]
            }
        }
    }

    return $cscis
}

# Validate CSCI exists in constitution and filesystem
function Test-CsciValid {
    param([string]$CsciName)

    $repoRoot = Get-RepoRoot

    # Check constitution
    $availableCscis = Get-AvailableCscis
    $found = $false

    foreach ($csci in $availableCscis) {
        if ($csci -eq $CsciName) {
            $found = $true
            break
        }
    }

    if (-not $found) {
        Write-Error "ERROR: CSCI '$CsciName' not found in constitution"
        Write-Error "Available CSCIs:"
        foreach ($csci in $availableCscis) {
            Write-Error "  - $csci"
        }
        return $false
    }

    # Check directory exists
    $csciDir = Join-Path $repoRoot "csci/$CsciName"
    if (-not (Test-Path $csciDir)) {
        Write-Error "ERROR: CSCI directory not found: $csciDir"
        Write-Error "Run /constitution to create CSCI structure"
        return $false
    }

    return $true
}

# Get all feature paths based on current CSCI branch
function Get-FeaturePathsEnv {
    $repoRoot = Get-RepoRoot
    $currentBranch = Get-CurrentBranch

    # Validate and parse branch
    if (-not (Test-FeatureBranch -Branch $currentBranch)) {
        return $null
    }

    $parsed = Parse-CsciBranch -Branch $currentBranch
    if ($null -eq $parsed) {
        return $null
    }

    $csciName = $parsed.CSCI_NAME
    $featurePart = $parsed.FEATURE_PART

    # Construct CSCI-based paths
    $csciDir = Join-Path $repoRoot "csci/$csciName"
    $featureDir = Join-Path $csciDir "features/$featurePart"
    $artifactsDir = Join-Path $featureDir "artifacts"
    $csciDocsDir = Join-Path $csciDir "docs"
    $systemDocsDir = Join-Path $repoRoot "csci/system/docs"

    # Return all paths as custom object
    return [PSCustomObject]@{
        REPO_ROOT = $repoRoot
        CURRENT_BRANCH = $currentBranch
        CSCI_NAME = $csciName
        FEATURE_PART = $featurePart
        CSCI_DIR = $csciDir
        CSCI_DOCS_DIR = $csciDocsDir
        SYSTEM_DOCS_DIR = $systemDocsDir
        FEATURE_DIR = $featureDir
        ARTIFACTS_DIR = $artifactsDir
        FEATURE_SPEC = Join-Path $featureDir 'spec.md'
        IMPL_PLAN = Join-Path $featureDir 'plan.md'
        TASKS = Join-Path $featureDir 'tasks.md'
        RESEARCH = Join-Path $artifactsDir 'research.md'
        DATA_MODEL = Join-Path $artifactsDir 'data-model.md'
        QUICKSTART = Join-Path $artifactsDir 'quickstart.md'
        CONTRACTS_DIR = Join-Path $artifactsDir 'contracts'
    }
}

# File/directory check utilities
function Test-FileExists {
    param([string]$Path, [string]$Description)

    if (Test-Path -Path $Path -PathType Leaf) {
        Write-Output "  ✓ $Description"
        return $true
    } else {
        Write-Output "  ✗ $Description"
        return $false
    }
}

function Test-DirHasFiles {
    param([string]$Path, [string]$Description)

    if ((Test-Path -Path $Path -PathType Container) -and
        (Get-ChildItem -Path $Path -ErrorAction SilentlyContinue |
         Where-Object { -not $_.PSIsContainer } |
         Select-Object -First 1)) {
        Write-Output "  ✓ $Description"
        return $true
    } else {
        Write-Output "  ✗ $Description"
        return $false
    }
}

# Check if MIL-STD-498 structure exists
function Test-MilStd498 {
    $repoRoot = Get-RepoRoot
    $systemDocs = Join-Path $repoRoot "csci/system/docs"

    if (Test-Path $systemDocs) {
        $ocd = Join-Path $systemDocs "ocd.md"
        $ssdd = Join-Path $systemDocs "ssdd.md"
        if ((Test-Path $ocd) -or (Test-Path $ssdd)) {
            return $true
        }
    }

    return $false
}
