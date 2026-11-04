#!/bin/bash
# Set up a new Mac. Safe to re-run: each step skips anything that's already done.
#
#   curl -fsSL https://raw.githubusercontent.com/eshwen/macOS-setup/main/bootstrap.sh | bash
#
# or run ./bootstrap.sh from a clone of the repo. Set MACOS_SETUP_DIR to change where the repo is cloned.
set -euo pipefail
shopt -s nullglob nocaseglob

REPO_URL="https://github.com/eshwen/macOS-setup.git"
REPO_DIR="${MACOS_SETUP_DIR:-$HOME/GitHub/macOS-setup}"
DOCS_URL="https://eshwen.github.io/macOS-setup/"

warnings=""

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

warn() {
    printf '\033[1;33mWarning: %s\033[0m\n' "$*" >&2
    warnings="$warnings  - $*"$'\n'
}

keep_sudo_alive() {
    log "Requesting administrator access"
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
    log "Installing Rosetta 2"
    softwareupdate --install-rosetta --agree-to-license
}

install_homebrew() {
    local brew_bin=/opt/homebrew/bin/brew
    [[ "$(uname -m)" == arm64 ]] || brew_bin=/usr/local/bin/brew

    if [[ ! -x "$brew_bin" ]]; then
        log "Installing Homebrew and the Xcode Command Line Tools"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$("$brew_bin" shellenv)"

    if ! grep -qs "brew shellenv" "$HOME/.zprofile"; then
        log "Adding Homebrew to PATH in ~/.zprofile"
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
        log "Updating $REPO_DIR"
        git -C "$REPO_DIR" pull --ff-only || warn "Couldn't update $REPO_DIR, so using it as it is"
    else
        log "Cloning macOS-setup into $REPO_DIR"
        mkdir -p "$(dirname "$REPO_DIR")"
        git clone "$REPO_URL" "$REPO_DIR"
    fi
}

install_packages() {
    log "Installing Homebrew packages"
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
    log "Copying fonts and sounds"
    copy_missing "$HOME/Library/Fonts" "$REPO_DIR"/fonts/*/*.[ot]tf
    copy_missing "$HOME/Library/Sounds" "$REPO_DIR"/*.aiff
}

configure_trackpad() {
    local domain
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

configure_macos() {
    log "Configuring macOS settings"
    configure_trackpad
    configure_finder
    configure_terminal
}

clone_if_missing() {
    [[ -d "$2" ]] || git clone --depth 1 "$1" "$2"
}

install_oh_my_zsh() {
    local omz="$HOME/.oh-my-zsh"
    local custom="$omz/custom"
    if [[ ! -d "$omz" ]]; then
        log "Installing Oh My Zsh"
        RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    log "Installing Oh My Zsh theme and plugins"
    clone_if_missing https://github.com/spaceship-prompt/spaceship-prompt.git "$custom/themes/spaceship-prompt"
    ln -sf "$custom/themes/spaceship-prompt/spaceship.zsh-theme" "$custom/themes/spaceship.zsh-theme"
    clone_if_missing https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git "$custom/plugins/autoswitch_virtualenv"
}

print_summary() {
    log "Done"
    if [[ -n "$warnings" ]]; then
        printf '\nSome steps need attention:\n%s' "$warnings"
    fi
    cat <<EOF

Still to do by hand:
  - In ~/.zshrc, set ZSH_THEME="spaceship", add autoswitch_virtualenv to plugins, and source
    \$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  - Log out and back in so the trackpad settings take effect
  - Sign in to apps, and follow $DOCS_URL for anything not installed by Homebrew
EOF
}

main() {
    keep_sudo_alive
    install_rosetta
    install_homebrew
    find_repo
    install_packages
    install_fonts_and_sounds
    configure_macos
    install_oh_my_zsh
    print_summary
}

main "$@"
