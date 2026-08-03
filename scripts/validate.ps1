[CmdletBinding()]
param(
    [string]$Spec42Exe,
    [string]$DomainLibrariesRoot,
    [string]$MethodLibraryRoot,
    [string]$ModelPath = "model",
    [ValidateSet("text", "json")]
    [string]$Format = "text"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$workspaceRoot = Split-Path -Parent $repoRoot
$resolvedModelPath = Join-Path $repoRoot $ModelPath
$photonicsLibraryPath = Join-Path $repoRoot "library\photonics"

if (-not $Spec42Exe) {
    if ($env:SPEC42_EXE) {
        $Spec42Exe = $env:SPEC42_EXE
    } elseif (Test-Path (Join-Path $workspaceRoot "spec42\target\debug\spec42.exe")) {
        $Spec42Exe = Join-Path $workspaceRoot "spec42\target\debug\spec42.exe"
    } else {
        $Spec42Exe = "spec42"
    }
}

if (-not $DomainLibrariesRoot) {
    if ($env:SYSML_DOMAIN_LIBRARIES_ROOT) {
        $DomainLibrariesRoot = $env:SYSML_DOMAIN_LIBRARIES_ROOT
    } else {
        $DomainLibrariesRoot = Join-Path $workspaceRoot "sysml-domain-libraries"
    }
}

if (-not $MethodLibraryRoot) {
    if ($env:ELAN8_METHOD_LIBRARY_ROOT) {
        $MethodLibraryRoot = $env:ELAN8_METHOD_LIBRARY_ROOT
    } else {
        $MethodLibraryRoot = Join-Path $workspaceRoot "mbse-methodology\library"
    }
}

$arguments = @(
    "--disable-kpar-library", "domain",
    "--disable-kpar-library", "method"
)

foreach ($libraryPath in @(
    $MethodLibraryRoot,
    (Join-Path $DomainLibrariesRoot "domain"),
    (Join-Path $DomainLibrariesRoot "technical"),
    (Join-Path $DomainLibrariesRoot "generic"),
    $photonicsLibraryPath
)) {
    if (-not (Test-Path $libraryPath)) {
        throw "Required library path not found: $libraryPath"
    }
    $arguments += @("--library-path", (Resolve-Path $libraryPath))
}

$arguments += @("check", $resolvedModelPath, "--format", $Format)

Write-Host "Running: $Spec42Exe $($arguments -join ' ')"
& $Spec42Exe @arguments
exit $LASTEXITCODE
