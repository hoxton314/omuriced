#!/bin/bash

# Setup symlinks for Omarchy configs
# This script removes existing configs and creates symlinks to the repo
# Run backup.sh first if you want to preserve existing configs!

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/config"
LOCAL_DIR="$SCRIPT_DIR/local"

# ~/.config directories to symlink
CONFIG_DIRS=(
    "hypr"
    "waybar"
    "walker"
    "omarchy"
    "alacritty"
    "kitty"
    "ghostty"
)

# ~/.config files to symlink
CONFIG_FILES=(
    "starship.toml"
    "mimeapps.list"
)

# ~/.local/bin scripts to symlink
LOCAL_BIN=(
    "gmail-mailto"
)

# ~/.local/share/applications entries to symlink
LOCAL_APPS=(
    "gmail-edge.desktop"
)

echo "Repo directory: $SCRIPT_DIR"
echo ""

# Ensure target directories exist
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"

# Helper function to setup a symlink
setup_symlink() {
    local source_path="$1"
    local target_path="$2"
    local display_name="$3"

    if [ ! -e "$source_path" ]; then
        echo "Skipping (not in repo): $display_name"
        return
    fi

    if [ -L "$target_path" ]; then
        echo "Removing existing symlink: $display_name"
        rm "$target_path"
    elif [ -e "$target_path" ]; then
        echo "Removing existing: $display_name"
        rm -rf "$target_path"
    fi

    echo "Linking: $display_name"
    ln -s "$source_path" "$target_path"
}

echo "=== Setting up ~/.config ==="
for config in "${CONFIG_DIRS[@]}"; do
    setup_symlink "$CONFIG_DIR/$config" "$HOME/.config/$config" ".config/$config"
done

for config in "${CONFIG_FILES[@]}"; do
    setup_symlink "$CONFIG_DIR/$config" "$HOME/.config/$config" ".config/$config"
done

echo ""
echo "=== Setting up ~/.local/bin ==="
for script in "${LOCAL_BIN[@]}"; do
    setup_symlink "$LOCAL_DIR/bin/$script" "$HOME/.local/bin/$script" ".local/bin/$script"
done

echo ""
echo "=== Setting up ~/.local/share/applications ==="
for app in "${LOCAL_APPS[@]}"; do
    setup_symlink "$LOCAL_DIR/share/applications/$app" "$HOME/.local/share/applications/$app" ".local/share/applications/$app"
done

# Update desktop database
echo ""
echo "Updating desktop database..."
update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true

echo ""
echo "Setup complete!"
echo "Your configs are now symlinked to this repo."
echo "Run 'git pull' in this repo to update configs across devices."
