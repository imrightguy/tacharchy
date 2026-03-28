# Compositor Support

Tacharchy supports multiple Wayland compositors. Choose yours during installation.

## Supported Compositors

### niri
Scrollable-tiling Wayland compositor with smooth animations. Our recommended default.

- **Config format:** KDL (`config.kdl`)
- **Status:** Primary target, best tested
- **Theme integration:** Full (colors, borders, animations, gaps)

### Hyprland
Dynamic tiling Wayland compositor with extensive customization.

- **Config format:** Hyprland config (`hyprland.conf`)
- **Status:** Supported
- **Theme integration:** Full

### Sway
i3-compatible Wayland compositor. Stable and well-documented.

- **Config format:** i3-compatible (`config`)
- **Status:** Supported
- **Theme integration:** Full

### labwc
Stacking Wayland compositor (openbox-compatible).

- **Config format:** XML (`rc.xml`) + theme
- **Status:** Supported
- **Theme integration:** Colors and borders

### river
Dynamic tiling Wayland compositor (inspired by dwm).

- **Config format:** init script
- **Status:** Planned
- **Theme integration:** Basic

### Wayfire
3D Wayland compositor with effects.

- **Config format:** INI (`wf.ini`)
- **Status:** Planned
- **Theme integration:** Planned

### dwl
Minimal dwm-like Wayland compositor.

- **Config format:** C header (`config.h`) — requires recompilation
- **Status:** Planned
- **Theme integration:** Basic (colors only)

## Not Supported (Yet)

### GNOME
GNOME has its own theming system that doesn't follow the same patterns. Could add basic support later (tweaked GNOME settings + performance tuning) but full theme integration would require GNOME Shell extensions.

### KDE Plasma
Similar to GNOME — KDE has its own theme engine. Performance tuning packages still apply. Full theme integration is a future consideration.

## Adding a New Compositor

See [CONTRIBUTING.md](../CONTRIBUTING.md#adding-a-new-compositor) for the process.

## Keybind Consistency

We aim for consistent keybinds across compositors where possible:

| Action | Default |
|---|---|
| Terminal | `Super + Enter` |
| App launcher | `Super + Space` |
| Close window | `Super + Shift + Q` |
| Move focus left/right | `Super + Arrow` or `Super + HJKL` |
| Toggle floating | `Super + V` |
| Fullscreen | `Super + F` |
| Screenshot | `Print` |
| Screenshot region | `Super + Print` |

## Desktop Shell Integration

### DankMaterialShell (DMS)
Full desktop environment built with Quickshell. Works best with niri.

### Waybar
Lightweight status bar. Works with all compositors.

### None
No bar, no shell. Just the compositor. For minimalists.
