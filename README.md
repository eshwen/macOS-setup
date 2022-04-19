# macOS-setup

Files and scripts useful for setting up a new Mac. Helps keep synchronisation between my different Mac computers and offers a backup.

## Setup

1) Make a directory within the home folder called `GitHub` to store repos:

    ```sh
    mkdir $HOME/GitHub
    ```

2) Download GitHub Desktop from <https://desktop.github.com/>, then open it and sign in

3) On this page, hit the **Code** button, followed by **Open with GitHub Desktop**. If prompted for a directory, store the repo in `/Users/eshwen/GitHub/macOS-setup`

4) Copy over the profile/configuration settings:

    ```sh
    repo_dir="$HOME/GitHub/macOS-setup"
    cd $repo_dir
    cat bash_profile >> $HOME/.bash_profile
    cat bashrc >> $HOME/.bashrc
    cat inputrc >> $HOME/.inputrc
    cat profile >> $HOME/.profile
    ```

5) Strip out any unnecessary stuff from these new files

## Useful installs

### bash

`zsh` is the default shell in macOS as of Catalina. To switch it to `bash`, do

```sh
chsh -s /bin/bash
```

Then also download Oh My Bash (bash configuration management, themes, plugins): <https://github.com/ohmybash/oh-my-bash>. Follow the instructions to download and install.

Installing Oh My Bash may overwrite my `.bashrc` file. So I'll need to copy over my personal settings and append them to the file again, e.g., with

```sh
cat $HOME/GitHub/macOS-setup/bashrc >> $HOME/.bashrc
```

The cleanest way to manage these configurations is to keep all setup commands in the `.bashrc` file. Then in `.profile` and `.bash_profile`, just `source` the `.bashrc` file. More info can be found at <https://scriptingosx.com/2017/04/about-bash_profile-and-bashrc-on-macos/>.

#### Sticking with zsh

If sticking with `zsh`, there is an equivalent to Oh My Bash called Oh My Zsh: <https://github.com/ohmyzsh/ohmyzsh>. Both shells have configuration files `.bashrc` for `bash`, and `.zshrc` for `zsh`. If I want to switch from `bash` to `zsh`, I just need to rename my `~/.bashrc` → `~/.zshrc`, and `~/.bash_profile` → `~/.zprofile`. And obviously update the calls to the relevant configuration files.

I haven't tested it, but as with bash, installing Oh My Zsh may overwrite `~/.zshrc`. So I should be aware of that. And the same logic applies to managing the configuration files as with bash.

### Rosetta 2

Rosetta 2 is Apple's utility to translate Intel-based (x86) apps so they're Apple Silicon-compatibile. It's no longer bundled with macOS as of Monterey. If I try to open an x86 app, I'll be prompted to install it. Otherwise, I can type in the Terminal

```sh
softwareupdate --install-rosetta
```

### Homebrew

Install Homebrew (an excellent package manager for macOS): <https://brew.sh/>. This should also install the XCode Command Line Tools which is useful for software development.

Once completed, I can use it to install and manage various programs and packages. It should keep them up to date without requiring conscious individual checks, and should install the right versions for my architecture (i.e., Intel x64 or Apple Silicon) and OS. Install the packages with

