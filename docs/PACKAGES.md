# AUR Packages Reference

All packages are version 0.1.0, `arch=any`, MIT licensed.

## Packages

### tacharchy-foundation

Meta-package that depends on all tuning packages. Install this for the complete performance layer.

**Depends:** tacharchy-sysctl, tacharchy-audio, tacharchy-gpu, tacharchy-network, tacharchy-io, tacharchy-cpu, tacharchy-detect

### tacharchy-sysctl

Kernel parameter tuning with documented reasoning for every value.

**Installs:**
- `/etc/sysctl.d/99-tacharchy-sysctl.conf` — memory, network, kernel, filesystem sysctls

**Install script:**
- Detects swap storage type (NVMe/SSD/HDD) and sets `vm.swappiness` accordingly
- Warns if RAM < 8GB about vfs_cache_pressure

### tacharchy-audio

PipeWire realtime scheduling and audio protection.

**Installs:**
- `/etc/security/limits.d/20-tacharchy-audio.conf` — `@audio rtprio 99`, `memlock unlimited`
- `/etc/modprobe.d/tacharchy-audio.conf` — HD audio `power_save=0`
- Example systemd units for CPU affinity on Intel hybrid CPUs

**Install script:**
- Adds user to `audio` group
- Detects Intel hybrid CPUs and offers CPU affinity configuration

### tacharchy-gpu

GPU driver optimizations.

**Installs:**
- `/etc/nvidia/nvidia-application-profiles-rc.d/50-tacharchy-niri-vram.json` — VRAM leak prevention for niri
- Vendor-specific config examples

**Optdepends:** `intel-media-driver`, `intel-ivsc-firmware`, `libva-mesa-driver`, `mesa-vdpau`, `nvidia-utils`

**Install script:**
- Detects GPU vendor (NVIDIA/AMD/Intel)
- Shows relevant recommendations and warnings

### tacharchy-network

Network stack tuning.

**Installs:**
- `/etc/sysctl.d/99-tacharchy-network.conf` — BBR congestion control, netdev_max_backlog
- `/etc/modules-load.d/tacharchy-bbr.conf` — `tcp_bbr` kernel module
- Network link template for ring buffer configuration

**Install script:**
- Detects network interfaces
- Shows ring buffer status and recommendations

### tacharchy-io

I/O scheduler auto-detection via udev rules.

**Installs:**
- `/etc/udev/rules.d/60-tacharchy-io-scheduler.rules` — NVMe→none, SSD→mq-deadline, HDD→bfq

**Install script:**
- Enables `fstrim.timer` for SSD/NVMe TRIM support

### tacharchy-cpu

CPU and scheduler tuning.

**Installs:**
- `/etc/systemd/system/user.slice.d/affinity.conf` — P-core only affinity (Intel hybrid)
- Tmpfiles config for per-core EPP setting

**Install script:**
- Detects Intel hybrid (P/E core) vs AMD
- Applies per-core EPP tuning on Intel hybrid CPUs
- Verifies AMD preferred cores support

### tacharchy-detect

Hardware detection and recommendation engine.

**Installs:**
- `/usr/bin/tacharchy-detect` — detection script

**Depends:** bash, coreutils, util-linux, pciutils

**Usage:**
```bash
tacharchy-detect              # Human-readable summary
tacharchy-detect --json       # Machine-readable JSON
tacharchy-detect --verbose    # Detailed output
```

**Detects:**
- CPU (vendor, model, hybrid P/E cores, AMD preferred cores)
- GPU (vendor, architecture, driver recommendation)
- Audio (sound card, PCI latency)
- Storage (NVMe/SSD/HDD per device)
- Network (interfaces, link speed)
- RAM amount

### tms-shell-bin

TMS desktop shell (stable release). Forked from DankMaterialShell.

**Depends:** quickshell, matugen, cliphist

### tms-shell-git

TMS desktop shell (nightly build from git HEAD).

**Depends:** quickshell-git, matugen, cliphist

## File Layout

All Tacharchy configs live under `/etc/tacharchy/` with symlinks to system directories:

```
/etc/tacharchy/
├── sysctl/              # Sysctl drop-in files
│   └── 99-tacharchy-sysctl.conf → /etc/sysctl.d/
├── audio/               # Audio configs
│   ├── limits.conf → /etc/security/limits.d/
│   └── modprobe.conf → /etc/modprobe.d/
├── network/             # Network configs
│   ├── sysctl.conf → /etc/sysctl.d/
│   └── modules.conf → /etc/modules-load.d/
├── io/                  # I/O scheduler rules
│   └── udev.rules → /etc/udev/rules.d/
├── cpu/                 # CPU tuning
│   └── affinity.conf → /etc/systemd/system/user.slice.d/
└── gpu/                 # GPU configs
    └── nvidia-app-profile → /etc/nvidia/
```

This layout enables clean uninstall: remove `/etc/tacharchy/` and all symlinks, and the system is restored.

## Building from Source

```bash
git clone https://github.com/imrightguy/tacharchy.git
cd tacharchy/packages/tacharchy-sysctl  # or any package
makepkg -si
```

## AUR Repository (Future)

A signed AUR repository will be available for one-line setup:

```bash
# Add Tacharchy repo
curl -fsSL https://repo.tacharchy.com/tacharchy.key | sudo pacman-key --add -
echo '[tacharchy]' | sudo tee -a /etc/pacman.conf
echo 'Server = https://repo.tacharchy.com/$arch' | sudo tee -a /etc/pacman.conf
sudo pacman -Syu tacharchy-foundation
```
