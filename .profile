alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=cxfxcxdxdxcgcdafagacax

# Source ROOT
#source ~/PhD_Software/Root/root_5_34_36/bin/thisroot.sh

# For tunnelling to P5
alias p5tun='ssh -tN -v -4  -D 55555 ebhal@cmsusr.cern.ch -o "ProxyCommand=ssh ebhal@lxplus.cern.ch -W %h:%p"'

# Update outdated pip modules
alias pipupdate="pip list --outdated | cut -d' ' -f1 | xargs pip install --upgrade --user"