```sh
# Make directory to store gaming apps
games_dir="/Applications/Games"
mkdir $games_dir

# Formulae
brew install bash  # for a newer version than that bundled with macOS
brew install emacs  # since it's not provided by default as of macOS Catalina. If I can't run emacs after it's been installed, do 'brew reinstall --cask --no-quarantine emacs'
brew install git  # for a newer version than that bundled with macOS
brew link --overwrite git  # so it's linked by default instead of the version bundled with macOS
brew install pyenv  # best way of managing Python installs on Mac
brew install tree  # Show directory trees (use `-L <levels>` options to show set number of levels)
brew install wget  # for wget command like on linux

# Casks
brew install --cask adobe-acrobat-reader
brew install --cask alfred  # suped version of Spotlight
brew install --cask android-file-transfer  # For copying files to Oculus Quest
brew install --cask blackhole-64ch  # for BlackHole (audio output from screen recording)
brew install --cask discord
brew install --cask epic-games --appdir $games_dir
brew install --cask filebot  # for batch renaming of files
brew install --cask folx  # torrent client
brew install --cask github  # GitHub Desktop
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask handbrake  # for re-encoding videos
brew install --cask mactex  # for MacTeX distro of TeXLive with GUI applications
brew install --cask messenger  # Facebook Messenger
brew install --cask microsoft-excel
brew install --cask microsoft-powerpoint
brew install --cask microsoft-word
brew install --cask mkvtoolnix  # for quickly adding/removing embedded audio and subtitle tracks from MKV files
brew install --cask openemu  # Old video game emulation
brew install --cask plex  # Media player client for Plex
brew install --cask private-internet-access
brew install --cask qlvideo  # for QLVideo (thumbnails for mkv and other file formats)
brew install --cask raindropio
brew install --cask runescape --appdir $games_dir
brew install --cask sidequest  # For sideloading more VR content onto Oculus Quest 
brew install --cask skype
brew install --cask steam --appdir $games_dir
brew install --cask todoist
brew install --cask visual-studio-code  # the best code editor
brew install --cask vlc
brew install --cask whatsapp
brew install --cask zoom

# Huboo-specific
brew install mysql

brew install --cask anaconda
brew install --cask aws-vpn-client
brew install --cask docker
brew install --cask microsoft-outlook
brew install --cask microsoft-teams
brew install --cask mysqlworkbench
brew install --cask onedrive
brew install --cask postman
brew install --cask slack
```

Typically, the `--cask` option is used when you want to install GUI applications. Certain packages like `handbrake` can operate solely on the command line. So in that case, just doing `brew install handbrake` would install the _formula_ (the CLI-only version), where `brew install --cask handbrake` will install the GUI application that sits in my `Applications` folder.

For any issues with opening these programs, see <https://support.apple.com/en-gb/guide/mac-help/mh40616/mac>.

The manpage is at <https://docs.brew.sh/Manpage>, containing a bunch of useful commands like `autoremove` (to remove unused dependencies).

#### Updating

Upgrade Homebrew packages with

```sh
brew upgrade
brew upgrade --cask
```

Casks with auto-update utilities (like a lot of GUI applications) won't be updated when the above commands are run; the built-in updaters will maintain them in those cases. To force them to update with Homebrew, run

```sh
brew upgrade --greedy
```

#### Cleanup and uninstalling

Homebrew should run a cleanup of caches and old files every so often. For manual scrubbing, run

```sh
brew cleanup -s --prune all
```

Uninstall a formula/cask with

```sh
brew uninstall <formula/cask>
```

Uninstall unused dependencies of formulae/casks with

```sh
brew autoremove
```

### TeX Live

TeX Live is installed under the `mactex` cask with Homebrew. As well as the actual TeX backend, it may bundle the spelling utility cocoAspell, and fronted GUI applications like BibDesk, TeX Live Utility, LaTeXiT, and TeXShop. Uninstall the latter two, since VS Code is way better than TeXShop and I've never needed LaTeXiT. For the former three, if they are not installed by default do so with

```sh
tex_dir="/Applications/TeX"
mkdir $tex_dir
brew install cocoaspell  # for TeX spelling utilities
brew install --cask bibdesk --appdir $tex_dir  # for LaTeX bibliography management
brew install --cask tex-live-utility --appdir $tex_dir  # for maintaining installed LaTeX packages
```

MacTeX/TeX Live installs as root (possibly to avoid large installs and conflicts for multiple users). So if avoiding TeX Live Utility to update packages, I can go via the command line with `sudo` privileges. Check for outdated packages with

```sh
sudo tlmgr update --list
```

Update the package manager itself with

```sh
sudo tlmgr update --self
```

and then update the packages with

```sh
sudo tlmgr update --all
```

### Garamond Expert

My favourite font is **Garamond Expert with New TX Math** (the LaTeX package `garamondx` - see [here](helpful_docs/garamondx-doc.pdf)). As well as being visually appealing, it supports bold, italic, and small cap styles that other Garamond variants do not. If compiling a LaTeX document on Overleaf, this should already be installed. However, it is not bundled with TeX Live due to licensing. To circumvent this, follow the instructions at <http://tug.org/fonts/getnonfreefonts/>:

```sh
curl --remote-name https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts
sudo texlua install-getnonfreefonts
sudo getnonfreefonts --sys -a
```

If the above doesn't work (sometimes the `microtype` package fails to map things properly), also try

```sh
updmap-sys
```

