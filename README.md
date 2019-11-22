# macOS-home-files
Files and scripts useful for macOS. Helps keep synchronisation between my different Mac computers and offers a backup

If wanting to implement, move files from [ssh/](ssh/) to `~/.ssh/` and [sshfs/](sshfs/) to `~/.sshfs/`.


# Other useful installs

- Install Homebrew (package manager for macOS): [https://brew.sh/].
- Install pip: `sudo easy_install pip`
- Install the latest Python2 and Python3 version: [https://www.python.org/downloads/]. Though, a better way to manage Python on Mac can be found in this article: https://opensource.com/article/19/5/python-3-default-mac
- Install FUSE (for sshfs capabilities): [https://osxfuse.github.io/]
- Download QLVideo for thumbnails for mkv and other file formats: [https://github.com/Marginal/QLVideo]
- Terminal settings/preferences (personal choice): [Ocean.terminal](./Ocean/terminal)
- Git completion for bash (download, then `source` in `~/.profile`/`~/.bashrc`): [https://github.com/git/git/blob/master/contrib/completion/git-completion.bash]
- Oh My Bash (bash configuration management, themes, plugins): [https://github.com/ohmybash/oh-my-bash]


# Helpful links for computing

- Adding ssh keys to GitHub: [https://help.github.com/en/enterprise/2.16/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent]
- Emacs reference card: [https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf]


# Commands

- Updating all outdated `pip` packages:
```bash
for package in $(pip list --outdated --format freeze | cut -d= -f1); do pip install --upgrade --user $package; done
```

or

```bash
pip list --outdated --format freeze | cut -d= -f1 > pip_outdated.txt; pip install --upgrade --user -r pip_outdated.txt; rm pip_outdated.txt
```