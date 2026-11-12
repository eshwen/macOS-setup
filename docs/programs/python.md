---
icon: lucide/code-xml
---

# Python

Python is not bundled with macOS as of v13.

## uv

[uv](https://docs.astral.sh/uv/) manages Python installs, virtual environments, dependencies and CLI tools in one place, so it's the default for any new project. `pyenv` and Poetry are still installed with [Homebrew](./homebrew.md) for repos that use them. Once it's been installed with Homebrew, install a recent version of Python with

```sh
uv python install <version>
```

Multiple installations are supported. List the installed and available versions with

```sh
uv python list
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

## Dependencies

See <https://github.com/eshwen/ds-python-boilerplate> for a list of common Python dependencies for data science.
