# Roadmap

## Phase 0: Research & Planning ✅

- [x] Analyze CachyOS tuning (sysctls, kernel patches, scheduler)
- [x] Analyze Omarchy architecture (install scripts, config layer, theming)
- [x] Analyze DankLinux model (cross-distro repo, DMS, installer)
- [x] Analyze dotfile ecosystem (ML4W, HyDE, End-4, etc.)
- [x] Define project vision and principles
- [x] Decide Phase 1 scope (Arch-only)
- [x] Name: Tacharchy
- [x] Fork Omarchy and DankLinux for study
- [x] Study both repo structures in detail
- [x] Create GitHub repo with README, BRAND.md, LICENSE

## Phase 1a: Performance Layer (Build New)

Our unique value — neither Omarchy nor DankLinux touches system performance tuning.

### Packages to create:

#### `tacharchy-sysctl`
System-level kernel parameter tuning with documented reasoning for every value.

```bash
# Values from CachyOS research, with explanations
vm.swappiness = 100              # Swap on fast NVMe — kernel formula says >=100 when swap >= filesystem speed
vm.vfs_cache_pressure = 50       # Less aggressive VFS cache reclaim = faster file ops
vm.dirty_bytes = 268435456       # 256MB — limits dirty data per process, prevents I/O spikes
vm.dirty_background_bytes = 67108864  # 64MB — background flush threshold
vm.page-cluster = 0              # Disable swap readahead — NVMe doesn't need it
vm.dirty_writeback_centisecs = 1500  # 15s dirty page flush interval (vs 5s default)
kernel.nmi_watchdog = 0          # Disable watchdog — slight perf gain, less power
kernel.printk = 3 3 3 3          # Reduce kernel log noise
fs.inotify.max_user_instances = 1024   # More inotify watches for file watchers
fs.inotify.max_user_watches = 524288
net.core.netdev_max_backlog = 4096     # Network backlog
fs.file-max = 2097152                  # Max open files
```

#### `tacharchy-audio`
PipeWire realtime scheduling and priority tuning.

```bash
# /etc/security/limits.d/20-tacharchy-audio.conf
@audio - rtprio 99
@audio - memlock unlimited

# systemd user service overrides for PipeWire
[Service]
OOMScoreAdjust=-1000
MemoryMin=32M
```

#### `tacharchy-gpu`
GPU-specific driver optimizations.

```bash
# NVIDIA: DRM modeset, VRAM management
# AMD: OverDrive, power saving
# Intel: video acceleration, IPU camera support
# Detects GPU at install time, applies appropriate config
```

#### `tacharchy-network`
Network stack tuning.

```bash
# BBR congestion control
net.ipv4.tcp_congestion_control = bbr
# NIC ring buffers (detected per-interface)
# Larger netdev_max_backlog
```

#### `tacharchy-io`
I/O scheduler udev rules.

```bash
# NVMe → none (correct for modern NVMe)
# SSD → mq-deadline
# HDD → bfq
# Auto-detected by drive type
```

#### `tacharchy-cpu`
CPU and scheduler tuning.

```bash
# Intel HWP: powersave governor + performance EPP on P-cores
# AMD: preferred cores enablement
# Hybrid core detection and per-core EPP tuning
# User session pinned to P-cores via systemd AllowedCPUs
```

#### `tacharchy-foundation` (meta-package)
Depends on all the above. Single install to get everything.

#### `tacharchy-detect`
Hardware detection script. Fork from Omarchy, extended with:

- CPU type detection (Intel hybrid P/E, AMD preferred cores)
- GPU detection (NVIDIA, AMD, Intel — with version checks)
- Audio hardware (PCI latency for sound cards)
- Storage detection (NVMe power management, TRIM)
- Display detection (multi-monitor, VRR support)
- Peripherals (keyboard layout, touchpad, Bluetooth)
- Applies appropriate tacharchy-* package configurations

### AUR Repository Setup
- GPG signing key
- Repo build infrastructure
- PKGBUILD templates for all packages
- CI/CD for automated builds

