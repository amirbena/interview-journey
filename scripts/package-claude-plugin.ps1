# Packages the Interview Journey Claude Plugin into
# dist\interview-journey-claude-plugin.zip (logically equivalent to
# package-claude-plugin.sh). Optional $env:RELEASE_VERSION stamps the
# packaged plugin manifest version.
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.IO.Compression.FileSystem

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$SkillSource = Join-Path $RepoRoot "skills\interview-journey"
$Manifest = Join-Path $RepoRoot ".claude-plugin\plugin.json"
$DistDir = Join-Path $RepoRoot "dist"
$BuildDir = Join-Path $RepoRoot ".build\claude-plugin-package"
$PackageName = "interview-journey-claude-plugin"
$OutputZip = Join-Path $DistDir "$PackageName.zip"

foreach ($p in @($Manifest, (Join-Path $SkillSource "SKILL.md"), (Join-Path $SkillSource "references"), (Join-Path $SkillSource "templates"))) {
  if (-not (Test-Path $p)) { throw "required path not found: $p" }
}

if (Test-Path $BuildDir) { Remove-Item -Recurse -Force $BuildDir }
$Root = Join-Path $BuildDir $PackageName
$SkillDest = Join-Path $Root "skills\interview-journey"
New-Item -ItemType Directory -Force (Join-Path $Root ".claude-plugin"), (Join-Path $SkillDest "references"), (Join-Path $SkillDest "templates") | Out-Null

$utf8 = New-Object System.Text.UTF8Encoding($false)
$manifestText = [IO.File]::ReadAllText($Manifest)
if ($env:RELEASE_VERSION) {
  if ($env:RELEASE_VERSION -notmatch '^\d+\.\d+\.\d+([-+][0-9A-Za-z.-]+)?$') { throw "RELEASE_VERSION must be a semantic version, got: $($env:RELEASE_VERSION)" }
  $manifestText = [regex]::Replace($manifestText, '("version"\s*:\s*)"[^"]*"', "`$1`"$($env:RELEASE_VERSION)`"", 1)
}
[IO.File]::WriteAllText((Join-Path $Root ".claude-plugin\plugin.json"), $manifestText, $utf8)

Copy-Item (Join-Path $SkillSource "SKILL.md") (Join-Path $SkillDest "SKILL.md")
Copy-Item (Join-Path $SkillSource "references\*.md") (Join-Path $SkillDest "references")
Copy-Item (Join-Path $SkillSource "templates\*.md") (Join-Path $SkillDest "templates")

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

Write-Host "Packaged Claude Plugin: $OutputZip"
Write-Host ""
Write-Host "Packaged files:"
$z = [IO.Compression.ZipFile]::OpenRead($OutputZip)
try { $z.Entries | ForEach-Object { $_.FullName } | Sort-Object } finally { $z.Dispose() }
