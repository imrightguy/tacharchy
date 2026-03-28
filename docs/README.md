# Tacharchy Documentation

## Getting Started

- [Installation](INSTALL.md) — ISO, curl, and AUR installation methods
- [Architecture](ARCHITECTURE.md) — System design, what we fork, CLI reference
- [Roadmap](../ROADMAP.md) — Development phases and progress
- [Contributing](../CONTRIBUTING.md) — How to contribute
- [Packages](PACKAGES.md) — AUR package reference and file layout

## Performance Tuning

Every value documented with reasoning, tradeoffs, and sources.

- [Memory](memory.md) — Swap strategy (NVMe/ZRAM/HDD), dirty pages, VFS cache, HugePages
- [Sysctl](sysctl.md) — Memory, network, kernel, filesystem parameters
- [CPU](cpu.md) — Intel hybrid P/E cores, AMD preferred cores, governor/EPP tuning
- [GPU](gpu.md) — NVIDIA, AMD, Intel driver optimizations and fixes
- [Audio](audio.md) — PipeWire realtime scheduling, CPU affinity, OOM protection
- [Network](network.md) — BBR congestion control, NIC ring buffers
- [I/O](io.md) — Scheduler auto-detection, fstrim, TRIM

## Desktop

- [Compositors](COMPOSITORS.md) — Supported Wayland compositors, keybinds, shell integration
- [Theming](THEMING.md) — matugen theme engine, named themes, per-app theming, custom themes
- [Hardware Detection](HARDWARE.md) — Per-vendor fixes, GPU/CPU/audio/storage detection
- [Security](SECURITY.md) — Firewall, sudo, kernel hardening notes

## Brand

- [Brand Guide](../BRAND.md) — Colors, logo, typography, tagline
