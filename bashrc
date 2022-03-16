#############################
# Personal bash configuration
#############################

# Terminal colour configuration
alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=cxfxcxdxdxcgedafagacax

# Add Homebrew to PATH if 'brew' command doesn't work
export PATH="/opt/homebrew/bin:$PATH"

# Do not open GUI version of emacs
alias emacs="emacs -nw"

# Shell completion for git
source "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"

# Fix PATH and PYTHONPATH for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

################################
# WEB SCRAPING-SPECIFIC COMMANDS
################################

# Add repo to PYTHONPATH so local imports work
WEB_SCRAPING_ROOT_DIR="/Users/eshwen/GitHub/ONS/prices-web-scraping"
export PYTHONPATH="$PYTHONPATH:$WEB_SCRAPING_ROOT_DIR"

# Shell completion for Google Cloud SDK
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

# Directory shortcuts
PRICES_WEB_SCRAPING="$WEB_SCRAPING_ROOT_DIR/pm1"
PRICES_WEB_SCRAPING_TERRAFORM="/Users/eshwen/GitHub/ONS/prices-web-scraping-terraform/terraform"

# Single command to build Sphinx documentation locally
build_sphinx_docs(){
    cd $WEB_SCRAPING_ROOT_DIR
    sphinx-apidoc --force --separate --module-first --private --output-dir docs/_source . */core_spiders* */testing/*test*
    pushd docs
    make html
    popd
}
