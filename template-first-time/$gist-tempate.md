# `example.py`

Describe your Gist here. Modify the usage instructions below as needed.

## Usage

Ensure Python is installed. If on Windows, install Python [from here](https://www.python.org/downloads/) rather than from the more limited Microsoft Store install. If on MacOS or a UNIX-like system, install [the Python Launcher](https://python-launcher.app) and obtain different Python versions as needed from [deadsnakes](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa).

Download this Gist and run `setup.ps1` in a [cross-platform PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell) terminal window. If you open the downloaded Gist folder in VSCode, open a new terminal (`` Ctrl+` ``) and run `setup.ps1` there. If on Windows, you may need to complete `Task 1` in [this guide](https://denisecase.github.io/windows-setup/) to allow scripts to run. The `setup.ps1` script essentially does the following:

- Creates a virtual environment by running `py -m venv .venv`
- Activates the virtual environment with `.venv/scripts/activate` on Windows, or `.venv/bin/activate` on UNIX-like/MacOS systems.
- Installs requirements with `pip install -r requirements.txt`.
- Installs some template-specific VSCode tooling

See a more [in-depth guide](https://github.com/blakeNaccarato/gist-template#first-time-setup) for first-time setup instructions on a new machine, or if this is your first time using Python. Now you can run Python scripts in this Gist, in an activated terminal window, for example like `python example.py`. If you plan to modify this code or use it as a starting point for your own development, the [template](https://github.com/blakeNaccarato/gist-template) from which this Gist is derived details the additional VSCode tooling available.
