#!/bin/bash

# Sync Omarchy configs by copying files
# Then activate the omuriced theme and restart services

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/config"
LOCAL_DIR="$SCRIPT_DIR/local"
ETC_DIR="$SCRIPT_DIR/etc"

# ~/.config directories to copy
CONFIG_DIRS=(
    "hypr"
    "waybar"
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

# /etc files to copy (requires sudo)
ETC_FILES=(
    "locale.conf"
)

# /etc/udev/rules.d files to copy (requires sudo)
UDEV_RULES=(
    "99-wlmouse-dpi.rules"
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

echo ""
echo "=== Syncing /etc files (requires sudo) ==="
for etc_file in "${ETC_FILES[@]}"; do
    source_path="$ETC_DIR/$etc_file"
    target_path="/etc/$etc_file"
    if [ ! -e "$source_path" ]; then
        echo "Skipping (not in repo): $etc_file"
        continue
    fi
    if [ -e "$target_path" ]; then
        echo "Replacing: /etc/$etc_file"
    else
        echo "Copying: /etc/$etc_file"
    fi
    sudo cp "$source_path" "$target_path"
done

echo ""
echo "=== Syncing /etc/udev/rules.d (requires sudo) ==="
for rule in "${UDEV_RULES[@]}"; do
    source_path="$ETC_DIR/udev/rules.d/$rule"
    target_path="/etc/udev/rules.d/$rule"
    if [ ! -e "$source_path" ]; then
        echo "Skipping (not in repo): $rule"
        continue
    fi
    if [ -e "$target_path" ]; then
        echo "Replacing: /etc/udev/rules.d/$rule"
    else
        echo "Copying: /etc/udev/rules.d/$rule"
    fi
    sudo cp "$source_path" "$target_path"
done
# Reload udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

# Update desktop database
echo ""
echo "Updating desktop database..."
update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || echo "Warning: update-desktop-database not available"

# Set the theme
echo ""
echo "=== Setting theme to omuriced ==="
if command -v omarchy-theme-set &> /dev/null; then
    omarchy-theme-set omuriced
else
    echo "Warning: omarchy-theme-set not found. Set theme manually."
fi

# Restart waybar to apply changes
echo ""
echo "=== Restarting waybar ==="
if command -v omarchy-restart-waybar &> /dev/null; then
    omarchy-restart-waybar
else
    pkill waybar 2>/dev/null || true
    waybar &>/dev/null &
fi

echo ""
echo "Sync complete!"
