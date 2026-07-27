<#
.SYNOPSIS
    Packages the Interview Journey ChatGPT Custom GPT deployment archive into
    dist/interview-journey-chatgpt.zip.

.DESCRIPTION
    Runs the Knowledge builder first, then assembles the archive around its
    output plus the deployment documentation, using an explicit allowlist.
    Works when invoked from inside or outside the repository root; all paths
    resolve relative to $PSScriptRoot.
#>

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Fail {
    param([string]$Message)
    Write-Error "error: $Message"
    exit 1
}

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ChatGptDir = Join-Path $RepoRoot "chatgpt"
$KnowledgeDir = Join-Path $ChatGptDir "knowledge"

$DistDir = Join-Path $RepoRoot "dist"
$BuildDir = Join-Path $RepoRoot ".build\chatgpt-gpt-package"
$PackageName = "interview-journey-chatgpt"
$OutputZip = Join-Path $DistDir "$PackageName.zip"

$Docs = @("README.md","instructions.md","builder-config.md","conversation-starters.md","builder-setup.md","capability-policy.md","testing-guide.md","sharing-and-publishing.md","knowledge-manifest.md")
foreach ($doc in $Docs) {
    $p = Join-Path $ChatGptDir $doc
    if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { Fail "required file not found: $p" }
}

$BuildScript = Join-Path $PSScriptRoot "build-chatgpt-knowledge.ps1"
if (-not (Test-Path -LiteralPath $BuildScript -PathType Leaf)) { Fail "required build script not found: $BuildScript" }
& $BuildScript | Out-Null

$KnowledgeFiles = @("01-product-orchestration-and-state.md","02-role-intelligence.md","03-resume-stage-and-fit.md","04-interview-intelligence-and-strategy.md","05-question-prediction-and-hypotheses.md","06-coding-interviews.md","07-system-design-interviews.md","08-behavioral-and-answer-coaching.md","09-mock-interviews-and-debrief.md","10-output-contracts-and-quality.md")
foreach ($kf in $KnowledgeFiles) {
    $p = Join-Path $KnowledgeDir $kf
    if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { Fail "Knowledge build did not produce: $p" }
}

if (Test-Path -LiteralPath $BuildDir) {
    Remove-Item -LiteralPath $BuildDir -Recurse -Force
}

$PackageRoot = Join-Path $BuildDir $PackageName
New-Item -ItemType Directory -Path (Join-Path $PackageRoot "knowledge") -Force | Out-Null

foreach ($doc in $Docs) {
    Copy-Item -LiteralPath (Join-Path $ChatGptDir $doc) -Destination (Join-Path $PackageRoot $doc) -Force
}
foreach ($kf in $KnowledgeFiles) {
    Copy-Item -LiteralPath (Join-Path $KnowledgeDir $kf) -Destination (Join-Path $PackageRoot "knowledge\$kf") -Force
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

Write-Host "Packaged ChatGPT Custom GPT: $OutputZip"
Write-Host ""
Write-Host "Packaged files:"

$Archive = [System.IO.Compression.ZipFile]::OpenRead($OutputZip)
try {
    $Archive.Entries | Where-Object { -not $_.FullName.EndsWith("/") } | ForEach-Object { $_.FullName } | Sort-Object
} finally {
    $Archive.Dispose()
}
