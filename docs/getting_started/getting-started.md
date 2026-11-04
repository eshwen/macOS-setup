# Installation

Run the bootstrap script in the Terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/eshwen/macOS-setup/main/bootstrap.sh | bash
```

It asks for your password once, then

1. Installs Rosetta 2 (on Apple Silicon), Homebrew and the Xcode Command Line Tools
2. Clones this repo into `~/GitHub/macOS-setup` (set `MACOS_SETUP_DIR` to change this)
3. Installs everything in the [Brewfile](../programs/homebrew.md)
4. Copies the [fonts](../programs/programs.md#fonts) and [system sounds](../mac_utilities/mac-utilities.md#system-sounds)
5. Applies the [trackpad and Finder settings](../mac_utilities/mac-utilities.md#configuration-options), and sets the [Terminal profile](../programs/cli.md#settings-for-terminal)
6. Installs [Oh My Zsh and its extensions](../programs/cli.md#extensions)

It's safe to re-run, e.g., after adding packages to the Brewfile. Each step skips anything that's already done. If you've already cloned the repo, run `./bootstrap.sh` from it instead.

## Manual steps

Once it finishes,

1. Configure the [shell extensions](../programs/cli.md#extensions) in `~/.zshrc`
2. Log out and back in so the trackpad settings take effect
3. Sign in to apps, and install the [programs not available on Homebrew](../programs/programs.md#non-homebrew)
4. Set up [verified Git commits](../programs/cli.md#verified-git-commits)
5. Install [Garamond Expert](../programs/latex.md#garamond-expert) for LaTeX
