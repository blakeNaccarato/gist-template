<#.SYNOPSIS
Copy the template and update dependencies in a Python virtual environment.#>

# ? Fail early
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true
$PSNativeCommandUseErrorActionPreference | Out-Null
# ? Source Python version from `runtime.txt`
$ver_pattern = '^python-(\d+\.\d+).+$'
$re = Get-Content "runtime.txt" -ErrorAction Ignore | Select-String -Pattern $ver_pattern
$Version = $re.Matches.Groups[1].value
$Version = $Version ? $Version : '3.12'

function Sync-Py {
    <#.SYNOPSIS
    Copy the template and update dependencies in a Python virtual environment.#>
    '***SYNCING' | Write-PyProgress
    'SYNCING PROJECT FROM TEMPLATE' | Write-PyProgress
    $tmp = New-TemporaryFile
    $tmpdir = "$($tmp.Directory)/$($tmp.BaseName)"
    git clone --depth 1 'https://github.com/blakeNaccarato/gist-template.git' $tmpdir
    $template = "$tmpdir/template"
    Get-ChildItem -File "$template/*" | Move-Item -Force
    if (! (Test-Path '.vscode')) {New-Item -ItemType Directory '.vscode'}
    Get-ChildItem -File "$template/.vscode/*" | Move-Item -Destination '.vscode' -Force
    $py = Get-Py $Version
    'INSTALLING UV' | Write-PyProgress
    Invoke-Expression "$py -m pip install $(Get-Content "requirements.txt" | Select-String -Pattern '^uv')"
    'INSTALLING DEPENDENCIES' | Write-PyProgress
    Invoke-Expression "$py -m uv pip install --requirement requirements.txt"
    '...DONE ***' | Write-PyProgress -Done
}

function Get-Py {
    <#.SYNOPSIS
    Get Python interpreter.#>
    Param([Parameter(ValueFromPipeline)][string]$Version)
    begin { $venvPath = '.venv' }
    process {
        $GlobalPy = Get-PyGlobal $Version
        if (!(Test-Path $venvPath)) {
            "CREATING VIRTUAL ENVIRONMENT: $venvPath" | Write-PyProgress
            Invoke-Expression "$GlobalPy -m venv $venvPath"
        }
        $VenvPy = Start-PyEnv $venvPath
        $foundVersion = Invoke-Expression "$VenvPy --version"
        if ($foundVersion |
                Select-String -Pattern "^Python $([Regex]::Escape($Version))\.\d+$") {
            "SYNCING VIRTUAL ENVIRONMENT: $(Resolve-Path $VenvPy -Relative)" |
                Write-PyProgress
            return $VenvPy
        }
        "REMOVING VIRTUAL ENVIRONMENT WITH INCORRECT PYTHON: $Env:VIRTUAL_ENV" |
            Write-PyProgress -Done
        Remove-Item -Recurse -Force $Env:VIRTUAL_ENV
        return Get-Py $Version
    }
}

function Get-PyGlobal {
    <#.SYNOPSIS
    Get global Python interpreter.#>
    Param([Parameter(Mandatory, ValueFromPipeline)][string]$Version)
    process {
        if ((Test-Command 'py') -and
        (py '--list' | Select-String -Pattern "^\s?-V:$([Regex]::Escape($Version))")) {
            return "py -$Version"
        }
        elseif (Test-Command "python$Version") { return "python$Version" }
        elseif (Test-Command 'python') { return 'python' }
        throw "Expected Python $Version, which does not appear to be installed. Ensure it is installed (e.g. from https://www.python.org/downloads/) and run this script again."
    }
}

function Start-PyEnv {
    <#.SYNOPSIS
    Activate and get the Python interpreter for the virtual environment.#>
    Param([Parameter(Mandatory, ValueFromPipeline)][string]$venvPath)
    process {
        if ($IsWindows) { $bin = 'Scripts'; $py = 'python.exe' }
        else { $bin = 'bin'; $py = 'python' }
        Invoke-Expression "$venvPath/$bin/Activate.ps1"
        return "$Env:VIRTUAL_ENV/$bin/$py"
    }
}


function Write-PyProgress {
    <#.SYNOPSIS
    Write progress and completion messages.#>
    Param([Parameter(Mandatory, ValueFromPipeline)][string]$Message,
        [switch]$Done)
    begin { $Color = $Done ? 'Green' : 'Yellow' }
    process {
        if (!$Done) { Write-Host }
        Write-Host "$Message$($Done ? '' : '...')" -ForegroundColor $Color
    }
}

function Test-Command {
    <#.SYNOPSIS
    Like `Get-Command` but errors are ignored.#>
    return Get-Command @args -ErrorAction 'Ignore'
}

Sync-Py
