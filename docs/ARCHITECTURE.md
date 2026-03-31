# Architecture

## Overview

Tacharchy is a performance-first Linux desktop project forked from [Omarchy](https://github.com/basecamp/omarchy), with an original tuning layer and a desktop UX direction owned by Tacharchy itself.

One codebase. One architecture. Fork Omarchy's installer, hardware detection, and migrations where they help. Build Tacharchy's own desktop layer instead of outsourcing project identity. Add performance tuning on top.

## Naming

- **Tacharchy** — the project, the brand, the CLI, and the UX direction
- **tacharchy-* ** — performance tuning packages (sysctl, cpu, gpu, audio, network, io)

## What We Fork

### From Omarchy (foundation)

We fork Omarchy's entire codebase for the base system:

- **Installer** — two-phase design (base install + first-boot configuration)
- **Hardware detection** — per-vendor fixes for Intel, NVIDIA, AMD, Apple, ASUS, Framework, Dell, Surface
- **Theme library** — planned: 19 themes converted to matugen seed colors
- **Migration system** — timestamp-based migrations for safe upgrades
- **App configs** — per-app config templates (ghostty, kitty, alacritty, waybar, tmux, lazygit, fastfetch, starship)
- **Webapp system** — install web apps as desktop entries with custom icons
- **ISO build system** — Arch-based ISO with Limine bootloader, btrfs, snapper
- **Profile system** — save/restore system configuration

### Build Tacharchy UX (desktop layer)

Tacharchy owns the desktop layer instead of depending on DMS:

- **Own shell direction** — launcher, bar, lock flow, notifications, and app menu under Tacharchy control
- **Compositor-agnostic approach** — support multiple Wayland compositors without binding the project to one shell ecosystem
- **Theme pipeline we control** — wallpaper / seed-color driven theming integrated on Tacharchy's terms
- **Installer-first UX** — first boot assembles the desktop experience from Tacharchy-managed components
- **CLI and tooling** — Tacharchy commands remain the primary interface for status, migrations, and future desktop controls

### Original (performance tuning)

Our unique contribution — performance tuning remains the part almost nobody else does properly:

- **tacharchy-sysctl** — kernel parameter tuning with documented reasoning
- **tacharchy-cpu** — Intel hybrid P/E core tuning, AMD preferred cores
- **tacharchy-gpu** — NVIDIA/AMD/Intel driver optimizations
- **tacharchy-audio** — PipeWire realtime scheduling, CPU affinity
- **tacharchy-network** — BBR congestion control, NIC tuning
- **tacharchy-io** — I/O scheduler auto-detection (NVMe/SSD/HDD)
- **tacharchy-detect** — hardware detection and recommendation engine
- **tacharchy-foundation** — meta-package depending on all above

## CLI

```bash
# Implemented today
tacharchy status                   # Current tuning state
tacharchy benchmark                # Before/after performance comparison
tacharchy migrate                  # Run pending migrations

# Planned CLI surface
tacharchy install                  # TUI installer (forked from Omarchy)
tacharchy update                   # Update system (migrations + packages)
tacharchy update --firmware        # + firmware updates
tacharchy detect                   # Hardware report + recommendations
tacharchy theme list               # List themes
tacharchy theme set <name|path>    # Apply static or dynamic (wallpaper) theme
tacharchy theme custom             # Create custom theme
tacharchy shell status             # Future desktop-layer status / health
tacharchy shell reload             # Future shell component reload
tacharchy snapshot                 # Btrfs snapshot (from Omarchy)
tacharchy snapshot rollback        # Roll back
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

### Installer: Two-Phase Design

**Phase 1: Base Install** — Minimal, gets you to a booted Arch desktop.

- Disk placement (erase, free space, manual)
- User creation (username, password)
- Timezone and keyboard layout
- Bootloader setup (Limine) + btrfs + snapper
- Reboot

Headless and fast. Forked from Omarchy installer.

**Phase 2: First-Boot Configuration** — Fullscreen, beautiful, guided.

Runs on first login. This is the real Tacharchy experience:

1. Welcome screen with Tacharchy branding
2. Hardware detection (automatic, shows results)
3. Compositor selection (Hyprland, Sway, labwc, etc.)
4. Desktop layer selection (Tacharchy shell, Waybar stack, or minimal)
5. Theme (pick a wallpaper or named theme)
6. Performance tuning (on by default, shows what will apply)
7. Optional apps (all opt-in)
8. Apply everything
9. Done — shows Tacharchy status and next steps

**ISO vs Existing Install:**
- **Tacharchy ISO** — Phase 1 pre-done. User sees only Phase 2.
- **Omarchy ISO** — Phase 1 via Omarchy, then Phase 2 on first boot.
- **Existing Arch** — Skip Phase 1, run Phase 2 directly.

Same Phase 2 experience regardless.

### Theme System

Single theme engine. Wallpaper or seed color → generated palette → semantic tokens → composed outputs for the Tacharchy desktop layer, GTK, Qt, terminals, editors, and TUIs. One pipeline, one code path.

Named themes (from Omarchy's library) are planned as Tacharchy presets / seed-color themes. See [docs/THEMING.md](THEMING.md).

Theming should live in Tacharchy-owned tooling so the project controls its own UX path. The key missing piece is a **Theme Composer** that can translate one canonical token model into GTK, Qt, and TUI outputs consistently instead of treating each app family as a separate theming problem. It may later be extracted as its own project, but the design work belongs in Tacharchy right now. Implementation should follow stabilization of the desktop layer rather than racing ahead of the features it needs to unify.

### Hardware Detection

Automatic per-vendor configuration (forked from Omarchy):

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

## Cross-Distro Support

| Distro | Package Format | Status |
|---|---|---|
| Arch Linux (primary distro) | AUR + pacman | Phase 1 |
| Fedora | COPR | Phase 2 |
| Debian | OBS / apt | Phase 2 |
| Ubuntu | PPA / Launchpad | Phase 2 |
| openSUSE | OBS / zypper | Phase 2 |
| Gentoo | Ebuild | Phase 3 |
| NixOS | Flake / home-manager | Phase 3 |

## Philosophy

1. **Performance tuning is the core value** — that remains Tacharchy's unique leverage
2. **We give back your freedom** — compositor, shell, theme, apps: your choice
3. **No bullshit** — no censorship, no politics, no gatekeeping
4. **Don't reinvent blindly** — fork Omarchy where it helps, own the UX pieces that define Tacharchy
5. **Everything documented with reasoning** — every sysctl, every fix, every choice
6. **Everything reversible** — one command to remove all traces

## Sources

- [Omarchy](https://github.com/basecamp/omarchy) — forked base: installer, hardware detection, themes, migrations, app configs
- [CachyOS](https://github.com/CachyOS/CachyOS-Settings) — sysctl tuning inspiration
- External Wayland shell ecosystems — studied for lessons, not adopted as hard dependencies
