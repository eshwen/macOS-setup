---
icon: lucide/sigma
---

# LaTeX

## TeX Live

TeX Live is installed with the `mactex-no-gui` cask in the [Brewfile](./homebrew.md). It's the full MacTeX distribution without the GUI applications like TeXShop and LaTeXiT, which I don't need since VS Code is way better. The two GUI applications I do use, BibDesk (for managing BibTeX references) and TeX Live Utility (for updating TeX Live packages), are separate casks in the Brewfile, so Homebrew keeps them up to date. They're installed into `/Applications/TeX`.

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

My favourite font is **Garamond Expert with New TX Math** (the LaTeX package `garamondx` - see [here](https://mirror.ox.ac.uk/sites/ctan.org/fonts/garamondx/doc/garamondx-doc.pdf)). As well as being visually appealing, it supports bold, italic, and small cap styles that other Garamond variants do not. If compiling a LaTeX document on Overleaf, this should already be installed. However, it is not bundled with TeX Live due to licensing. `bootstrap.sh` installs it, along with the other non-free fonts. To do it by hand, follow the instructions at <http://tug.org/fonts/getnonfreefonts/>:

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
