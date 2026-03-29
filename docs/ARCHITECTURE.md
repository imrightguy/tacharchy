# Architecture

## Overview

Tacharchy is a complete Linux desktop environment forked from [Omarchy](https://github.com/basecamp/omarchy), consuming [DankMaterialShell (DMS)](https://github.com/AvengeMedia/DankMaterialShell) as the desktop shell, with an original performance tuning layer.

One codebase. One architecture. Fork Omarchy's installer, hardware detection, app configs, and theming. Consume DMS as-is for the desktop shell. Add performance tuning on top.

## Naming

- **Tacharchy** — the project, the brand, the CLI
- **DMS** — DankMaterialShell, the desktop shell (consumed as-is, not forked)
- **tacharchy-\*** — performance tuning packages (sysctl, cpu, gpu, audio, network, io)

## What We Fork

### From Omarchy (foundation)

We fork Omarchy's entire codebase for the base system:

- **Installer** — two-phase design (base install + first-boot configuration)
- **Hardware detection** — per-vendor fixes for Intel, NVIDIA, AMD, Apple, ASUS, Framework, Dell, Surface
- **Theme library** — 19 themes converted to matugen seed colors
- **Migration system** — timestamp-based migrations for safe upgrades
- **App configs** — per-app config templates (ghostty, kitty, alacritty, waybar, tmux, lazygit, fastfetch, starship)
- **Webapp system** — install web apps as desktop entries with custom icons
- **ISO build system** — Arch-based ISO with Limine bootloader, btrfs, snapper
- **Profile system** — save/restore system configuration

### Consume DMS (desktop shell)

DankMaterialShell is consumed as-is — no fork, no rebrand. We port theming work into DMS itself:

- **Quickshell-based desktop shell** — used directly as DMS
- **Go backend + CLI** — `dms` command (extended via plugins if needed)
- **Cross-distro packaging** — Arch, Fedora, Debian, Ubuntu, openSUSE, Gentoo, NixOS
- **Multi-compositor support** — niri, Hyprland, Sway, MangoWC, labwc, Scroll, Miracle WM
- **Material You theming** — matugen + dank16 dynamic wallpaper → palette (ported into DMS)
- **TUI installer** — charm-based interactive install with compositor/shell selection
- **IPC system** — `dms ipc call ...` for programmatic control
- **Greeter support** — GDM/greetd integration
- **Doctor/diagnostics** — `dms doctor`

### Original (performance tuning)

Our unique contribution — neither Omarchy nor DMS touches system performance tuning:

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

tacharchy install                  # TUI installer (forked from Omarchy)
tacharchy update                   # Update system (migrations + packages)
tacharchy update --firmware        # + firmware updates

tacharchy detect                   # Hardware report + recommendations

tacharchy theme list               # List themes
tacharchy theme set <name|path>    # Apply static or dynamic (wallpaper) theme
tacharchy theme custom             # Create custom theme

tacharchy status                   # Current tuning state
tacharchy benchmark                # Before/after performance comparison

dms config                         # DMS interactive configuration
dms theme                          # DMS theme controls

tacharchy snapshot                 # Btrfs snapshot (from Omarchy)
tacharchy snapshot rollback        # Roll back

dms ipc call <command>             # Programmatic shell control
dms doctor                         # DMS diagnostic check
tacharchy migrate                  # Run pending migrations

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
3. Compositor selection (niri, Hyprland, Sway, etc.)
4. Desktop shell (DMS, Waybar, or none)
5. Theme (matugen: pick a wallpaper or named theme)
6. Performance tuning (on by default, shows what will apply)
7. Optional apps (all opt-in)
8. Apply everything
9. Done — shows `dms doctor` and next steps

**ISO vs Existing Install:**
- **Tacharchy ISO** — Phase 1 pre-done. User sees only Phase 2.
- **Omarchy ISO** — Phase 1 via Omarchy, then Phase 2 on first boot.
- **Existing Arch** — Skip Phase 1, run Phase 2 directly.

Same Phase 2 experience regardless.

### Theme System

Single matugen engine. Wallpaper or seed color → Material You palette → applied to DMS shell, GTK, Qt, terminals, editors. One pipeline, one code path.

Named themes (from Omarchy's library) are converted to matugen seed colors. See [docs/THEMING.md](THEMING.md).

Theming work is ported into DMS itself — matugen integration lives in the DMS codebase, not a separate Tacharchy fork.

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

1. **Performance tuning is the core value** — everything else is forked from Omarchy, DMS is consumed as-is
2. **We give back your freedom** — compositor, shell, theme, apps: your choice
3. **No bullshit** — no censorship, no politics, no gatekeeping
4. **Don't reinvent** — fork Omarchy as the foundation, consume DMS as-is, build only what's missing (performance tuning)
5. **Everything documented with reasoning** — every sysctl, every fix, every choice
6. **Everything reversible** — one command to remove all traces

## Sources

- [Omarchy](https://github.com/basecamp/omarchy) — forked base: installer, hardware detection, themes, migrations, app configs
- [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell) — consumed desktop shell
- [CachyOS](https://github.com/CachyOS/CachyOS-Settings) — sysctl tuning inspiration
