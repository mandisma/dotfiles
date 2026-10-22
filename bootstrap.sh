#!/usr/bin/env bash

# Exit immediately on error, treat unset variables as an error, catch pipeline failures
set -euo pipefail

# Color definitions
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

DOTFILES_DIRECTORY=$(cd "$(dirname "$0")" && pwd)

info() {
    printf "${BLUE}========== %s ==========${NC}\n" "$1"
}

success() {
    printf "${GREEN}%s${NC}\n" "$1"
}

error() {
    printf "${RED}Error: %s${NC}\n" "$1"
}

# 1. OS & Package Manager Check (Fedora only)
os_id=$(awk -F= '$1=="ID" { print $2 }' /etc/os-release | tr -d '"')
if [[ "$os_id" != "fedora" ]]; then
    error "Unsupported OS ('$os_id'). Fedora is required."
    exit 1
fi

if ! command -v dnf &> /dev/null; then
    error "Package manager 'dnf' not found."
    exit 1
fi

printf "\n${YELLOW}-------------- Bootstrap Terminal --------------${NC}\n"
printf "${GREEN}OS Detected:${NC} %s\n" "$os_id"
printf "${GREEN}Package Manager:${NC} dnf\n"
printf "${YELLOW}------------------------------------------------${NC}\n"

read -r -p "This will configure your system and stow dotfiles. Continue? [y/N]: " reply
if [[ ! "$reply" =~ ^[Yy]$ ]]; then
    printf "${RED}Aborting.${NC}\n"
    exit 0
fi

sudo -v

# 2. Package Repositories & Base Tools
info "Installing dependencies"
sudo dnf install -y \
    curl wget zip git stow \
    zsh fzf vim python3 tldr \
    bat git-delta zoxide ripgrep fd-find

# 3. Default Shell Setup
zsh_bin=$(command -v zsh)
if [[ "${SHELL:-}" != "$zsh_bin" ]]; then
    info "Changing default shell to Zsh"
    sudo chsh -s "$zsh_bin" "$USER"
fi

# 4. Antidote (Zsh Plugin Manager)
info "Installing Antidote"
ANTIDOTE_DIR="$HOME/.antidote"
if [[ ! -d "$ANTIDOTE_DIR" ]]; then
    if ! git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"; then
        error "Failed to clone Antidote. Check your network connection."
        exit 1
    fi
    chmod 700 "$ANTIDOTE_DIR"
else
    echo " - Antidote is already installed."
fi

# 5. Starship Prompt
info "Installing Starship"
if ! command -v starship &> /dev/null; then
    sudo dnf copr enable -y atim/starship
    sudo dnf install -y starship
else
    echo " - Starship is already installed."
fi

# 6. Git Configuration
info "Configuring Git local identity"
if [[ ! -f "$HOME/.gitconfig.local" ]]; then
    read -r -p " - Git Author Name: " git_authorname
    read -r -p " - Git Author Email: " git_authoremail
    git config -f "$HOME/.gitconfig.local" user.name "$git_authorname"
    git config -f "$HOME/.gitconfig.local" user.email "$git_authoremail"
    if [[ -f "$HOME/.ssh/id_ed25519.pub" ]]; then
        git config -f "$HOME/.gitconfig.local" user.signingkey "$HOME/.ssh/id_ed25519.pub"
        success " - Configured SSH signing key ($HOME/.ssh/id_ed25519.pub)"
    fi
    success " - Created ~/.gitconfig.local"
else
    echo " - ~/.gitconfig.local already exists."
    if [[ -f "$HOME/.ssh/id_ed25519.pub" ]] && ! git config -f "$HOME/.gitconfig.local" user.signingkey &> /dev/null; then
        git config -f "$HOME/.gitconfig.local" user.signingkey "$HOME/.ssh/id_ed25519.pub"
        success " - Added SSH signing key to ~/.gitconfig.local"
    fi
fi


# 7. Vale Prose Linter
info "Installing Vale"
if ! command -v vale &> /dev/null; then
    mkdir -p "$HOME/.local/bin"
    VALE_VERSION=$(curl -sIL "https://github.com/vale-cli/vale/releases/latest" | grep -i '^location:' | tail -n 1 | awk -F'/tag/v' '{print $2}' | tr -d '\r\n')
    if [[ -n "$VALE_VERSION" ]]; then
        curl -sL "https://github.com/vale-cli/vale/releases/download/v${VALE_VERSION}/vale_${VALE_VERSION}_Linux_64-bit.tar.gz" | tar -xz -C "$HOME/.local/bin" vale
        chmod +x "$HOME/.local/bin/vale"
        success " - Vale v${VALE_VERSION} installed to ~/.local/bin/vale"
    else
        error "Failed to resolve latest Vale release. You can install it manually from https://github.com/vale-cli/vale/releases"
    fi
else
    echo " - Vale is already installed."
fi

# 8. Stow Dotfiles
info "Stowing dotfiles"
cd "$DOTFILES_DIRECTORY"
mkdir -p "$HOME/.config"

# Clean up legacy files to avoid stow conflicts
rm -f "$HOME/.global-gitconfig" "$HOME/.gitconfig" "$HOME/.global-gitignore"

stow -R git starship vim zsh vale

# 9. Sync Vale Styles
if command -v vale &> /dev/null; then
    info "Syncing Vale styles"
    vale sync || true
fi

printf "\n"
success "++++++++++++++++++++++++++"
success "+ Installation Complete. +"
success "++++++++++++++++++++++++++"
