#!/usr/bin/env bash

# Dotfiles Install Script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "Installing Dotfiles from $DOTFILES_DIR..."

# Create base config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# 1. Symlink ZSH
echo "Symlinking .zshrc..."
ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"

# 2. Symlink .config folders
FOLDERS=("hypr" "waybar" "wofi" "nvim" "foot")

for folder in "${FOLDERS[@]}"; do
    if [ -d "$DOTFILES_DIR/config/$folder" ]; then
        echo "Symlinking $folder..."
        
        # If the target exists and is a directory (not a symlink), back it up
        if [ -d "$CONFIG_DIR/$folder" ] && [ ! -L "$CONFIG_DIR/$folder" ]; then
            echo "  Backing up existing $CONFIG_DIR/$folder to $CONFIG_DIR/${folder}.bak"
            mv "$CONFIG_DIR/$folder" "$CONFIG_DIR/${folder}.bak"
        fi
        
        ln -sfn "$DOTFILES_DIR/config/$folder" "$CONFIG_DIR/$folder"
    fi
done

# 3. Symlink theme engine
echo "Symlinking Theme Engine..."
ln -sf "$DOTFILES_DIR/config/theme.json" "$CONFIG_DIR/theme.json"
ln -sf "$DOTFILES_DIR/config/apply_theme.py" "$CONFIG_DIR/apply_theme.py"

echo ""
echo "Installation complete!"
echo "Applying theme..."
if [ -f "$CONFIG_DIR/apply_theme.py" ]; then
    chmod +x "$CONFIG_DIR/apply_theme.py"
    "$CONFIG_DIR/apply_theme.py"
fi

echo "Done!"
