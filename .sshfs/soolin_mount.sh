# Mount my /storage directory
#sshfs soolin:/storage/eb16003/ ~/sshfs/soolin/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=storage.eb16003

# Mount my /users directory
#sshfs soolin:/users/eb16003/ /Users/eshwen/sshfs/soolin/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=users.eb16003

# Mount my /software directory
sshfs soolin:/software/eb16003/ ~/sshfs/soolin/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=software.eb16003