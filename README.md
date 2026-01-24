# omuriced

Personal dotfiles for [Omarchy](https://omarchy.dev) - a Hyprland-based Linux desktop environment.

## Installation

```bash
# Clone with submodules
git clone --recurse-submodules git@github.com:hoxton314/omuriced.git

# Backup existing configs (optional, recommended on new systems)
./backup.sh

# Create symlinks and configure submodules
./setup.sh
```

## Updating

```bash
git pull
```

If you didn't run `setup.sh` (which enables automatic submodule updates), use:

```bash
git pull --recurse-submodules
```

## Structure

```
config/
├── hypr/           # Hyprland window manager
├── waybar/         # Status bar
├── walker/         # Application launcher
├── omarchy/        # Theme system
├── alacritty/      # Terminal
├── kitty/          # Terminal
├── ghostty/        # Terminal
├── starship.toml   # Shell prompt
└── mimeapps.list   # Default applications

local/
├── bin/            # Custom scripts
└── share/applications/  # Desktop entries
```

## Submodules

This repo uses git submodules for external dependencies:

- `config/waybar/modules/waybar-mpris-enhanced` - Enhanced MPRIS module for Waybar

## Hyprland Customization

The main `hyprland.conf` sources files in order:
1. Omarchy defaults (system-managed)
2. Theme config from `~/.config/omarchy/current/theme/`
3. Personal overrides from `~/.config/hypr/*.conf` (this repo)

Edit the personal override files to customize behavior while preserving Omarchy defaults.
