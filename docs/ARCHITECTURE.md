# Architecture

## Overview

Tacharchy is a complete Linux desktop environment forked from [DankLinux/DMS](https://github.com/AvengeMedia/DankMaterialShell) and [Omarchy](https://github.com/basecamp/omarchy), with an original performance tuning layer on top.

We don't reinvent — we take what works, improve what doesn't, and fill the gaps nobody else is filling.

## Naming

- **Tacharchy** — the project, the brand, the CLI
- **TMS** — Tacharchy Material Shell, the desktop shell (forked from DMS, plugin-compatible)
- **tacharchy-\*** — performance tuning packages (sysctl, cpu, gpu, audio, network, io)

## What We Fork

### From DankLinux/DMS (foundation)
- **Quickshell-based desktop shell** → rebranded as TMS
- **Go backend + CLI** (`dms` → `tacharchy`)
- **Cross-distro packaging** — Arch, Fedora, Debian, Ubuntu, openSUSE, Gentoo, NixOS
- **Multi-compositor support** — niri, Hyprland, Sway, MangoWC, labwc, Scroll, Miracle WM
- **Material You theming** — matugen + dank16 dynamic wallpaper → palette
- **TUI installer** — charm-based interactive install with compositor/shell selection
- **IPC system** — `tacharya ipc call ...` for programmatic control
- **Plugin system** — DMS plugin API kept identical for compatibility
- **Greeter support** — GDM/greetd integration
- **Doctor/diagnostics** — `tacharya doctor`

### From Omarchy (hardware + apps)
- **Hardware detection & fixes** — per-vendor, per-model (ASUS ROG, Framework, Surface, Apple T2, Dell XPS, Intel, NVIDIA, Broadcom, Tuxedo)
- **Migration system** — timestamp-based config migration tracking
- **App ecosystem** — webapp system, per-app configs (ghostty, kitty, alacritty, waybar, tmux, lazygit, fastfetch, starship)
- **Theme library** — 19 static themes in colors.toml format
- **Package management CLI** — distro-agnostic package install/remove/present/missing
- **Snapshot/rollback** — Limine bootloader + snapper btrfs snapshots
- **Battery management** — capacity, monitor, hibernation
- **Hot-reload** — `tacharya refresh-*` for individual app configs on theme change
- **Hidden desktop entries** — clean up app launchers
- **Custom desktop icons** — for common apps

### Original (performance tuning)
- **tacharchy-sysctl** — kernel parameter tuning with documented reasoning
- **tacharchy-cpu** — Intel hybrid P/E core tuning, AMD preferred cores
- **tacharchy-gpu** — NVIDIA/AMD/Intel driver optimizations
- **tacharchy-audio** — PipeWire realtime scheduling, CPU affinity
- **tacharchy-network** — BBR congestion control, NIC tuning
- **tacharchy-io** — I/O scheduler auto-detection (NVMe/SSD/HDD)
- **tacharchy-detect** — hardware detection and recommendation engine
- **tacharchy-foundation** — meta-package depending on all above

## CLI

```
tacharchy                          # Status overview

tacharchy install                  # TUI installer
tacharchy update                   # Update system (migrations + packages)
tacharchy update --firmware        # + firmware updates

tacharchy detect                   # Hardware report + recommendations

tacharchy theme list               # List themes
tacharchy theme set <name|path>    # Apply static or dynamic (wallpaper) theme
tacharchy theme custom             # Create custom theme

tacharchy status                   # Current tuning state
tacharchy benchmark                # Before/after performance comparison

tacharya config                    # Interactive configuration
tacharya config export             # Export config as dotfiles
tacharya config import             # Import config

tacharchy snapshot                 # Btrfs snapshot
tacharchy snapshot rollback        # Roll back

tacharya ipc call <command>        # Programmatic shell control
tacharya doctor                    # Diagnostic check
tacharya migrate                   # Run pending migrations

tacharchy remove                   # Clean uninstall
```

## Components

### Packages

| Package | Purpose | Source |
|---|---|---|
| `tacharchy-sysctl` | Kernel parameter tuning | Original |
| `tacharchy-audio` | PipeWire realtime scheduling | Original |
| `tacharchy-gpu` | GPU driver optimizations | Original + Omarchy hw detection |
| `tacharchy-network` | Network stack tuning | Original |
| `tacharchy-io` | I/O scheduler udev rules | Original |
| `tacharchy-cpu` | CPU scheduler tuning | Original + Omarchy hw detection |
| `tacharchy-detect` | Hardware detection | Original + Omarchy hw detection |
| `tacharchy-foundation` | Meta-package | Original |
| `tms-shell` | Desktop shell (Quickshell) | Fork: DMS |
| `tms-greeter` | Login greeter | Fork: DMS |

### Installer Flow

```
curl tacharchy.sh | sh
  → Preflight (distro detection, sudo, network, disk space)
  → Hardware detection (Omarchy's per-vendor scripts)
  → Compositor selection (niri, Hyprland, Sway, labwc, etc.)
  → Desktop shell (TMS, Waybar, or none)
  → Theme selection (static or dynamic)
  → Performance tuning (tacharchy-foundation)
  → Optional apps (webapps, dev tools, etc.)
  → First-run wizard
  → Post-install
```

### Theme System

Two theme engines, one application layer:

1. **Dynamic (matugen)** — wallpaper → Material You palette, applied to TMS shell, GTK, Qt, terminals, editors
2. **Static (colors.toml)** — 19 pre-built themes from Omarchy, same application layer

Both feed into the same theme application pipeline. User picks whichever they prefer.

### Hardware Detection

Automatic per-vendor configuration:

| Vendor | Detection | Fixes |
|---|---|---|
| Intel | CPU, GPU, WiFi 7, IPU camera | Video accel, LPMD, thermald, PTL kernel |
| NVIDIA | GPU architecture (Turing+ vs legacy) | Correct driver, KMS, env vars, VRAM fix |
| AMD | GPU, preferred cores | Video accel, OverDrive |
| Apple | T2 MacBooks | SPI keyboard, suspend NVMe, T2 audio |
| ASUS | ROG laptops | Audio mixer, mic, keyboard RGB |
| Framework | F13, F16 | AMD audio input, QMK HID |
| Dell | XPS | Haptic touchpad, PTL display |
| Surface | Surface devices | Keyboard fix |
| Broadcom | WiFi chips | Driver install |
| Tuxedo | Backlight | Fix backlight control |

## Plugin Compatibility

TMS maintains full API compatibility with DMS plugins. All existing DMS plugins work without modification. The plugin registry at plugins.danklinux.com is supported, and Tacharchy may host its own registry in the future.

## Cross-Distro Support

| Distro | Package Format | Status |
|---|---|---|
| Arch Linux | AUR + pacman | Phase 1 |
| Fedora | COPR | Phase 2 |
| Debian | OBS / apt | Phase 2 |
| Ubuntu | PPA / Launchpad | Phase 2 |
| openSUSE | OBS / zypper | Phase 2 |
| Gentoo | Ebuild | Phase 3 |
| NixOS | Flake / home-manager | Phase 3 |

## Philosophy

1. **Performance tuning is the core value** — everything else is borrowed and improved
2. **We give back your freedom** — compositor, shell, theme, apps: your choice
3. **No bullshit** — no censorship, no politics, no gatekeeping
4. **Don't reinvent** — fork what works, improve what doesn't, build only what's missing
5. **Everything documented with reasoning** — every sysctl, every fix, every choice
6. **Everything reversible** — one command to remove all traces
7. **Plugin compatible** — DMS plugins work out of the box

## Sources

- [DankLinux/DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell) — shell, installer, cross-distro
- [Omarchy](https://github.com/basecamp/omarchy) — hardware detection, themes, migrations, app configs
- [CachyOS](https://github.com/CachyOS/CachyOS-Settings) — sysctl tuning inspiration
