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
