# Python

Apparently, Python won't come bundled with macOS starting with v13. And only Python 2 seems to be bundled with versions as recent as Monterey.

## pyenv

While Anaconda is a good environment manager, `pyenv` is the simplest and most lightweight option for pure Python. Once `pyenv` has been installed with Homebrew, install a recent version of Python with

```sh
pyenv install <version>
```

Multiple installations are supported, so I can have separate Python 2 and Python 3 environments, or even separate Python 3.X ones. Each is bundled with `pip` for external package dependency management. The active environment can be found with

```sh
pyenv local
```

and can be switched to any other installation (applicable to the active directory) with

```sh
pyenv local <version>
```

Change the global default Python version with

```shell
pyenv global <version>
```

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

If `pip install tensorflow` doesn't work, it may because it does not yet run natively on Apple Silicon. Run the following commands to get a usable installation:

```sh
pyenv install miniforge3
pyenv local miniforge3
conda install -c apple tensorflow-deps -y

pip install -U pip
pip install tensorflow-macos
pip install tensorflow-metal  # Metal plugin for GPU acceleration
```

Then, before using Tensorflow, do either `pyenv local miniforge3` to activate the environment it's installed in.

See also: https://developer.apple.com/metal/tensorflow-plugin/
