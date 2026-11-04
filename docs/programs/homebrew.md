# Homebrew

Homebrew :simple-homebrew: is an excellent, open source package manager for macOS. It's full of useful GUI programs as well as command line utilities that can be easily installed.

It should keep them up to date without requiring conscious individual checks, and should install the right versions for my architecture (i.e., Intel x64 or Apple Silicon) and OS version.

## Installation

`bootstrap.sh` installs Homebrew and everything in the [Brewfile](https://github.com/eshwen/macOS-setup/blob/main/Brewfile). To install Homebrew by hand, follow the instructions at <https://brew.sh/>.(1) This should also install the Xcode Command Line Tools, which are useful for software development.(2)
{ .annotate }

1. The installer prints the line to add Homebrew to your `PATH`. On Apple Silicon, it's `eval "$(/opt/homebrew/bin/brew shellenv)"` in `~/.zprofile`.
2. The manpage is at <https://docs.brew.sh/Manpage>, containing a bunch of useful commands like `autoremove` (to remove unused dependencies).

## Packages

Everything I install with Homebrew is in the Brewfile:

```ruby
--8<-- "Brewfile"
```

Install or update them all with

```sh
brew bundle install --file ~/GitHub/macOS-setup/Brewfile
```

To add a package, add it to the Brewfile rather than running `brew install`, so it's installed on every Mac. `brew bundle cleanup --file ~/GitHub/macOS-setup/Brewfile` lists anything installed that isn't in the Brewfile (add `--force` to uninstall them).

`brew` lines install _formulae_ (command line tools), and `cask` lines install GUI applications into the `Applications` folder. Some programs come as both, e.g., `handbrake` is the command line version and `handbrake-app` is the GUI.

For any issues with opening these programs, see <https://support.apple.com/en-gb/guide/mac-help/mh40616/mac>.

## Updating

Upgrade Homebrew packages with

```sh
brew upgrade
brew upgrade --cask
```

Casks with auto-update utilities (like a lot of GUI applications) won't be updated when the above commands are run; the built-in updaters will maintain them in those cases. To force them to update with Homebrew, run

```sh
brew upgrade --greedy
```

## Viewing

Check everything that's installed with

```sh
brew list
```

Check only top-level formulae with

```sh
brew leaves
```

Add the `-r` option for formulae that were explicitly installed, or `-p` for formulae installed as a dependency of a cask.

Check which formulae and casks are using a specific dependency with

```sh
brew uses --installed --recursive <dependency>
```

## Cleanup and uninstalling

Homebrew should run a cleanup of caches and old files every so often. For manual scrubbing, run

```sh
brew cleanup -s --prune all
```

Uninstall a formula/cask with

```sh
brew uninstall <formula/cask>
```

Add the `--zap` option to remove all associated files.

Uninstall unused dependencies of formulae/casks with

```sh
brew autoremove
```
