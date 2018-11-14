# Mount my /storage directory
#sshfs soolin_proxy:/storage/eb16003/ ~/sshfs/soolin_proxy/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=storage.eb16003

# Mount my /users directory
#sshfs soolin_proxy:/users/eb16003/ ~/sshfs/soolin_proxy/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=users.eb16003

# Mount my /software directory
sshfs soolin_proxy:/software/eb16003/ ~/sshfs/soolin_proxy/ -o reconnect,allow_recursion,local,allow_other,follow_symlinks,volname=software.eb16003
