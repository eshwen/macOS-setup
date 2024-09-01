# Homebrew

Homebrew :simple-homebrew: is an excellent, open source package manager for macOS. It's full of useful GUI programs as well as command line utilities that can be easily installed.

It should keep them up to date without requiring conscious individual checks, and should install the right versions for my architecture (i.e., Intel x64 or Apple Silicon) and OS version.

## Installation

Install Homebrew with the instructions at <https://brew.sh/>. This should also install the XCode Command Line Tools which is useful for software development.(1)
{ .annotate }

1. The manpage is at <https://docs.brew.sh/Manpage>, containing a bunch of useful commands like `autoremove` (to remove unused dependencies).

## Useful CLI utilities

```sh
brew install bash  # for a newer version than that bundled with macOS
brew install emacs  # since it's not provided by default as of macOS Catalina. If I can't run emacs after it's been installed, do 'brew reinstall --cask --no-quarantine emacs'
brew install git  # for a newer version than that bundled with macOS
brew link --overwrite git  # so it's linked by default instead of the version bundled with macOS
brew install gnupg  # GPG key generation utility (for signing Git commits
brew install poetry  # for Python project management
brew install pyenv  # best way of managing Python installs on Mac
brew install tree  # Show directory trees (use `-L <levels>` options to show set number of levels)
brew install wget  # for wget command like on linux
brew install zsh  # for a newer version than that bundled with macOS
```

## Useful GUI applications

Create a directory for games with

```shell
games_dir="/Applications/Games"
mkdir $games_dir
```

Then install the following GUI applications with

```sh
brew install --cask adobe-acrobat-reader
brew install --cask alfred  # suped version of Spotlight
brew install --cask amazon-q  # for modern terminal settings, plugin management, etc.
brew install --cask android-file-transfer  # For copying files to Oculus Quest
brew install --cask ankerwork  # For configuring my webcam
brew install --cask bartender  # for menu bar organisation
brew install --cask blackhole-64ch  # for BlackHole (audio output from screen recording)
brew install --cask discord
brew install --cask epic-games --appdir $games_dir
brew install --cask fantastical  # Better calendar app than the default
brew install --cask filebot --force --no-quarantine  # for batch renaming of files. Additional options required to start up properly
brew install --cask folx  # torrent client
brew install --cask github  # GitHub Desktop
brew install --cask gog-galaxy --appdir $games_dir
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask handbrake  # for re-encoding videos
brew install --cask hyper  # a nicer, modern terminal
brew install --cask macgpt  # ChatGPT plugin
brew install --cask mactex  # for MacTeX distro of TeXLive with GUI applications
brew install --cask messenger  # Facebook Messenger
brew install --cask microsoft-excel
brew install --cask microsoft-powerpoint
brew install --cask microsoft-word
brew install --cask mimestream  # a modern, macOS-native Gmail client
brew install --cask mkvtoolnix  # for quickly adding/removing embedded audio and subtitle tracks from MKV files
brew install --cask openemu  # Old video game emulation
brew install --cask plex  # Media player client for Plex
brew install --cask private-internet-access
brew install --cask pycharm  # My favourite IDE at the moment
brew install --cask qlvideo  # for QLVideo (thumbnails for mkv and other file formats)
brew install --cask raindropio
brew install --cask readdle-spark  # For the Spark email client
brew install --cask runescape --appdir $games_dir
brew install --cask sidequest  # For sideloading more VR content onto Oculus Quest 
brew install --cask skype
brew install --cask steam --appdir $games_dir
brew install --cask todoist
brew install --cask visual-studio-code  # A good code and text editor supporting many languages
brew install --cask vivid  # Unlock higher brightness range on the display
brew install --cask vlc
brew install --cask whatsapp
brew install --cask zoom
```

Typically, the `--cask` option is used when you want to install GUI applications. Certain packages like `handbrake` can operate solely on the command line. So in that case, just doing `brew install handbrake` would install the _formula_ (the CLI-only version), where `brew install --cask handbrake` will install the GUI application that sits in my `Applications` folder.

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

## Bartender 5 triggers

Bartender contains functionality to show a (normally-hidden) menu bar item based on a trigger. These can be on specific WiFi connections, battery percentages, or shell scripts. New triggers can be added in Bartender's settings -> Triggers.

### Private Internet Access trigger

One thing I would like to be aware of is when my VPN Private Internet Access (PIA) is active. The most robust trigger for this case is a script, pasting the following:

```shell
PATH="$PATH:/usr/local/bin"
[[ "$(piactl get connectionstate)" != "Connected" ]]; echo "$?"
```

Now it will show the PIA icon when the VPN is connected. An unintuitive subtlety with these shell scripts is that Bartender designates `1` as True and `0` as False - the opposite of the Unix default! This is why the operator above is `!=` instead of `==`.
