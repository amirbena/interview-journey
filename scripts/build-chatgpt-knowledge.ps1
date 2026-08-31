<#
.SYNOPSIS
    Deterministically generates the 3 ChatGPT Custom GPT Knowledge bundles
    under chatgpt/knowledge/ from an explicit allowlist of canonical
    repository sources. See chatgpt/knowledge-manifest.md for the full
    bundle-to-source mapping.

.DESCRIPTION
    Each bundle carries a deterministic provenance header (bundle position,
    ordered source list, and a sha256 Content-Digest).

    Digest normalization contract (identical in build-chatgpt-knowledge.sh):
    the digest input is the ordered concatenation of each listed source's
    raw bytes with every CR (0x0D) byte removed. No other bytes are added,
    removed, or normalized - a source's final-LF presence or absence is
    preserved. The digest depends only on source content (no timestamp, no
    commit), so rebuilding from unchanged sources produces byte-identical
    output. The bundle body embeds the same CR-stripped bytes, and all
    files are written as UTF-8 without a BOM.

    Never edit a file under chatgpt/knowledge/ directly - rebuild it here.
    tests/validate-repository.sh rebuilds the bundles into a temporary
    directory and fails if the committed files differ in any byte.

    Logically equivalent to scripts/build-chatgpt-knowledge.sh: same bundle
    names, same source order, same CR-stripped bytes, same Content-Digest,
    same byte-for-byte output.

.PARAMETER OutputDir
    Directory to render the bundles into. Defaults to
    <repo>/chatgpt/knowledge. A non-default value is used only by
    validation to render into a scratch directory.
#>

param([string]$OutputDir)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Fail {
    param([string]$Message)
    Write-Error "error: $Message"
    exit 1
}

$RepoRoot = Split-Path -Parent $PSScriptRoot
$KnowledgeDir = if ([string]::IsNullOrWhiteSpace($OutputDir)) { Join-Path $RepoRoot "chatgpt\knowledge" } else { $OutputDir }

# Explicit bundle -> source allowlist. Every core/*.md, frameworks/NN-*.md,
# and the two schema/workflow sources appear in exactly one bundle.
$Bundles = [ordered]@{
    "01-product-orchestration-and-quality.md" = @("core/product-definition.md","core/terminology.md","core/scope-and-non-goals.md","core/workflow.md","core/orchestration-policy.md","core/state-management.md","frameworks/15-interview-journey-intelligence-framework.md","core/evidence-policy.md","core/accuracy-policy.md","core/context-priority.md","core/quality-gates.md","core/output-contracts.md","core/offer-negotiation-preparation.md")
    "02-role-resume-and-strategy.md" = @("frameworks/01-role-intelligence-framework.md","frameworks/02-resume-intelligence-framework.md","frameworks/03-interview-stage-framework.md","frameworks/04-role-fit-gap-analysis-framework.md","frameworks/05-interview-intelligence-framework.md","frameworks/06-preparation-strategy-framework.md","schemas/public-research-evidence.schema.md","workflows/research-current-interview-intelligence.md","frameworks/07-question-prediction-framework.md","frameworks/08-interview-hypothesis-framework.md")
    "03-interview-execution.md" = @("frameworks/09-coding-interview-decision-engine.md","frameworks/10-system-design-framework.md","frameworks/11-behavioral-interview-framework.md","frameworks/12-mock-interview-framework.md","frameworks/13-answer-coaching-framework.md","frameworks/14-post-interview-debrief-framework.md")
}

$BundleCount = $Bundles.Count

foreach ($bundle in $Bundles.Keys) {
    foreach ($src in $Bundles[$bundle]) {
        $p = Join-Path $RepoRoot $src
        if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { Fail "required canonical source not found: $p" }
    }
}

if (-not (Test-Path -LiteralPath $KnowledgeDir)) {
    New-Item -ItemType Directory -Path $KnowledgeDir -Force | Out-Null
}

$AllowedNames = $Bundles.Keys
Get-ChildItem -LiteralPath $KnowledgeDir -Filter "*.md" -File -ErrorAction SilentlyContinue |
    Where-Object { $AllowedNames -notcontains $_.Name } |
    Remove-Item -Force

