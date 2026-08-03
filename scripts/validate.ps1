[CmdletBinding()]
param(
    [string]$Spec42Exe,
    [string]$ModelPath = ".",
    [ValidateSet("text", "json")]
    [string]$Format = "text"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$workspaceRoot = Split-Path -Parent $repoRoot
$resolvedModelPath = Join-Path $repoRoot $ModelPath

if (-not $Spec42Exe) {
    if ($env:SPEC42_EXE) {
        $Spec42Exe = $env:SPEC42_EXE
    } elseif (Test-Path (Join-Path $workspaceRoot "spec42\target\debug\spec42.exe")) {
        $Spec42Exe = Join-Path $workspaceRoot "spec42\target\debug\spec42.exe"
    } else {
        $Spec42Exe = "spec42"
    }
}

$arguments = @("check", $resolvedModelPath, "--format", $Format)

Write-Host "Running: $Spec42Exe $($arguments -join ' ')"
& $Spec42Exe @arguments
exit $LASTEXITCODE
