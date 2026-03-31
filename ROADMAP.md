# Roadmap

## Phase 0: Research & Planning ✅

- [x] Analyze CachyOS tuning (sysctls, kernel patches, scheduler)
- [x] Analyze Omarchy architecture (install scripts, config layer, theming, hardware detection)
- [x] Analyze external shell ecosystems (including DMS) for lessons, wins, and traps
- [x] Define project vision: fork Omarchy where useful, own the Tacharchy desktop layer, add performance tuning
- [x] Name: **Tacharchy** — its own project and UX direction
- [x] Fork Omarchy for study
- [x] Deep-dive Omarchy repo structure, catalog wins/losses/gaps
- [x] Create GitHub repo with README, BRAND.md, LICENSE
- [x] Write tuning reference docs (sysctl, cpu, gpu, audio, network, io)
- [x] Build Phase 1a: 8 AUR performance tuning packages

## Phase 1: Foundation (Arch Linux)

### 1a: Performance Tuning Packages ✅

Our unique value — the desktop world is full of shells, but almost nobody touches system performance tuning properly.

- [x] `tacharchy-sysctl` — kernel parameter tuning with documented reasoning
- [x] `tacharchy-audio` — PipeWire realtime scheduling, CPU affinity
- [x] `tacharchy-gpu` — NVIDIA/AMD/Intel driver optimizations
- [x] `tacharchy-network` — BBR congestion control, NIC tuning
- [x] `tacharchy-io` — I/O scheduler auto-detection (NVMe/SSD/HDD)
- [x] `tacharchy-cpu` — Intel hybrid P/E core tuning, AMD preferred cores
- [x] `tacharchy-detect` — hardware detection and recommendation engine
- [x] `tacharchy-foundation` — meta-package

### 1b: Fork Omarchy Installer ✅

Fork Omarchy's installer system for Tacharchy, adapting branding and integrating performance tuning.

- [x] Create installer/ directory structure with modular phases
- [x] Fork helpers/ phase (all.sh, chroot.sh, presentation.sh, errors.sh, logging.sh)
- [x] Fork preflight/ phase (guard, pacman, migrations, show-env)
- [x] Fork packaging/ phase (base.sh with tacharchy-foundation integration)
- [x] Fork config/ phase (branding, tacharchy-detect integration)
- [x] Fork hardware detection scripts (Intel, NVIDIA, AMD, Apple, ASUS, Framework, Dell, Surface)
- [x] Fork login/ phase (sddm, limine-snapper, plymouth)
- [x] Fork post-install/ phase (finished, pacman, hibernation)
- [x] Create top-level boot.sh (curl installer) and install.sh (entry point)
- [x] Create Tacharchy branding (logo.txt with τ symbol, icon.txt)
- [x] Create tacharchy-base.packages (essential packages)
- [x] Replace all "omarchy" branding with "tacharchy"
- [x] Replace all "OMARCHY_" env vars with "TACHARCHY_"
- [x] Replace all paths (~/.local/share/omarchy → ~/.local/share/tacharchy)
- [x] Add tacharchy-foundation installation step in packaging phase
- [x] Add tacharchy-detect step in config phase

### 1c: Remove External Shell Dependency + Establish Tacharchy UX

Stop building Tacharchy around DMS. Keep the installer foundation, tuning layer, and hardware work; replace the shell dependency with Tacharchy-owned UX.

- [x] Add `tacharchy status` — show current tuning state
- [x] Add `tacharchy benchmark` — before/after performance comparison
- [x] Add `tacharchy migrate` — timestamp-based migrations
- [ ] Remove DMS packaging, migration, and installer assumptions
- [ ] Define Tacharchy shell / launcher / panel architecture
- [ ] Test on clean Arch install (VM first, then real hardware)

### 1d: Hardware Detection Refinement

Refine hardware detection with native Go implementation (building on forked Omarchy fixes).

- [ ] Intel detection (CPU, GPU, WiFi 7, IPU camera, LPMD, thermald, PTL kernel)
- [ ] NVIDIA detection (GPU arch: Turing+ vs legacy, correct driver, KMS, env vars)
- [ ] AMD detection (GPU, preferred cores, video accel)
- [ ] Apple T2 detection (SPI keyboard, suspend NVMe, T2 audio)
- [ ] ASUS ROG detection (audio mixer, mic, keyboard RGB)
- [ ] Framework detection (F13 AMD audio, QMK HID)
- [ ] Dell XPS detection (haptic touchpad, PTL display)
- [ ] Surface detection (keyboard fix)
- [ ] Broadcom WiFi, Tuxedo backlight, Synaptic touchpad, YT6801 ethernet

### 1e: Theme System

A Tacharchy-controlled theme pipeline: wallpaper or seed color → generated palette → semantic tokens → composed outputs for shell, GTK, Qt, and TUI surfaces.

- [ ] Build Tacharchy Theme Composer (shared semantic-token layer)
- [ ] Add GTK composer output
- [ ] Add Qt composer output
- [ ] Add TUI/terminal composer output
- [ ] Convert Omarchy's 19 themes to Tacharchy presets / seed colors
- [ ] Implement dynamic theming through Tacharchy-owned tooling
- [ ] Create Tacharchy default theme (dark orange brand)
- [ ] Per-app theme configs: neovim, VS Code, btop, Chromium, ghostty, kitty, alacritty
- [ ] Light/dark mode support
- [ ] Hot-reload system for shell + apps

### 1f: App Ecosystem

Port Omarchy's app configs and webapp system.

- [ ] Per-app config templates (ghostty, kitty, alacritty, waybar, tmux, lazygit, fastfetch, starship)
- [ ] Webapp system (install web apps as desktop entries with custom icons)
- [ ] Hidden desktop entries (clean up launchers)
- [ ] Custom desktop icons
- [ ] Screenshot/screen recording integration
- [ ] Clipboard management (cliphist)

### 1g: ISO & Installer

- [ ] Arch-based ISO with Tacharchy pre-installed (Limine bootloader)
- [ ] Snapshot/rollback system (Limine + snapper, btrfs)
- [ ] Boot from USB → auto-detect hardware → install
- [ ] AUR repository setup (GPG key, repo host, CI/CD)

### 1h: Polish & Release

- [ ] Install script live (curl tacharchy.sh | sh)
- [ ] Documentation site (tacharchy.com)
- [ ] Screenshots for each compositor + theme combo
- [ ] `tacharchy remove` — clean uninstall
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

## Phase 4: Kernel

- [ ] Custom kernel packages (BORE/EEVDF scheduler patches)
- [ ] Kernel module hook integration

## Key Principles (Non-Negotiable)

1. **Performance tuning is our unique contribution** — the piece nobody else provides, baked into a complete desktop
2. **We give back your freedom** — compositor, shell, theme, apps: your choice
3. **No bullshit** — no censorship, no politics, no gatekeeping
4. **Don't reinvent blindly** — fork Omarchy where it helps, own the missing Tacharchy pieces, avoid dependency traps
5. **Everything documented with reasoning** — every sysctl, every fix, every choice
6. **Everything reversible** — one command to remove all traces
7. **Own the identity layer** — Tacharchy should control its shell, theming path, and UX decisions
8. **Wayland only** — no X11 support
