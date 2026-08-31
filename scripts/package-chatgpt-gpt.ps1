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

$Docs = @("README.md","instructions.md","builder-config.md","conversation-starters.md","builder-setup.md","capability-policy.md","testing-guide.md","sharing-and-publishing.md","publishing-knowledge.md","knowledge-manifest.md")
foreach ($doc in $Docs) {
    $p = Join-Path $ChatGptDir $doc
    if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { Fail "required file not found: $p" }
}

$BuildScript = Join-Path $PSScriptRoot "build-chatgpt-knowledge.ps1"
if (-not (Test-Path -LiteralPath $BuildScript -PathType Leaf)) { Fail "required build script not found: $BuildScript" }
& $BuildScript | Out-Null

$KnowledgeFiles = @("01-product-orchestration-and-quality.md","02-role-resume-and-strategy.md","03-interview-execution.md")
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

# Release metadata — ties the packaged bundles to a repository commit so a
# deployed Custom GPT can be traced back to a repository version. dist/ is
# gitignored; this file is a build artifact, not a committed source.
function Get-GitValue {
    param([string[]]$GitArgs, [string]$Fallback = "unknown")
    try {
        $out = & git -C $RepoRoot @GitArgs 2>$null
        if ($LASTEXITCODE -eq 0 -and $out) { return ($out | Select-Object -First 1).Trim() }
    } catch { }
    return $Fallback
}

$RelCommit     = Get-GitValue @("rev-parse","HEAD")
$RelDescribe   = Get-GitValue @("describe","--tags","--always","--dirty")
$RelCommitDate = Get-GitValue @("show","-s","--format=%cI","HEAD")
$RelPackagedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$Bundles = foreach ($kf in $KnowledgeFiles) {
    $bundlePath = Join-Path $PackageRoot "knowledge\$kf"
    $header = Get-Content -LiteralPath $bundlePath
    $digestLine = $header | Where-Object { $_ -like 'Content-Digest (sha256*' } | Select-Object -First 1
    $digest = ($digestLine -replace '^.*: ', '').Trim()
    $sources = @()
    $inSources = $false
    foreach ($line in $header) {
        if ($line -eq 'Sources (in order):') { $inSources = $true; continue }
        if ($inSources) {
            if ($line -like 'Content-Digest*') { break }
            if ($line -like '  *') { $sources += $line.Trim() }
        }
    }
    [ordered]@{
        file                  = "knowledge/$kf"
        content_digest_sha256 = $digest
        sources               = $sources
    }
}

$Release = [ordered]@{
    package     = $PackageName
    repository  = [ordered]@{
        commit      = $RelCommit
        describe    = $RelDescribe
        commit_date = $RelCommitDate
    }
    packaged_at = $RelPackagedAt
    knowledge_bundles = @($Bundles)
}

$ReleaseJson = Join-Path $PackageRoot "deployment-release.json"
($Release | ConvertTo-Json -Depth 6) | Set-Content -LiteralPath $ReleaseJson -Encoding utf8

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

Write-Host ""
Write-Host "== Deployment checklist (see chatgpt/publishing-knowledge.md) =="
Write-Host "Repository commit: $RelCommit"
Write-Host "Repository describe: $RelDescribe"
Write-Host ("Replace exactly these {0} Knowledge files in the GPT editor," -f $KnowledgeFiles.Count)
Write-Host "then Save/Update and Publish:"
foreach ($b in $Bundles) {
    Write-Host ("  - {0}  sha256:{1}" -f $b.file, $b.content_digest_sha256)
}
