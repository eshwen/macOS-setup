# Python

Apparently, Python won't come bundled with macOS starting with v13. And only Python 2 seems to be bundled with versions as recent as Monterey.

## uv

[uv](https://docs.astral.sh/uv/) manages Python installs, virtual environments, dependencies and CLI tools in one place, replacing `pyenv`, Poetry and `pipx`. Once it's been installed with Homebrew, install a recent version of Python with

```sh
uv python install <version>
```

Multiple installations are supported. List the installed and available versions with

```sh
uv python list
```

Pin the version for the current project (written to `.python-version`) with

```sh
uv python pin <version>
```

Make a version the default `python` on the `PATH` with

```sh
uv python install <version> --default
```

### Projects

Start a new project, add dependencies, and run code in its environment with

```sh
uv init
uv add <package>
uv run <command>
```

`uv sync` installs everything in `uv.lock` into `.venv`, e.g., after cloning a repo.

### Tools

Install Python CLI tools into their own isolated environments with

```sh
uv tool install <package>
```

or run one without installing it with `uvx <package>`.

## Anaconda

For completeness, below are instructions to install Anaconda with Homebrew:

```sh
brew install --cask anaconda
conda init "$(basename "${SHELL}")"  # (1)
<exit and reopen shell>
conda activate
conda config --set auto_activate_base false
conda deactivate
```

1. If `conda` executable doesn't work, run `$(brew --prefix)/anaconda3/bin/conda`

Then, to install the Anaconda Navigator (a GUI for managing conda environments and installing related tools), do

```sh
conda activate
conda install -c anaconda anaconda-navigator -y
conda deactivate
```

## Dependencies

See <https://github.com/eshwen/ds-python-boilerplate> for a list of common Python dependencies for data science.

## Tensorflow

Tensorflow runs natively on Apple Silicon, so it can be added like any other dependency:

```sh
uv add tensorflow
```

For GPU acceleration, also add Apple's Metal plugin with `uv add tensorflow-metal`. It tends to lag behind Tensorflow releases, so check which Tensorflow and Python versions it supports first.

See also: <https://developer.apple.com/metal/tensorflow-plugin/>
