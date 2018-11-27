# Mount my user's directory

sshfs imperial01:/home/hep/ebhal/ /Users/eb16003/sshfs/imperial/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=imperial.ebhal