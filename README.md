# gist-template

This is a Gist template designed for rapid development of Python utilities in VSCode. It occupies the middle ground between one-off scripts and full-featured repositories. It includes refactoring tools, optional type checking, linting, and code formatting.

## Usage

To use this template, run [`Initialize-Gist.ps1`](#initialize-gistps1) in a local clone of a newly-created Gist, then commit and push the changes ([⬇ details](#generate-a-gist-from-this-template)). The script is written for [cross-platform PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell), and should work on Windows, UNIX-like, and MacOS systems alike.

## Generate a Gist from this template

These steps detail the usage of this template starting from scratch on a brand new machine, including the installation of Python and other tools.

- Ensure that Python, VSCode, PowerShell, and Git are installed. [⬇ details](#first-time-setup)
- Create a new Gist, clone it, and open in VSCode. [⬇ details](#create-a-gist-from-this-template)
- Open a new terminal window in VSCode (`` Ctrl+` ``), and copy/paste/run [`Initialize-Gist.ps1`](#initialize-gistps1) at the root of the cloned Gist directory.
- If prompted, respond `Yes` to the prompt to select the virtual environment for the workspace folder. You can fix this later on if you miss your chance here.
- Restart VSCode and follow the notification/prompt to install the recommended extensions. If you miss this prompt, you can go to the Extensions tab, search for `@recommended`, and install Workspace Recommendations with the cloud icon.
- Add the year and your name to the `LICENSE`, e.g. `Copyright (c) 2023 Blake Naccarato`. This tells others how they can use your code.
- You can now commit and push these changes to your Gist. See this [segment from a video tutorial](https://www.youtube.com/watch?v=i_23KUAEtUM&t=76s) on doing this in VSCode ([brief outline](https://code.visualstudio.com/docs/introvideos/versioncontrol#_video-outline), [more detail](https://code.visualstudio.com/docs/sourcecontrol/overview)).

Now you are ready to modify the Python scripts in your Gist to demonstrate whatever Python code you had in mind. See [next steps and template features](#next-steps-and-template-features) for more detail.

## Next steps and template features

Now you can start writing your Python code, updating requirements, and using the tooling provided by this template. Here is an example workflow which exhibits the features of this template:

### Control the Gist name/details that others see

Rename `$gist-template.md` and modify it to reflect the purpose of your Gist. It is `$`-prefixed and named so it sorts to the top of the Gist, and the Gist inherits its name. After pushing the Gist to the web and checking it online, you'll see how this Markdown file becomes the name of the Gist.

### Maintain your `requirements.txt`

We include the dependencies for running our script(s) in `requirements.txt` (e.g. `pandas==2.1.4` if we're using Pandas to crunch some numbers). Consider [pinning your requirements](https://pip.pypa.io/en/stable/topics/repeatable-installs/). You can run `pip freeze -r requirements.txt` and copy any package versions directly used by your scripts to your `requirements.txt`.

Remember to run `setup.ps1` (or `pip install -r requirements.txt`) whenever you modify `requirements.txt`.

### Set the Python interpreter

If you missed your chance on initial setup, you can still set the Python interpreter at any point. This will select the virtual environment for the workspace folder, and allow your Python scripts to leverage the packages we will install via `requirements.txt`. We isolate our Python packages in a virtual environment so that we can have different versions of packages for different projects, and so that we can easily share our project with others without sharing our Python installation.

- Open `example.py`, the main script for your Gist. You may optionally rename it.
- With `example.py` open, if you don't see `(.venv: venv)` after e.g. `3.11.6 64-bit` in the bottom-right corner of VSCode click the version number and select the interpreter option with `.venv` in it.

### Interact with suggestions from Ruff

- You may notice squiggly underlines telling you not to use `print` statements. Here `print` is a stand-in for more complex logic, but generally `print` statements should be avoided. If we hover over it and click the violation code (`T201`), it opens a webpage that suggests alternatives. Tools like Ruff help us to write better code in this fashion. We could press `Ctrl+.` (or click the floating lightbulb) and either suppress the warning, or remove the `print` statement.
- Try adding some Python code to the `main()` function. Run your script from the terminal like e.g. `python example.py`, or by clicking the "play button" icon in the VSCode tab ribbon while `example.py` is open.

### Understanding the recommended control flow

We use `main()` to encapsulate the most interesting parts of our Gist, encode constants above, implementation details below, and maybe even the really boring stuff into other files.

- Notice that `main()` is actually executed when the Python interpreter sees `if __name__ == "__main__": main()` (this condition will always be `True` when we're running the script directly). Since `do_something` is defined *before* we `main()` is executed, it will be available to `main()`, even though it's visually "below" `def main()`.
- Defining all-caps constants above `main()` (e.g. `SOME_CONSTANT`) will show others that this constant might vary in their usage (e.g. a file path, URL, or parameter). We may eventually make this a proper function argument, but for Gists, constants are fine.
- Notice that `main()` is actually executed when the Python interpreter sees `if __name__ == "__main__": main()` (this condition will always be `True` when we're running the script directly). Since `do_something` is defined *before* we `main()` is executed, it will be available to `main()`, even though it's visually "below" `def main()`.
- As your `main()` function gets even more complex, you may want to migrate some code out of it. If you want to isolate some bits of code to `other.py`, note that you can import from it like `from other import something` in your main `example.py`.

### Refactor complex bits of code with the help of Pylance

Following the recommendations above is difficult if you're constantly copy/pasting things around. But we can use Pylance to do a lot of the heavy lifting for us, moving and renaming things across files, allowing us to keep the most interesting stuff at the top without making typos.

- Try moving `do_something_boring` over to `other.py`. Simply place your cursor somewhere in `do_something_boring`'s name, click the floating lightbulb or press `Ctrl+.` then click `Move symbol to ...` and move it to `other.py`.
- You can use `F2` (or the lightbulb) to rename symbols across files, too. Try renaming `do_something_boring` to `do_something_cool`.
- Sometimes you have lots of related logic in line with the `main()` function. Try highlighting the lines from `lots_of_inline_logic` down to `but_all_this_stuff_is_related` (press `Ctrl+L` repeatedly to select entire lines at a time), click the lightbulb or press `Ctrl+.`, then click `Extract method...` and name it `do_related_things` (or whatever you like).
- Other times, you'll end up hard-coding something, e.g. `61347`, that has some special meaning to you, but not to others. Try highlighting `65535` and clicking the lightbulb or pressing `Ctrl+.`, selecting `Extract variable...`, and naming it `MAX_16_BIT_INTEGER` (just a toy example). Move this all-caps variable to the top of the file with the other all-caps constant (you'll have to manually cut/paste this one).

### Let Ruff's auto-formatting and fixes do the tedious stuff for you

You may have noticed that excess space has been automatically removed whenver saving the file. This is happening because we have enabled auto-formatting on save in `.vscode/settings.json`. This is also the case in notebooks (try VSCode's built-in Jupyter notebook features by creating an `example_notebook.ipynb` file, if you'd like).

- When you save a Python file, it will be automatically formatted, checked for errors, and some errors fixed automatically. This is enabled by Pylance and Ruff in this template.
- Consider also using [Sourcery](https://sourcery.ai/) ([VSCode extension](https://marketplace.visualstudio.com/items?itemName=sourcery.sourcery)). This suggests alternative rewritings of actual logic, not just formatting. Similarly to Ruff, it helps you discover best practices and write better code as you learn.

With auto-formatting, you'll find yourself writing longer bits of code that may spread over a couple lines, but a quick `Ctrl+S` will format it neatly. Still, avoid packing too much code into one "line" (e.g. one assignment statement).

### Type check your code with Pylance

While Ruff gives us squigglies to help us with our code style, Pylance will highlight issues with the "types" of our variables passing in and out of functions. But how does Pylance know what "type" a certain variable is? We can use "type annotations" to tell it what type we *want* a variable to have. For instance the first parameter in the `do_something_fancy` function signature is `an_argument: int`, where `an_argument` is the name of that first argument, and `int` is the type that we *want* it to be.

Python won't *guarantee* that `an_argument` is an `int`, but Pylance will warn us if we try to pass something else in. Try passing a non-integer to `do_something_fancy`. This is useful for catching bugs early, and for documenting our code. We also see from `-> float` that `do_something_fancy` should return a `float`.

We can even "reveal" the expected types of things by pressing `Ctrl+Alt`. We can see that the `result` variable up in `main` has a ghostly `: float` next to it, telling us that Pylance expects `result` to be a floating point number.

You can interact with Pylance squigglies much in the same way as you do with Ruff, the lightbulb will let you suppress warnings (it adds `# type: ignore` to the end of the line in question).

### Going beyond the Gist

If your Gist becomes more complex, consider migrating to a full-featured GitHub repository. Check out my [copier-python repository template](https://github.com/blakeNaccarato/copier-python), which is a lot like this Gist template, but facilitates organizing your code into a package releasable on PyPI, and has documentation, testing, and even more dev tooling.

## In-depth guides

These details further expand on the steps for [generating a Gist from this template](#generate-a-gist-from-this-template).

### First-time setup

If on Windows, you may simply run [`Initialize-WindowsDev.ps1`](#initialize-windowsdevps1), which will also install Windows Terminal. Otherwise, follow the steps below.

- Review relevant sections of [this setup guide](https://blakenaccarato.github.io/copier-python/#one-time-setup) to install Python, VSCode, Python, the cross-platform PowerShell, and Git.
- Install the UNIX-like/MacOS [Python Launcher](https://python-launcher.app/) so the `py` command in `setup.ps1` will work for you.
- Create a GitHub account if you haven't already, and set up your Git user credentials. See [⬇ details](#create-a-github-account)

[⬆ back](#generate-a-gist-from-this-template)

### Create a Gist from this template

- Create a new Gist by clicking `+` near the top-right of the Gist web interface.
- Here you can provide a description that will show alongside your Gist, or edit it later.
- Type any arbitrary characters into the blank filename and file contents fields and create your Gist.
- Clone your newly-created Gist and open it in VSCode. [⬇ details](#clone-and-open-your-gist)

[⬆ back](#generate-a-gist-from-this-template)

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

### `Initialize-Gist.ps1`

This script copies the template and sets up a Python virtual environment.

```PowerShell
$tmp = New-TemporaryFile
$tmpdir = "$($tmp.Directory)/$($tmp.BaseName)"
git clone --depth 1 'https://github.com/blakeNaccarato/gist-template.git' $tmpdir
$template = "$tmpdir/template"
Get-ChildItem -File "$tmpdir/template-first-time/*", "$template/*" | Move-Item -Force
if (! (Test-Path '.vscode')) {New-Item -ItemType Directory '.vscode'}
Get-ChildItem -File "$template/.vscode/*" | Move-Item -Destination '.vscode' -Force
if (! (Test-Path '.venv')) {py -m 'venv' '.venv'}
```

[⬆ back](#generate-a-gist-from-this-template)

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
