# Packages the Interview Journey ChatGPT Plugin (skills-only) into
# dist\interview-journey-chatgpt-plugin.zip (logically equivalent to
# package-chatgpt-plugin.sh). Optional $env:RELEASE_VERSION stamps the
# packaged plugin manifest version.
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.IO.Compression.FileSystem

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$ChatgptDir = Join-Path $RepoRoot "chatgpt"
$PluginSrc = Join-Path $ChatgptDir "plugin"
$DistDir = Join-Path $RepoRoot "dist"
$BuildDir = Join-Path $RepoRoot ".build\chatgpt-plugin-package"
$PackageName = "interview-journey-chatgpt-plugin"
$OutputZip = Join-Path $DistDir "$PackageName.zip"
$KnowledgeFiles = @("01-product-orchestration-and-quality.md", "02-role-resume-and-strategy.md", "03-interview-execution.md")

foreach ($p in @((Join-Path $PluginSrc "plugin.json"), (Join-Path $PluginSrc "SKILL.header.md"), (Join-Path $ChatgptDir "instructions.md"), (Join-Path $ChatgptDir "capability-policy.md"))) {
  if (-not (Test-Path $p)) { throw "required file not found: $p" }
}

& (Join-Path $PSScriptRoot "build-chatgpt-knowledge.ps1") | Out-Null
foreach ($kf in $KnowledgeFiles) {
  if (-not (Test-Path (Join-Path $ChatgptDir "knowledge\$kf"))) { throw "Knowledge build did not produce: $kf" }
}

if (Test-Path $BuildDir) { Remove-Item -Recurse -Force $BuildDir }
$Root = Join-Path $BuildDir $PackageName
$SkillDest = Join-Path $Root "skills\interview-journey"
New-Item -ItemType Directory -Force (Join-Path $SkillDest "references") | Out-Null

$utf8 = New-Object System.Text.UTF8Encoding($false)
$manifestText = [IO.File]::ReadAllText((Join-Path $PluginSrc "plugin.json"))
if ($env:RELEASE_VERSION) {
  if ($env:RELEASE_VERSION -notmatch '^\d+\.\d+\.\d+([-+][0-9A-Za-z.-]+)?$') { throw "RELEASE_VERSION must be a semantic version, got: $($env:RELEASE_VERSION)" }
  $manifestText = [regex]::Replace($manifestText, '("version"\s*:\s*)"[^"]*"', "`$1`"$($env:RELEASE_VERSION)`"", 1)
}
[IO.File]::WriteAllText((Join-Path $Root "plugin.json"), $manifestText, $utf8)

$header = [IO.File]::ReadAllText((Join-Path $PluginSrc "SKILL.header.md")).Replace("`r`n", "`n")
$body = [IO.File]::ReadAllText((Join-Path $ChatgptDir "instructions.md")).Replace("`r`n", "`n")
[IO.File]::WriteAllText((Join-Path $SkillDest "SKILL.md"), ($header + "`n" + $body), $utf8)
foreach ($kf in $KnowledgeFiles) { Copy-Item (Join-Path $ChatgptDir "knowledge\$kf") (Join-Path $SkillDest "references\$kf") }
Copy-Item (Join-Path $ChatgptDir "capability-policy.md") (Join-Path $SkillDest "references\capability-policy.md")

New-Item -ItemType Directory -Force $DistDir | Out-Null
if (Test-Path $OutputZip) { Remove-Item -Force $OutputZip }
$zip = [IO.Compression.ZipFile]::Open($OutputZip, "Create")
try {
  Get-ChildItem -Recurse -File $Root | ForEach-Object {
    $rel = $_.FullName.Substring($BuildDir.Length + 1).Replace('\', '/')
    [void][IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $_.FullName, $rel)
  }
} finally { $zip.Dispose() }
Remove-Item -Recurse -Force $BuildDir

Write-Host "Packaged ChatGPT Plugin: $OutputZip"
Write-Host ""
Write-Host "Packaged files:"
$z = [IO.Compression.ZipFile]::OpenRead($OutputZip)
try { $z.Entries | ForEach-Object { $_.FullName } | Sort-Object } finally { $z.Dispose() }
