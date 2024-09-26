# LaTeX

## TeX Live

TeX Live is installed under the `mactex` cask with Homebrew. As well as the actual TeX backend, it may bundle the spelling utility cocoAspell, and fronted GUI applications like BibDesk, TeX Live Utility, LaTeXiT, and TeXShop. Uninstall the latter two, since VS Code is way better than TeXShop, and I've never needed LaTeXiT. For the former three, if they are not installed by default do so with

```sh
tex_dir="/Applications/TeX"
mkdir $tex_dir
brew install --cask bibdesk --appdir $tex_dir  # (1)
brew install --cask tex-live-utility --appdir $tex_dir  # (2)
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
