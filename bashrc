# Terminal colour configuration
alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=cxfxcxdxdxcgedafagacax

# Add Homebrew to PATH if 'brew' command doesn't work
export PATH="/opt/homebrew/bin:$PATH"

# Do not open GUI version of emacs
alias emacs="emacs -nw"

# Fix PATH and PYTHONPATH for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYTHONPATH="$PYTHONPATH:/Users/eshwen/GitHub/ONS/prices-web-scraping/pm1"
eval "$(pyenv init --path)"

# Shell completion for Google Cloud SDK
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

# Shell completion for git
source $HOME/.git-completion.bash

# Web scraping directory shortcuts
PRICES_WEB_SCRAPING="/Users/eshwen/GitHub/ONS/prices-web-scraping/pm1/pm1"
PRICES_WEB_SCRAPING_TERRAFORM="/Users/eshwen/GitHub/ONS/prices-web-scraping-terraform/terraform"
