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

![Status](https://img.shields.io/badge/status-prototype-orange)
![Phase](https://img.shields.io/badge/phase-foundation-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Arch](https://img.shields.io/badge/arch-linux-blue)
![FOSS](https://img.shields.io/badge/foss-defaults-brightgreen)

# Tacharchy: Fast Freedom — Linux Desktop Tuned for Performance

**Status:** 🛠️ Prototype foundation built | **Target:** Linux users who want a fast, beautiful desktop

---

## What Is Tacharchy?

**Tacharchy** is a performance-first Linux desktop project forked from [Omarchy](https://github.com/basecamp/omarchy), focused on installer ergonomics, hardware-aware defaults, and an original tuning layer — without depending on DMS.

```text
Part 1: Fork Omarchy        → Installer, hardware detection, migrations, UX patterns
Part 2: Build Tacharchy UX  → Our own shell / launcher / panel direction
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

# Check current tuning state
tacharchy status

# Run a quick benchmark
tacharchy benchmark

# Apply any pending migrations
tacharchy migrate
```

**Fast by default. Beautiful by design. Freedom always.**

---

## 🎯 Three-Part Architecture

### Part 1: Fork Omarchy (Foundation)

We fork Omarchy's entire installer and configuration system:

- **Two-phase installer** — minimal base install → fullscreen first-boot config
- **Hardware detection** — per-vendor fixes (Intel, NVIDIA, AMD, Apple, ASUS, Framework, Dell, Surface)
- **Theme library** — planned: 19 themes converted to matugen seed colors
- **Migration system** — timestamp-based migrations for safe upgrades
- **App configs** — per-app templates (ghostty, kitty, alacritty, waybar, tmux, lazygit, fastfetch)
- **Webapp system** — install web apps as desktop entries
- **ISO build system** — Arch-based ISO with Limine + btrfs + snapper

### Part 2: Build Tacharchy UX (Desktop Layer)

Tacharchy now owns its desktop direction instead of depending on DMS:

- **Own shell direction** — launcher, bar, lock flow, notifications, and app menu under Tacharchy control
- **Compositor-agnostic approach** — support multiple Wayland compositors without tying the project to one external shell ecosystem
- **Theme pipeline we control** — wallpaper / seed-color driven theming integrated on our terms
- **Installer-first UX** — the first-boot flow becomes the place where shell and app choices are assembled

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
- Theme Composer direction for **GTK + Qt + TUI** consistency
- 19 pre-built themes (Tokyo Night, Nord, Rose Pine, Gruvbox, Catppuccin, etc.)
- Dark orange Tacharchy default (τ logo, "Fast Freedom")
- Hot-reload system — change wallpaper, entire desktop updates

### 🔧 **Compositor Freedom**
- Hyprland, Sway, MangoWC, labwc, Scroll, Miracle WM, and other sane Wayland targets
- Or go minimal with just a compositor plus Tacharchy tooling
- Your choice — nothing forced

### 📦 **Clean Architecture**
- Fork Omarchy where it helps (installer, hardware, migrations)
- Own the Tacharchy desktop layer instead of outsourcing identity
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

- ❌ **Not** tied to DMS or any single external shell community
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

**This repository is past pure planning and into prototype foundation work.**

What already exists:
- ✅ Design philosophy and requirements
- ✅ Research on existing solutions
- ✅ Complete architecture specification
- ✅ Fork strategy (Omarchy) and independent Tacharchy direction
- ✅ 8 performance tuning packages
- ✅ Forked installer baseline
- ✅ Initial Tacharchy CLI (`status`, `benchmark`, `migrate`)
- ⏳ Desktop integration and clean-install validation

**What happens next?**
- Validate the installer flow on a clean Arch VM
- Stabilize the Tacharchy-controlled desktop layer and core features
- Keep tightening docs so they match the real implementation
- Then build the cross-surface Theme Composer on top of that stable base

---

## 🤝 Contributing

**Currently:** Prototype foundation work, validation, and doc cleanup.

**Upcoming:** Clean-install testing, Tacharchy desktop-layer design, and installer polish.

**Important:** Tacharchy is no longer built around DMS. The project owns its own desktop direction.

---

## 🎯 Who Is This For?

- ✅ Linux users who want a fast, beautiful desktop
- ✅ People who care about performance tuning
- ✅ Users who value FOSS software and transparency
- ✅ Anyone who wants their desktop to feel smooth and responsive
- ✅ People who like Material You theming
- ✅ Users who want compositor freedom (Hyprland, Sway, labwc, etc.)

---

## 🎨 Design Principles

1. **Performance tuning is the core value** — everything else should serve that
2. **We give back your freedom** — compositor, shell, theme, apps: your choice
3. **No bullshit** — no censorship, no politics, no gatekeeping
4. **Don't reinvent blindly** — fork Omarchy where it helps, own the Tacharchy-specific UX
5. **Everything documented with reasoning** — every sysctl, every fix, every choice
6. **Everything reversible** — one command to remove all traces
7. **Own the identity layer** — shell, theming path, and UX should be under Tacharchy control

---

## 🗺️ Roadmap Highlights

### Phase 1: Foundation (Arch Linux)
- ✅ Performance tuning packages (8 AUR packages)
- ✅ Forked Omarchy installer baseline
- ✅ Added Tacharchy CLI foundation (`status`, `benchmark`, `migrate`)
- ⏳ Clean-install validation in VM / real hardware
- ⏳ Build the Tacharchy-owned desktop layer and theme pipeline
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
<strong>Fork Omarchy where it helps. Own the UX. Add performance tuning. Simple.</strong>
</p>
