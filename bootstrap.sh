#!/bin/bash
# Set up a new Mac. Asks before each step, and skips any step that's already done, so it's safe to re-run.
#
#   curl -fsSL https://raw.githubusercontent.com/eshwen/macOS-setup/main/bootstrap.sh | bash
#
# or run ./bootstrap.sh from a clone of the repo. Set MACOS_SETUP_DIR to change where the repo is cloned.
# Pass --yes to run every step without asking (with curl: `| bash -s -- --yes`).
set -euo pipefail
shopt -s nullglob nocaseglob

REPO_URL="https://github.com/eshwen/macOS-setup.git"
REPO_DIR="${MACOS_SETUP_DIR:-$HOME/GitHub/macOS-setup}"
DOCS_URL="https://eshwen.github.io/macOS-setup/"

warnings=""
skipped=""
sudo_pid=""
assume_yes=false

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

warn() {
    printf '\033[1;33mWarning: %s\033[0m\n' "$*" >&2
    warnings="$warnings  - $*"$'\n'
}

die() {
    printf '\033[1;31mError: %s\033[0m\n' "$*" >&2
    exit 1
}

# Reads the answer from the terminal, since stdin is the script itself when it's piped from curl
confirm() {
    local answer
    log "$1"
    printf '    %s\n' "$2"
    if $assume_yes; then
        return 0
    fi
    printf 'Continue? [Y/n] '
    read -r answer </dev/tty || die "Stopped"
    if [[ -z "$answer" || "$answer" == [Yy]* ]]; then
        return 0
    fi
    skipped="$skipped  - $1"$'\n'
    return 1
}

# Asks for the password the first time a step needs it, then keeps sudo's timestamp fresh for the rest of the run
ensure_sudo() {
    [[ -n "$sudo_pid" ]] && return 0
    printf 'This step needs administrator access.\n'
    sudo -v
    while true; do
        sudo -n true
        sleep 50
        kill -0 "$$" || exit
    done 2>/dev/null &
    sudo_pid=$!
    trap 'kill "$sudo_pid" 2>/dev/null' EXIT
}

install_rosetta() {
    [[ "$(uname -m)" == arm64 ]] || return 0
    /usr/bin/arch -x86_64 /usr/bin/true 2>/dev/null && return 0
    confirm "Install Rosetta 2" "Lets Apple Silicon Macs run Intel apps, which some apps in the Brewfile still are." ||
        return 0
    ensure_sudo
    softwareupdate --install-rosetta --agree-to-license
}

install_homebrew() {
    local brew_bin=/opt/homebrew/bin/brew
    [[ "$(uname -m)" == arm64 ]] || brew_bin=/usr/local/bin/brew

    if [[ ! -x "$brew_bin" ]]; then
        confirm "Install Homebrew" "Also installs the Xcode Command Line Tools, which include git. Every later step needs it." ||
            die "Homebrew is needed for every later step"
        ensure_sudo
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$("$brew_bin" shellenv)"

    if ! grep -qs "brew shellenv" "$HOME/.zprofile" &&
        confirm "Add Homebrew to your PATH" "Adds 'eval \"\$($brew_bin shellenv)\"' to ~/.zprofile, so new shells can find brew."; then
        # shellcheck disable=SC2016 # The $(...) is meant to be written literally
        printf '\neval "$(%s shellenv)"\n' "$brew_bin" >>"$HOME/.zprofile"
    fi
}

find_repo() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]:-}")" && pwd)"
    if [[ -f "$script_dir/Brewfile" && -f "$script_dir/bootstrap.sh" ]]; then
        REPO_DIR="$script_dir"
    elif [[ -d "$REPO_DIR/.git" ]]; then
        if confirm "Update $REPO_DIR" "Pulls the latest Brewfile and settings with git pull --ff-only."; then
            git -C "$REPO_DIR" pull --ff-only || warn "Couldn't update $REPO_DIR, so using it as it is"
        fi
    else
        confirm "Clone macOS-setup into $REPO_DIR" \
            "Later steps use its Brewfile, fonts, sounds and Terminal profile. Set MACOS_SETUP_DIR to clone it elsewhere." ||
            die "The repo is needed for the remaining steps"
        mkdir -p "$(dirname "$REPO_DIR")"
        git clone "$REPO_URL" "$REPO_DIR"
    fi
}

