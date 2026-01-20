#!/usr/bin/env bash
set -e

# Determine dotfiles location
if [ -n "$DOTFILES" ]; then
    DOTFILES_DIR="$DOTFILES"
elif [ -d "$HOME/.dotfiles" ]; then
    DOTFILES_DIR="$HOME/.dotfiles"
else
    # Assume script is in dotfiles directory
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory not found at $DOTFILES_DIR" >&2
    exit 1
fi

echo "Installing dotfiles from $DOTFILES_DIR..."

# Detect current shell
CURRENT_SHELL="${SHELL##*/}"
if [ -z "$CURRENT_SHELL" ]; then
    # Fallback: check if zsh is available, otherwise default to bash
    if command -v zsh >/dev/null 2>&1; then
        CURRENT_SHELL="zsh"
    else
        CURRENT_SHELL="bash"
    fi
fi

echo "Detected shell: $CURRENT_SHELL"

# Create necessary directories
mkdir -p "$HOME/.docker"

# Install shell-specific configuration
if [ "$CURRENT_SHELL" = "zsh" ]; then
    if [ -d "$DOTFILES_DIR/zsh" ]; then
        ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
        ln -sf "$DOTFILES_DIR/zsh/zlogout" "$HOME/.zlogout"
        echo "Installed zsh configuration"
    else
        echo "Warning: zsh directory not found, skipping zsh configuration" >&2
    fi
else
    if [ -d "$DOTFILES_DIR/bash" ]; then
        ln -sf "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"
        ln -sf "$DOTFILES_DIR/bash/bash_logout" "$HOME/.bash_logout"
        echo "Installed bash configuration"
    else
        echo "Warning: bash directory not found, skipping bash configuration" >&2
    fi
fi

# Install common dotfiles (shell-agnostic)
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/terraform/terraformrc" "$HOME/.terraformrc"
ln -sf "$DOTFILES_DIR/editor/editorconfig" "$HOME/.editorconfig"
ln -sf "$DOTFILES_DIR/docker/config.json" "$HOME/.docker/config.json"

# Configure git
git config --global core.excludesfile "$HOME/.gitignore_global" || true

# Set git user name and email from environment variables if provided
if [ -n "${GIT_USER_NAME:-}" ]; then
    git config --global user.name "$GIT_USER_NAME"
    echo "Set git user.name from GIT_USER_NAME environment variable"
fi

if [ -n "${GIT_USER_EMAIL:-}" ]; then
    git config --global user.email "$GIT_USER_EMAIL"
    echo "Set git user.email from GIT_USER_EMAIL environment variable"
fi

# Source shell-specific files if they exist (for immediate use)
if [ "$CURRENT_SHELL" = "zsh" ] && [ -f "$DOTFILES_DIR/zsh/functions.sh" ]; then
    source "$DOTFILES_DIR/zsh/functions.sh" || true
elif [ "$CURRENT_SHELL" = "bash" ] && [ -f "$DOTFILES_DIR/bash/functions.sh" ]; then
    source "$DOTFILES_DIR/bash/functions.sh" || true
fi

echo "Dotfiles installed successfully."
echo ""
echo "Note: You may need to configure your git user.name and user.email in ~/.gitconfig"
if [ -z "${GIT_USER_NAME:-}" ] || [ -z "${GIT_USER_EMAIL:-}" ]; then
    echo "Note: Git user.name and user.email can be set via environment variables:"
    echo "  export GIT_USER_NAME='Your Name'"
    echo "  export GIT_USER_EMAIL='your.email@example.com'"
    echo "  ./install.sh"
    echo ""
    echo "Or configure manually:"
    echo "  git config --global user.name 'Your Name'"
    echo "  git config --global user.email 'your.email@example.com'"
fi
if [ "$CURRENT_SHELL" = "zsh" ]; then
    echo "Note: You may need to reload your shell or run: source ~/.zshrc"
else
    echo "Note: You may need to reload your shell or run: source ~/.bashrc"
fi