# Digest normalization contract: raw source bytes with every CR (0x0D)
# removed; nothing else added, removed, or normalized. Byte-for-byte
# equivalent to `tr -d '\r'` in build-chatgpt-knowledge.sh.
#
# Returns the array as a single object (unary comma) so the pipeline does
# not unroll it. The caller keeps it as a real [byte[]] and never relies on
# implicit object[] -> IEnumerable[byte] coercion. Correct for empty,
# one-byte, multi-byte, CR-only, and no-final-LF sources.
function Get-NormalizedSourceBytes {
    param([string]$RelPath)
    $bytes = [System.IO.File]::ReadAllBytes((Join-Path $RepoRoot $RelPath))
    $out = [System.Collections.Generic.List[byte]]::new($bytes.Length)
    foreach ($b in $bytes) { if ($b -ne 0x0D) { $out.Add($b) } }
    return ,$out.ToArray()
}

$sha256 = [System.Security.Cryptography.SHA256]::Create()
# UTF-8 without BOM for every text fragment written below.
$utf8 = New-Object System.Text.UTF8Encoding($false)

$bundleIndex = 0
foreach ($bundleName in $Bundles.Keys) {
    $bundleIndex++
    $sources = $Bundles[$bundleName]
    $outPath = Join-Path $KnowledgeDir $bundleName
    $tmpPath = "$outPath.tmp"

    $normalized = @{}
    $digestInput = [System.Collections.Generic.List[byte]]::new()
    foreach ($src in $sources) {
        [byte[]] $nb = Get-NormalizedSourceBytes $src
        $normalized[$src] = $nb
        $digestInput.AddRange([byte[]] $nb)
    }
    $digest = ([BitConverter]::ToString($sha256.ComputeHash($digestInput.ToArray())) -replace '-', '').ToLowerInvariant()

    # Assemble the bundle as raw bytes: header/framing as UTF-8 (no BOM),
    # source content as the exact CR-stripped bytes.
    $out = [System.Collections.Generic.List[byte]]::new()
    $out.AddRange($utf8.GetBytes("<!--`n"))
    $out.AddRange($utf8.GetBytes("Generated from canonical Interview Journey repository sources.`n"))
    $out.AddRange($utf8.GetBytes("Do not edit this file manually.`n"))
    $out.AddRange($utf8.GetBytes("Rebuild it using the ChatGPT Knowledge build script`n"))
    $out.AddRange($utf8.GetBytes("(scripts/build-chatgpt-knowledge.sh or .ps1).`n"))
    $out.AddRange($utf8.GetBytes("`n"))
    $out.AddRange($utf8.GetBytes("Bundle: $bundleName ($bundleIndex of $BundleCount)`n"))
    $out.AddRange($utf8.GetBytes("Sources (in order):`n"))
    foreach ($src in $sources) { $out.AddRange($utf8.GetBytes("  $src`n")) }
    $out.AddRange($utf8.GetBytes("Content-Digest (sha256, sources concatenated in order, CR bytes removed): $digest`n"))
    $out.AddRange($utf8.GetBytes("-->`n`n"))
    $out.AddRange($utf8.GetBytes("# " + ($bundleName -replace '\.md$', '') + "`n`n"))

    for ($i = 0; $i -lt $sources.Count; $i++) {
        $src = $sources[$i]
        $out.AddRange($utf8.GetBytes("## Source: ``$src```n`n"))
        $out.AddRange([byte[]] $normalized[$src])
        if ($i -lt $sources.Count - 1) {
            $out.AddRange($utf8.GetBytes("`n`n---`n`n"))
        } else {
            $out.AddRange($utf8.GetBytes("`n"))
        }
    }

    [System.IO.File]::WriteAllBytes($tmpPath, $out.ToArray())
    Move-Item -LiteralPath $tmpPath -Destination $outPath -Force
}

Write-Host "Generated ChatGPT Knowledge bundles in: $KnowledgeDir"
Write-Host ""
Write-Host "Generated files:"
foreach ($name in $Bundles.Keys) {
    Write-Host "chatgpt/knowledge/$name"
}
