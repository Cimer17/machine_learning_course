param(
    [string]$Python = "python",
    [string]$PythonArgs = "",
    [string]$VenvPath = ".venv",
    [string]$Wheelhouse = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) "..\..")
$mirrorRoot = Join-Path $repoRoot "shared\package_mirror"
if ([string]::IsNullOrWhiteSpace($Wheelhouse)) {
    $Wheelhouse = Join-Path $mirrorRoot "wheelhouse"
}

$requirements = Join-Path $mirrorRoot "requirements.lock.txt"
$constraints = Join-Path $mirrorRoot "constraints.txt"
$venvFullPath = Join-Path $repoRoot $VenvPath
$venvPython = Join-Path $venvFullPath "Scripts\python.exe"

if (-not (Test-Path $Wheelhouse)) {
    throw "Wheelhouse not found: $Wheelhouse. Run build_mirror.ps1 first."
}

$wheelCount = (Get-ChildItem -Path $Wheelhouse -File -Filter "*.whl" -ErrorAction SilentlyContinue | Measure-Object).Count
if ($wheelCount -eq 0) {
    throw "Wheelhouse is empty: $Wheelhouse. Run build_mirror.ps1 on a machine with internet access."
}

$pythonPrefixArgs = @()
if (-not [string]::IsNullOrWhiteSpace($PythonArgs)) {
    $pythonPrefixArgs = $PythonArgs -split " "
}

Push-Location $repoRoot
try {
    & $Python @pythonPrefixArgs -m venv $VenvPath
    & $venvPython -m pip install --no-index --find-links $Wheelhouse -r $requirements -c $constraints
    & $venvPython -m ipykernel install --user --name machine-learning-course --display-name "Machine Learning Course"
}
finally {
    Pop-Location
}

Write-Host "Environment ready: $venvFullPath"
Write-Host "Jupyter kernel: Machine Learning Course"
