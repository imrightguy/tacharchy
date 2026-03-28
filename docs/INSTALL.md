# Installation

## Method 1: Omarchy ISO + Tacharchy (New System)

### Step 1: Base Install via Omarchy ISO

Boot the [Omarchy ISO](https://github.com/basecamp/omarchy) to install Arch with Limine bootloader, btrfs, and snapper. This is **Phase 1** — minimal and fast.

```bash
sudo dd if=omarchy-arch-YYYY.MM-DD-x86_64.iso of=/dev/sdX bs=4M status=progress && sync
```

Boot from USB, run Omarchy's installer (disk, user, timezone, keyboard), reboot.

### Step 2: First-Boot Configuration

On first login, the Tacharchy fullscreen installer launches automatically (**Phase 2**):

1. Welcome screen
2. Hardware detection (automatic)
3. Compositor selection
4. Desktop shell (TMS, Waybar, or none)
5. Theme (wallpaper or named theme)
6. Performance tuning
7. Optional apps
8. Done

This is the same experience whether you used the Omarchy ISO, the Tacharchy ISO, or installed Arch manually.

### Rollback

Limine + snapper gives you snapshot/rollback:

```bash
tacharya snapshot              # Create a snapshot
tacharya snapshot rollback     # Roll back
tacharya snapshot list         # List snapshots
```

### Tacharchy ISO (Future)

Our ISO will have Phase 1 pre-done — user boots directly into the fullscreen Phase 2 installer.

## Method 2: Install on Existing Arch

Already running Arch? Install Tacharchy on top:

```bash
curl -fsSL https://install.tacharchy.com | sh
```

Or clone and inspect first:

```bash
git clone https://github.com/imrightguy/tacharchy.git ~/.local/share/tacharchy
~/.local/share/tacharchy/install.sh
```

### What It Does

1. **Preflight** — checks you're on Arch, have sudo, network, and disk space
2. **Hardware detection** — identifies CPU, GPU, audio, storage, network, vendor-specific quirks
3. **Installs packages** — TMS shell, performance tuning layer, compositor, apps
4. **Applies tuning** — sysctls, I/O schedulers, CPU governor, audio RT priority, network BBR
5. **Configures compositor** — sets up your chosen compositor with theme colors and keybinds
6. **Applies theme** — matugen generates palette, applies to all apps
7. **First-run wizard** — timezone, keyboard layout, user preferences

### Flags

```bash
tacharchy install --compositor niri       # Skip selection, use niri
tacharchy install --compositor hyprland   # Use Hyprland
tacharchy install --shell tms             # Use TMS desktop shell
tacharchy install --shell none            # No desktop shell, just compositor
tacharchy install --theme tokyo-night     # Use named theme
tacharchy install --no-tuning             # Skip performance tuning
tacharchy install --minimal               # Compositor + tuning only, no extra apps
```

## Method 3: AUR Packages

Install just the performance tuning layer without the full desktop:

```bash
# Install all tuning packages
paru -S tacharchy-foundation

# Or install individually
paru -S tacharchy-sysctl tacharchy-cpu tacharchy-gpu tacharchy-audio tacharchy-network tacharchy-io tacharchy-detect
```

### TMS Shell

```bash
paru -S tms-shell-bin    # Stable release
paru -S tms-shell-git    # Git (nightly) build
```

## Post-Install

### Verify Everything Works

```bash
tacharya doctor          # Run diagnostics
tacharya detect          # Show hardware detection results
tacharya status          # Show tuning state
tacharya benchmark       # Run before/after comparison
```

### Common First Steps

```bash
tacharya theme set /path/to/wallpaper.jpg   # Set your wallpaper
tacharya config                               # Open config editor
tacharya snapshot                             # Create a baseline snapshot
```

## Uninstall

```bash
tacharya remove          # Remove all Tacharchy configs and packages
```

This removes:
- All `/etc/tacharchy/` configs
- All symlinks created by packages
- Performance tuning packages
- TMS shell
- Restores backed-up originals

Your compositor, apps, and personal files are not touched.

## System Requirements

### Minimum

- Arch Linux (fresh install or existing)
- 4GB RAM (8GB recommended)
- 20GB disk space (SSD recommended)
- UEFI firmware (no legacy BIOS support)

### Recommended

- 16GB+ RAM
- NVMe SSD
- Intel 12th gen+ or AMD Ryzen 5000+ CPU
- Dedicated GPU (NVIDIA Turing+, AMD RDNA)

## Troubleshooting

### Installer fails preflight

```bash
# Check distro
cat /etc/os-release

# Check sudo
sudo -v

# Check network
ping -c 1 archlinux.org
```

### Performance tuning not applying

```bash
tacharya status          # Check what's applied
tacharya doctor          # Run diagnostics
tacharya detect          # Check hardware detection
```

### Theme not applying

```bash
tacharya theme set /path/to/wallpaper.jpg  # Re-apply
tacharya refresh all                        # Force reload all apps
```

### Audio crackling

```bash
# Verify realtime scheduling
groups | grep audio       # Should show 'audio'
tacharya doctor           # Check audio status
```
