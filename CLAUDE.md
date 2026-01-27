# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Overview

Personal Omarchy dotfiles repo. Syncs configs between machines by copying files.

**Key principle:** Theme provides colors, waybar/hyprland configs are separate.

## Quick Reference

```bash
./backup.sh   # Backup existing configs before syncing
./sync.sh     # Copy configs to ~/.config and activate theme
```

## Structure

- `config/waybar/` - Full waybar config (layout, modules, styling)
- `config/hypr/` - Hyprland overrides (monitors, bindings, etc.)
- `config/omarchy/themes/omuriced/` - Theme (colors.toml, waybar.css, backgrounds)
- `config/omarchy/branding/` - Custom branding
- `config/walker/` - App launcher config
- `local/bin/` - Custom scripts

## How Omarchy Theming Works

1. **Theme** provides colors via `colors.toml` and `waybar.css`
2. **Waybar config** (`~/.config/waybar/`) is separate - imports theme colors via CSS
3. **Hyprland** sources theme config + personal overrides

The `waybar/style.css` imports colors from the active theme:
```css
@import '../omarchy/current/theme/waybar.css';
```

## After Editing

- Hyprland: auto-reloads on save
- Waybar: run `omarchy-restart-waybar`
- Theme changes: run `omarchy-theme-set omuriced`
