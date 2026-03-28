# Installation

## Method 1: Omarchy ISO + Tacharchy (New System)

Boot from the [Omarchy ISO](https://github.com/basecamp/omarchy) to install Arch with Limine bootloader, btrfs, and snapper. Then run Tacharchy on top.

### Step 1: Install Arch via Omarchy ISO

1. Download the Omarchy ISO from [github.com/basecamp/omarchy](https://github.com/basecamp/omarchy)
2. Create a bootable USB:

```bash
sudo dd if=omarchy-arch-YYYY.MM-DD-x86_64.iso of=/dev/sdX bs=4M status=progress && sync
```

3. Boot from USB, run the Omarchy installer — this sets up:
   - Arch Linux base system
   - Limine bootloader (with btrfs snapshot support)
   - btrfs filesystem with snapper for rollback
   - Plymouth boot splash
4. Reboot into your new Arch system

### Step 2: Install Tacharchy

```bash
curl -fsSL https://install.tacharchy.com | sh
```

Tacharchy detects your hardware, installs TMS shell + performance tuning, applies theme. See Method 2 for full details.

### Rollback

Limine + snapper gives you snapshot/rollback out of the box:

```bash
tacharya snapshot              # Create a snapshot
tacharya snapshot rollback     # Roll back
tacharya snapshot list         # List snapshots
```

### Tacharchy ISO (Future)

Once Tacharchy is stable on real hardware, we'll snapshot a configured system and build our own ISO from it. No separate ISO builder — Omarchy's installer handles the Arch base.

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
