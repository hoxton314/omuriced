# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles repository for Omarchy, a Hyprland-based Linux desktop environment. It contains:
- A custom theme (`omuriced`) in `config/omarchy/themes/omuriced/`
- Personal Hyprland overrides in `config/hypr/`
- Custom branding and extensions

The repo symlinks specific items to `~/.config/` and `~/.local/` directories.

## Setup Commands

```bash
# Backup existing configs before setup (run on new systems)
./backup.sh

# Create symlinks from repo to ~/.config and ~/.local
./setup.sh

# Activate the custom theme
omarchy-theme-set omuriced
```

## Repository Structure

- `config/omarchy/themes/omuriced/` - Custom theme (main content)
  - `colors.toml` - Color palette (Omarchy generates terminal configs from this)
  - `waybar/` - Status bar config with custom modules
  - `backgrounds/` - Wallpapers
  - Terminal, hyprlock, mako, walker styling files

- `config/omarchy/branding/` - Custom about screen branding
- `config/omarchy/extensions/` - Menu extensions

- `config/hypr/` - Personal Hyprland overrides
  - `monitors.conf`, `bindings.conf`, `input.conf`, etc.
  - These override Omarchy defaults and are machine-specific

- `config/walker/config.toml` - Application launcher settings
- `config/starship.toml` - Shell prompt
- `config/mimeapps.list` - Default applications

- `local/bin/` - Custom scripts (gmail-mailto)
- `local/share/applications/` - Desktop entries

## Theme System

Custom themes go in `~/.config/omarchy/themes/`. The `colors.toml` file is the main definition - Omarchy auto-generates terminal colors, hyprland theme, and other app configs from it.

After making changes to the theme, run `omarchy-theme-set omuriced` to regenerate and apply.

## Hyprland Configuration Pattern

The main `hyprland.conf` sources files in order:
1. Omarchy defaults from `~/.local/share/omarchy/default/hypr/` (system-managed)
2. Theme config from `~/.config/omarchy/current/theme/hyprland.conf` (generated)
3. Personal overrides from `~/.config/hypr/*.conf` (this repo)

Edit the personal override files to customize behavior while preserving Omarchy defaults.
