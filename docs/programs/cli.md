---
icon: lucide/square-terminal
---

# Command Line Interface (CLI)

## Rosetta 2

Rosetta 2 is Apple's utility to translate Intel-based (x86) apps, so they're Apple Silicon-compatible. It's no longer bundled with macOS as of Monterey. `bootstrap.sh` installs it, or I can type in the Terminal

```sh
softwareupdate --install-rosetta --agree-to-license
```

## Shell

`zsh` is the default shell in macOS as of Catalina.

### Extensions

`bootstrap.sh` installs these and turns them on with `omz`, which edits `~/.zshrc` for you:

- [Oh My Zsh](https://ohmyz.sh/)
- [zsh-autoswitch-virtualenv](https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv)
    - `omz plugin enable autoswitch_virtualenv`
- [spaceship-prompt](https://github.com/spaceship-prompt/spaceship-prompt)
    - `omz theme set spaceship`
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    - Bundled with Oh My Zsh. `omz plugin enable zsh-syntax-highlighting`

!!! note

    `zsh-autoswitch-virtualenv` and `spaceship-prompt` aren't bundled with Oh My Zsh. Install them into `$ZSH_CUSTOM` first, following the Oh My Zsh instructions in each repo (`bootstrap.sh` does this). Until then, `omz` can't find them, so `omz plugin enable` and `omz theme set` fail.

### Settings for Terminal

Terminal settings/preferences (personal choice): [Ocean_Esh.terminal]

`bootstrap.sh` imports it as the **Ocean_Esh** profile and makes it the default. To do it by hand,

1. Open the Terminal, and go to **Settings** :material-arrow-right: **Profiles**
2. Hit the three dots in the bottom left corner and click **Import...**
3. Select the terminal preferences file and set it as the default

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
