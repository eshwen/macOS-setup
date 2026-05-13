# Command Line Interface (CLI)

## Rosetta 2

Rosetta 2 is Apple's utility to translate Intel-based (x86) apps, so they're Apple Silicon-compatible. It's no longer bundled with macOS as of Monterey. If I try to open an x86 app, I'll be prompted to install it. Otherwise, I can type in the Terminal

```sh
softwareupdate --install-rosetta
```

## Shell

`zsh` is the default shell in macOS as of Catalina.

### Changing shells

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

### Extensions

- [Oh My Zsh](https://ohmyz.sh/)
- [zsh-autoswitch-virtualenv](https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv)
    - Follow the specific instructions to integrate with Oh My Zsh
- [spaceship-prompt](https://github.com/spaceship-prompt/spaceship-prompt)
    - Follow the specific instructions to integrate with Oh My Zsh
- zsh-syntax-highlighting
    - With `brew install zsh-syntax-highlighting`

### Settings for Terminal

Terminal settings/preferences (personal choice): [Ocean_Esh.terminal]

1. Open the Terminal, and go to **Preferences** :material-arrow-right: **Profiles**
2. Hit the three dots in the bottom left corner and click **Import...**
3. Select the terminal preferences file and set it as the default

### Settings for Hyper

If using Hyper as the terminal, personalise with

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

This should apply to GitHub Desktop as well, not just commits on the CLI. Just ensure you're using the same email address for your commits as entered when creating the key. Double check in Preferences :material-arrow-right: Git :material-arrow-right: Email.

[Ocean_Esh.terminal]: https://github.com/eshwen/macOS-setup/blob/main/Ocean_Esh.terminal
