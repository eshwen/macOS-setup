# Mac utilities

## Time Machine

Time Machine is a great backup utility, but it's not perfect. One of the drawbacks is that - from the GUI - it's not easy to create complex exclusions from the backup.

Since I do a lot of Python development, I don't want to back up virtual environments, etc. To exclude these, you can use `find` to search for the directories and pipe them to `tmutil`, e.g.,

```shell
find `pwd` -maxdepth 3 -type d -name '.venv' | xargs -n 1 tmutil addexclusion
```

to exclude the `.venv` directory.

There's also a [tmignore] tool to automatically exclude files from your `.gitignore`, but that doesn't appear to be maintained anymore.

## System sounds

I don't like some of the system sound effects in Big Sur. I've uploaded [Basso](./Basso_Catalina.aiff) and [Glass](./Glass_Catalina.aiff) from Catalina. To use them as system sounds, do

```bash
mkdir ~/Library/Sounds
cp Basso_Catalina.aiff Glass_Catalina.aiff ~/Library/Sounds/
```

Then, in System Preferences :material-arrow-right: Sound, they should be available.

## Configuration options

- Enable 3-finger drag on the trackpad
  - Go to **System Preferences** :material-arrow-right: **Accessibility** :material-arrow-right: **Pointer Control**
  - Under **Mouse & Trackpad** :material-arrow-right: **Trackpad Options...** select **three finger drag** from the dropdown menu and tick the checkbox
- Order everything in every directory within Finder alphabetically
  - In the menu bar in Finder, go to **View** :material-arrow-right: **Show View Options**
  - Ensure **Group By** and **Sort By** have the value **Name** and click **Use As Defaults**

## Useful shortcuts

- Forward delete: <kbd>fn</kbd> + <kbd>&#9003;</kbd>
- Show inspector (so **Get Info** shows for active file): <kbd>&#8984;</kbd> + <kbd>&#8997;</kbd> + <kbd>i</kbd>
- Toggle to show/hide hidden files and directories (i.e., prefixed with `.`): <kbd>&#8984;</kbd> + <kbd>&#8679;</kbd> + <kbd>.</kbd>

[tmignore]: https://github.com/samuelmeuli/tmignore
