# Theme System

Tacharchy uses [matugen](https://github.com/InioX/matugen) as the planned theme engine. It generates palettes from either a wallpaper image or a seed color, then applies them through Tacharchy-owned tooling instead of an external shell dependency.

## How It Works

```text
Input (wallpaper or seed color)
  → matugen generates palette
  → Tacharchy theme tooling maps palette roles
  → shell, GTK, Qt, terminals, editors, and app configs are regenerated
```

One engine, one pipeline, every app themed the same way.

## Applying Themes

```bash
tacharchy theme set /path/to/wallpaper.jpg   # Planned: dynamic palette from wallpaper
tacharchy theme set tokyo-night              # Planned: named theme preset
tacharchy theme list                         # Planned: show available themes
tacharchy theme set --seed '#FF6B00'         # Planned: direct seed color
tacharchy theme set --light                  # Planned: toggle light mode
tacharchy theme set --dark                   # Planned: toggle dark mode
```

## Named Themes

The 19 Omarchy themes are planned as Tacharchy seed-color presets. When that work lands, picking a named theme will generate a full palette from that seed:

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

Planned support:

```bash
tacharchy theme wallpaper set /path/to/wall1.jpg --monitor eDP-1
tacharchy theme wallpaper set /path/to/wall2.jpg --monitor HDMI-A-1
```

## Per-App Theming

The generated palette will be applied to:

| App | Config | Format |
|---|---|---|
| Tacharchy shell / panel | project config | palette roles |
| GTK apps | CSS / `settings.ini` | gtk colors |
| Qt apps | qt6ct/qt5ct | palette colors |
| ghostty | `config` | palette mapping |
| kitty | `kitty.conf` | color definitions |
| alacritty | `alacritty.toml` | color definitions |
| neovim | theme file | highlight groups |
| VS Code | JSON theme | workbench colors |
| btop | `btop.theme` | color definitions |
| Chromium/Brave | CSS override | theme colors |
| tmux | `tmux.conf` | color definitions |
| starship | `starship.toml` | color definitions |
| fastfetch | `config.jsonc` | color definitions |
| fzf | `fzf.colors` | color definitions |

### Hot Reload

```bash
tacharchy theme reload            # Planned: reload all theme outputs
tacharchy shell reload            # Planned: reload shell / panel components
```

## Creating a Custom Theme

1. Pick a seed color (hex)
2. Register it: `tacharchy theme add my-theme --seed '#FF6B00'`
3. Optionally set light/dark mode defaults
4. Apply: `tacharchy theme set my-theme`

Or just point at a wallpaper and let the theme pipeline do the rest.

## Default Theme

The Tacharchy default uses `#FF6B00` (dark orange) as the seed color on a dark background. See [BRAND.md](../BRAND.md) for the full brand guide.

## Ownership

Tacharchy owns its theming path. No external shell project is a hard dependency for the core desktop identity.

## Sources

- [matugen](https://github.com/InioX/matugen) — palette generation
- [Omarchy themes](https://github.com/basecamp/omarchy/tree/master/themes) — source material for named presets
