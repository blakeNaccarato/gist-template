<#
.SYNOPSIS
Copy the template and install requirements in a Python virtual environment.
#>

$PYTHON_VERSION = '3.11'

$tmp = New-TemporaryFile
$tmpdir = "$($tmp.Directory)/$($tmp.BaseName)"
git clone --depth 1 'https://github.com/blakeNaccarato/gist-template.git' $tmpdir
$template = "$tmpdir/template"
Get-ChildItem -File "$template/*" | Move-Item -Force
if (! (Test-Path '.vscode')) {New-Item -ItemType Directory '.vscode'}
Get-ChildItem -File "$template/.vscode/*" | Move-Item -Destination '.vscode' -Force
py "-$PYTHON_VERSION" -m 'venv' '.venv'
$activate_win = '.venv/scripts/activate'
if (Test-Path $activate_win) { . $activate_win } else { . '.venv/bin/activate' }
pip install --requirement 'requirements.txt'
