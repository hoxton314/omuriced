# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles repository for Omarchy, a Hyprland-based Linux desktop environment. It manages personal configurations that symlink to `~/.config/` and `~/.local/` directories.

## Setup Commands

```bash
# Backup existing configs before setup (run on new systems)
./backup.sh

# Create symlinks from repo to ~/.config and ~/.local
./setup.sh
```

## Repository Structure

- `config/` - Configuration files that symlink to `~/.config/`
  - `hypr/` - Hyprland window manager config (modular: monitors, bindings, looknfeel, autostart, input)
  - `waybar/` - Status bar (config.jsonc + style.css)
  - `walker/` - Application launcher
  - `omarchy/` - Theme system (current theme in `current/theme/`, hooks, extensions)
  - `alacritty/`, `kitty/`, `ghostty/` - Terminal emulators
  - `starship.toml` - Shell prompt
  - `mimeapps.list` - Default applications

- `local/` - Files that symlink to `~/.local/`
  - `bin/` - Custom scripts (gmail-mailto)
  - `share/applications/` - Desktop entries

## Hyprland Configuration Pattern

The main `hyprland.conf` sources files in order:
1. Omarchy defaults from `~/.local/share/omarchy/default/hypr/` (system-managed, don't edit)
2. Theme config from `~/.config/omarchy/current/theme/hyprland.conf`
3. Personal overrides from `~/.config/hypr/*.conf` (this repo)

Edit the personal override files to customize behavior while preserving Omarchy defaults.

## Theme System

Current theme stored in `config/omarchy/current/`:
- `theme.name` - Theme identifier (e.g., tokyo-night)
- `theme/` - Theme assets (colors.toml, terminal configs, CSS files, backgrounds)

Theme files provide consistent styling across waybar, walker, terminals, hyprlock, mako notifications, etc.
