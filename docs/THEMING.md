# Theme System

Tacharchy uses [matugen](https://github.com/InioX/matugen) as the planned theme engine. It generates palettes from either a wallpaper image or a seed color, then applies them through Tacharchy-owned tooling instead of an external shell dependency.

## How It Works

```text
Input (wallpaper or seed color)
  → matugen generates palette
  → Tacharchy Theme Composer maps palette roles into semantic tokens
  → composers/renderers emit configs for shell, GTK, Qt, terminals, editors, and app configs
```

One engine, one pipeline, every app themed the same way.

## Tacharchy Theme Composer

The next architectural step is a **GTK / Qt / TUI theme composer**, but not the next implementation priority.

This may eventually deserve its **own standalone project**, but it should still be designed in the open inside Tacharchy because the desktop vision depends on it.

First, Tacharchy needs to stabilize the desktop layer, installer flow, compositor support, and core UX. The composer should land after the features it is supposed to unify are stable enough to target.

Instead of hand-maintaining separate theme logic for every surface, Tacharchy should own a composer layer that:

- takes one canonical palette and semantic token set
- translates it into **GTK**, **Qt**, and **TUI/terminal** targets consistently
- normalizes contrast, accent usage, borders, selection states, and error/warning/success colors
- lets Tacharchy ship one visual identity across graphical apps and terminal tools

That means the theme pipeline becomes:

- **palette generation** — wallpaper or seed color → source palette
- **semantic mapping** — background, surface, primary, secondary, destructive, muted, focus, etc.
- **target composition** — GTK CSS/settings, Qt palettes, terminal/TUI color sets, editor themes, shell styles
- **export + reload** — write configs and refresh affected components

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

The generated palette will be applied through composer targets:

| Target | Output examples | Format |
|---|---|---|
| Tacharchy shell / panel | shell theme config | semantic roles |
| GTK composer | CSS / `settings.ini` / theme overrides | gtk colors |
| Qt composer | qt6ct/qt5ct / kvantum / palette exports | palette colors |
| TUI composer | ghostty, kitty, alacritty, tmux, btop, fzf, fastfetch | terminal/TUI colors |
| Editor composer | neovim, VS Code and similar tools | highlight/theme files |
| Browser/app overrides | Chromium/Brave and app-specific overrides | CSS / config snippets |

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
