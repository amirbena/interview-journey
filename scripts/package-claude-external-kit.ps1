<#
.SYNOPSIS
    Packages the Interview Journey External Self-Install Kit into
    dist/interview-journey-claude-kit.zip.

.DESCRIPTION
    Builds the Skill ZIP first, then assembles the kit around it with the
    canonical compact Project Instructions and a fixed Knowledge allowlist,
    both copied byte-for-byte. Works when invoked from inside or outside the
    repository root; all paths resolve relative to $PSScriptRoot.
#>

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Fail {
    param([string]$Message)
    Write-Error "error: $Message"
    exit 1
}

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ExternalInstallDir = Join-Path $RepoRoot "claude\external-install"
$ProjectInstructionsCompact = Join-Path $RepoRoot "claude\project-instructions.compact.md"
$CoreDir = Join-Path $RepoRoot "core"

$DistDir = Join-Path $RepoRoot "dist"
$BuildDir = Join-Path $RepoRoot ".build\claude-external-kit-package"
$PackageName = "interview-journey-claude-kit"
$OutputZip = Join-Path $DistDir "$PackageName.zip"

$SkillZipName = "interview-journey.skill.zip"
$SkillZipPath = Join-Path $DistDir $SkillZipName

$RequiredDocs = @("README.md", "installation-checklist.md", "knowledge-files.md", "conversation-starters.md", "verification-guide.md", "privacy-guide.md")
foreach ($doc in $RequiredDocs) {
    $p = Join-Path $ExternalInstallDir $doc
    if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { Fail "required file not found: $p" }
}

if (-not (Test-Path -LiteralPath $ProjectInstructionsCompact -PathType Leaf)) {
    Fail "required file not found: $ProjectInstructionsCompact"
}

$KnowledgeFiles = @(
    @{ Src = "product-definition.md"; Dest = "product-definition.md" },
    @{ Src = "terminology.md"; Dest = "terminology.md" },
    @{ Src = "scope-and-non-goals.md"; Dest = "scope-and-non-goals.md" },
    @{ Src = "workflow.md"; Dest = "workflow.md" },
    @{ Src = "orchestration-policy.md"; Dest = "orchestration-policy.md" },
    @{ Src = "evidence-policy.md"; Dest = "evidence-policy.md" },
    @{ Src = "accuracy-policy.md"; Dest = "accuracy-policy.md" },
    @{ Src = "context-priority.md"; Dest = "context-priority.md" },
    @{ Src = "quality-gates.md"; Dest = "quality-gates.md" },
    @{ Src = "output-contracts.md"; Dest = "output-contracts.md" },
    @{ Src = "state-management.md"; Dest = "state-management.md" }
)

foreach ($kf in $KnowledgeFiles) {
    $p = Join-Path $CoreDir $kf.Src
    if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { Fail "required Knowledge source not found: $p" }
}

$SkillScript = Join-Path $PSScriptRoot "package-claude-skill.ps1"
if (-not (Test-Path -LiteralPath $SkillScript -PathType Leaf)) { Fail "required packaging script not found: $SkillScript" }
& $SkillScript | Out-Null
if (-not (Test-Path -LiteralPath $SkillZipPath -PathType Leaf)) { Fail "Skill packaging did not produce: $SkillZipPath" }

if (Test-Path -LiteralPath $BuildDir) {
    Remove-Item -LiteralPath $BuildDir -Recurse -Force
}

$PackageRoot = Join-Path $BuildDir $PackageName
New-Item -ItemType Directory -Path (Join-Path $PackageRoot "skill") -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $PackageRoot "knowledge") -Force | Out-Null

foreach ($doc in $RequiredDocs) {
    Copy-Item -LiteralPath (Join-Path $ExternalInstallDir $doc) -Destination (Join-Path $PackageRoot $doc) -Force
}

Copy-Item -LiteralPath $ProjectInstructionsCompact -Destination (Join-Path $PackageRoot "project-instructions.md") -Force
Copy-Item -LiteralPath $SkillZipPath -Destination (Join-Path $PackageRoot "skill\$SkillZipName") -Force

foreach ($kf in $KnowledgeFiles) {
    Copy-Item -LiteralPath (Join-Path $CoreDir $kf.Src) -Destination (Join-Path $PackageRoot "knowledge\$($kf.Dest)") -Force
}

Get-ChildItem -LiteralPath $BuildDir -Recurse -Force -File |
    Where-Object { $_.Name -eq ".DS_Store" -or $_.Name -eq "Thumbs.db" } |
    Remove-Item -Force -ErrorAction SilentlyContinue

Get-ChildItem -LiteralPath $BuildDir -Recurse -Force -Directory |
    Where-Object { $_.Name -eq "__MACOSX" } |
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

if (-not (Test-Path -LiteralPath $DistDir)) {
    New-Item -ItemType Directory -Path $DistDir -Force | Out-Null
}
if (Test-Path -LiteralPath $OutputZip) {
    Remove-Item -LiteralPath $OutputZip -Force
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory(
    $BuildDir, $OutputZip, [System.IO.Compression.CompressionLevel]::Optimal, $false
)

Remove-Item -LiteralPath $BuildDir -Recurse -Force

if (-not (Test-Path -LiteralPath $OutputZip -PathType Leaf)) { Fail "packaging failed: $OutputZip was not created" }

Write-Host "Packaged Claude external kit: $OutputZip"
Write-Host ""
Write-Host "Packaged files:"

$Archive = [System.IO.Compression.ZipFile]::OpenRead($OutputZip)
try {
    $Archive.Entries | Where-Object { -not $_.FullName.EndsWith("/") } | ForEach-Object { $_.FullName } | Sort-Object
} finally {
    $Archive.Dispose()
}
