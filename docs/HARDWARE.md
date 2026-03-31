# Hardware Detection

Tacharchy automatically detects your hardware and applies appropriate fixes, drivers, and optimizations. Detection happens during installation and is intended to be re-runnable via `tacharchy detect` once that command is wired into the main CLI. This is independent of any particular shell project.

## Detection Flow

```
tacharchy detect
  ├── CPU vendor and model
  │   ├── Intel (hybrid P/E? PTL? specific model?)
  │   ├── AMD (preferred cores? specific model?)
  │   └── Apple Silicon (Asahi)
  ├── GPU vendor and architecture
  │   ├── NVIDIA (Turing+ GSP? Maxwell/Pascal/Volta legacy?)
  │   ├── AMD (RDNA? specific model?)
  │   └── Intel (integrated? Arc? IPU camera?)
  ├── Display
  │   └── Multi-monitor, VRR, scaling
  ├── Audio
  │   └── PCI latency, sound card model
  ├── Storage
  │   ├── NVMe (model, power management)
  │   ├── SATA SSD
  │   └── HDD
  ├── Network
  │   ├── Wireless (vendor, WiFi 6E/7?)
  │   └── Wired (NIC model, ring buffers)
  ├── Peripherals
  │   ├── Keyboard layout
  │   ├── Touchpad (vendor, model)
  │   └── Bluetooth
  ├── Vendor-specific (laptop/vendor quirks)
  │   ├── ASUS ROG
  │   ├── Framework
  │   ├── Dell XPS
  │   ├── Surface
  │   ├── Apple T2 MacBook
  │   └── Tuxedo
  └── RAM amount
```

## CPU Detection

### Intel

| Feature | Detection | Action |
|---|---|---|
| Hybrid P/E cores | `/sys/devices/system/cpu/cpu*/topology/core_type` | Apply per-core EPP tuning, pin user session to P-cores |
| Platform Tuning (PTL) | CPU model string match | Install `linux-ptl` kernel, fix WiFi 7 EHT |
| Video acceleration | lspci Intel GPU | Install `intel-media-driver`, `libva-intel-driver` |
| IPU camera | lspci + model match | Install `intel-ipu7-camera` firmware |
| LPMD | Laptop + Intel CPU | Install `intel-lpmd`, configure power management |
| thermald | Laptop + Intel CPU | Install `thermald` for thermal management |

### AMD

| Feature | Detection | Action |
|---|---|---|
| Preferred cores | `/sys/devices/system/cpu/amd_pstate/status` | Verify active (kernel handles automatically) |
| Video acceleration | lspci AMD GPU | Install `libva-mesa-driver`, `mesa-vdpau` |
| OverDrive | RDNA GPU + `lact`/`corectrl` | Document undervolting options (opt-in) |

### Apple Silicon (Asahi)

| Feature | Detection | Action |
|---|---|---|
| Vulkan driver | lspci Apple GPU | Install `vulkan-asahi` |

## GPU Detection

### NVIDIA

Omarchy's NVIDIA detection is comprehensive — it identifies the GPU architecture and installs the correct driver variant:

| Architecture | GPUs | Driver | Notes |
|---|---|---|---|
| Turing+ (GSP) | GTX 16xx, RTX 20xx-50xx, RTX Pro, A/H/T series | `nvidia-open-dkms` | GSP firmware support, `NVD_BACKEND=direct` |
| Maxwell/Pascal/Volta | GTX 9xx, GT/GTX 10xx, Quadro P/M, Titan X/Xp/V | `nvidia-580xx-dkms` | No GSP, `NVD_BACKEND=egl` |

**Actions applied:**
- Correct driver installed based on GPU architecture
- `nvidia-drm.modeset=1` enabled (required for Wayland)
- Early KMS via mkinitcpio
- Architecture-specific environment variables
- VRAM leak prevention for niri (via NVIDIA app profile)
- Power management mode (auto for daily, suggest performance for gaming)

### AMD

| Feature | Detection | Action |
|---|---|---|
| Video acceleration | lspci AMD GPU | Install VA-API drivers |
| Vulkan | lspci AMD GPU | Install `vulkan-radeon` |

### Intel

| Feature | Detection | Action |
|---|---|---|
| Video acceleration | lspci Intel GPU | Install `intel-media-driver`, `libva-utils` |
| Vulkan | lspci Intel GPU | Install `vulkan-intel` |
| IPU camera | Laptop + specific Intel models | Install `intel-ipu7-camera` firmware |

## Vendor-Specific Fixes

### ASUS ROG
- Fix audio mixer routing
- Fix microphone input
- Configure keyboard RGB lighting
- Install `asusctl` for fan/profile control

### Framework
- Fix F13 AMD audio input
- Configure QMK HID keyboard support

### Dell XPS
- Fix haptic touchpad (XPS 9315/9320)
- Fix PTL display issues

### Microsoft Surface
- Fix keyboard input on Surface devices

### Apple T2 MacBooks
- Fix SPI keyboard driver (`macbook12-spi-driver-dkms`)
- Fix NVMe suspend/resume
- Configure T2 audio (`apple-bcm-firmware`, `apple-t2-audio-config`)
- Install T2 Linux kernel (`linux-t2`)
- Fan control (`t2fanrd`)
- Touch Bar / DFR support (`tiny-dfr`)

### Tuxedo
- Fix backlight control on Tuxedo laptops

### Broadcom
- Install `broadcom-wl` driver for Broadcom WiFi chips

### Synaptic
- Fix Synaptic touchpad issues

### YT6801
- Fix YT6801 USB ethernet adapter

## Network Detection

| Feature | Detection | Action |
|---|---|---|
| Wireless | Any wireless interface | Enable `iwd` service, configure powersave rules |
| WiFi 7 EHT | Intel PTL + WiFi 7 | Apply EHT fix patch |
| Gigabit+ wired | ethtool link speed | Show ring buffer recommendations |
| Regulatory domain | System locale | Set wireless regulatory domain |

## Audio Detection

| Feature | Detection | Action |
|---|---|---|
| Sound card | PCI audio devices | Apply PCI latency fix if needed |
| HD Audio power saving | Laptop + HD Audio codec | Disable `power_save=0` to prevent pops |
| PipeWire | System check | Enable realtime scheduling, add user to audio group |

## Storage Detection

| Feature | Detection | Action |
|---|---|---|
| NVMe | `/sys/block/nvme*` | Apply `none` scheduler, check power management |
| SATA SSD | `/sys/block/sd*` + `rotational=0` | Apply `mq-deadline` scheduler |
| HDD | `/sys/block/sd*` + `rotational=1` | Apply `bfq` scheduler |
| TRIM support | SSD/NVMe | Enable `fstrim.timer` |
| Swap type | `/proc/swaps` + block device type | Set `vm.swappiness` accordingly (100 NVMe, 60 SSD, 10 HDD) |

## Sources

- [Omarchy hardware detection](https://github.com/basecamp/omarchy/tree/master/install/config/hardware) — per-vendor fix scripts
- [Arch Linux Wiki](https://wiki.archlinux.org/) — hardware configuration reference
- [Intel Linux firmware](https://github.com/intel/linux-firmware) — IPU, WiFi, GPU firmware
- [NVIDIA driver README](https://download.nvidia.com/XFree86/Linux-x86_64/) — driver selection and configuration
