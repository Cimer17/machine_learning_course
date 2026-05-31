param(
    [string]$Python = "python",
    [string]$PythonArgs = "",
    [string]$Wheelhouse = ""
)

$ErrorActionPreference = "Stop"

$mirrorRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($Wheelhouse)) {
    $Wheelhouse = Join-Path $mirrorRoot "wheelhouse"
}

$requirements = Join-Path $mirrorRoot "requirements.lock.txt"
$constraints = Join-Path $mirrorRoot "constraints.txt"
$inventory = Join-Path $mirrorRoot "wheelhouse_inventory.csv"

New-Item -ItemType Directory -Force -Path $Wheelhouse | Out-Null

$pythonPrefixArgs = @()
if (-not [string]::IsNullOrWhiteSpace($PythonArgs)) {
    $pythonPrefixArgs = $PythonArgs -split " "
}

Write-Host "Using Python: $Python $PythonArgs"
& $Python @pythonPrefixArgs -m pip --version
& $Python @pythonPrefixArgs -m pip download `
    --dest $Wheelhouse `
    --requirement $requirements `
    --constraint $constraints `
    --only-binary=:all:

Get-ChildItem -Path $Wheelhouse -File |
    Sort-Object Name |
    Select-Object Name, Length, LastWriteTime |
    Export-Csv -Path $inventory -NoTypeInformation -Encoding UTF8

Write-Host "Mirror saved to: $Wheelhouse"
Write-Host "Inventory saved to: $inventory"
