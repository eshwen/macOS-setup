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
    cat inputrc >> $HOME/.inputrc
    ```

5) Strip out any unnecessary stuff from these new files

## Useful installs

### Rosetta 2

Rosetta 2 is Apple's utility to translate Intel-based (x86) apps, so they're Apple Silicon-compatible. It's no longer bundled with macOS as of Monterey. If I try to open an x86 app, I'll be prompted to install it. Otherwise, I can type in the Terminal

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
brew install gnupg  # GPG key generation utility (for signing Git commits
brew install poetry  # for Python project management
brew install pyenv  # best way of managing Python installs on Mac
brew install tree  # Show directory trees (use `-L <levels>` options to show set number of levels)
brew install wget  # for wget command like on linux
brew install zsh  # for a newer version than that bundled with macOS

# Casks
brew install --cask adobe-acrobat-reader
brew install --cask alfred  # suped version of Spotlight
brew install --cask android-file-transfer  # For copying files to Oculus Quest
brew install --cask ankerwork  # For configuring my webcam
brew install --cask bartender  # for menu bar organisation
brew install --cask blackhole-64ch  # for BlackHole (audio output from screen recording)
brew install --cask discord
brew install --cask epic-games --appdir $games_dir
brew install --cask fantastical  # Better calendar app than the default
brew install --cask fig  # for modern terminal settings, plugin management, etc.
brew install --cask filebot --force --no-quarantine  # for batch renaming of files. Additional options required to start up properly
brew install --cask folx  # torrent client
brew install --cask github  # GitHub Desktop
brew install --cask gog-galaxy --appdir $games_dir
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask handbrake  # for re-encoding videos
brew install --cask hyper  # a nicer, modern terminal
brew install --cask lg-onscreen-control  # for controlling my LG monitor
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

#### Viewing

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

#### Cleanup and uninstalling

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

### Shell

`zsh` is the default shell in macOS as of Catalina.

#### Changing shells

To change shells, do

```sh
chsh -s <executable_path>
```

where `<executable_path>` is the path to the shell executable. For example, to change to `bash`, do

```sh
chsh -s /bin/bash
```

If installing a new shell with Homebrew (see above), the executable paths should automatically symlink. So finding the exact path shouldn't be necessary.

If changing the shell, log out and log back in to ensure it takes effect.

#### Extensions

[Fig](https://fig.io/) is an excellent tool for managing everything terminal-related: appearance, autocomplete, shell profiles, settings, plugins, etc. It's a bit like Oh My Bash/Zsh, but more modern and with a GUI. And it works with `bash`, `zsh`, and `fish`.

Install it with Homebrew (see above). Then, open it and follow the instructions to set it up. It should automatically detect the shell and prompt anything else it needs.

All shell profiles and settings, and plugins can be backed up to your Fig account, and therefore synced across computers.

##### Issues

- For an error about `.zshenv` not being found when launching the terminal in PyCharm, try the solution here: <https://github.com/withfig/fig/issues/2232#issuecomment-1497465713>
- When hovering over an element in PyCharm fails to pop up with the tooltip, see this issue: <https://github.com/withfig/fig/issues/2357>
- Fig may conflict with environment initialisation in PyCharm. Normally, when a virtualenv/Poetry environment/etc. is detected in a project and you open the terminal, that env will automatically activate. If it doesn't, install the `Zsh Autoswitch Python Virtualenv` plugin for Fig

### Python

Apparently, Python won't come bundled with macOS starting with v13. And only Python 2 seems to be bundled with versions as recent as Monterey.

#### pyenv

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

#### Anaconda

For completeness, below are instructions to install Anaconda with Homebrew:

```sh
brew install --cask anaconda
conda init "$(basename "${SHELL}")"  # If 'conda' executable doesn't work, run $(brew --prefix)/anaconda3/bin/conda
<exit and reopen shell>
conda activate
conda config --set auto_activate_base false
conda deactivate
```

Then, to install the Anaconda Navigator (a GUI for managing conda environments and installing related tools), do

```sh
conda activate
conda install -c anaconda anaconda-navigator -y
conda deactivate
```

#### Dependencies

See <https://github.com/eshwen/ds-python-boilerplate> for a list of common Python dependencies for data science.

#### Tensorflow

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

### LaTeX

#### TeX Live

TeX Live is installed under the `mactex` cask with Homebrew. As well as the actual TeX backend, it may bundle the spelling utility cocoAspell, and fronted GUI applications like BibDesk, TeX Live Utility, LaTeXiT, and TeXShop. Uninstall the latter two, since VS Code is way better than TeXShop, and I've never needed LaTeXiT. For the former three, if they are not installed by default do so with

```sh
tex_dir="/Applications/TeX"
mkdir $tex_dir
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

#### Garamond Expert

My favourite font is **Garamond Expert with New TX Math** (the LaTeX package `garamondx` - see [here](https://mirror.ox.ac.uk/sites/ctan.org/fonts/garamondx/doc/garamondx-doc.pdf)). As well as being visually appealing, it supports bold, italic, and small cap styles that other Garamond variants do not. If compiling a LaTeX document on Overleaf, this should already be installed. However, it is not bundled with TeX Live due to licensing. To circumvent this, follow the instructions at <http://tug.org/fonts/getnonfreefonts/>:

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

### Fonts

There are some nice fonts I've found over the years in the [fonts/](./fonts) directory. To install them to the system's Font Book, just highlight them all in the Finder and double click.

### Other useful installs

- Terminal settings/preferences (personal choice): [Ocean_Esh.terminal](./Ocean_Esh.terminal)
  1) Open the Terminal, and go to **Preferences** -> **Profiles**
  2) Hit the three dots in the bottom left corner and click **Import...**
  3) Select the terminal preferences file and set it as the default

