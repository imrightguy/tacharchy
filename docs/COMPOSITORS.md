# Compositor Support

Tacharchy supports multiple Wayland compositors through DMS (DankMaterialShell). Choose yours during installation — nothing is forced.

## Supported Compositors

### niri
Scrollable-tiling Wayland compositor with smooth animations. Our recommended default.

- **Config format:** KDL (`config.kdl`)
- **Status:** Primary target, best tested
- **DMS integration:** Full (workspace switching, overview, monitor management)
- **Standalone:** Full theme support

### Hyprland
Dynamic tiling Wayland compositor with extensive customization.

- **Config format:** Hyprland config (`hyprland.conf`)
- **Status:** Fully supported
- **DMS integration:** Full
- **Standalone:** Full theme support

### Sway
i3-compatible Wayland compositor. Stable and well-documented.

- **Config format:** i3-compatible (`config`)
- **Status:** Fully supported
- **DMS integration:** Full
- **Standalone:** Full theme support

### MangoWC
Wayland compositor built with MangoHud's rendering pipeline.

- **Config format:** Custom
- **Status:** Supported
- **DMS integration:** Full
- **Standalone:** Basic theme support

### labwc
Stacking Wayland compositor (openbox-compatible).

- **Config format:** XML (`rc.xml`) + theme
- **Status:** Supported
- **DMS integration:** Full
- **Standalone:** Colors and borders

### Scroll
Scrolling Wayland compositor.

- **Config format:** Custom
- **Status:** Supported
- **DMS integration:** Full
- **Standalone:** Basic theme support

### Miracle WM
Tiling Wayland compositor for Ubuntu.

- **Config format:** Custom
- **Status:** Supported
- **DMS integration:** Full
- **Standalone:** Basic theme support

### river
Dynamic tiling Wayland compositor (inspired by dwm).

- **Config format:** init script
- **Status:** Planned
- **DMS integration:** Basic
- **Standalone:** Colors only

### Wayfire
3D Wayland compositor with effects.

- **Config format:** INI (`wf.ini`)
- **Status:** Planned
- **DMS integration:** Planned
- **Standalone:** Planned

### dwl
Minimal dwm-like Wayland compositor.

- **Config format:** C header (`config.h`) — requires recompilation
- **Status:** Planned
- **DMS integration:** Limited (no ext_workspace protocol)
- **Standalone:** Colors only

## Not Supported

### GNOME / KDE Plasma
These have their own shell, theming system, and ecosystem. Tacharchy's performance tuning packages still apply. DMS and theme integration are not planned — GNOME and KDE users should use their native tools.

### X11 Compositors
Tacharchy is Wayland only. No X11 support is planned.

## Desktop Shell Options

### DMS (DankMaterialShell)
The full desktop shell experience. Replaces waybar + swaylock + swayidle + mako + fuzzel + polkit with one unified Quickshell app. Works best with niri and Hyprland, fully supported on all listed compositors.

### Standalone
No desktop shell. Just your compositor with Tacharchy's performance tuning and theme colors applied. For minimalists who prefer their own bar, notifications, and launcher.

## Keybind Consistency

We aim for consistent keybinds across compositors where possible:

| Action | Default | Notes |
|---|---|---|
| Terminal | `Super + Enter` | |
| App launcher | `Super + Space` | DMS launcher or system launcher |
| Close window | `Super + Shift + Q` | |
| Move focus | `Super + Arrow` or `Super + HJKL` | Vim-style optional |
| Toggle floating | `Super + V` | Tiling compositors only |
| Fullscreen | `Super + F` | |
| Screenshot | `Print` | Full screen |
| Screenshot region | `Super + Print` | Selection tool |
| Screen record | `Super + Shift + Print` | |
| Volume up/down | `XF86AudioRaise/LowerVolume` | Via SwayOSD or DMS |
| Brightness up/down | `XF86MonBrightnessUp/Down` | Via SwayOSD or DMS |
| Lock screen | `Super + L` | DMS lock or swaylock |
| Overview | `Super + Tab` | DMS workspace overview |

## Adding a New Compositor

See [CONTRIBUTING.md](../CONTRIBUTING.md#adding-a-compositor) for the process.
