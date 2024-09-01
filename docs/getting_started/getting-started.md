# Installation

1. Make a directory within the home folder called `GitHub` to store repos:

    ```sh
    mkdir $HOME/GitHub
    ```

2. Download GitHub Desktop from <https://desktop.github.com/>, then open it and sign in

3. On this page, hit the **Code** button, followed by **Open with GitHub Desktop**. If prompted for a directory, store the repo in `/Users/eshwen/GitHub/macOS-setup`

4. Copy over the profile/configuration settings:

    ```sh
    repo_dir="$HOME/GitHub/macOS-setup"
    cd $repo_dir
    cat inputrc >> $HOME/.inputrc
    ```

5. Strip out any unnecessary stuff from these new files
