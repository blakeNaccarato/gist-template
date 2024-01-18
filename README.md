# gist-template

A Gist template designed for rapid Python development in VSCode. It occupies the middle ground between one-off scripts and full-featured repositories. It includes refactoring tools, optional type checking, linting, and code formatting. You might ask, why use these tools in the first place? See [⬇ using template features](#using-template-features) for more detail, example usage, and some reasons why you might want to use these features in your development workflow.

If you're new to Python or VSCode, this template represents sensible configuration of a VSCode development environment for Python with dependency management, debugging, code checking, code formatting, refactoring, and type checking. Most tooling is configured in `pyproject.toml`, with Pylance modified to be relatively strict, but use warnings to reduce visual overwhelm, and Ruff made similarly strict, but with certain rules suppressed.

## Usage

To [⬇ generate a Gist from this template](#generate-a-gist-from-this-template), run [⬇`setup.ps1`](#setupps1) in a local clone of a newly-created Gist, then commit and push the changes. The script is written for [cross-platform PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell), and should work on Windows, UNIX-like, and MacOS systems alike. See [⬇ using template features](#using-template-features) for more detail on what this template offers.

This template currently assumes Python 3.11, but you may fork it, change `target-version = "py311"` in `pyproject.toml` accordingly, and update the `clone` target in [⬇`setup.ps1`](#setupps1).

## Generate a Gist from this template

These steps detail the usage of this template starting from scratch on a brand new machine, including the installation of Python and other tools.

- Install Python 3.11, VSCode, cross-platform PowerShell, and Git [(⬇details)](#first-time-setup)
- Create a GitHub account and set the same username/email in your `~/.gitconfig` [(⬇details)](#create-a-github-account-and-configure-git)
- Create a [blank Gist](https://gist.github.com/), populate with [⬇`setup.ps1`](#setupps1), and clone/open in VSCode [(⬇details)](#create-clone-and-open-your-gist-in-vscode)
- Run `setup.ps1` locally [(⬇details)](#run-setupps1)
- If prompted, respond `Yes` to the prompt to select the virtual environment for the workspace folder. You can fix this later on if you miss your chance here [(⬇details)](#set-your-python-interpreter).
- Restart VSCode and click `Yes` when prompted to install recommended extensions from the bottom-right notification bell menu. Otherwise, navigate to the Extensions tab, search for `@recommended`, and click the cloud icon next to `Workspace Recommendations` to install.
- Add the year and your name to the `LICENSE`, e.g. `Copyright (c) 2023 Blake Naccarato`. This signals to others the conditions for using your code.
- Commit and push changes to your Gist. See [this segment](https://www.youtube.com/watch?v=i_23KUAEtUM&t=76s) for doing this in VSCode ([brief outline](https://code.visualstudio.com/docs/introvideos/versioncontrol#_video-outline), [more detail](https://code.visualstudio.com/docs/sourcecontrol/overview)).

Now you should be able to modify and run Python scripts in this Gist. Try adding some Python code to the `main()` function of `example.py`. Run your script from the terminal like e.g. `python example.py`, or by clicking the "play button" icon in the VSCode tab ribbon while `example.py` is open. See [⬇ using template features](#using-template-features) with examples involving the code in `example.py`.

## Customizing further and going beyond the Gist template

The `.gitignored` `.vscode` folder, `.markdownlint-cli2.yaml`, and `pyproject.toml` configures template tooling. Adjust these files accordingly to customize behaviors. Modify `.gitignore` if you want to track config changes, but be mindful that Gists cannot contain directories (e.g. `.vscode`). This template seeks sensible configurations, and intentionally avoids committing the tooling specifics to the Gist to avoid clutter.

If your Gist becomes more complex, consider migrating to a full-featured GitHub repository. Check out my [copier-python repository template](https://github.com/blakeNaccarato/copier-python), which is a lot like this Gist template, but facilitates organizing your code into a package releasable on PyPI, and has documentation, testing, and even more dev tooling.

## Using template features

Now you can start writing your Python code, updating requirements, and using the tooling provided by this template. Here is an example using code in `example.py` and `other.py` that exhibits some of the features:

<!-- no toc -->
- [⬇ Control the displayed Gist name](#control-the-displayed-gist-name)
- [⬇ Debug your code](#debug-your-code)
- [⬇ Communicate your dependencies](#communicate-your-dependencies)
- [⬇ Learn gradually from immediate feedback](#learn-gradually-from-immediate-feedback)
- [⬇ Surface important details to improve readability](#surface-important-details-to-improve-readability)
- [⬇ Automate tedium every time you save the file](#automate-tedium-every-time-you-save-the-file)
- [⬇ Reduce friction and typos with refactoring](#reduce-friction-and-typos-with-refactoring)
- [⬇ Keep track of expected data types](#keep-track-of-expected-data-types)

### Control the displayed Gist name

Rename `$gist-template.md` and modify it to reflect the purpose of your Gist. It is `$`-prefixed and named so it sorts to the top of the Gist, and the Gist inherits its name. After pushing the Gist to the web and checking it online, you'll see how this Markdown file becomes the name of the Gist.

[⬆ back](#using-template-features)

### Communicate your dependencies

Include dependencies for running script(s) in `requirements.txt` (e.g. `pandas == 2.1.4` if using Pandas). Consider [pinning your requirements](https://pip.pypa.io/en/stable/topics/repeatable-installs/). You can run `pip freeze -r requirements.txt` and copy any package versions directly used by your scripts to `requirements.txt`. This signals the exact versions of dependencies these scripts last worked on. Consider also specifying the Python version you're using (Python 3.11, 3.12, etc.) in the Markdown document of your Gist. Remember to re-run `setup.ps1` (or `pip install -r requirements.txt`) whenever you modify `requirements.txt`!

[⬆ back](#using-template-features)

### Debug your code

The configurations in `launch.json` enable you to run your code in debug mode, that is, to freeze in the middle of executing your code and analyze local state. See VSCode's [Python debugging guide](https://code.visualstudio.com/docs/python/debugging) for details, but in short, you can debug your code by clicking somewhere in the "gutter" (to the left of the line number) to place a breakpoint, then press `F5` or click the drop-down arrow next to the "play button" in the tab strip and click `Debug Python file`. The bundled debug configuration redirects output to the `Debug Console` pane, so all commands run there will receive input there, as opposed to the default configuration where output is echoed to the `Terminal` pane.

### Learn gradually from immediate feedback

You may notice in `example.py`, Ruff underlines `print` statements and emits a message in the `Problems` pane. If we hover over it and click the violation code (`T201`), it opens a webpage detailing the issue. Tools like Ruff gently nudge us towards write better code by bringing up things we might not have even known to search for.

In this case, our `print` statements are stand-ins for the purposes of a tutorial. We can press `Ctrl+.` (or click the floating lightbulb) and suppress the warning in this case. Don't feel obligated to correct every single "violation" like this. Consider it an opportunity for gradual learning.

[⬆ back](#using-template-features)

### Surface important details to improve readability

Use `main()`, e.g. in `example.py`, to encapsulate the most interesting parts of your Gist. Define constants above the `main()` function body, migrate implementation details to functions below the `main()` function body, and maybe even migrate the really boring stuff to other files, e.g. `other.py`.

Notice that `main()` is actually executed when the Python interpreter runs the lines `if __name__ == "__main__": main()`. This condition will always be `True` when we're running the script directly. Since `do_something` is defined *before* `main()` is executed, it will be available to `main()`, even though it's visually "below" the `main()` function body.

Defining all-caps constants above `main()` (e.g. `SOME_CONSTANT`) shows others that this constant may vary in their usage (e.g. a file path, URL, or parameter). We may eventually make this into a proper function parameter, but for a simple Gist, hard-coded constants are fine. Use all-caps to make it obvious that this is hard-coded.

As `main()` gets even more complex, you may want to migrate some code out of it. If you want to move code over to `other.py`, note that you can import from it, e.g. `from other import something` in `example.py`.

[⬆ back](#using-template-features)

### Automate tedium every time you save the file

You may have noticed some spacing changes whenver you save the file. This is happening because we have enabled auto-formatting on save in `.vscode/settings.json`. This is also the case in notebooks (try VSCode's built-in Jupyter notebook features by creating an `example_notebook.ipynb` file, if you'd like).

Whenever you save a Python file, Ruff will automatically format it, check for stylistic issues, and fix some of them automatically. Consider also using [Sourcery](https://sourcery.ai/) ([VSCode extension](https://marketplace.visualstudio.com/items?itemName=sourcery.sourcery)). This suggests alternative rewritings of actual logic, not just formatting. Similarly to Ruff, it helps you discover best practices and learn gradually as you go along.

With auto-formatting, you'll find yourself writing longer bits of code that may run long, but a quick `Ctrl+S` will format it neatly. Still, try to avoid packing *too much* code into one statement.

[⬆ back](#using-template-features)

### Reduce friction and typos with refactoring

It is easy to make typos or lose track of code if you're constantly copy/pasting in the service of surfacing important details in `main()`, moving implementation details to their own function definitions, and so-on. These best practices really do improve readability of your code, but if it's hard to do, that code is just as likely to stay right where you put it when you first wrote it.

But we can use Pylance allows moving and renaming things across files, automatically taking care of the copy/pasting and renaming for us. This is called "refactoring", and in VSCode, all of these tools are accessible via a contextual floating lightbulb that appears in certain circumstances. We can also press `Ctrl+.` to trigger it. You can also rename a symbol with `F2` if your cursor is placed in the symbol name. Here "symbol" refers to any valid name in your Python code, be it a variable, function argument, or something else.

Here are the most important refactoring tools available to you:

- **Import symbols automatically, right when you need them:** If you wanted to use `pi` from Python's `math` module, you would need to type `from math import pi` at the top of your code, then use `pi` in your code. But we can actually just start typing `pi` whenver you first want to use it, and in the suggestion menu (`Ctrl+Space` to trigger it), we can select the `pi` entry with `math` displaying next to it, and Pylance will import it for us just in time. This "just works" for most symbols, but you may need to manually import some things still.
- **Move code to other files:** Try moving `do_something_boring` over to `other.py`. Place your cursor somewhere in `do_something_boring`'s name, click the lightbulb, click `Move symbol to ...`, and move it to `other.py`.
- **Rename symbols:** Try renaming `do_something_boring`. Place your cursor in `do_something_boring`, click the lightbulb or press `F2` to rename it to `do_something_cool`. You can do it wherever you see the symbol used, or where it's defined, and Pylance will rename it everywhere.
- **Extract code into its own function:** Sometimes you have lots of related logic in line with the `main()` function. Try highlighting the three lines of code ending with `but_all_this_stuff_is_related` (press `Ctrl+L` repeatedly to select entire lines at a time), click the lightbulb, then click `Extract method...` and name it `do_related_things`.
- **Extract constants:** You may find yourself hard-coding a "magic number", e.g. `65535`. It may have some special meaning to you, but the intent is not clear to others. Try renaming `65535`. Highlight it, click the lightbulb, click `Extract variable...`, and name it `MAX_16_BIT_INTEGER`. You may now move this to the top of the file (you'll have to manually cut/paste from here).

[⬆ back](#using-template-features)

### Keep track of expected data types

While Ruff underlines code style issues, Pylance looks for issues with the "types" of variables passing through code. But how does Pylance know what "type" a certain variable should be? We can use "type annotations" to tell it what type we *want* a variable to have. For instance the first parameter in the `do_something_fancy` function signature is `an_argument: int`, where `an_argument` is the name of that first argument, and `int` is the type that we *want* it to be.

Python won't *guarantee* that `an_argument` is an `int`, but Pylance will warn us if we try to pass something else in. Try passing a non-integer to `do_something_fancy`. This is useful for catching bugs early, and for documenting our code. We also see from the `-> float` annotation that `do_something_fancy` should return a `float`.

We can even "reveal" the expected types of things by holding down the `Ctrl+Alt` keys. We can see a ghostly `: float` appear next to the `result` variable in the `main()` function body. This tells us that Pylance has inferred `result` to be a floating point number.

You can interact with Pylance underlines much in the same way as you do with Ruff, the lightbulb will let you view and suppress warnings.

[⬆ back](#using-template-features)

## In-depth setup guide

These details further expand on the steps for [generating a Gist from this template](#generate-a-gist-from-this-template).

### First-time setup

Some basics need installing on a new computer, or if you're new to Python coding altogether.

#### On Windows

If on Windows, run [⬇`Initialize-WindowsDev.ps1`](#initialize-windowsdevps1) in a local Windows PowerShell terminal (right-click and select `Run as administrator`) which will install Windows Terminal as well. You may want to copy/paste this script into the terminal window to run it. Before running any code in this fashion, be sure you understand what it's doing. In this case, the script just runs a series of `winget` commands, which installs the software we need for developing Python code with this template.

Once Windows Terminal (`wt`) is installed, open it from the start menu, click the drop-down arrow, then `Settings`. Here, select `PowerShell` (*not* `Windows PowerShell`) as your default profile, and also consider setting your "default terminal application" to Windows Terminal.

[⬆ back](#generate-a-gist-from-this-template)

#### On other operating systems

If you're on another operating system, review relevant sections of [this setup guide](https://blakenaccarato.github.io/copier-python/#one-time-setup) to install Python, VSCode, Python, cross-platform PowerShell, and Git. Also install the UNIX-like/MacOS-compatible [Python Launcher](https://python-launcher.app/), which unifies the `py` command functionality across operating systems.

[⬆ back](#generate-a-gist-from-this-template)

### Create a GitHub account and configure git

Modify the following terminal commands with your GitHub username/email to populate `.gitconfig` in your user folder (e.g. `%USERPROFILE%/.gitconfig` on Windows, `~/.gitconfig` otherwise), so that you can commit changes in VSCode using your GitHub identity.

```PowerShell
git config --global user.name 'yourGitHubUsername'
git config --global user.email 'yourGitHubAssociatedEmail@email.com'
```

- If done correctly, VSCode will prompt you to log in to your GitHub account before pushing changes (a later step in the overall process above).

[⬆ back](#generate-a-gist-from-this-template)

### Set your Python interpreter

If you missed your chance on initial setup, you can still set the Python interpreter at any point. This will select the virtual environment for the workspace folder, and allow your Python scripts to leverage the packages we have installed from `requirements.txt`.

- Open the main script in your Gist, e.g. `example.py`
- Check for `venv` in the bottom-right corner of VSCode, e.g. `3.11.6 64-bit (.venv: venv)`
- If you don't see `venv`, click the version number to select the option with `.venv` in it

[⬆ back](#generate-a-gist-from-this-template)

### Create, clone, and open your Gist in VSCode

These steps outline the process for creating a Gist from this template, cloning it locally, and opening it in VSCode.

#### Create your Gist

- Log in to your GitHub account at <https://gist.github.com>. You will be presented with a blank Gist.
- Type a brief description that will display alongside your Gist. You can always edit it later.
- Enter `setup.ps1` into the `Filename including extension...` field
- Paste the contents of [⬇`setup.ps1`](#setupps1) into the blank file field
- Click `Create public gist` (or secret, if desired).

#### Clone and open your Gist in VSCode

In the web UI of your newly-created Gist, click the drop-down for "Embed" near the top-right of the page and select "Clone via HTTPS". Copy the resulting URL and use it to clone your newly-created Gist locally by clicking `Clone Repository` in a new VSCode window or at the command line (e.g. Windows Terminal). For example:

```PowerShell
git clone '<URL you copied>' '<destination>'
```

Click `Open` when prompted to open your newly-created Gist in VSCode, or navigate to it in your file explorer and open it in VSCode.

[⬆ back](#generate-a-gist-from-this-template)

### Run `setup.ps1`

Run `setup.ps1` in a [cross-platform PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell) terminal window. Open a new terminal window in VSCode (`` Ctrl+` ``) and run `setup.ps1` there. If on Windows, you may need to complete `Task 1` in [this guide](https://denisecase.github.io/windows-setup/) to allow scripts to run. The `setup.ps1` script essentially does the following, and also copies over some VSCode tooling:

- Creates a virtual environment by running `py -m venv .venv`
- Activates the virtual environment with `.venv/scripts/activate` on Windows, or `.venv/bin/activate` on UNIX-like/MacOS systems.
- Installs requirements with `pip install -r requirements.txt`.
- Installs some template-specific VSCode tooling

[⬆ back](#generate-a-gist-from-this-template)

## Scripts

### `setup.ps1`

Paste this script into new Gists from the web interface, naming it `setup.ps1`. After [cloning your Gist locally](#create-clone-and-open-your-gist-in-vscode), run it to populate the Gist with template items, including examples (on the first time only) and `.gitignore`d VSCode tool configurations (overwriting existing configs).

```PowerShell
<#.SYNOPSIS
Copy VSCode configs and install requirements in a Python virtual environment.
#>

# Clone the template into a temporary directory
$tempDirectory = "$(($tempFile = New-TemporaryFile).Directory)/$($tempFile.BaseName)"
git clone --depth 1 'https://github.com/blakeNaccarato/gist-template.git' $tempDirectory

# Move first-time items over if none already exist here  (e.g. readme, example scripts)
$templateFirstTime = "$tempDirectory/template-first-time"
$firstTimeItems = Get-ChildItem -File "$templateFirstTime/*"
$existingFirstTimeItems = $firstTimeItems |
    Resolve-Path -RelativeBasePath $templateFirstTime -Relative |
    Get-Item -ErrorAction SilentlyContinue
if (-not $existingFirstTimeItems) { $firstTimeItems | Move-Item }

# Move all `.gitignore`d template items over, overwriting existing items
$template = "$tempDirectory/template"
Get-ChildItem -File "$template/*" | Move-Item -Force
if (! (Test-Path '.vscode')) { New-Item -ItemType Directory '.vscode' }
Get-ChildItem -File "$template/.vscode/*" | Move-Item -Destination '.vscode' -Force

# Create a virtual environment if needed, and install requirements
if (! (Test-Path '.venv')) { py -m 'venv' '.venv' }
if (Test-Path ($activateWin = '.venv/scripts/activate')) { . $activateWin }
else { . '.venv/bin/activate' }
pip install --requirement 'requirements.txt'
```

[⬆ back](#generate-a-gist-from-this-template)

### `Initialize-WindowsDev.ps1`

This script uses the [Windows Package Manager](https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1) (`winget`) to install all the tools needed for Python development on Windows. Run this as administrator in a local Windows PowerShell (not ISE) terminal (right-click and select `Run as administrator`).

You may want to copy/paste this script into the terminal window to run it. Before running any code in this fashion, be sure you understand what it's doing. In this case, the script just runs a series of `winget` commands, which installs the software we need for developing Python code with this template.

[⬆ back](#first-time-setup)

```PowerShell
<#.SYNOPSIS
One-time setup for Python dev tools on Windows. Installs Python, VSCode, Windows Terminal, PowerShell, and Git.
#>

# Install Python
winget install --id 'Python.Python.3.11' --override '/quiet PrependPath=0'
# Install VSCode
winget install --id 'Microsoft.VisualStudioCode'
# Install Windows Terminal
winget install --id 'Microsoft.WindowsTerminal'

# Install cross-platform PowerShell
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
winget install --id 'Microsoft.PowerShell' --override $PowerShellOverrides

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
'@ | Out-File ($inf = New-TemporaryFile)
winget install --id 'Git.Git' --override "/SILENT /LOADINF=$inf"
```

[⬆ back](#first-time-setup)
