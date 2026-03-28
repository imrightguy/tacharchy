# Tacharchy

<h3 align="center">ταχύς + ἀναρχία — Fast Freedom</h3>

<p align="center">
  <img src="https://img.shields.io/badge/color-dark_orange-FF6B00?style=for-the-badge" alt="Dark Orange">
</p>

<p align="center">
  <strong>Performance-tuned Linux desktop. Fork what works, improve what doesn't, build only what's missing.</strong>
</p>

<p align="center">
  <a href="#what-is-tacharchy">About</a> ·
  <a href="#install">Install</a> ·
  <a href="ROADMAP.md">Roadmap</a> ·
  <a href="docs/ARCHITECTURE.md">Architecture</a> ·
  <a href="CONTRIBUTING.md">Contributing</a>
</p>

---

## What is Tacharchy?

Tacharchy is a complete Linux desktop environment built on three pillars:

- **[DankLinux/DMS](https://github.com/AvengeMedia/DankMaterialShell)** — Quickshell-based desktop shell, Go backend, cross-distro packaging, multi-compositor support, plugin system
- **[Omarchy](https://github.com/basecamp/omarchy)** — Hardware detection, migration system, theme library, app ecosystem
- **Performance tuning layer (original)** — sysctl, CPU scheduler, GPU, audio, network, I/O optimization

We don't reinvent. We take what works from the best projects, improve what's broken, and fill the gaps nobody else fills.

**TMS (Tacharchy Material Shell)** is our desktop shell, forked from DMS with full plugin compatibility.

## Install

```bash
curl -fsSL https://install.tacharchy.com | sh
```

One command. Detects your distro, hardware, and guides you through setup.

Currently supports: Arch Linux. Fedora, Debian, Ubuntu, openSUSE coming soon.

## What You Get

### Performance Tuning (our unique value)

System-level tuning nobody else provides:

- **CPU** — Intel hybrid P/E core awareness, per-core EPP tuning, AMD preferred cores
- **Audio** — PipeWire realtime priority, CPU affinity, OOM protection
- **GPU** — NVIDIA/AMD/Intel driver optimization, compositor-specific fixes
- **Network** — BBR congestion control, NIC ring buffers, backlog tuning
- **I/O** — Auto-detected scheduler (NVMe→none, SSD→mq-deadline, HDD→bfq)
- **Memory** — Swap management, dirty page tuning, VFS cache optimization

Every value documented with reasoning. See `docs/` for the full reference.

### Desktop Shell (TMS)

Forked from DMS. Replaces waybar + swaylock + swayidle + mako + fuzzel + polkit with one unified shell:

- Dynamic Material You theming from any wallpaper
- Control center (network, Bluetooth, audio, display, night mode)
- Spotlight launcher (apps, files, emojis, windows, calculator, commands)
- Smart notifications with grouping
- Media integration (MPRIS, calendar, weather, clipboard)
- Plugin system (DMS plugins work out of the box)

### Multi-Compositor

niri, Hyprland, Sway, MangoWC, labwc, Scroll, Miracle WM — your choice.

### Hardware Detection

Per-vendor, per-model fixes: Intel, NVIDIA, AMD, Apple T2, ASUS ROG, Framework, Dell XPS, Surface, Broadcom, Tuxedo.

### Cross-Distro (Phase 2+)

| Distro | Format | Status |
|---|---|---|
| Arch Linux | AUR | ✅ Phase 1 |
| Fedora | COPR | Phase 2 |
| Debian | OBS | Phase 2 |
| Ubuntu | PPA | Phase 2 |
| openSUSE | OBS | Phase 2 |

## CLI

```bash
tacharchy                          # Status overview
tacharchy install                  # TUI installer
tacharchy update                   # Update system
tacharchy detect                   # Hardware report
tacharchy theme set tokyo-night    # Apply theme
tacharchy theme set /path/to/wp    # Dynamic palette from wallpaper
tacharya status                    # Tuning state
tacharya benchmark                 # Before/after comparison
tacharya ipc call spotlight toggle # Programmatic control
tacharya doctor                    # Diagnostics
tacharya remove                    # Clean uninstall
```

## Philosophy

1. **Performance tuning is the core value** — everything else is borrowed and improved
2. **We give back your freedom** — compositor, shell, theme, apps: your choice
3. **No bullshit** — no censorship, no politics, no gatekeeping
4. **Don't reinvent** — fork what works, improve what doesn't, build only what's missing
5. **Everything documented with reasoning**
6. **Everything reversible** — one command to remove all traces
7. **Plugin compatible** — DMS plugins work out of the box
8. **Wayland only**

## Name

**Tacharchy** — from Greek *ταχύς* (tachys, "swift, fast") + *ἀναρχία* (anarchia, "without rulers, self-governance").

Fast freedom.

## Status

🚧 **Early development.** Phase 1a (performance tuning packages) complete. Forking DMS and Omarchy next.

## License

MIT

---

<p align="center">
  <sub>Don't reinvent. Improve.</sub>
</p>
