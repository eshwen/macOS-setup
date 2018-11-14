# Mount my /users directory

#sshfs lxplus: ~/sshfs/lxplus/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=lxplus.ebhal

# Mount my /work directory

sshfs lxplus:/afs/cern.ch/work/e/ebhal  ~/sshfs/lxplus/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=lxplusWork.ebhal