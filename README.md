# omuriced

Personal dotfiles for [Omarchy](https://omarchy.org/) - a Hyprland-based Linux desktop environment.

This repo contains:
- Custom **omuriced** theme (colors, styling)
- Custom **waybar** config (layout, modules, MPRIS, memory)
- Personal **Hyprland** overrides (monitors, bindings, etc.)

## Usage

```bash
# Clone with submodules
git clone --recurse-submodules git@github.com:hoxton314/omuriced.git

# Backup existing configs (optional, recommended on new systems)
./backup.sh

# Sync configs and activate theme
./sync.sh
```

## Updating

```bash
git pull --recurse-submodules
./sync.sh
```

## Structure

```
config/
├── hypr/                    # Personal Hyprland overrides
│   ├── hyprland.conf        # Main config (sources defaults + overrides)
│   ├── monitors.conf        # Monitor configuration
│   ├── input.conf           # Input device settings
│   ├── bindings.conf        # Custom keybindings
│   ├── looknfeel.conf       # Visual overrides
│   ├── autostart.conf       # Startup applications
│   └── ...
├── waybar/                  # Custom waybar (replaces Omarchy default)
│   ├── config.jsonc         # Layout, modules, behavior
│   ├── style.css            # Styling (imports theme colors)
│   └── modules/             # Custom modules
│       ├── memory/          # Memory usage module
│       └── waybar-mpris-enhanced/  # MPRIS music controls
├── omarchy/
│   ├── themes/omuriced/     # Custom theme
│   │   ├── colors.toml      # Color palette
│   │   ├── waybar.css       # Waybar color variables
│   │   ├── backgrounds/     # Wallpapers
│   │   └── ...              # Other theme files
│   ├── branding/            # Custom branding
│   └── extensions/          # Menu extensions
├── walker/config.toml       # Application launcher
├── starship.toml            # Shell prompt
└── mimeapps.list            # Default applications

local/
├── bin/gmail-mailto         # Custom mailto handler
└── share/applications/      # Desktop entries
```

## How It Works

**Theme** (`config/omarchy/themes/omuriced/`):
- `colors.toml` defines the color palette
- Omarchy generates terminal configs from colors.toml
- `waybar.css` provides color variables for waybar styling

**Waybar** (`config/waybar/`):
- Full waybar config separate from theme
- `style.css` imports colors from the active theme via `@import '../omarchy/current/theme/waybar.css'`
- Custom modules: memory tooltip, enhanced MPRIS controls

**Hyprland** (`config/hypr/`):
- Personal overrides sourced after Omarchy defaults
- Machine-specific settings (monitors, bindings, etc.)

## Submodules

- `config/waybar/modules/waybar-mpris-enhanced` - Enhanced MPRIS module for Waybar