## Phase 1b: Installer (Fork Omarchy)

Adapt Omarchy's `boot.sh` → `install.sh` framework:

- [ ] Remove Omarchy branding, add Tacharchy branding
- [ ] Remove forced Hyprland dependency
- [ ] Remove forced package list (~150 packages)
- [ ] Add compositor selection step
- [ ] Add optional app bundles (not forced)
- [ ] Add theme selection step
- [ ] Add performance layer installation step (Phase 1a packages)
- [ ] Adapt hardware detection for our GPU/CPU/audio tuning
- [ ] Create migration system for rolling updates
- [ ] Test on clean Arch install (VM first, then real hardware)

### Install flow:
```
curl tacharchy.sh | sh
  → Preflight checks (Arch, sudo, network)
  → Hardware detection
  → Install foundation packages (tacharchy-foundation)
  → Compositor selection (niri, Hyprland, Sway, labwc, etc.)
  → Desktop shell selection (DMS, Waybar, none)
  → Theme selection
  → Optional app bundles
  → Apply configs
  → Post-install (first-run wizard)
```

## Phase 1c: Theming (Fork Omarchy)

Adapt Omarchy's theme system:

- [ ] Fork colors.toml format and theme application engine
- [ ] Make theme application compositor-agnostic (not just Hyprland)
- [ ] Create Tacharchy default theme (dark orange brand)
- [ ] Support all 19 Omarchy themes as compatibility
- [ ] Per-app theme configs: neovim, VS Code, btop, Chromium, Waybar, ghostty
- [ ] Dynamic theming: wallpaper → auto-generate entire desktop palette
- [ ] Light/dark mode support

### Theme format:
```toml
[colors]
wallpaper = "path/to/wallpaper.jpg"
primary = "#FF6B00"
secondary = "#1a1a2e"
surface = "#0d1117"
text = "#FFFFFF"
muted = "#8b949e"
accent = "#FF8C33"

[fonts]
mono = "JetBrainsMono Nerd Font"
sans = "Inter"
```

## Phase 1d: Multi-Compositor Support

Create config templates for each compositor:

- [ ] **niri** — config.kdl with theme integration
- [ ] **Hyprland** — hyprland.conf with theme integration
- [ ] **Sway** — config with theme integration
- [ ] **labwc** — rc.xml with theme integration
- [ ] **river** — init with theme integration
- [ ] **Wayfire** — wf-config.ini with theme integration
- [ ] **dwl** — config.h patch with theme integration

Each template includes:
- Theme colors applied (border, background, text)
- Keybind defaults (consistent across compositors where possible)
- Integration with selected desktop shell (Waybar/DMS)
- Bar/panel configuration
- Notifications
- Screenshot/recording shortcuts

## Phase 1e: Polish & Release

- [ ] Documentation site (tacharchy.com)
  - Installation guide
  - Tuning explanations (why each sysctl value)
  - Compositor guides
  - Theme gallery
  - FAQ
- [ ] Install script live (curl tacharchy.sh | sh)
- [ ] AUR repository live
- [ ] Screenshots for each compositor + theme combo
- [ ] README final polish
- [ ] CONTRIBUTING.md
- [ ] Release v0.1.0-alpha
- [ ] Announce on Reddit, forums, Discord

## Future Phases (Not Now)

- Phase 2: Fedora support (COPR)
- Phase 3: Debian/Ubuntu support (PPA)
- Phase 4: openSUSE support (OBS)
- Phase 5: ISO images
- Phase 6: Custom kernel packages (BORE-patched)
- Phase 7: KWin + niri tiling engine (long-term vision)

## Key Principles (Non-Negotiable)

1. Performance tuning is the core value — everything else is secondary
2. We give back your freedom — user chooses their stack
3. No censorship, no politics in the project
4. Everything documented with reasoning
5. Everything reversible
6. Start narrow (Arch), expand when solid
7. Fork existing work where it makes sense — don't reinvent