- Hyper settings:

    ```shell
    hyper i hyper-material-theme
    hyper i hyper-fading-scrollbar
    hyper i hyper-blink
    hyper i hyper-quit
    hyper i default-shell
    ```

## Verified Git commits

For that sweet **Verified** mark next to commits on GitHub, the simplest method is to generate a GPG key and associate it with your account. Start with

```shell
gpg --default-new-key-algo rsa4096 --gen-key
# Enter real name
# Enter email address associated with GitHub account
# Don't enter a passphrase unless you want to type it in every time you commit
# Enter `o` to finish
```

Then view the key with

```shell
gpg --list-secret-keys --keyid-format=long
```

The output will look something like

```text
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: next trustdb check due at 2024-12-01
/Users/username/.gnupg/pubring.kbx
--------------------------------
sec   rsa4096/ABC123DEF456GHI 2022-12-02 [SC] [expires: 2024-12-01]
      JBNM4H5LJK5BKJ4BMNVTBHOI4H55P4BJ5K6L4JKL
uid                 [ultimate] Real Name <username@domain.com>
```

The bit after `sec   rsa4096/` is what we need next (`ABC123DEF456GHI`). To show the public key, do

```shell
gpg --armor --export ABC123DEF456GHI
```

which will output something like

```text
-----BEGIN PGP PUBLIC KEY BLOCK-----

AMASSIVEBLOCKOFLETTERSNUMBERSANDSYMBOLS
-----END PGP PUBLIC KEY BLOCK-----
```

Remove existing keys and associate this one to your GitHub account with

```shell
git config --global --unset gpg.format
git config --global user.signingkey ABC123DEF456GHI
git config --global commit.gpgsign true
```

Then copy that public key we generated earlier (in its entirety), and add it to your GitHub account:

1. Visit <https://github.com/settings/gpg/new>
2. Add a title
3. Paste the public key
4. Hit **Add GPG key**

This should apply to GitHub Desktop as well, not just commits on the CLI. Just ensure you're using the same email address for your commits as entered when creating the key. Double check in Preferences -> Git -> Email.

## Bartender 5 triggers

Bartender contains functionality to show a (normally-hidden) menu bar item based on a trigger. These can be on specific WiFi connections, battery percentages, or shell scripts. New triggers can be added in Bartender's settings -> Triggers.

### Private Internet Access trigger

One thing I would like to be aware of is when my VPN Private Internet Access (PIA) is active. The most robust trigger for this case is a script, pasting the following:

```shell
PATH="$PATH:/usr/local/bin"
[[ "$(piactl get connectionstate)" != "Connected" ]]; echo "$?"
```

Now it will show the PIA icon when the VPN is connected. An unintuitive subtlety with these shell scripts is that Bartender designates `1` as True and `0` as False - the opposite of the Unix default! This is why the operator above is `!=` instead of `==`.

## Time Machine

Time Machine is a great backup utility, but it's not perfect. One of the drawbacks is that - from the GUI - it's not easy to create complex exclusions from the backup.

Since I do a lot of Python development, I don't want to back up virtual environments, etc. To exclude these, you can use `find` to search for the directories and pipe them to `tmutil`, e.g.,

```shell
find `pwd` -maxdepth 3 -type d -name '.venv' | xargs -n 1 tmutil addexclusion
```

to exclude the `.venv` directory.

There's also a [tmignore] tool to automatically exclude files from your `.gitignore`, but that doesn't appear to be maintained anymore.

## System sounds

I don't like some of the system sound effects in Big Sur. I've uploaded [Basso](./Basso_Catalina.aiff) and [Glass](./Glass_Catalina.aiff) from Catalina. To use them as system sounds, do

```bash
mkdir ~/Library/Sounds
cp Basso_Catalina.aiff Glass_Catalina.aiff ~/Library/Sounds/
```

Then, in System Preferences -> Sound, they should be available.

## Helpful links for computing

- Adding ssh keys to GitHub: <https://help.github.com/en/enterprise/2.16/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>
- Emacs reference card: <https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf>
- Sort all folders in Finder alphabetically: <https://apple.stackexchange.com/questions/22717/how-to-set-arrange-by-for-all-the-folders-in-the-finder>
- Mac glyphs in unicode/HTML: <https://apple.stackexchange.com/questions/55727/where-can-i-find-the-unicode-symbols-for-mac-functional-keys-command-shift-e>

## Configuration options

- Enable 3-finger drag on the trackpad
  - Go to **System Preferences** -> **Accessibility** -> **Pointer Control**
  - Under **Mouse & Trackpad** -> **Trackpad Options...** select **three finger drag** from the dropdown menu and tick the checkbox
- Order everything in every directory within Finder alphabetically
  - In the menu bar in Finder, go to **View** -> **Show View Options**
  - Ensure **Group By** and **Sort By** have the value **Name** and click **Use As Defaults**

## Useful shortcuts

- Forward delete: <kbd>fn</kbd> + <kbd>&#9003;</kbd>
- Show inspector (so **Get Info** shows for active file): <kbd>&#8984;</kbd> + <kbd>&#8997;</kbd> + <kbd>i</kbd>
- Toggle to show/hide hidden files and directories (i.e., prefixed with `.`): <kbd>&#8984;</kbd> + <kbd>&#8679;</kbd> + <kbd>.</kbd>

[tmignore]: https://github.com/samuelmeuli/tmignore
