# Homebrew

Homebrew :simple-homebrew: is an excellent, open source package manager for macOS. It's full of useful GUI programs as well as command line utilities that can be easily installed.

It should keep them up to date without requiring conscious individual checks, and should install the right versions for my architecture (i.e., Intel x64 or Apple Silicon) and OS version.

## Installation

Install Homebrew with the instructions at <https://brew.sh/>.(1) This should also install the XCode Command Line Tools which is useful for software development.(2)
{ .annotate }

1. You may need to manually add the Homebrew executable to your `PATH`. See [cli.md/#zshrc](./cli.md/#zshrc)
2. The manpage is at <https://docs.brew.sh/Manpage>, containing a bunch of useful commands like `autoremove` (to remove unused dependencies).

## Useful CLI utilities

```sh
brew install bash  # (1)
brew install emacs  # (2)
brew install git  # (3)
brew link --overwrite git  # (4)
brew install gnupg  # (5)
brew install poetry  # (6)
brew install pyenv  # (7)
brew install tree  # (8)
brew install wget  # (9)
brew install zsh  # (10)
```

1. For a newer version than that bundled with macOS.
2. Since it's not provided by default as of macOS Catalina. If I can't run emacs after it's been installed, do `brew reinstall --cask --no-quarantine emacs`.
3. For a newer version than that bundled with macOS.
4. So it's linked by default instead of the version bundled with macOS.
5. GPG key generation utility (for signing Git commits).
6. For Python project management.
7. Best way of managing Python installs on Mac.
8. Show directory trees (use `-L <levels>` options to show set number of levels).
9. For `wget` command, like on linux.
10. For a newer version than that bundled with macOS.

## Useful GUI applications

Create a directory for games with

```shell
games_dir="/Applications/Games"
mkdir $games_dir
```

Then install the following GUI applications with

```sh
brew install --cask arc
brew install --cask adobe-acrobat-reader
brew install --cask alfred  # (1)
brew install --cask amazon-q  # (2)
brew install --cask android-file-transfer  # (3)
brew install --cask ankerwork  # (4)
brew install --cask bartender  # (5)
brew install --cask blackhole-64ch  # (6)
brew install --cask discord
brew install --cask epic-games --appdir $games_dir
brew install --cask fantastical  # (7)
brew install --cask filebot --force --no-quarantine  # (8)
brew install --cask folx  # (9)
brew install --cask github
brew install --cask gog-galaxy --appdir $games_dir
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask handbrake
brew install --cask hyper  # (10)
brew install --cask macgpt  # (11)
brew install --cask mactex  # (12)
brew install --cask messenger
brew install --cask microsoft-excel
brew install --cask microsoft-powerpoint
brew install --cask microsoft-word
brew install --cask mimestream  # (13)
brew install --cask mkvtoolnix  # (14)
brew install --cask openemu  # (15)
brew install --cask plex
brew install --cask private-internet-access
brew install --cask pycharm
brew install --cask qlvideo  # (16)
brew install --cask raindropio
brew install --cask readdle-spark  # (17)
brew install --cask runescape --appdir $games_dir
brew install --cask sidequest  # (18)
brew install --cask steam --appdir $games_dir
brew install --cask todoist
brew install --cask visual-studio-code
brew install --cask vivid  # (19)
brew install --cask vlc
brew install --cask whatsapp
```

1. Suped up version of Spotlight.
2. For modern terminal settings, plugin management, etc. Requires an AWS account.
3. For copying files to Oculus Quest.
4. For configuring my webcam.
5. For menu bar organisation. Requires a licence.
6. For capturing audio output alongside a screen recording.
7. Better calendar app than the default.
8. For batch renaming of files. Additional options required to start up properly.
9. Torrent client.
10. A nicer, modern terminal.
11. ChatGPT plugin. Requires a licence.
12. For MacTeX distro of TeXLive with GUI applications.
13. A modern, macOS-native Gmail client. Requires a subscription.
14. For quickly adding/removing embedded audio and subtitle tracks from MKV files.
15. Retro video game emulator.
16. For thumbnails for mkv and other file formats.
17. Another powerful email client.
18. For sideloading more VR content onto Oculus Quest.
19. Unlock higher brightness range on the display. Requires a licence.

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

Bartender contains functionality to show a (normally-hidden) menu bar item based on a trigger. These can be on specific WiFi connections, battery percentages, or shell scripts. New triggers can be added in Bartender's settings :material-arrow-right: Triggers.

### Private Internet Access trigger

One thing I would like to be aware of is when my VPN Private Internet Access (PIA) is active. The most robust trigger for this case is a script, pasting the following:

```shell
PATH="$PATH:/usr/local/bin"
[[ "$(piactl get connectionstate)" != "Connected" ]]; echo "$?"
```

Now it will show the PIA icon when the VPN is connected. An unintuitive subtlety with these shell scripts is that Bartender designates `1` as True and `0` as False - the opposite of the Unix default! This is why the operator above is `!=` instead of `==`.
