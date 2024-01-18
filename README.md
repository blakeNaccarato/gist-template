# gist-template

This is a Gist template designed for rapid development of Python utilities in VSCode. It occupies the middle ground between one-off scripts and full-featured repositories. It includes refactoring tools, optional type checking, linting, and code formatting.

## Usage

To use this template, run [`setup.ps1`](#setupps1) in a local clone of a newly-created Gist ([⬇ details](#details)). The script is written for [cross-platform PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell), and should work on Windows, UNIX-like, and MacOS systems alike.

## Details

These steps detail the usage of this template starting from scratch on a brand new machine, including the installation of Python and other tools.

- Ensure that Python, VSCode, PowerShell, and Git are installed. [⬇ details](#first-time-setup)
- Create a new Gist, clone it, and open in VSCode. [⬇ details](#create-a-gist-from-this-template)
- Open a new terminal window in VSCode (`` Ctrl+` ``), and copy/paste/run [`setup.ps1`](template/setup.ps1) at the root of the cloned Gist directory.
- If prompted, respond `Yes` to the prompt to select the virtual environment for the workspace folder. If you miss it, later you can click on e.g. `3.11.6 64-bit` and select the `.venv` interpreter option (in the bottom-right corner of when a Python file is open).
- Restart VSCode and follow the notification/prompt to install the recommended extensions.
- Update `.gitignore` as needed and modify the `LICENSE`.
- Place any Python package requirements in `requirements.txt`, e.g `pandas==2.1.4`, and consider [pinning your requirements](https://pip.pypa.io/en/stable/topics/repeatable-installs/).
- Re-run [`setup.ps1`](#setupps1) (or `pip install -r requirements.txt`) whenever you modify `requirements.txt`. [⬇ details](#set-up-a-virtual-environment-and-local-vscode-tooling)
- Rename `$gist-template.md` and modify it to reflect the purpose of your Gist. It is `$`-prefixed and named so it sorts to the top of the Gist, and the Gist inherits its name.

If your Gist becomes more complex, consider migrating to a full-featured GitHub repository. Check out my [copier-python repository template](https://github.com/blakeNaccarato/copier-python), which is a lot like this Gist template, but facilitates organizing your code into a package releasable on PyPI, and has documentation, testing, and even more dev tooling.

## More details

These details further expand on the steps above.

### First-time setup

If on Windows, you may simply run [`Initialize-WindowsDev.ps1`](#initialize-windowsdevps1), which will also install Windows Terminal. Otherwise, follow the steps below.

- Review relevant sections of [this setup guide](https://blakenaccarato.github.io/copier-python/#one-time-setup) to install Python, VSCode, Python, the cross-platform PowerShell, and Git.
- Install the UNIX-like/MacOS [Python Launcher](https://python-launcher.app/) so the `py` command in `setup.ps1` will work for you.
- Create a GitHub account if you haven't already, and set up your Git user credentials. See [⬇ details](#create-a-github-account)

[⬆ back](#details)

### Create a Gist from this template

- Create a new Gist by clicking `+` near the top-right of the Gist web interface.
- Here you can provide a description that will show alongside your Gist, or edit it later.
- Type any arbitrary characters into the blank filename and file contents fields and create your Gist.
- Clone your newly-created Gist and open it in VSCode. [⬇ details](#clone-and-open-your-gist)

[⬆ back](#details)

### Set up a virtual environment and local VSCode tooling

- Restart VSCode and follow the notification/prompt to install the recommended extensions.
- Rename and modify `example.py`, the main script for your Gist. Note that you can import symbols from adjacent Python modules. (e.g. `from other import ...` refers to symbols in `other.py`)
- If prompted by VSCode, click "Yes" to select this virtual environment for the workspace folder. If not, select it later on in the bottom-right corner of VSCode when editing a Python file.

[⬆ back](#details)

### Create a GitHub account

- Whichever OS you're on, open a `pwsh` terminal window, the cross-platform PowerShell. In Windows, open Windows Terminal from the start menu (`wt`), click the gear icon in the tab strip drop-down menu, select `pwsh` as your default profile, and reopen Windows Terminal.
- The following commands will populate `.gitconfig` in your user folder (e.g. `C:/Users/<...you...>`), so that you can commit changes using your GitHub identity.

```PowerShell
git config --global user.name 'yourGitHubUsername'
git config --global user.email 'yourGitHubAssociatedEmail@email.com'
```

- If done correctly, VSCode will prompt you to log in to your GitHub account before pushing changes (a later step in the overall process above).

[⬆ First-time setup](#first-time-setup)

### Clone and open your Gist

- In the web UI of your newly-created Gist, click the drop-down for "Embed" near the top-right of the page and select "Clone via HTTPS".
- Copy the resulting URL and use it to clone your newly-created Gist locally, through the VSCode command palette's `Git: Clone` or at the command line (e.g. Windows Terminal). For example:

```PowerShell
git clone 'https://gist.github.com/<...gist...>.git' 'C:/Users/<...you...>/Desktop/my-local-clone'
```

- Open your newly-created Gist in VSCode (e.g. `C:/Users/<...you...>/Desktop/my-local-clone`).

[⬆ Create a Gist from this template](#create-a-gist-from-this-template)

## Scripts

### `setup.ps1`

This script copies the template and sets up a Python virtual environment.

```PowerShell
$tmp = New-TemporaryFile
$tmpdir = "$($tmp.Directory)/$($tmp.BaseName)"
git clone --depth 1 'https://github.com/blakeNaccarato/gist-template.git' $tmpdir
$template = "$tmpdir/template"
Get-ChildItem -File "$template/*" | Move-Item -Force
if (! (Test-Path '.vscode')) {New-Item -ItemType Directory '.vscode'}
Get-ChildItem -File "$template/.vscode/*" | Move-Item -Destination '.vscode' -Force
py -m 'venv' '.venv'
$activate_win = '.venv/scripts/activate'
if (Test-Path $activate_win) { . $activate_win } else { . '.venv/bin/activate' }
pip install --requirement 'requirements.txt'
```

[⬆ back](#details)

### `Initialize-WindowsDev.ps1`

This script uses the Windows Package Manager (`winget`) to install all the tools needed for Python development on Windows. The additional installer configuration flags are passed to `winget` via the [splatting operator](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting?view=powershell-7.4) for readability.

[⬆ First-time setup](#first-time-setup)

```PowerShell
<#
.SYNOPSIS
One-time setup for Python dev tools on Windows. Installs Python, VSCode, Windows Terminal, PowerShell, and Git.

.DESCRIPTION

Usage:

- Ensure `winget` (Microsoft App Insstaller) is installed from the Windows store or at
  https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
- Search for "PowerShell" in the start menu, find "Windows PowerShell" (not ISE),
  right-click and select "Run as administrator" (may be hidden under "More")
- In the web user interface for this Gist, click "Raw" to get the raw text of this
  script, select all (Ctrl+A), copy (Ctrl+C), and paste (Ctrl+V) into the PowerShell
  window
- Hit "Enter" to run the pasted lines
- When installation is finished, you will see `PS C:\WINDOWS\system32>` and a blinking
  cursor. Close the PowerShell window.
#>

# Install Python
winget install --id 'Python.Python.3.11' --override '/quiet PrependPath=0'
# Install VSCode
winget install --id 'Microsoft.VisualStudioCode'
# Install Windows Terminal
winget install --id 'Microsoft.WindowsTerminal'

# Install PowerShell 7
$PowerShellOverrides = @(
  '/quiet'
  'ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1'
  'ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1'
  'ADD_PATH=1'
  'ENABLE_MU=1'
  'ENABLE_PSREMOTING=1'
  'REGISTER_MANIFEST=1'
  'USE_MU=1'
)
winget install --id 'Microsoft.PowerShell' --override "$PowerShellOverrides"

# Install git
@'
[Setup]
Lang=default
Dir=C:/Program Files/Git
Group=Git
NoIcons=0
SetupType=default
Components=ext,ext\shellhere,ext\guihere,gitlfs,assoc,assoc_sh,autoupdate,windowsterminal,scalar
Tasks=
EditorOption=VisualStudioCode
CustomEditorPath=
DefaultBranchOption=main
PathOption=Cmd
SSHOption=OpenSSH
TortoiseOption=false
CURLOption=OpenSSL
CRLFOption=CRLFAlways
BashTerminalOption=MinTTY
GitPullBehaviorOption=Merge
UseCredentialManager=Enabled
PerformanceTweaksFSCache=Enabled
EnableSymlinks=Disabled
EnablePseudoConsoleSupport=Disabled
EnableFSMonitor=Enabled
'@ > ($inf = New-TemporaryFile)
winget install --id 'Git.Git' --override "/SILENT /LOADINF=$inf"
```

[⬆ First-time setup](#first-time-setup)
