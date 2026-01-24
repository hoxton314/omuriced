#!/bin/bash

# Backup existing configs before setting up symlinks
# Run this BEFORE setup.sh on a new system

set -e

BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

# ~/.config items to backup
CONFIGS=(
    "hypr"
    "waybar"
    "walker"
    "omarchy"
    "alacritty"
    "kitty"
    "ghostty"
    "starship.toml"
    "mimeapps.list"
)

# ~/.local/bin scripts to backup
LOCAL_BIN=(
    "gmail-mailto"
)

# ~/.local/share/applications entries to backup
LOCAL_APPS=(
    "gmail-edge.desktop"
)

echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR/config"
mkdir -p "$BACKUP_DIR/local/bin"
mkdir -p "$BACKUP_DIR/local/share/applications"

echo ""
echo "=== Backing up ~/.config ==="
for config in "${CONFIGS[@]}"; do
    source_path="$HOME/.config/$config"
    if [ -e "$source_path" ]; then
        echo "Backing up: .config/$config"
        cp -r "$source_path" "$BACKUP_DIR/config/"
    else
        echo "Skipping (not found): .config/$config"
    fi
done

echo ""
echo "=== Backing up ~/.local/bin ==="
for script in "${LOCAL_BIN[@]}"; do
    source_path="$HOME/.local/bin/$script"
    if [ -e "$source_path" ]; then
        echo "Backing up: .local/bin/$script"
        cp "$source_path" "$BACKUP_DIR/local/bin/"
    else
        echo "Skipping (not found): .local/bin/$script"
    fi
done

echo ""
echo "=== Backing up ~/.local/share/applications ==="
for app in "${LOCAL_APPS[@]}"; do
    source_path="$HOME/.local/share/applications/$app"
    if [ -e "$source_path" ]; then
        echo "Backing up: .local/share/applications/$app"
        cp "$source_path" "$BACKUP_DIR/local/share/applications/"
    else
        echo "Skipping (not found): .local/share/applications/$app"
    fi
done

echo ""
echo "Backup complete: $BACKUP_DIR"
echo "You can now run setup.sh to create symlinks"
