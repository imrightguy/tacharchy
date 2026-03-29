```
═══════════════════════════════════════════════════════════════
║                                                               ║
║   ████████ ██    ██ ██████  ███████ ██████  ████████ ███████  ║
║   ██        ██  ██  ██   ██ ██      ██   ██    ██    ██      ║
║   █████     ████   ██████  █████   ██████     ██    ███████  ║
║   ██        ██  ██  ██   ██ ██      ██   ██    ██         ██  ║
║   ████████ ██    ██ ██   ██ ███████ ██   ██    ██    ███████  ║
║                                                               ║
║   ███████ ██      ██ ██    ██ ███████ ██████                   ║
║   ██      ██      ██ ██    ██      ██ ██   ██                  ║
║   ███████ ██      ██ ██    ██      ██ ██████                   ║
║        ██ ██      ██ ██    ██      ██ ██                       ║
║   ███████ ████████   ██████       ██ ██                       ║
║                                                               ║
═══════════════════════════════════════════════════════════════
```

![Status](https://img.shields.io/badge/status-design--phase-orange)
![Phase](https://img.shields.io/badge/phase-research--planning-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Arch](https://img.shields.io/badge/arch-linux-blue)
![FOSS](https://img.shields.io/badge/foss-defaults-brightgreen)

# Tacharchy: Fast Freedom — Linux Desktop Tuned for Performance

**Status:** 🎨 Design & Research Phase | **Target:** Linux users who want a fast, beautiful desktop

---

## What Is Tacharchy?

**Tacharchy** is a complete Linux desktop environment forked from [Omarchy](https://github.com/basecamp/omarchy), consuming [DankMaterialShell (DMS)](https://github.com/AvengeMedia/DankMaterialShell) as the desktop shell, with an original performance tuning layer.

```
Part 1: Fork Omarchy        → Installer, hardware detection, themes, migrations
Part 2: Consume DMS         → Desktop shell (Quickshell), used as-is
Part 3: Performance Layer   → 8 tuning packages (our unique contribution)
```

### The Problem

Linux desktops are slow, power-hungry, and poorly tuned:
- Generic kernel parameters for server workloads
- No per-vendor hardware optimization
- Audio crackling, screen tearing, input lag
- Network throughput left on the table
- I/O schedulers not matched to storage type

### The Solution

```bash
# Install from Tacharchy ISO or add to existing Arch
curl -fsSL https://install.tacharchy.com | sh

# Hardware detection (automatic)
tacharchy detect

# One-command tuning
tacharya install --compositor niri --shell dms

# Reboot into a tuned, themed desktop
```

**Fast by default. Beautiful by design. Freedom always.**

---

## 🎯 Three-Part Architecture

### Part 1: Fork Omarchy (Foundation)

We fork Omarchy's entire installer and configuration system:

- **Two-phase installer** — minimal base install → fullscreen first-boot config
- **Hardware detection** — per-vendor fixes (Intel, NVIDIA, AMD, Apple, ASUS, Framework, Dell, Surface)
- **Theme library** — 19 themes converted to matugen seed colors
- **Migration system** — timestamp-based migrations for safe upgrades
- **App configs** — per-app templates (ghostty, kitty, alacritty, waybar, tmux, lazygit, fastfetch)
- **Webapp system** — install web apps as desktop entries
- **ISO build system** — Arch-based ISO with Limine + btrfs + snapper

### Part 2: Consume DMS (Desktop Shell)

DankMaterialShell is consumed as-is — no fork, no rebrand:

- **Quickshell-based desktop shell** — unified launcher, bar, lock, notifications
- **Go backend + CLI** — `dms` command for full control
- **Cross-distro packaging** — Arch, Fedora, Debian, Ubuntu, openSUSE, Gentoo, NixOS
- **Multi-compositor support** — niri, Hyprland, Sway, MangoWC, labwc, Scroll, Miracle WM
- **Material You theming** — matugen integration (contributed upstream to DMS)
- **TUI installer** — charm-based interactive install

### Part 3: Performance Tuning Layer (Original)

Our unique contribution — 8 AUR packages that tune your system:

| Package | Purpose |
|---|---|
| `tacharchy-sysctl` | Kernel parameter tuning with documented reasoning |
| `tacharchy-cpu` | Intel hybrid P/E core tuning, AMD preferred cores |
| `tacharchy-gpu` | NVIDIA/AMD/Intel driver optimizations |
| `tacharchy-audio` | PipeWire realtime scheduling, CPU affinity |
| `tacharchy-network` | BBR congestion control, NIC tuning |
| `tacharchy-io` | I/O scheduler auto-detection (NVMe/SSD/HDD) |
| `tacharchy-detect` | Hardware detection and recommendation engine |
| `tacharchy-foundation` | Meta-package (installs all above) |

---

## ✨ What Makes Tacharchy Different

### 🚀 **Performance First**
- 8 tuning packages optimize kernel, CPU, GPU, audio, network, I/O
- Per-vendor hardware fixes (Intel, NVIDIA, AMD, Apple, ASUS, Framework, Dell)
- Documented reasoning for every tuning value
- Benchmark before/after to see the difference

### 🎨 **Beautiful Theming**
- matugen Material You theming (wallpaper → palette)
- 19 pre-built themes (Tokyo Night, Nord, Rose Pine, Gruvbox, Catppuccin, etc.)
- Dark orange Tacharchy default (τ logo, "Fast Freedom")
- Hot-reload system — change wallpaper, entire desktop updates

### 🔧 **Compositor Freedom**
- niri (recommended), Hyprland, Sway, MangoWC, labwc, Scroll, Miracle WM
- Or use DMS full shell, or go minimal with just compositor
- Your choice — nothing forced

### 📦 **Clean Architecture**
- Fork Omarchy (installer, hardware, themes, migrations)
- Consume DMS (desktop shell, no fork, no rebrand)
- Add performance layer (original contribution)

### 🛡️ **Safe & Reversible**
- Everything documented with *why*, not just *what*
- One-command uninstall: `tacharchy remove`
- Snapshot/rollback via Limine + snapper
- No forced packages, no fake "minimal" modes

---

## 🚀 Quick Start

### Option 1: Tacharchy ISO (Complete System)

```bash
# Flash USB, boot, install
# Omarchy-style installer → Phase 1 (base)
# First boot → Phase 2 (fullscreen config)
```

**Best for:** Fresh installs, new PCs, bare metal

### Option 2: Install on Existing Arch

```bash
curl -fsSL https://install.tacharchy.com | sh
```

**Best for:** Adding to existing Arch systems

### Option 3: Performance Packages Only

```bash
paru -S tacharchy-foundation
```

**Best for:** Tuning without full desktop

---

## 🎮 What Tacharchy Is NOT

- ❌ **Not** forking DMS — We consume DMS as-is, contribute theming upstream
- ❌ **Not** just another distro — Performance tuning is our unique value
- ❌ **Not** NixOS — We use vanilla Arch, KISS principle
- ❌ **Not** Arch-only — Cross-distro support planned (Phase 2)
- ❌ **Not** X11 support — Wayland only

---

## 📚 Documentation

| Document | What It Covers |
|----------|----------------|
| **[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)** | System architecture, what we fork, CLI reference |
| **[docs/COMPOSITORS.md](docs/COMPOSITORS.md)** | Supported Wayland compositors |
| **[docs/THEMING.md](docs/THEMING.md)** | Theme system (matugen, Material You) |
| **[docs/INSTALL.md](docs/INSTALL.md)** | Installation methods |
| **[docs/PACKAGES.md](docs/PACKAGES.md)** | AUR packages reference |
| **[docs/FIRST_BOOT.md](docs/FIRST_BOOT.md)** | First-boot experience design |
| **[ROADMAP.md](ROADMAP.md)** | Development roadmap |
| **[CONTRIBUTING.md](CONTRIBUTING.md)** | Contributing guide |

---

## 🚧 Current Status

**This repository is in the design and research phase.**

No implementation code exists yet. This is a knowledge base capturing:
- ✅ Design philosophy and requirements
- ✅ Research on existing solutions
- ✅ Complete architecture specification
- ✅ Fork strategy (Omarchy) and consume strategy (DMS)
- ✅ 8 performance tuning packages (complete)
- ⏳ Desktop integration (not started)

**When will implementation begin?**
- Architecture is complete
- Design decisions are documented
- Looking for community feedback before writing code

---

## 🤝 Contributing

**Currently:** Design feedback and discussion welcome!

**Upcoming:** Implementation planning will begin after design phase locks.

**Important:** We do NOT fork DMS (DankMaterialShell). We consume DMS as-is and contribute theming work upstream.

---

## 🎯 Who Is This For?

- ✅ Linux users who want a fast, beautiful desktop
- ✅ People who care about performance tuning
- ✅ Users who value FOSS software and transparency
- ✅ Anyone who wants their desktop to feel smooth and responsive
- ✅ People who like Material You theming
- ✅ Users who want compositor freedom (niri, Hyprland, Sway, etc.)

---

## 🎨 Design Principles

1. **Performance tuning is the core value** — everything else is forked or consumed
2. **We give back your freedom** — compositor, shell, theme, apps: your choice
3. **No bullshit** — no censorship, no politics, no gatekeeping
4. **Don't reinvent** — fork Omarchy, consume DMS, build only what's missing
5. **Everything documented with reasoning** — every sysctl, every fix, every choice
6. **Everything reversible** — one command to remove all traces
7. **DMS is consumed, not forked** — use DMS as-is, contribute upstream

---

## 🗺️ Roadmap Highlights

### Phase 1: Foundation (Arch Linux)
- ✅ Performance tuning packages (8 AUR packages)
- ⏳ Fork Omarchy installer and hardware detection
- ⏳ Consume DMS + port theming upstream
- ⏳ Theme system (matugen, 19 themes)
- ⏳ App ecosystem (configs, webapps)
- ⏳ ISO build system
- ⏳ v0.1.0-alpha release

### Phase 2: Cross-Distro
- Fedora, Debian, Ubuntu, openSUSE support

### Phase 3: Extended Support
- Gentoo, NixOS support

### Phase 4: Kernel
- Custom kernel packages (BORE/EEVDF scheduler)

---

## 💡 Why "Tacharchy"?

**Tachy-** (speed) + **-archy** (Arch Linux)

Speed + Arch Linux philosophy = Tacharchy

Also sounds cool.

---

## 📝 License

MIT License — See [LICENSE](LICENSE) file.

---

## 🌟 Star Us If...

- You want a fast, beautiful Linux desktop
- You believe in performance tuning
- You like Material You theming
- You want compositor freedom
- You believe in FOSS defaults
- You like the idea of documented, reversible tuning

**Star the repo to follow progress!** ⭐

---

<p align="center">
<strong>Tacharchy — Fast Freedom. Linux desktop tuned for performance.</strong><br>
<strong>Fork Omarchy. Consume DMS. Add performance tuning. Simple.</strong>
</p>
