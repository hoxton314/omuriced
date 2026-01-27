# omuriced

Personal dotfiles for [Omarchy](https://omarchy.dev) - a Hyprland-based Linux desktop environment.

This repo contains a custom **omuriced** theme and personal Hyprland overrides.

## Installation

```bash
# Clone with submodules
git clone --recurse-submodules git@github.com:hoxton314/omuriced.git

# Backup existing configs (optional, recommended on new systems)
./backup.sh

# Create symlinks and configure submodules
./setup.sh

# Activate the custom theme
omarchy-theme-set omuriced
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
├── hypr/                    # Personal Hyprland overrides
│   ├── hyprland.conf        # Main config (sources defaults + overrides)
│   ├── monitors.conf        # Monitor configuration
│   ├── input.conf           # Input device settings
│   ├── bindings.conf        # Custom keybindings
│   ├── looknfeel.conf       # Visual overrides
│   ├── autostart.conf       # Startup applications
│   ├── hypridle.conf        # Idle behavior
│   ├── hyprlock.conf        # Lock screen config
│   └── hyprsunset.conf      # Color temperature
├── omarchy/
│   ├── themes/omuriced/     # Custom theme
│   │   ├── colors.toml      # Color palette (generates terminal configs)
│   │   ├── backgrounds/     # Wallpapers
│   │   ├── waybar/          # Status bar config + modules
│   │   └── ...              # Other theme files
│   ├── branding/            # Custom branding (about screen)
│   └── extensions/          # Menu extensions
├── walker/config.toml       # Application launcher settings
├── starship.toml            # Shell prompt
└── mimeapps.list            # Default applications

local/
├── bin/gmail-mailto         # Custom mailto handler
└── share/applications/      # Desktop entries
```

## Custom Theme

The `omuriced` theme lives in `config/omarchy/themes/omuriced/`. After running `setup.sh`, activate it with:

```bash
omarchy-theme-set omuriced
```

The theme includes:
- Color palette (`colors.toml`) - used to generate terminal colors
- Waybar configuration with custom memory module and MPRIS controls
- Styling for walker, hyprlock, mako notifications, and more

## Hyprland Customization

The main `hyprland.conf` sources files in order:
1. Omarchy defaults (system-managed)
2. Theme config from the active theme
3. Personal overrides from `~/.config/hypr/*.conf` (this repo)

Edit the personal override files to customize behavior while preserving Omarchy defaults.

## Submodules

This repo uses git submodules for external dependencies:

- `config/omarchy/themes/omuriced/waybar/modules/waybar-mpris-enhanced` - Enhanced MPRIS module for Waybar
