# Tacharchy Documentation

## Getting Started

- [README](../README.md) — Project overview and install
- [Architecture](ARCHITECTURE.md) — System design, what we fork, CLI reference
- [Roadmap](../ROADMAP.md) — Development phases and progress
- [Contributing](../CONTRIBUTING.md) — How to contribute

## Performance Tuning

Every value documented with reasoning, tradeoffs, and sources.

- [Sysctl Tuning](sysctl.md) — Memory, network, kernel, filesystem parameters
- [CPU Tuning](cpu.md) — Intel hybrid P/E cores, AMD preferred cores, governor/EPP
- [GPU Tuning](gpu.md) — NVIDIA, AMD, Intel driver optimizations
- [Audio Tuning](audio.md) — PipeWire realtime scheduling, CPU affinity, OOM protection
- [Network Tuning](network.md) — BBR congestion control, NIC ring buffers
- [I/O Tuning](io.md) — Scheduler auto-detection, fstrim, swap management

## Desktop

- [Compositors](COMPOSITORS.md) — Supported Wayland compositors, keybinds, shell integration
- [Theming](THEMING.md) — matugen dynamic themes, colors.toml static themes, per-app theming
- [Hardware Detection](HARDWARE.md) — Per-vendor fixes, GPU/CPU/audio/storage detection

## Brand

- [Brand Guide](../BRAND.md) — Colors, logo, typography, tagline
