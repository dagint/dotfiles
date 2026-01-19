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

# Create necessary directories
mkdir -p "$HOME/.docker"

# Create symlinks
ln -sf "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/terraform/terraformrc" "$HOME/.terraformrc"
ln -sf "$DOTFILES_DIR/editor/editorconfig" "$HOME/.editorconfig"
ln -sf "$DOTFILES_DIR/docker/config.json" "$HOME/.docker/config.json"

# Configure git
git config --global core.excludesfile "$HOME/.gitignore_global" || true

echo "Dotfiles installed successfully."
echo ""
echo "Note: You may need to configure your git user.name and user.email in ~/.gitconfig"
