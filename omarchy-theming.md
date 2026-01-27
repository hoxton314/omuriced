# Themes

Omarchy comes with fourteen beautiful themes. You can select between them via **Style > Theme** in the Omarchy Menu (`Super + Alt + Space`) or hop directly to the theme selector using `Super + Ctrl + Shift + Space`.

Each theme styles the desktop, terminal, neovim, activity screen (btop), notifications (mako), top bar (waybar), application launcher (walker), and the lock screen (hyprlock). (For Obsidian, you must manually select the Omarchy theme via **Appearance > Themes** inside the app).

Most themes have a set of background images that you can rotate between using `Super + Ctrl + Space`. (But some, like Kanagawa, has only one).

You can find even more themes on the extra themes page or even make your own theme.

### Included Themes:

- Tokyo Night
- Catppuccin
- Ethereal
- Everforest
- Gruvbox
- Hackerman
- Osaka Jade
- Kanagawa
- Nord
- Matte Black
- Ristretto
- Flexoki Light
- Rose Pine
- Catppuccin Latte

# Making your own theme

You can add your own themes to `~/.config/omarchy/themes`. Just copy one of the existing ones as a base (look in `~/.local/share/omarchy/themes`), then tweak to your delight. As long as your theme is inside that folder, it'll be included in the theme selection menu.

The main file you have to tweak is `colors.toml`. That defines the color set that's then used to generate configurations for the terminal (Ghostty/Alacritty/Kitty), btop, Chromium, Hyprland, Hyprlock, Mako, SwayOSD, Walker, and Waybar.

You can also use the included Aether application to create a new theme using a lovely GUI interface to play with colors and search for backgrounds. Just start it via the app launcher on `Super + Space`.

### Light mode

If you're making a light mode theme, drop an empty file called `light.mode` in the root of your theme. Then it'll automatically be paired with light mode for all the apps.

### Icon colors

If you'd like to color-match the file manager icons to your theme, add a file called `icons.theme` with the name of the icon set you want to you. By default, the options are:

- Yaru
- Yaru-blue
- Yaru-dark
- Yaru-magenta
- Yaru-olive
- Yaru-prussiangreen
- Yaru-purple
- Yaru-red
- Yaru-sage
- Yaru-wartybrown
- Yaru-yellow

### Distributing your theme

If you want to distribute your theme so others can use it, you need to put it on a public git server, like GitHub. Then people can install it using **Install > Theme** in the Omarchy menu using that URL. It's recommended that you follow the naming convention of `omarchy-[themename]-theme`, as the theme will show correctly as just `[themename]` in the theme selection menu after installation.

You can have your theme added to the extra themes page by pinging `@tahayvr` on the `#omarchy` Discord.
