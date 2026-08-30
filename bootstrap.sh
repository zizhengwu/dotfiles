#!/usr/bin/env bash

set -Eeuo pipefail

readonly DOTFILES_REPO="https://github.com/zizhengwu/dotfiles.git"
readonly CHEZMOI_REPO="https://github.com/zizhengwu/chezmoi_dotfiles.git"
readonly DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"

if [[ "$(uname -s)" != "Linux" ]] || ! command -v apt-get >/dev/null 2>&1; then
    echo "This bootstrap script currently supports apt-based Linux systems only." >&2
    exit 1
fi

# Validate sudo up front so unattended work does not fail halfway through.
if ! sudo -n true 2>/dev/null; then
    sudo -v
fi

# passwordless-sudo
sudoers_tmp="$(mktemp)"
trap 'rm -f "$sudoers_tmp"' EXIT
printf '%s ALL=(ALL:ALL) NOPASSWD:ALL\n' "$USER" >"$sudoers_tmp"
sudo visudo -cf "$sudoers_tmp"
sudo install -o root -g root -m 0440 \
    "$sudoers_tmp" "/etc/sudoers.d/90-${USER}-nopasswd"

sudo apt-get update
sudo env DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential \
    curl \
    fzf \
    git \
    htop \
    pbzip2 \
    python3 \
    sshpass \
    sshuttle \
    stow \
    tldr \
    wget \
    xfsprogs \
    zsh

# The managed shell configuration is for Zsh, so make it the login shell too.
zsh_path="$(command -v zsh)"
if [[ "$(getent passwd "$USER" | cut -d: -f7)" != "$zsh_path" ]]; then
    sudo chsh -s "$zsh_path" "$USER"
fi

# Load an existing Homebrew installation into this non-login shell.
load_brew() {
    command -v brew >/dev/null 2>&1 && return
    for brew_bin in \
        /home/linuxbrew/.linuxbrew/bin/brew \
        "$HOME/.linuxbrew/bin/brew"; do
        if [[ -x "$brew_bin" ]]; then
            eval "$("$brew_bin" shellenv)"
            return
        fi
    done
}

load_brew

# Install Homebrew once, then load the new installation.
if ! command -v brew >/dev/null 2>&1; then
    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    load_brew
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew was installed but could not be added to PATH." >&2
    exit 1
fi

brew install --yes \
    atuin \
    bat \
    chezmoi \
    delta \
    eza \
    fd \
    k9s \
    kind \
    kubectl \
    neovim \
    ripgrep \
    zoxide

# The script can be run either from this checkout or before it exists.
if [[ -e "$DOTFILES_DIR" ]]; then
    if ! git -C "$DOTFILES_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "$DOTFILES_DIR exists but is not a git checkout." >&2
        exit 1
    fi
else
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone --recurse-submodules "$DOTFILES_REPO" "$DOTFILES_DIR"
fi
git -C "$DOTFILES_DIR" submodule update --init --recursive

# iTerm2 shell integration.
if [[ ! -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
    curl -fsSL \
        https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh |
        SHELL="$zsh_path" bash
fi

chezmoi init "$CHEZMOI_REPO"
chezmoi apply

echo "Bootstrap completed successfully."
