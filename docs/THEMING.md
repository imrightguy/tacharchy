# Theme System

Tacharchy has a dual-theme engine: **matugen** for dynamic wallpaper-based palettes, and **colors.toml** for static hand-crafted themes. Both feed into the same application layer that themes your entire desktop.

## Dynamic Theming (matugen)

Uses [matugen](https://github.com/InioX/matugen) to generate a Material You color palette from any wallpaper image. The palette is applied in real-time to TMS, GTK apps, Qt apps, terminals, and editors.

```bash
tacharya theme set /path/to/wallpaper.jpg
```

How it works:
1. matugen extracts dominant colors from the image
2. Colors are mapped to Material You roles (primary, surface, background, etc.)
3. Palette is applied to TMS shell via IPC
4. Per-app configs are regenerated (GTK CSS, terminal colors, editor themes)

### Per-Monitor Wallpaper
TMS supports different wallpapers per monitor, each generating its own palette:

```bash
tacharya ipc call wallpaper set /path/to/wall1.jpg --monitor eDP-1
tacharya ipc call wallpaper set /path/to/wall2.jpg --monitor HDMI-A-1
```

## Static Theming (colors.toml)

Hand-crafted color palettes in a simple TOML format, forked from Omarchy's theme library.

### Theme Format

```toml
accent = "#FF6B00"
cursor = "#FFFFFF"
foreground = "#e0e2e8"
background = "#0d1117"
selection_foreground = "#FFFFFF"
selection_background = "#FF6B00"

color0 = "#32344a"
color1 = "#f7768e"
color2 = "#9ece6a"
color3 = "#e0af68"
color4 = "#7aa2f7"
color5 = "#ad8ee6"
color6 = "#449dab"
color7 = "#787c99"
color8 = "#444b6a"
color9 = "#ff7a93"
color10 = "#b9f27c"
color11 = "#ff9e64"
color12 = "#7da6ff"
color13 = "#bb9af7"
color14 = "#0db9d7"
color15 = "#acb0d0"
```

### Applying a Static Theme

```bash
tacharya theme list                # Show available themes
tacharya theme set tokyo-night     # Apply by name
tacharya theme set /path/to/custom # Apply from directory with colors.toml
```

### Included Themes (from Omarchy)

| Theme | Style | Light Mode |
|---|---|---|
| tokyo-night | Dark blue/purple | No |
| nord | Dark blue | No |
| rose-pine | Dark pink/rose | No |
| kanagawa | Dark warm | No |
| gruvbox | Dark warm brown | No |
| catppuccin-mocha | Dark pastel | No |
| dracula | Dark purple | No |
| vantablack | Near-black | No |
| matte-black | Dark gray | No |
| miasma | Dark muted | No |
| lumon | Dark teal/cyan | No |
| retro-82 | Dark amber | No |
| osaka-jade | Dark green | No |
| ristretto | Dark brown/cream | No |
| catppuccin-latte | Light pastel | Yes |
| white | Light minimal | Yes |
| rose-pine-dawn | Light pink | Yes |

### Light/Dark Mode

Themes with light mode variants can toggle:

```bash
tacharya theme set tokyo-night --light
tacharya theme set tokyo-night --dark
```

## Per-App Theming

Both theme engines apply colors to the same set of applications:

| App | Config | Applied By |
|---|---|---|
| TMS shell | QML/JS (StockThemes) | matugen or static |
| GTK apps | CSS (`~/.config/gtk-3.0/settings.ini`) | matugen or static |
| Qt apps | qt6ct/qt5ct | matugen or static |
| ghostty | `~/.config/ghostty/config` | static colors.toml |
| kitty | `~/.config/kitty/kitty.conf` | static colors.toml |
| alacritty | `~/.config/alacritty/alacritty.toml` | static colors.toml |
| neovim | `~/.config/nvim/colors/tacharchy.lua` | static colors.toml |
| VS Code | JSON theme file | static colors.toml |
| btop | `~/.config/btop/btop.theme` | static colors.toml |
| Chromium/Brave | CSS override | static colors.toml |
| Waybar | CSS (`style.css`) | static colors.toml |
| tmux | `~/.config/tmux/tmux.conf` | static colors.toml |
| starship | `~/.config/starship.toml` | static colors.toml |
| fastfetch | `~/.config/fastfetch/config.jsonc` | static colors.toml |
| fzf | `~/.config/fzf/fzf.colors` | static colors.toml |

### Hot Reload

When the theme changes, configs are regenerated and apps are reloaded:

```bash
tacharya refresh ghostty     # Reload just ghostty
tacharya refresh all         # Reload everything
```

## Creating a Custom Theme

1. Create a directory: `~/.config/tacharchy/themes/my-theme/`
2. Add `colors.toml` with your palette (see format above)
3. Optionally add per-app overrides:
   - `neovim.lua` — custom neovim colorscheme
   - `vscode.json` — VS Code theme override
   - `btop.theme` — btop theme override
   - `ghostty` — ghostty config override
   - `preview.png` — 1280x720 screenshot
4. Apply: `tacharya theme set ~/.config/tacharchy/themes/my-theme`

## Default Tacharchy Theme

The Tacharchy brand theme uses dark orange as the accent on a dark background:

- **Primary:** `#FF6B00` (dark orange)
- **Background:** `#0d1117` (dark)
- **Surface:** `#161b22`
- **Text:** `#e0e2e8`
- **Muted:** `#8b949e`

See [BRAND.md](../BRAND.md) for the full brand guide.

## Sources

- [matugen](https://github.com/InioX/matugen) — Material You color generation
- [dank16](https://github.com/AvengeMedia/DankMaterialShell) — TMS theme application engine
- [Omarchy themes](https://github.com/basecamp/omarchy/tree/master/themes) — Static theme library
