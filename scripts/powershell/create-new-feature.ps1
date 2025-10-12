#!/usr/bin/env pwsh
# Create a new feature with CSCI-based branch, directory structure, and template
[CmdletBinding()]
param(
    [switch]$Json,
    [string]$Csci,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$FeatureDescription
)
$ErrorActionPreference = 'Stop'

if (-not $FeatureDescription -or $FeatureDescription.Count -eq 0) {
    Write-Error "Error: Feature description required`nUsage: ./create-new-feature.ps1 [-Json] [-Csci <csci-name>] <feature description>"
    exit 1
}
$featureDesc = ($FeatureDescription -join ' ').Trim()

$repoRoot = git rev-parse --show-toplevel
$constitution = Join-Path $repoRoot 'memory/constitution.md'
$csciBaseDir = Join-Path $repoRoot 'csci'

# Extract available CSCIs from constitution
$availableCscis = @()
if (Test-Path $constitution) {
    Get-Content $constitution | ForEach-Object {
        if ($_ -match '\*\*CSCI ID\*\*: `([a-z0-9_-]+)`') {
            $availableCscis += $matches[1]
        }
    }
}

# If no CSCI specified, return available CSCIs for AI to choose
if (-not $Csci) {
    if ($Json) {
        $obj = [PSCustomObject]@{
            ERROR = "CSCI_REQUIRED"
            AVAILABLE_CSCIS = $availableCscis
            FEATURE_DESCRIPTION = $featureDesc
        }
        $obj | ConvertTo-Json -Compress
    } else {
        Write-Error "Error: CSCI must be specified with -Csci parameter"
        Write-Output "Available CSCIs:"
        $availableCscis | ForEach-Object { Write-Output "  - $_" }
    }
    exit 1
}

# Validate CSCI exists
if ($availableCscis -notcontains $Csci) {
    Write-Error "Error: CSCI '$Csci' not found in constitution`nAvailable CSCIs: $($availableCscis -join ', ')"
    exit 1
}

# Check if CSCI directory exists, create if needed
$csciDir = Join-Path $csciBaseDir $Csci
$csciDocsDir = Join-Path $csciDir 'docs'
$featuresDir = Join-Path $csciDir 'features'

New-Item -ItemType Directory -Path $csciDocsDir -Force | Out-Null
New-Item -ItemType Directory -Path $featuresDir -Force | Out-Null

# Get next feature number for this CSCI
$highest = 0
if (Test-Path $featuresDir) {
    Get-ChildItem -Path $featuresDir -Directory | ForEach-Object {
        if ($_.Name -match '^(\d{3})') {
            $num = [int]$matches[1]
            if ($num -gt $highest) { $highest = $num }
        }
    }
}
$next = $highest + 1
$featureNum = ('{0:000}' -f $next)

# Generate feature name slug
$featureSlug = $featureDesc.ToLower() -replace '[^a-z0-9]', '-' -replace '-{2,}', '-' -replace '^-', '' -replace '-$', ''
$words = ($featureSlug -split '-') | Where-Object { $_ } | Select-Object -First 3
$featureSlug = [string]::Join('-', $words)

# Branch name: csci/number-name
$branchName = "$Csci/$featureNum-$featureSlug"
git checkout -b $branchName | Out-Null

# Create feature directory
$featureDir = Join-Path $featuresDir "$featureNum-$featureSlug"
New-Item -ItemType Directory -Path $featureDir -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $featureDir 'artifacts') -Force | Out-Null

# Copy spec template
$template = Join-Path $repoRoot 'templates/spec-template.md'
$specFile = Join-Path $featureDir 'spec.md'
if (Test-Path $template) {
    Copy-Item $template $specFile -Force
} else {
    New-Item -ItemType File -Path $specFile | Out-Null
}

# Check if CSCI has MIL-STD-498 docs
$milStd498Enabled = $false
$srsFrontend = Join-Path $csciDocsDir 'srs-frontend.md'
$systemDocs = Join-Path $csciBaseDir 'system/docs'
if ((Test-Path $srsFrontend) -or (Test-Path $systemDocs)) {
    $milStd498Enabled = $true
}

# Output JSON
if ($Json) {
    $obj = [PSCustomObject]@{
        BRANCH_NAME = $branchName
        SPEC_FILE = $specFile
        CSCI_NAME = $Csci
        CSCI_DIR = $csciDir
        FEATURE_NUM = $featureNum
        FEATURE_DIR = $featureDir
        MIL_STD_498_ENABLED = $milStd498Enabled
        CSCI_DOCS_DIR = $csciDocsDir
    }
    $obj | ConvertTo-Json -Compress
} else {
    Write-Output "BRANCH_NAME: $branchName"
    Write-Output "SPEC_FILE: $specFile"
    Write-Output "CSCI_NAME: $Csci"
    Write-Output "CSCI_DIR: $csciDir"
    Write-Output "FEATURE_NUM: $featureNum"
    Write-Output "FEATURE_DIR: $featureDir"
    Write-Output "MIL_STD_498_ENABLED: $milStd498Enabled"
    Write-Output "CSCI_DOCS_DIR: $csciDocsDir"
}
