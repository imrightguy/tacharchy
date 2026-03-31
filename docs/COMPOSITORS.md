# Compositor Support

Tacharchy supports multiple Wayland compositors through its own desktop-layer direction. Choose yours during installation — nothing is forced.

## Supported Compositors

### Hyprland
Dynamic tiling Wayland compositor with extensive customization.

- **Config format:** Hyprland config (`hyprland.conf`)
- **Status:** Active target
- **Desktop-layer support:** Planned
- **Standalone:** Full theme support planned

### Sway
i3-compatible Wayland compositor. Stable and well-documented.

- **Config format:** i3-compatible (`config`)
- **Status:** Active target
- **Desktop-layer support:** Planned
- **Standalone:** Full theme support planned

### labwc
Stacking Wayland compositor (openbox-compatible).

- **Config format:** XML (`rc.xml`) + theme
- **Status:** Supported target
- **Desktop-layer support:** Planned
- **Standalone:** Colors and borders

### MangoWC
Wayland compositor built with MangoHud's rendering pipeline.

- **Config format:** Custom
- **Status:** Exploratory target
- **Desktop-layer support:** Planned
- **Standalone:** Basic theme support

### Scroll
Scrolling Wayland compositor.

- **Config format:** Custom
- **Status:** Exploratory target
- **Desktop-layer support:** Planned
- **Standalone:** Basic theme support

### Miracle WM
Tiling Wayland compositor for Ubuntu.

- **Config format:** Custom
- **Status:** Exploratory target
- **Desktop-layer support:** Planned
- **Standalone:** Basic theme support

### river
Dynamic tiling Wayland compositor (inspired by dwm).

- **Config format:** init script
- **Status:** Planned
- **Desktop-layer support:** Planned
- **Standalone:** Colors only

### Wayfire
3D Wayland compositor with effects.

- **Config format:** INI (`wf.ini`)
- **Status:** Planned
- **Desktop-layer support:** Planned
- **Standalone:** Planned

### dwl
Minimal dwm-like Wayland compositor.

- **Config format:** C header (`config.h`) — requires recompilation
- **Status:** Planned
- **Desktop-layer support:** Limited
- **Standalone:** Colors only

## Not Supported

### GNOME / KDE Plasma
These have their own shell, theming system, and ecosystem. Tacharchy's performance tuning packages still apply, but Tacharchy is not trying to replace their native UX.

### X11 Compositors
Tacharchy is Wayland only. No X11 support is planned.

## Desktop Layer Options

### Tacharchy Shell (planned)
The full desktop-layer experience: launcher, bar, lock flow, notifications, app menu, and theme integration under Tacharchy control.

### DMS (optional external shell)
A valid user-selectable shell option for people who want it. Tacharchy may integrate with it, but DMS is not the architectural center of the project.

### Waybar Stack
A modular stack using compositor-native or standard Wayland pieces.

### Minimal
No desktop layer. Just your compositor with Tacharchy's performance tuning and theme colors applied.

## Keybind Consistency

We aim for consistent keybinds across compositors where possible:

| Action | Default | Notes |
|---|---|---|
| Terminal | `Super + Enter` | |
| App launcher | `Super + Space` | Tacharchy launcher or system launcher |
| Close window | `Super + Shift + Q` | |
| Move focus | `Super + Arrow` or `Super + HJKL` | Vim-style optional |
| Toggle floating | `Super + V` | Tiling compositors only |
| Fullscreen | `Super + F` | |
| Screenshot | `Print` | Full screen |
| Screenshot region | `Super + Print` | Selection tool |
| Screen record | `Super + Shift + Print` | |
| Volume up/down | `XF86AudioRaise/LowerVolume` | Via standard Wayland tooling |
| Brightness up/down | `XF86MonBrightnessUp/Down` | Via standard Wayland tooling |
| Lock screen | `Super + L` | Tacharchy lock flow or swaylock |
