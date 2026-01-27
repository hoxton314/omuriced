#!/bin/bash

# Backup existing configs before syncing
# Run this BEFORE sync.sh on a new system

set -e

BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

# ~/.config items to backup
CONFIGS=(
    "hypr"
    "waybar"
    "walker"
    "starship.toml"
    "mimeapps.list"
)

# ~/.config/omarchy subdirs to backup
OMARCHY_SUBDIRS=(
    "themes/omuriced"
    "branding"
    "extensions"
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
mkdir -p "$BACKUP_DIR/config/omarchy/themes"
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
echo "=== Backing up ~/.config/omarchy (subdirs only) ==="
for subdir in "${OMARCHY_SUBDIRS[@]}"; do
    source_path="$HOME/.config/omarchy/$subdir"
    if [ -e "$source_path" ]; then
        echo "Backing up: .config/omarchy/$subdir"
        mkdir -p "$BACKUP_DIR/config/omarchy/$(dirname "$subdir")"
        cp -r "$source_path" "$BACKUP_DIR/config/omarchy/$subdir"
    else
        echo "Skipping (not found): .config/omarchy/$subdir"
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
echo "You can now run sync.sh to apply configs"
