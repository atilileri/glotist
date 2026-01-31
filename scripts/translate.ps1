# Loads .env from project root and runs arb_translate.
# Requires ARB_TRANSLATE_API_KEY in .env. Run from project root:
#   .\scripts\translate.ps1

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$EnvPath = Join-Path $ProjectRoot '.env'

if (-not (Test-Path $EnvPath)) {
    Write-Error ".env not found at $EnvPath. Copy .env.example to .env and set ARB_TRANSLATE_API_KEY."
    exit 1
}

Get-Content $EnvPath | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith('#')) {
        $idx = $line.IndexOf('=')
        if ($idx -gt 0) {
            $name = $line.Substring(0, $idx).Trim()
            $value = $line.Substring($idx + 1).Trim()
            [Environment]::SetEnvironmentVariable($name, $value, 'Process')
        }
    }
}

if (-not $env:ARB_TRANSLATE_API_KEY) {
    Write-Error "ARB_TRANSLATE_API_KEY is not set in .env."
    exit 1
}

Push-Location $ProjectRoot
try {
    dart pub global run arb_translate
} finally {
    Pop-Location
}
