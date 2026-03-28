# Architecture

## Overview

Tacharchy is a Linux configuration layer, not a full distribution. It installs on top of an existing Arch Linux system and provides:

1. **Performance tuning** — system-level optimizations for CPU, GPU, audio, network, I/O, and memory
2. **Hardware detection** — automatic identification and configuration of hardware
3. **Compositor support** — config templates for multiple Wayland compositors
4. **Theming** — dynamic color generation from wallpapers
5. **User choice** — nothing is forced; everything is selected during installation

## Components

### Packages (AUR)

| Package | Purpose | Dependencies |
|---|---|---|
| `tacharchy-foundation` | Meta-package, depends on all below | all tacharchy-* packages |
| `tacharchy-sysctl` | Kernel parameter tuning | none |
| `tacharchy-audio` | PipeWire realtime scheduling | pipewire, rtkit |
| `tacharchy-gpu` | GPU driver optimizations | NVIDIA/AMD/Intel drivers |
| `tacharchy-network` | Network stack tuning | none |
| `tacharchy-io` | I/O scheduler udev rules | systemd, udev |
| `tacharchy-cpu` | CPU scheduler tuning | none |
| `tacharchy-detect` | Hardware detection script | bash, coreutils |

### Installer

```
boot.sh (entry point)
  └── install.sh
        ├── preflight/      System checks (Arch, sudo, network, space)
        ├── packaging/      Package installation (foundation + user selections)
        ├── config/
        │   ├── hardware/   Hardware-specific fixes (fork from Omarchy)
        │   ├── compositors/ Compositor config templates
        │   ├── themes/     Theme application engine
        │   └── system/     System-wide config (sysctls, udev, limits)
        ├── login/          Login manager setup (SDDM)
        └── post-install/   First-run wizard
```

### Theme System

Themes use a `colors.toml` format:

```toml
[colors]
primary = "#FF6B00"
secondary = "#1a1a2e"
surface = "#0d1117"
text = "#FFFFFF"
muted = "#8b949e"

[fonts]
mono = "JetBrainsMono Nerd Font"
sans = "Inter"

[options]
light = false  # or true for light mode
```

Theme application reads `colors.toml` and generates configs for:
- Compositor (border colors, background)
- Terminal (color scheme)
- Editor (neovim, VS Code)
- Bar (Waybar, swaybar)
- System tools (btop, starship)
- GTK/Qt themes
- Cursor/pointer colors

### Hardware Detection

Forked from Omarchy's modular per-vendor system:

```
hardware/
├── detect-cpu.sh        # Intel hybrid, AMD preferred cores
├── detect-gpu.sh        # NVIDIA, AMD, Intel
├── detect-audio.sh      # PCI latency, audio devices
├── detect-storage.sh    # NVMe, SSD, HDD
├── detect-display.sh    # Monitors, VRR, multi-head
├── detect-peripherals.sh # Keyboard, touchpad, mouse, Bluetooth
├── intel/
│   ├── hybrid-cores.sh  # P-core/E-core EPP tuning
│   └── video-accel.sh   # VA-API, VAAPI
├── nvidia/
│   ├── drm-modeset.sh   # DRM modeset, fbdev
│   ├── vram-manage.sh   # VRAM leak prevention
│   └── power.sh         # Power management
├── asus/
├── dell/
├── framework/
└── apple/
```

## File Locations

All Tacharchy files live in predictable locations:

| Path | Contents |
|---|---|
| `/etc/tacharchy/` | System-wide config, sysctl drop-ins, udev rules |
| `/usr/share/tacharchy/` | Install scripts, templates, hardware detection |
| `/usr/share/tacharchy/themes/` | Theme packs |
| `~/.config/tacharchy/` | User-specific overrides (never touches other dotfiles) |
| `~/.local/share/tacharchy/` | Runtime data, migrations, logs |

## Reversibility

All changes are tracked:

```bash
tacharchy-list    # Show all applied changes
tacharchy-undo    # Remove all tacharchy modifications
tacharchy-status  # Check what's applied and what's not
```

Uninstalling the packages removes the config files. The undo command reverses any changes to existing system files.

## Design Decisions

### Why Arch-only for Phase 1?

- Simplifies development — one package format, one package manager, one set of configs
- Arch users are comfortable with system configuration
- AUR provides easy package distribution
- Cross-distro support (Phase 2+) uses the same config logic, different packaging

### Why fork Omarchy instead of starting from scratch?

- Omarchy's install framework is battle-tested (thousands of users)
- Hardware detection covers 10+ vendors with specific fixes
- Theme system with 19 themes already exists
- Migration system for rolling updates
- MIT licensed
- We strip the forced choices (Hyprland, packages) and add what's missing (performance)

### Why not just use CachyOS sysctls directly?

We do — with documentation. CachyOS sets these values but doesn't explain why. Every value in Tacharchy is documented with reasoning, tradeoffs, and applicability. Users can understand and modify their system.

### Why shell scripts instead of a compiled tool?

- Shell scripts are transparent — users can read exactly what's being done
- No build toolchain required
- Easy to modify and contribute to
- Omarchy proved this approach works at scale
- Can be wrapped in a Rust/Go binary later for performance if needed
