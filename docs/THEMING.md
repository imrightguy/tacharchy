# Theme System

Tacharchy uses [matugen](https://github.com/InioX/matugen) as the single theme engine. It generates Material You color palettes from either a wallpaper image or a seed color, then applies them to your entire desktop through one pipeline.

This theming system is the target design. Tacharchy plans to contribute matugen integration upstream into DMS (DankMaterialShell) rather than forking DMS.

## How It Works

```
Input (wallpaper or seed color)
  → matugen generates Material You palette
  → palette applied to DMS shell via IPC
  → per-app configs regenerated (GTK, Qt, terminals, editors)
```

One engine, one pipeline, every app themed the same way.

## Applying Themes

```bash
dms theme set /path/to/wallpaper.jpg    # Dynamic: palette from wallpaper
dms theme set tokyo-night                # Named theme (uses seed color)
dms theme list                           # Show available themes
dms theme set --seed #FF6B00             # Direct seed color
dms theme set --light                    # Toggle light mode
dms theme set --dark                     # Toggle dark mode
```

## Named Themes

The 19 Omarchy themes are planned as matugen seed-color presets. When that work lands, picking a named theme will let matugen generate the full Material You palette from that seed:

| Theme | Seed Color | Style |
|---|---|---|
| tacharchy | `#FF6B00` | Dark orange (default) |
| tokyo-night | `#7aa2f7` | Blue/purple |
| nord | `#88c0d0` | Blue |
| rose-pine | `#c4a7e7` | Pink/rose |
| kanagawa | `#e0af68` | Warm gold |
| gruvbox | `#d65d0e` | Warm brown |
| catppuccin-mocha | `#cba6f7` | Pastel purple |
| dracula | `#bd93f9` | Purple |
| vantablack | `#44475a` | Near-black |
| matte-black | `#6c7086` | Dark gray |
| miasma | `#a9b1d6` | Muted blue |
| lumon | `#42a5f5` | Teal/cyan |
| retro-82 | `#ffb86c` | Amber |
| osaka-jade | `#9ece6a` | Green |
| ristretto | `#d4a574` | Brown/cream |
| catppuccin-latte | `#8839ef` | Light pastel |
| white | `#40a02b` | Light minimal |
| rose-pine-dawn | `#d7827e` | Light pink |

## Per-Monitor Wallpaper

Different wallpapers per monitor, each generating its own palette:

```bash
dms ipc call wallpaper set /path/to/wall1.jpg --monitor eDP-1
dms ipc call wallpaper set /path/to/wall2.jpg --monitor HDMI-A-1
```

## Per-App Theming

The matugen palette is applied to:

| App | Config | Format |
|---|---|---|
| DMS shell | QML/JS (StockThemes) | Material You roles |
| GTK apps | CSS (`settings.ini`) | gtk:theme-colors |
| Qt apps | qt6ct/qt5ct | Palette colors |
| ghostty | `config` | palette mapping |
| kitty | `kitty.conf` | color definitions |
| alacritty | `alacritty.toml` | color definitions |
| neovim | `colors/tacharchy.lua` | highlight groups |
| VS Code | JSON theme | workbench colors |
| btop | `btop.theme` | color definitions |
| Chromium/Brave | CSS override | theme colors |
| tmux | `tmux.conf` | color definitions |
| starship | `starship.toml` | color definitions |
| fastfetch | `config.jsonc` | color definitions |
| fzf | `fzf.colors` | color definitions |

### Hot Reload

```bash
dms refresh ghostty     # Reload one app
dms refresh all         # Reload everything
```

## Creating a Custom Theme

1. Pick a seed color (hex)
2. Register it: `dms theme add my-theme --seed #FF6B00`
3. Optionally set light/dark mode defaults
4. Apply: `dms theme set my-theme`

Or just point at a wallpaper and let matugen do the rest.

## Default Theme

The Tacharchy default uses `#FF6B00` (dark orange) as the seed color on a dark background. See [BRAND.md](../BRAND.md) for the full brand guide.

## Integration with DMS

The intended integration path is upstream into DMS:

- **No fork** — DMS stays DMS, we don't create a separate "TMS" shell
- **Upstream contribution** — theming features become part of DMS itself
- **Shared benefit** — all DMS users gain Material You theming, not just Tacharchy users

This approach keeps the DMS ecosystem unified while giving Tacharchy the theming capabilities we need.

## Sources

- [matugen](https://github.com/InioX/matugen) — Material You color generation
- [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell) — Desktop shell, theming integration contributed upstream
- [Omarchy themes](https://github.com/basecamp/omarchy/tree/master/themes) — Seed colors for named themes
