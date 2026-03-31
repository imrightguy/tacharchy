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
4. Desktop layer selection (Tacharchy shell, Waybar stack, or minimal)
5. Theme (wallpaper or named theme)
6. Performance tuning
7. Optional apps
8. Done

This is the same experience whether you used the Omarchy ISO, the Tacharchy ISO, or installed Arch manually.

### Rollback

Limine + snapper gives you snapshot/rollback:

```bash
tacharchy snapshot              # Create a snapshot
tacharchy snapshot rollback     # Roll back
tacharchy snapshot list         # List snapshots
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

### Current State

The repo already includes:

1. **Preflight / installer foundation** — forked Omarchy-style install scaffolding
2. **Performance packages** — the `tacharchy-*` tuning layer
3. **CLI baseline** — `tacharchy status`, `tacharchy benchmark`, and `tacharchy migrate`
4. **Desktop-layer pivot** — installer/docs now move away from DMS and toward Tacharchy-owned UX

Still planned:

5. **Clean-install validation** — VM first, then real hardware
6. **Desktop layer implementation** — shell / launcher / panel architecture under Tacharchy control
7. **First-run wizard polish** — compositor, theme, and app UX completed end-to-end

### Current CLI

```bash
tacharchy status        # Show current tuning state
tacharchy benchmark     # Save a benchmark snapshot
tacharchy migrate       # Apply pending migrations
```

### Planned Install Flags

```bash
tacharchy install --compositor hyprland   # Use Hyprland
tacharchy install --compositor sway       # Use Sway
tacharchy install --shell tacharchy       # Use the Tacharchy desktop layer
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

## Post-Install

### Verify Everything Works

```bash
tacharchy detect        # Show hardware detection results
tacharchy status        # Show tuning state
tacharchy benchmark     # Run before/after comparison
tacharchy migrate       # Apply compatibility / upgrade migrations
```

### Common First Steps

```bash
tacharchy theme set /path/to/wallpaper.jpg   # Planned: set your wallpaper / theme
tacharchy status                            # Check system state
tacharchy snapshot                          # Create a baseline snapshot
```

## Uninstall

```bash
tacharchy remove          # Remove all Tacharchy configs and packages
```

This removes:
- All `/etc/tacharchy/` configs
- All symlinks created by packages
- Performance tuning packages
- Legacy desktop-layer configs installed by older Tacharchy versions
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
tacharchy status          # Check what's applied
tacharchy benchmark       # Capture a quick state snapshot
tacharchy detect          # Check hardware detection
```

### Theme not applying

```bash
tacharchy theme set /path/to/wallpaper.jpg  # Planned: re-apply theme
tacharchy shell reload                     # Planned: reload desktop-layer components
```

### Audio crackling

```bash
# Verify realtime scheduling
groups | grep audio       # Should show 'audio'
tacharchy status          # Check current tuning state
```