install_packages() {
    local count
    count="$(grep -cE '^(brew|cask) ' "$REPO_DIR/Brewfile")"
    confirm "Install Homebrew packages" \
        "Installs or upgrades the $count command line tools and apps in the Brewfile. MacTeX alone is about 5 GB." ||
        return 0
    ensure_sudo
    brew bundle install --file "$REPO_DIR/Brewfile" ||
        warn "Some Homebrew packages failed. Retry with: brew bundle install --file $REPO_DIR/Brewfile"
}

copy_missing() {
    local dest="$1" file
    shift
    mkdir -p "$dest"
    for file in "$@"; do
        [[ -e "$dest/$(basename "$file")" ]] || cp "$file" "$dest/"
    done
}

install_fonts_and_sounds() {
    confirm "Copy fonts and sounds" \
        "Copies the repo's fonts to ~/Library/Fonts and system sounds to ~/Library/Sounds. Existing files are left alone." ||
        return 0
    copy_missing "$HOME/Library/Fonts" "$REPO_DIR"/fonts/*/*.[ot]tf
    copy_missing "$HOME/Library/Sounds" "$REPO_DIR"/*.aiff
}

install_garamond() {
    local tmp texbin=/Library/TeX/texbin
    local root_path="$texbin:/usr/bin:/bin:/usr/sbin:/sbin"
    [[ -x "$texbin/tlmgr" ]] || return 0
    "$texbin/kpsewhich" garamondx.sty >/dev/null && return 0

    confirm "Install Garamond Expert for LaTeX" \
        "Downloads TUG's getnonfreefonts and runs it with sudo to add Garamond Expert and other non-free fonts to TeX Live." ||
        return 0
    ensure_sudo
    tmp="$(mktemp -d)"
    # texbin is only added to PATH in new shells. Keep root's PATH to system directories
    if ! {
        curl -fsSL -o "$tmp/install-getnonfreefonts" https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts &&
            sudo env PATH="$root_path" texlua "$tmp/install-getnonfreefonts" &&
            sudo env PATH="$root_path" getnonfreefonts --sys -a
    }; then
        warn "Couldn't install the non-free TeX fonts. See ${DOCS_URL}programs/latex/#garamond-expert"
    fi
    rm -rf "$tmp"
}

configure_trackpad() {
    local domain
    confirm "Turn on three-finger drag" \
        "Three-finger swipes move to four fingers. Takes effect after you log out and back in." || return 0
    # Matches what System Settings writes when three-finger drag is turned on: three-finger swipes move to four fingers
    for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
        defaults write "$domain" TrackpadThreeFingerDrag -int 1
        defaults write "$domain" TrackpadThreeFingerHorizSwipeGesture -int 0
        defaults write "$domain" TrackpadThreeFingerVertSwipeGesture -int 0
        defaults write "$domain" TrackpadFourFingerHorizSwipeGesture -int 2
        defaults write "$domain" TrackpadFourFingerVertSwipeGesture -int 2
    done
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -int 1
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 0
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerHorizSwipeGesture -int 2
    defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -int 2
}

configure_finder() {
    local plist view_key buddy=/usr/libexec/PlistBuddy
    confirm "Sort Finder folders by name" "Groups and sorts every folder by name, then restarts Finder." || return 0
    defaults write com.apple.finder FXPreferredGroupBy -string Name
    defaults write com.apple.finder FXArrangeGroupViewBy -string Name

    # The sort order is nested inside StandardViewSettings, which `defaults write` can't edit in place
    plist="$(mktemp)"
    defaults export com.apple.finder "$plist"
    $buddy -c "Add :StandardViewSettings dict" "$plist" 2>/dev/null || true
    for view_key in IconViewSettings:arrangeBy GalleryViewSettings:arrangeBy ListViewSettings:sortColumn \
        ExtendedListViewSettingsV2:sortColumn; do
        $buddy -c "Add :StandardViewSettings:${view_key%%:*} dict" "$plist" 2>/dev/null || true
        $buddy -c "Set :StandardViewSettings:$view_key name" "$plist" 2>/dev/null ||
            $buddy -c "Add :StandardViewSettings:$view_key string name" "$plist"
    done
    defaults import com.apple.finder "$plist"
    rm "$plist"
    killall Finder 2>/dev/null || true
}

configure_terminal() {
    local plist profile=Ocean_Esh buddy=/usr/libexec/PlistBuddy
    confirm "Set the Terminal profile" \
        "Imports Ocean_Esh.terminal as the $profile profile and makes it the default for new windows." || return 0
    # The file's own name is "Ocean", which clashes with a built-in profile, so import it under a unique name
    plist="$(mktemp)"
    defaults export com.apple.Terminal "$plist"
    $buddy -c "Delete ':Window Settings:$profile'" "$plist" 2>/dev/null || true
    $buddy -c "Add ':Window Settings:$profile' dict" "$plist" 2>/dev/null ||
        $buddy -c "Add ':Window Settings' dict" -c "Add ':Window Settings:$profile' dict" "$plist"
    $buddy -c "Merge '$REPO_DIR/Ocean_Esh.terminal' ':Window Settings:$profile'" "$plist"
    $buddy -c "Set ':Window Settings:$profile:name' $profile" "$plist"
    defaults import com.apple.Terminal "$plist"
    rm "$plist"
    defaults write com.apple.Terminal "Default Window Settings" -string "$profile"
    defaults write com.apple.Terminal "Startup Window Settings" -string "$profile"
}

clone_if_missing() {
    [[ -d "$2" ]] || git clone --depth 1 "$1" "$2"
}

install_oh_my_zsh() {
    local omz="$HOME/.oh-my-zsh"
    local theme="$omz/custom/themes/spaceship-prompt" plugin="$omz/custom/plugins/autoswitch_virtualenv"
    [[ -d "$omz" && -d "$theme" && -d "$plugin" ]] && return 0
    confirm "Install Oh My Zsh" \
        "Installs Oh My Zsh (keeping any ~/.zshrc), the Spaceship theme and the autoswitch-virtualenv plugin." ||
        return 0

    if [[ ! -d "$omz" ]]; then
        RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    clone_if_missing https://github.com/spaceship-prompt/spaceship-prompt.git "$theme"
    ln -sf "$theme/spaceship.zsh-theme" "$omz/custom/themes/spaceship.zsh-theme"
    clone_if_missing https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git "$plugin"
}

print_summary() {
    log "Done"
    if [[ -n "$warnings" ]]; then
        printf '\nSome steps need attention:\n%s' "$warnings"
    fi
    if [[ -n "$skipped" ]]; then
        printf '\nSkipped:\n%s' "$skipped"
    fi
    cat <<EOF

Still to do by hand:
  - In ~/.zshrc, set ZSH_THEME="spaceship", and add autoswitch_virtualenv and zsh-syntax-highlighting to plugins
  - Log out and back in so the trackpad settings take effect
  - Sign in to apps, and follow $DOCS_URL for anything not installed by Homebrew
EOF
}

main() {
    local arg
    for arg in "$@"; do
        case "$arg" in
        -y | --yes) assume_yes=true ;;
        *) die "Unknown option: $arg. The only option is --yes, to run every step without asking" ;;
        esac
    done

    if ! $assume_yes; then
        { : </dev/tty; } 2>/dev/null || die "Can't ask for confirmation without a terminal. Pass --yes to run every step"
        printf 'This sets up a new Mac. It explains each step and asks before running it, so you can skip any of them.\n'
    fi
    install_rosetta
    install_homebrew
    find_repo
    install_packages
    install_fonts_and_sounds
    install_garamond
    configure_trackpad
    configure_finder
    configure_terminal
    install_oh_my_zsh
    print_summary
}

main "$@"
