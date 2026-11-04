# LaTeX

## TeX Live

TeX Live is installed with the `mactex-no-gui` cask in [Homebrew](./homebrew.md). It's the full MacTeX distribution without the GUI applications like TeXShop and LaTeXiT, which I don't need since VS Code is way better. Install the two GUI applications I do use as separate casks, so Homebrew keeps them up to date:

```sh
brew install --cask bibdesk --appdir /Applications/TeX  # (1)
brew install --cask tex-live-utility --appdir /Applications/TeX  # (2)
```

1. For managing BibTeX references.
2. For updating TeX Live packages.

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

## Garamond Expert

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
