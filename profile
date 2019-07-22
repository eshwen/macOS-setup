alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=cxfxcxdxdxcgedafagacax

# For tunnelling to P5
alias p5tun='ssh -tN -v -4  -D 55555 ebhal@cmsusr.cern.ch -o "ProxyCommand=ssh ebhal@lxplus.cern.ch -W %h:%p"'

# Updating pip modules
alias pipupdate="for package in $(pip list --outdated --format freeze | cut -d= -f1); do pip install --upgrade --user $package; done"
# Setting PATH for Python 2.7
# The original version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
alias soolin_proxy_key="ssh-add -K ~/.ssh/soolin_proxy_rsa"
