# Tacharchy

<h3 align="center">ταχύς + ἀναρχία — Fast Freedom</h3>

<p align="center">
  <img src="https://img.shields.io/badge/color-dark_orange-FF6B00?style=for-the-badge" alt="Dark Orange">
</p>

<p align="center">
  <strong>A performance-first Linux layer that gives back your freedom.</strong>
</p>

<p align="center">
  <a href="https://tacharchy.com">Website</a> ·
  <a href="https://tacharchy.rip">tacharchy.rip</a> ·
  <a href="https://github.com/imrightguy/tacharchy/discussions">Discussions</a>
</p>

---

## What is Tacharchy?

Tacharchy makes your Linux system run optimally — and gives back your freedom.

The Linux desktop ecosystem has a gap:

- **Plain distros** give you freedom but zero opinions — you spend days tuning sysctls, audio, scheduling, and GPU setup
- **Opinionated distros** give you a polished setup but force their choices — apps, compositor, politics
- **Dotfile setups** give you beautiful desktops but are fragile and don't touch the performance layer

Tacharchy fills the gap: **opinionated about performance, gives back your freedom.**

## The Three Layers

### 🔧 Foundation (always applied)

System-level tuning you shouldn't have to think about:

- **CPU scheduling** — hybrid core awareness (P-cores / E-cores), per-core EPP tuning
- **Audio pipeline** — PipeWire realtime priority, RT scheduling, OOM protection
- **GPU setup** — NVIDIA DRM modeset, VRAM management, compositor optimization
- **Network** — BBR congestion control, ring buffer sizing, backlog tuning
- **I/O** — per-device scheduler selection (NVMe→none, SSD→mq-deadline, HDD→bfq)
- **Memory** — swap management, dirty page tuning, VFS cache optimization
- **Filesystem** — fstrim, mount options, btrfs snapshot configuration
- **Security basics** — firewall (opt-in), kernel hardening

### 🖥️ Desktop (you choose)

First-run wizard presents options — nothing is forced:

- **Compositor**: niri, Hyprland, Sway, labwc, river, Wayfire, dwl, GNOME, KDE
- **Shell**: DankMaterialShell, Waybar, or none
- **Theme**: 19+ themes with dynamic color generation (wallpaper → entire desktop)
- **Apps**: opt-in bundles — communication, media, office, dev, gaming

### 🎨 Theming (you choose)

- Material Design 3 color palette generation from any wallpaper
- Consistent colors across terminal, editor, compositor, bar, and apps
- Per-app theme configs: neovim, VS Code, btop, Chromium, Waybar
- Light and dark mode support

## Status

🚧 **Early development.** Currently in research and planning phase.

We're forking and studying [Omarchy](https://github.com/basecamp/omarchy) (installer framework, hardware detection, theming) and [DankLinux](https://github.com/AvengeMedia/DankLinux) (cross-distro package infrastructure) to build on what works.

### What we're building vs. forking

| Component | Approach |
|---|---|
| Performance tuning layer | **Building new** — our core value, nobody else does this |
| Installer framework | Fork from Omarchy, decouple from Hyprland |
| Hardware detection | Fork from Omarchy — excellent per-vendor support |
| Theme system | Fork from Omarchy — colors.toml format, compositor-agnostic |
| Compositor configs | **Building new** — niri, Hyprland, Sway, labwc, river, Wayfire, dwl |
| User choice wizard | **Building new** |
| Cross-distro builds | Adapt from DankLinux (for future phases) |

## Philosophy

1. **Performance tuning is the core value** — everything else is secondary
2. **We give back your freedom** — user chooses their stack. No forced apps, compositor, or desktop shell.
3. **No censorship, no politics in the project** — we ship code, not ideological gatekeeping
4. **Everything documented with reasoning** — if we set a sysctl value, we explain why
5. **Everything reversible** — one command to remove all traces
6. **Start narrow, expand carefully** — Arch-only until solid, then more distros

## Roadmap

- [x] Research: CachyOS tuning, Omarchy architecture, DankLinux model
- [x] Define vision, principles, and scope
- [x] Fork Omarchy and DankLinux for study
- [ ] Phase 1a: Build performance tuning packages
- [ ] Phase 1b: Build installer (fork Omarchy)
- [ ] Phase 1c: Build theming system (fork Omarchy)
- [ ] Phase 1d: Multi-compositor support
- [ ] Phase 1e: Polish and release

See [ROADMAP.md](ROADMAP.md) for the full plan.

## Name

**Tacharchy** — from Greek *ταχύς* (tachys, "swift, fast") + *ἀναρχία* (anarchia, "without rulers, self-governance").

Fast freedom. Performance that gives back your freedom.

## License

MIT

---

<p align="center">
  <sub>RIP bloat. Your system, your choice.</sub>
</p>
