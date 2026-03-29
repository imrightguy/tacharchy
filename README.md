```
╔═══════════════════════════════════════════════════════════════╗
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
╚═══════════════════════════════════════════════════════════════╝
```

![Status](https://img.shields.io/badge/status-design--phase-orange)
![Phase](https://img.shields.io/badge/phase-research--planning-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Arch](https://img.shields.io/badge/arch-linux-blue)
![FOSS](https://img.shields.io/badge/foss-defaults-brightgreen)

# Tacharchy: Linux System with Built-in Save/Restore

**Status:** 🎨 Design & Research Phase | **Target:** Linux users who value their time

---

## What Is Tacharchy?

**Tacharchy** is a complete Linux system with a built-in save/restore for your entire setup.

```
Part 1: Tacharchy ISO      → Complete Arch-based distro
Part 2: Universal Script   → Works on ANY Linux distro
Part 3: Profile System     → Save/restore everything (shared by both)
```

### The Problem

Reinstalling Linux takes forever:
- Remembering 200+ packages
- Reconfiguring compositors, terminals, themes
- Hunting down dotfiles from backups
- Setting up services, preferences, state
- **8+ hours to get back to work**

### The Solution

```bash
# Fresh install from Tacharchy ISO OR
# Add Tacharchy layer to any distro

# Save your setup anytime
tacharchy profile save my-dev-setup

# Reinstall from scratch

# Restore everything
tacharchy restore my-dev-setup

# 10 minutes later, you're back to work
```

**No more package hunting. No more config archaeology. No more wasted days.**

---

## 🎯 Two Ways to Use Tacharchy

### **Option 1: Tacharchy ISO** (Complete Arch System)

Boot the ISO, install a complete Arch-based distro:

```bash
# Flash USB, boot, install
# Choose: Basic | Dev | Gamer | Creative | Restore Profile | Custom

# What you get (Basic):
✓ Arch Linux + Hyprland/Niri + DMS desktop shell
✓ FOSS browser (Chromium), password manager (KeePassXC)
✓ Messengers (Telegram, WhatsApp), code viewer (Opencode)
✓ Everything FOSS, no proprietary surprises
✓ System works immediately
```

**Best for:** Fresh installs, new PCs, bare metal, complete system wipes

### **Option 2: Universal Installer** (Any Distro)

Already running Linux? Add Tacharchy layer on top:

```bash
curl -fsSL https://install.tacharchy.com | sh

# Works on: Ubuntu, Fedora, Debian, Arch, Manjaro, EndeavourOS, etc.
# Detects your distro, adapts package manager
# Installs Tacharchy layer + profile system
```

**Best for:** Testing without wiping, adding to working systems, non-Arch distros

---

## ✨ What Makes Tacharchy Different

### 🎯 **FOSS Defaults, No Surprises**
- Chromium (not Chrome)
- KeePassXC (not 1Password)
- Telegram, WhatsApp Desktop
- Opencode (code viewer)
- **Everything open source by default**

### 🔄 **Portable Profiles**
- Save on Arch → Restore on Fedora ✓
- Save on desktop → Restore on laptop ✓
- Save on NVIDIA → Restore on AMD ✓
- **Profiles work across all delivery methods and hardware**

### 🛡️ **Safe by Design**
- Automatic backups before restore
- Dry-run mode (see what changes before applying)
- Rollback if anything breaks
- Clear warnings, no silent destruction

---

## 🚀 Quick Feature Overview

| Feature | Description |
|---------|-------------|
| **Complete Arch Distro** | Tacharchy ISO: Arch + Omarchy installer + DMS + profile system |
| **Universal Installer** | Works on ANY Linux distro (Ubuntu, Fedora, Debian, Arch, etc.) |
| **Profile System** | Save/restore entire system state (packages, configs, services, preferences) |
| **FOSS Defaults** | Basic install: Chromium, KeePassXC, Telegram, WhatsApp, Opencode |
| **Preset Profiles** | Dev (nvim, git, docker), Gamer (Steam, Lutris), Creative (Blender, Krita) |
| **Hardware-Agnostic** | Profiles work across different machines, GPUs, monitor setups |
| **DMS Integration** | Uses DankMaterialShell desktop shell (consumed as-is, not forked) |

---

## 🎮 The "Skill Tree" Philosophy

> "Like Path of Exile's skill tree: dead simple at first glance, endlessly deep when you look closer."

**Level 1:** `tacharchy restore my-setup` → Done. System back.

**Level 2:** Custom disk layouts, multiple profiles, compositor switching

**Level 3:** Custom ISO generation, hooks, credential automation, profile sharing

**You never see Level 2/3 unless you ask.**

---

## 📁 The Three Parts

```
┌─────────────────────────────────────────────────────────────┐
│                    TACHARCHY SYSTEM                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Part 1: Tacharchy ISO (Arch-based Distro)               │
│  ├── Forked Omarchy installer                             │
│  ├── DMS desktop shell integrated                        │
│  ├── Profile system built-in                                │
│  └── Arch-specific optimizations                           │
│                                                             │
│  Part 2: Universal Installer Script                         │
│  ├── Works on ANY Linux distro                             │
│  ├── Detects distro, adapts package manager               │
│  ├── Installs Tacharchy layer on top                        │
│  └── Profile system built-in                                │
│                                                             │
│  Part 3: Profile System (Shared by both)                    │
│  ├── Save current setup as profile                         │
│  ├── Restore from profile (on any distro)                    │
│  ├── Portable across all delivery methods                     │
│  └── Hardware-agnostic                                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🎯 What Tacharchy Is NOT

- ❌ **Not** NixOS — We use vanilla Arch, KISS principle
- ❌ **Not** just a restore tool — It's a complete system (ISO) OR layer (script)
- ❌ **Not** just dotfiles — We capture packages, services, state, preferences
- ❌ **Not** forking DMS — We consume DankMaterialShell as-is, extend via plugins
- ❌ **Not** Arch-only — Universal installer works on ANY distro

---

## 📚 Documentation

| Document | What It Covers |
|----------|----------------|
| **[COMPLETE-ARCHITECTURE.md](COMPLETE-ARCHITECTURE.md)** | Full 3-part architecture, install flows, package abstraction |
| **[DESIGN.md](DESIGN.md)** | Core philosophy, rules, anti-patterns |
| **[DESIGN-DIRECTION.md](DESIGN-DIRECTION.md)** | FOSS defaults, install flows, package decisions |
| **[research.md](research.md)** | Comprehensive research (Chezmoi, yadm, archinstall, Timeshift, Nix comparison) |
| **[RESEARCH-OMARCHY.md](RESEARCH-OMARCHY.md)** | Omarchy launcher/installer analysis |
| **[DANKLINUX-INSTALLER-ANALYSIS.md](DANKLINUX-INSTALLER-ANALYSIS.md)** | Safety patterns, backups, UI design |
| **[CURRENT-SYSTEM-MODEL.md](CURRENT-SYSTEM-MODEL.md)** | Reference system (179 packages, 4GB configs) |

---

## 🚧 Current Status

**This repository is in the design and research phase.**

No implementation code exists yet. This is a knowledge base capturing:
- ✅ Design philosophy and requirements
- ✅ Research on existing solutions
- ✅ Complete architecture specification
- ✅ Integration approach (Omarchy + DMS)
- ✅ Safety patterns from DankLinux installer
- ⏳ Implementation (not started)

**When will implementation begin?**
- Architecture is complete
- Design decisions are documented
- Looking for community feedback before writing code

---

## 🤝 Contributing

**Currently:** Design feedback and discussion welcome!

**Upcoming:** Implementation planning will begin after design phase locks.

**Important:** We do NOT fork DMS (DankMaterialShell) unless absolutely necessary. Extend through plugins first.

---

## 🎯 Who Is This For?

- ✅ Linux users who reinstall frequently (any distro)
- ✅ People who tinker with their setup and break things
- ✅ Developers who want reproducible environments
- ✅ Users who value FOSS software and transparency
- ✅ Anyone who's ever spent days getting their system back after a reinstall
- ✅ People who want to try different distros but keep their setup

---

## 📊 Quick Stats (Reference System)

Based on Christopher's Omarchy setup (the model):
- **179 packages** explicitly installed
- **4GB** of dotfiles and configs
- **NVIDIA** GPU, multi-monitor setup
- **Restoration target:** ~10 minutes (vs. 8+ hours manual)

---

## 🎨 Design Principles

1. **Simple first, complex never** — Level 1 just works, deeper features opt-in
2. **Respect the user's time** — No blocking prompts for deferrable things
3. **Don't defuse the bomb** — Never interrupt important work
4. **Progressive disclosure** — Show options when asked, hide by default
5. **Durable by default** — Everything important lives off root filesystem
6. **Arch-first, not Arch-only** — Vanilla Arch, portable principles
7. **Clean integration** — Tacharchy adds alongside, never patches base system

---

## 🗺️ Roadmap

### Phase 1: Core Profile System (MVP)
- [ ] Profile save (packages, configs, services, state)
- [ ] Profile restore (with backups, warnings, rollback)
- [ ] Dry-run mode
- [ ] Profile list/delete

### Phase 2: Tacharchy ISO (Arch Distro)
- [ ] Fork Omarchy installer
- [ ] Integrate DMS desktop shell
- [ ] Add Tacharchy branding
- [ ] Build ISO with archiso
- [ ] Test in VM

### Phase 3: Universal Installer (Multi-Distro)
- [ ] Detect distro (Ubuntu, Fedora, Debian, Arch)
- [ ] Adapt package manager (apt, dnf, pacman, zypper)
- [ ] Map packages to distro equivalents
- [ ] Install DMS (if compatible) or skip
- [ ] Deploy compatible configs

### Phase 4: Advanced Features
- [ ] Package browser (search repos)
- [ ] Profile inheritance (base + customizations)
- [ ] Profile versioning
- [ ] Profile sharing (export/import)
- [ ] Community profiles

---

## 💡 Why "Tacharchy"?

**Tachy-** (speed) + **-archy** (Arch Linux)

Speed of restoration + Arch Linux philosophy = Tacharchy

Also sounds cool.

---

## 📝 License

MIT License — See [LICENSE](LICENSE) file.

---

## 🌟 Star Us If...

- You've ever spent days reinstalling Linux
- You believe in FOSS defaults
- You want portable Linux setups
- You want to try different distros without losing your setup
- You like the idea of 10-minute restoration vs 8-hour setups

**Star the repo to follow progress!** ⭐

---

<p align="center">
<strong>Tacharchy — Linux system with built-in save/restore for your entire setup.</strong><br>
<strong>Complete Arch distro OR universal layer on any distro. Your choice.</strong>
</p>