_Do not_ run `getnonfreefonts` with `--user`, or `updmap-user`, for the reasons outlined in <https://tex.stackexchange.com/a/255711>.

### Python

Apparently, Python won't come bundled with macOS starting with v13. And only Python 2 seems to be bundled with versions as recent as Monterey. While Anaconda is a good environment manager, `pyenv` is the simplest and most lightweight option for pure Python. Once `pyenv` has been installed with Homebrew, install a recent version of Python with

```sh
pyenv install <version>
```

Multiple installs are supported, so I can have separate Python 2 and Python 3 environments, or even separate Python 3.X ones. Each is bundled with `pip` for external package dependency management. The active environment can be found with

```sh
pyenv global
```

and can be switched to any other install with

```sh
pyenv global <version>
```

#### Dependencies

A useful suite of packages is housed in [requirements.txt](./requirements.txt). Install them with

```sh
pip install -r requirements.txt
```

These will be tied to the active environment. So switching to a different Python version will require them to be installed again.

#### Tensorflow

If `pip install tensorflow` doesn't work, it may because it does not yet run natively on Apple Silicon. Run the following commands to get a usable install:

```sh
pyenv install miniforge3
pyenv local miniforge3
conda install -c apple tensorflow-deps -y

pip install -U pip
pip install tensorflow-macos
pip install tensorflow-metal  # Metal plugin for GPU acceleration
```

Then, before using Tensorflow, do either `pyenv local miniforge3` or `pyenv global miniforge3` to activate the environment it's installed in.

### VS Code

In Visual Studio Code, the `settings.json` file can be edited to override some default commands. My current list of installed extensions are

- bibtexLanguage
- GitLens
- LaTeX Workshop
- markdownlint
- Project Dashboard
- Pylance
- Python
- Rainbow CSV
- Remote - SSH
- Remote - SSH: Editing Configuration Files
- Spell Right
- vscode-icons

and the settings file is [vscode_settings.json](vscode_settings.json). Even though it should be backed up to my GitHub account (`@eshwen`), a cold copy could be handy. Make sure the Python path reflects whatever version I have installed. It can be switched on-the-fly in any case.

### Fonts

There are some nice fonts I've found over the years in the [fonts/](./fonts/) directory. To install them to the system's Font Book, just highlight them all in the Finder and double click.

### Other useful installs

- Terminal settings/preferences (personal choice): [Ocean_Esh.terminal](./Ocean_Esh.terminal)
  1) Open the Terminal, and go to **Preferences** -> **Profiles**
  2) Hit the three dots in the bottom left corner and click **Import...**
  3) Select the terminal preferences file and set it as the default

## System sounds

I don't like some of the system sound effects in Big Sur. I've uploaded [Basso](./Basso_Catalina.aiff) and [Glass](./Glass_Catalina.aiff) from Catalina. To use them as system sounds, do

```bash
mkdir ~/Library/Sounds
cp Basso_Catalina.aiff Glass_Catalina.aiff ~/Libraray/Sounds/
```

Then, in System Preferences -> Sound, they should be available.

## Helpful links for computing

- Adding ssh keys to GitHub: <https://help.github.com/en/enterprise/2.16/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>
- Emacs reference card: <https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf>
- Sort all folders in Finder alphabetically: <https://apple.stackexchange.com/questions/22717/how-to-set-arrange-by-for-all-the-folders-in-the-finder>
- Mac glyphs in unicode/HTML: <https://apple.stackexchange.com/questions/55727/where-can-i-find-the-unicode-symbols-for-mac-functional-keys-command-shift-e>

## Useful shortcuts

- Forward delete: <kbd>fn</kbd> + <kbd>&#9003;</kbd>
- Show inspector (so **Get Info** shows for active file): <kbd>&#8984;</kbd> + <kbd>&#8997;</kbd> + <kbd>i</kbd>
- Toggle to show/hide hidden files and directories (i.e., prefixed with `.`): <kbd>&#8984;</kbd> + <kbd>&#8679;</kbd> + <kbd>.</kbd>

## Mac App Wishlist

- [ ] Pixelmator Pro
- [ ] Final Cut Pro X
- [ ] Downie
- [ ] Bartender
- [ ] One Switch
- [ ] Duet Display
- [ ] Vivid

iOS apps:

- [ ] The Elements
- [ ] LumaFusion
