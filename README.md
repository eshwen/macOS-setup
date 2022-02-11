# macOS-home-files

Files and scripts useful for macOS. Helps keep synchronisation between my different Mac computers and offers a backup

If wanting to implement, move files from [ssh/](ssh/) to `~/.ssh/` and [sshfs/](sshfs/) to `~/.sshfs/`. The files [profile](profile) and [inputrc](inputrc) should be moved to `~/` and have a `.` prepend their filenames as well.

- [macOS-home-files](#macos-home-files)
  - [Other useful installs](#other-useful-installs)
  - [Other useful commands](#other-useful-commands)
  - [VSCode settings](#vscode-settings)
  - [Helpful links for computing](#helpful-links-for-computing)

## Other useful installs

- Install XCode Command Line Tools with

```sh
xcode-select --install
```

- Install Homebrew (package manager for macOS): <https://brew.sh/>. Once installed, do

```sh
brew install pyenv  # best way of managing Python installs on Mac. Multiple installs supported, so can have Python 2 and Python 3 envs. Comes bundled with pip
brew install wget  # for wget command like on linux
brew install --cask qlvideo  # for QLVideo (thumbnails for mkv and other file formats)
brew install --cask blackhole  # for BlackHole (audio output from screen recording)
brew install --cask mactex  # for MacTeX distro of TeXLive with GUI applications. Potentially missing frontend apps are 'bibdesk', 'cocoaspell', and 'tex-live-utility', but these can be installed with 'brew cask install <app>'
brew install --cask emacs  # since it's not provided by default as of macOS Catalina. If I can't run emacs after it's been installed, do 'brew reinstall --cask --no-quarantine emacs
```

- Install following packages with pip:
  - `setuptools`
  - `colorama`
  - `scipy`
  - `pandas`
  - `matplotlib`
  - `PyYAML`
  - `jupyterlab`
  - `notebook`
  - `voila`

- Terminal settings/preferences (personal choice): [Ocean.terminal](./Ocean/terminal)
- The default install of git can be upgraded by downloading from <https://git-scm.com/>
- Git completion for bash (download, then `source` in `~/.profile`/`~/.bashrc`): <https://github.com/git/git/blob/master/contrib/completion/git-completion.bash>
- Oh My Bash (bash configuration management, themes, plugins): <https://github.com/ohmybash/oh-my-bash>

## Other useful commands

- `zsh` is the default shell in macOS as of Catalina. To switch it to `bash`, do

```sh
chsh -s /bin/bash
```

- Upgrade homebrew packages with

```sh
brew upgrade
brew cask upgrade
```

- MacTeX/TeXLive installs as root (possibly to avoid large installs and conflicts for multiple users). So if not using TeX Live Utility to update packages, I can go via the command line with `sudo` privileges. Check for outdated packages with

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

## VSCode settings

In Visual Studio Code, the `settings.json` file can be edited to override some default commands. My current list of installed extensions are

- bibtexLanguage
- GitLens
- LaTeX Workshop
- markdownlint
- Python
- Rainbow CSV
- Remote - SSH
- Remote - SSH: Editing Configuration Files
- Spell Right
- vscode-icons

and the settings file is [vscode_settings.json](vscode_settings.json)

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
