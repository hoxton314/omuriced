# omuriced (desktop-multiple-monitors)

Personal dotfiles for [Omarchy](https://omarchy.org/) - desktop setup with multiple monitors.

This repo contains:
- Custom **omuriced** theme (colors, styling)
- Custom **waybar** config (layout, modules, MPRIS, memory) - larger font for desktop
- Personal **Hyprland** overrides (multi-monitor setup)

## Usage

```bash
# Clone with submodules
git clone --recurse-submodules -b desktop-multiple-monitors git@github.com:hoxton314/omuriced.git

# Backup existing configs (optional)
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
│   ├── monitors.conf        # Multi-monitor config (HDMI-A-1, DP-1, DP-3)
│   ├── bindings.conf        # Custom keybindings
│   └── ...
├── waybar/                  # Custom waybar (16px font for desktop)
│   ├── config.jsonc
│   ├── style.css
│   └── modules/
├── omarchy/
│   ├── themes/omuriced/     # Custom theme
│   ├── branding/
│   └── extensions/
├── walker/config.toml
├── starship.toml
└── mimeapps.list

local/
├── bin/gmail-mailto
└── share/applications/
```

## Branches

- `master` - laptop config
- `desktop-multiple-monitors` - desktop with multiple monitors (this branch)

## Submodules

- `config/waybar/modules/waybar-mpris-enhanced` - Enhanced MPRIS module for Waybar
