#!/bin/bash

# Sync Omarchy configs by copying files (instead of symlinks)
# Then activate the omuriced theme

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/config"
LOCAL_DIR="$SCRIPT_DIR/local"

# ~/.config directories to copy
CONFIG_DIRS=(
    "hypr"
    "walker"
)

# ~/.config files to copy
CONFIG_FILES=(
    "starship.toml"
    "mimeapps.list"
)

# ~/.config/omarchy subdirectories to copy
OMARCHY_SUBDIRS=(
    "themes/omuriced"
    "branding"
    "extensions"
)

# ~/.local/bin scripts to copy
LOCAL_BIN=(
    "gmail-mailto"
)

# ~/.local/share/applications entries to copy
LOCAL_APPS=(
    "gmail-edge.desktop"
)

echo "Repo directory: $SCRIPT_DIR"
echo ""

# Ensure target directories exist
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/omarchy/themes"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"

# Helper function to copy files/directories
sync_copy() {
    local source_path="$1"
    local target_path="$2"
    local display_name="$3"

    if [ ! -e "$source_path" ]; then
        echo "Skipping (not in repo): $display_name"
        return
    fi

    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        echo "Replacing: $display_name"
        rm -rf "$target_path"
    else
        echo "Copying: $display_name"
    fi

    cp -r "$source_path" "$target_path"
}

echo "=== Syncing ~/.config ==="
for config in "${CONFIG_DIRS[@]}"; do
    sync_copy "$CONFIG_DIR/$config" "$HOME/.config/$config" ".config/$config"
done

for config in "${CONFIG_FILES[@]}"; do
    sync_copy "$CONFIG_DIR/$config" "$HOME/.config/$config" ".config/$config"
done

echo ""
echo "=== Syncing ~/.config/omarchy ==="
for subdir in "${OMARCHY_SUBDIRS[@]}"; do
    sync_copy "$CONFIG_DIR/omarchy/$subdir" "$HOME/.config/omarchy/$subdir" ".config/omarchy/$subdir"
done

echo ""
echo "=== Syncing ~/.local/bin ==="
for script in "${LOCAL_BIN[@]}"; do
    sync_copy "$LOCAL_DIR/bin/$script" "$HOME/.local/bin/$script" ".local/bin/$script"
    chmod +x "$HOME/.local/bin/$script" 2>/dev/null || true
done

echo ""
echo "=== Syncing ~/.local/share/applications ==="
for app in "${LOCAL_APPS[@]}"; do
    sync_copy "$LOCAL_DIR/share/applications/$app" "$HOME/.local/share/applications/$app" ".local/share/applications/$app"
done

# Update desktop database
echo ""
echo "Updating desktop database..."
update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || echo "Warning: update-desktop-database not available"

# Set the theme
echo ""
echo "=== Setting theme to omuriced ==="
if command -v omarchy-theme-set &> /dev/null; then
    omarchy-theme-set omuriced
    echo "Theme set to omuriced"
else
    echo "Warning: omarchy-theme-set not found. Set theme manually with: omarchy-theme-set omuriced"
fi

echo ""
echo "Sync complete!"
