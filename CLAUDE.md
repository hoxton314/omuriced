# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Overview

Personal Omarchy dotfiles repo - **desktop-multiple-monitors** branch.

**Key principle:** Theme provides colors, waybar/hyprland configs are separate.

## Quick Reference

```bash
./backup.sh   # Backup existing configs before syncing
./sync.sh     # Copy configs to ~/.config and activate theme
```

## Structure

- `config/waybar/` - Full waybar config (16px font for desktop displays)
- `config/hypr/` - Hyprland overrides (multi-monitor: HDMI-A-1, DP-1, DP-3)
- `config/omarchy/themes/omuriced/` - Theme (colors.toml, waybar.css, backgrounds)
- `config/omarchy/branding/` - Custom branding
- `config/walker/` - App launcher config
- `local/bin/` - Custom scripts

## Desktop-specific Settings

- `monitors.conf` - Multi-monitor layout (3 monitors)
- `waybar/style.css` - 16px font (larger than laptop's 12px)

## After Editing

- Hyprland: auto-reloads on save
- Waybar: run `omarchy-restart-waybar`
- Theme changes: run `omarchy-theme-set omuriced`
