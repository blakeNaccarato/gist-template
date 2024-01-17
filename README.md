# gist-template

This is a Gist template designed for rapid development of Python utilities in VSCode. It occupies the middle ground between one-off scripts and full-featured repositories. It includes refactoring tools, optional type checking, linting, and code formatting.

## Usage

This template uses a setup script, `setup.ps1`, written for [cross-platform PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell). It should work on Windows and UNIX-like or MacOS systems alike.

- Ensure that Python, VSCode, PowerShell, and Git are installed. If on Windows, run [Initialize-WindowsDev.ps1](https://gist.github.com/blakeNaccarato/cc50b9111afbc43ce39d7972770fefc8) or see [new machine setup (below)](#new-machine-setup) for details.
- Create a new Gist, clone it locally, and unzip this template into it. See how to [prepare a local Gist clone from this template (below)](#prepare-a-local-gist-clone-from-this-template) for details.
- Update `.gitignore` as needed, the `LICENSE` (update the year and add your name), and `requirements.txt` (consider [pinning your requirements](https://pip.pypa.io/en/stable/topics/repeatable-installs/)).
- Update `$PYTHON_VERSION` in `setup.ps1` to reflect the Python version needed for your Gist, then run `setup.ps1`. See how to [set up a virtual environment and local VSCode tooling (below)](#set-up-a-virtual-environment-and-local-vscode-tooling) for details.
- Rename and modify `$gist-template.md` to reflect the purpose of your Gist. It is `$`-prefixed and named so it sorts to the top of the Gist, and the Gist inherits its name. Think of it as the `README.md` of a Gist. Comments hiding in this Markdown document instruct what sections to cut in Gists derived from this template.

If your Gist becomes more complex, consider migrating to a full-featured GitHub repository derived from the [copier-python repository template](https://github.com/blakeNaccarato/copier-python), a sibling template with documentation, testing, and even more dev tooling.

### New machine setup

- Ensure that Python, VSCode, Python, the cross-platform PowerShell, and Git are installed.
  - For Windows machines, run [this script](https://gist.github.com/blakeNaccarato/cc50b9111afbc43ce39d7972770fefc8), which will also install Windows Terminal.
  - For other operating systems, review relevant sections of [this setup guide](https://blakenaccarato.github.io/copier-python/#one-time-setup) to install Python, VSCode, Python, the cross-platform PowerShell, and Git. You will also want to install the UNIX-like/MacOS [Python Launcher](https://python-launcher.app/) so the `py` command in `setup.ps1` will work for you.
- Create a GitHub account if you haven't already, and set up your Git user credentials
  - Whichever OS you're on, open a `pwsh` terminal window, the cross-platform PowerShell. In Windows, open Windows Terminal from the start menu (`wt`), click the gear icon in the tab strip drop-down menu, select `pwsh` as your default profile, and reopen Windows Terminal.
  - The following commands will populate `.gitconfig` in your user folder (e.g. `C:/Users/<...you...>`), so that you can commit changes using your GitHub identity.

    ```PowerShell
    git config --global user.name 'yourGitHubUsername'
    git config --global user.email 'yourGitHubAssociatedEmail@email.com'
    ```
  
  - If done correctly, VSCode will prompt you to log in to your GitHub account before pushing changes.

### Prepare a local Gist clone from this template

- Click "Download ZIP" near the top-right of the Gist web interface to download a copy of this template.
- Create a new Gist by clicking `+` near the top-right of the Gist web interface.
- Here you can provide a description that will show alongside your Gist, or edit it later.
- Type arbitrary characters into the blank filename and file contents fields and click `Create <Public/Secret> Gist`. If your Gist is secret, only those who you share the Gist link to will be able to find it. We will properly populate this Gist  shortly.
- Clone your newly-created Gist and open it in VSCode.
  - In the web UI of your newly-created Gist, click the drop-down for "Embed" near the top-right of the page and select "Clone via HTTPS".
  - Copy the resulting URL and use it to clone your newly-created Gist locally, through the VSCode command palette's `Git: Clone` or at the command line (e.g. Windows Terminal). For example:

    ```PowerShell
    git clone 'https://gist.github.com/<...gist...>.git' 'C:/Users/<...you...>/Desktop/my-local-clone'
    ```

- Open your newly-created Gist in VSCode (e.g. `C:/Users/<...you...>/Desktop/my-local-clone`).

### Set up a virtual environment and local VSCode tooling

- Run `setup.ps1`  to get some `.gitignore`'d configs for VSCode, Pylance, Ruff, and markdownlint.
- Restart VSCode and follow the notification/prompt to install the recommended extensions.
- Rename and modify `example.py`, the main script for your Gist. Note that you can import symbols from adjacent Python modules. (e.g. `from other import ...` refers to symbols in `other.py`)
- If prompted by VSCode, click "Yes" to select this virtual environment for the workspace folder. If not, select it later on in the bottom-right corner of VSCode when editing a Python file.
