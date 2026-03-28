# Roadmap

## Phase 0: Research & Planning ✅

- [x] Analyze CachyOS tuning (sysctls, kernel patches, scheduler)
- [x] Analyze Omarchy architecture (install scripts, config layer, theming, hardware detection)
- [x] Analyze DankLinux/DMS architecture (Quickshell shell, Go backend, cross-distro, multi-compositor, plugins)
- [x] Define project vision: fork DMS + Omarchy, add performance tuning layer
- [x] Name: **Tacharchy** (project), **TMS** (Tacharchy Material Shell, forked from DMS)
- [x] Fork Omarchy and DankLinux/DMS for study
- [x] Deep-dive both repo structures, catalog wins/losses/gaps
- [x] Create GitHub repo with README, BRAND.md, LICENSE
- [x] Write tuning reference docs (sysctl, cpu, gpu, audio, network, io)
- [x] Build Phase 1a: 8 AUR performance tuning packages

## Phase 1: Foundation (Arch Linux)

### 1a: Performance Tuning Packages ✅

Our unique value — neither Omarchy nor DMS touches system performance tuning.

- [x] `tacharchy-sysctl` — kernel parameter tuning with documented reasoning
- [x] `tacharchy-audio` — PipeWire realtime scheduling, CPU affinity
- [x] `tacharchy-gpu` — NVIDIA/AMD/Intel driver optimizations
- [x] `tacharchy-network` — BBR congestion control, NIC tuning
- [x] `tacharchy-io` — I/O scheduler auto-detection (NVMe/SSD/HDD)
- [x] `tacharchy-cpu` — Intel hybrid P/E core tuning, AMD preferred cores
- [x] `tacharchy-detect` — hardware detection and recommendation engine
- [x] `tacharchy-foundation` — meta-package

### 1b: Fork DMS → TMS

Fork DankMaterialShell, rebrand as TMS, maintain plugin API compatibility.

- [ ] Fork DankMaterialShell repo
- [ ] Rebrand: DMS → TMS (logo, colors, CLI name)
- [ ] Ensure DMS plugin API compatibility (all existing plugins work)
- [ ] Port `dms` Go CLI → `tacharchy` CLI with our subcommands added
- [ ] Port TUI installer (`dankinstall` → `tacharchy install`)
- [ ] Integrate Omarchy's hardware detection into the installer
- [ ] Integrate performance tuning package installation into the installer
- [ ] Add `tacharya status` — show current tuning state
- [ ] Add `tacharya benchmark` — before/after performance comparison
- [ ] Add `tacharya migrate` — Omarchy-style timestamp-based migrations
- [ ] Test on clean Arch install (VM first, then real hardware)

### 1c: Fork Omarchy Hardware Detection

Port Omarchy's per-vendor hardware detection scripts into the Go backend.

- [ ] Intel detection (CPU, GPU, WiFi 7, IPU camera, LPMD, thermald, PTL kernel)
- [ ] NVIDIA detection (GPU arch: Turing+ vs legacy, correct driver, KMS, env vars)
- [ ] AMD detection (GPU, preferred cores, video accel)
- [ ] Apple T2 detection (SPI keyboard, suspend NVMe, T2 audio)
- [ ] ASUS ROG detection (audio mixer, mic, keyboard RGB)
- [ ] Framework detection (F13 AMD audio, QMK HID)
- [ ] Dell XPS detection (haptic touchpad, PTL display)
- [ ] Surface detection (keyboard fix)
- [ ] Broadcom WiFi, Tuxedo backlight, Synaptic touchpad, YT6801 ethernet

### 1d: Theme System

Dual engine: matugen (dynamic from wallpaper) + colors.toml (static from Omarchy).

- [ ] Port Omarchy's 19 colors.toml themes
- [ ] Ensure matugen dynamic theming works through TMS
- [ ] Create Tacharchy default theme (dark orange brand)
- [ ] Per-app theme configs: neovim, VS Code, btop, Chromium, ghostty, kitty, alacritty
- [ ] Light/dark mode support
- [ ] Hot-reload system (`tacharya refresh-*`)

### 1e: App Ecosystem

Port Omarchy's app configs and webapp system.

- [ ] Per-app config templates (ghostty, kitty, alacritty, waybar, tmux, lazygit, fastfetch, starship)
- [ ] Webapp system (install web apps as desktop entries with custom icons)
- [ ] Hidden desktop entries (clean up launchers)
- [ ] Custom desktop icons
- [ ] Screenshot/screen recording integration
- [ ] Clipboard management (cliphist)

### 1f: Polish & Release

- [ ] AUR repository setup (GPG key, repo host, CI/CD)
- [ ] Documentation site (tacharchy.com)
- [ ] Install script live (curl tacharchy.sh | sh)
- [ ] Screenshots for each compositor + theme combo
- [ ] CONTRIBUTING.md final polish
- [ ] `tacharya remove` — clean uninstall
- [ ] Release v0.1.0-alpha
- [ ] Announce on Reddit, forums, Discord

## Phase 2: Cross-Distro

- [ ] Fedora support (COPR)
- [ ] Debian support (OBS)
- [ ] Ubuntu support (PPA / Launchpad)
- [ ] openSUSE support (OBS / zypper)

## Phase 3: Extended Support

- [ ] Gentoo support (ebuild)
- [ ] NixOS support (flake / home-manager)
- [ ] Snapshot/rollback system (Limine + snapper)

## Phase 4: ISO Images

- [ ] Arch-based ISO with Tacharchy pre-installed
- [ ] Calamares or custom installer integration

## Phase 5: Kernel

- [ ] Custom kernel packages (BORE/EEVDF scheduler patches)
- [ ] Kernel module hook integration

## Key Principles (Non-Negotiable)

1. **Performance tuning is the core value** — everything else is borrowed and improved
2. **We give back your freedom** — compositor, shell, theme, apps: your choice
3. **No bullshit** — no censorship, no politics, no gatekeeping
4. **Don't reinvent** — fork what works, improve what doesn't, build only what's missing
5. **Everything documented with reasoning** — every sysctl, every fix, every choice
6. **Everything reversible** — one command to remove all traces
7. **Plugin compatible** — DMS plugins work out of the box
8. **Wayland only** — no X11 support
