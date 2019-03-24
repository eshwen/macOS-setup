alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=cxfxcxdxdxcgedafagacax

# For tunnelling to P5

alias p5tun='ssh -tN -v -4  -D 55555 ebhal@cmsusr.cern.ch -o "ProxyCommand=ssh ebhal@lxplus.cern.ch -W %h:%p"'

# Updating pip modules

alias pipupdate="pip list --outdated --format columns | cut -d' ' -f1 | xargs pip install --upgrade --user"
# Setting PATH for Python 2.7
# The original version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
soolin_proxy_key=$(ssh-add -K -t 1500000 ~/.ssh/soolin_proxy_rsa)