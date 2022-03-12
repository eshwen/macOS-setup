# macOS-home-files

Files and scripts useful for macOS. Helps keep synchronisation between my different Mac computers and offers a backup.

If wanting to implement, move files from [ssh/](ssh/) to `~/.ssh/` and [sshfs/](sshfs/) to `~/.sshfs/`. The files [bash_profile](bash_profile), [bashrc](bashrc), [profile](profile), [inputrc](inputrc) should be moved to `~/` and have a `.` prefix their filenames as well. Strip out all the unnecessary stuff from them.

## Useful installs

### Homebrew

Install Homebrew (an excellent package manager for macOS): <https://brew.sh/>. This should also install the XCode Command Line Tools which is useful for software development.

Once completed, I can use it to install and manage various programs and packages. It should keep them up to date without requiring conscious individual checks, and should install the right versions for my architecture (i.e., Intel x64 or Apple Silicon) and OS. Install the packages with

```sh
brew install pyenv  # best way of managing Python installs on Mac
brew install wget  # for wget command like on linux
brew install git  # for a newer version than that bundled with macOS
brew link --overwrite git  # so it's linked by default instead of the version bundled with macOS

brew install --cask visual-studio-code  # the best code editor
brew install --cask qlvideo  # for QLVideo (thumbnails for mkv and other file formats)
brew install --cask blackhole  # for BlackHole (audio output from screen recording)
brew install --cask mactex  # for MacTeX distro of TeXLive with GUI applications (uninstall TeXShop afterward)
brew install emacs  # since it's not provided by default as of macOS Catalina. If I can't run emacs after it's been installed, do 'brew reinstall --cask --no-quarantine emacs'
brew install --cask handbrake  # for converting videos
brew install --cask filebot  # for batch renaming of files
brew install --cask google-cloud-sdk  # for the Google Cloud SDK
```

Typically, the `--cask` option is used when you want to install GUI applications. Certain packages like `handbrake` can operate solely on the command line. So in that case, just doing `brew install handbrake` would install the _formula_ (the CLI-only version), where `brew install --cask handbrake` will install the GUI application that sits in my `Applications` folder.

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

### TeX Live

TeX Live is installed under the `mactex` cask with Homebrew. As well as the actual TeX backend, it may bundle the spelling utility cocoAspell, and fronted GUI applications like BibDesk, TeX Live Utility, and TeXShop. Uninstall the latter, since VS Code is way better. For the former three, if they are not installed by default do so with

```sh
brew install cocoaspell  # for TeX spelling utilities
brew install bibdesk  # for LaTeX bibliography management
brew install tex-live-utility  # for maintaining installed LaTeX packages
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

and the settings file is [vscode_settings.json](vscode_settings.json). Even though it should be backed up to my GitHub account, a cold copy could be handy. Make sure the Python path reflects whatever version I have installed. It can be switched on-the-fly in any case.

### bash

`zsh` is the default shell in macOS as of Catalina. To switch it to `bash`, do

```sh
chsh -s /bin/bash
```

Then also download Oh My Bash (bash configuration management, themes, plugins): <https://github.com/ohmybash/oh-my-bash>. If sticking with `zsh`, there is an equivalent: <https://github.com/ohmyzsh/ohmyzsh>.

Both shells have configuration files `.bashrc` for `bash`, and `.zshrc` for `zsh`. I'm using `bash` by default, but if I want to switch to `zsh`, I just need to rename my `~/.bashrc` to `~/.zshrc`, and `~/.bash_profile` to `~/.zprofile`, and obviously update the calls to the relevant configuration files.

Whichever shell I use, cleanest way to manage these configurations is to keep all setup commands in the `.<shell>rc` file. Then in `.profile` and `.<shell>profile` files, just `source` the `.<shell>rc` file. More info can be found at <https://scriptingosx.com/2017/04/about-bash_profile-and-bashrc-on-macos/>.

### Google Cloud SDK

This line should be added to my `.bashrc` file to get shell completion commands:

```bash
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
```

If using `zsh`, instead add to my `.zshrc`:

```zsh
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
```

### Other useful installs

- Terminal settings/preferences (personal choice): [Ocean.terminal](./Ocean/terminal)
- Git completion for `bash` (equivalent steps for `zsh`): <https://github.com/git/git/blob/master/contrib/completion/git-completion.bash>
  - Download, then rename to `$HOME/.git-completion.bash`
  - Add following line to `~/.bashrc`

  ```bash
  source $HOME/.git-completion.bash
  ```

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
