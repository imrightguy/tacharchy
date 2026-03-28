# GPU Tuning Reference

## NVIDIA

### DRM Kmodeset

**What:** Enables NVIDIA's Direct Rendering Manager kernel modesetting.

**Why:** Required for Wayland compositors to work properly. Without it, NVIDIA falls back to legacy mode which doesn't support Wayland natively (requires XWayland).

**How to verify:**
```bash
cat /sys/module/nvidia_drm/parameters/modeset
# Should output: Y
```

**How to enable (if not already):**
```bash
# Add to kernel parameters
echo "nvidia-drm.modeset=1" | sudo tee -a /etc/kernel/cmdline.d/nvidia.conf
# Or in GRUB: edit /etc/default/grub, add to GRUB_CMDLINE_LINUX_DEFAULT
sudo update-grub  # if using GRUB
```

**Applies to:** All NVIDIA GPUs on Wayland.

---

### Framebuffer Device

**What:** Enables the NVIDIA framebuffer device.

**Why:** Allows the NVIDIA driver to provide a console framebuffer, enabling hardware cursor rendering and early KMS. Without it, you get a software cursor and possibly display artifacts during boot.

**How to verify:**
```bash
cat /sys/module/nvidia_drm/parameters/fbdev
# Should output: Y
```

**Applies to:** All NVIDIA GPUs.

---

### VRAM Leak Prevention (niri Compositor)

**What:** Prevents niri from accumulating unused VRAM on NVIDIA.

**Why:** There's a known bug where niri (and some other Wayland compositors) cause NVIDIA to hold onto freed GPU memory. Setting `GLVidHeapReuseRatio=0` via NVIDIA application profiles prevents this.

**How:**

File: `/etc/nvidia/nvidia-application-profiles-rc.d/50-niri-vram.json`

```json
{
  "rules": [
    {
      "pattern": {
        "feature": "procname",
        "matches": "niri"
      }
    },
    "profile": "Limit Free Buffer Pool On Wayland Compositors"
    }
  ],
  "profiles": [
    {
      "name": "Limit Free Buffer Pool On Wayland Compositors",
      "settings": [
        {
          "key": "GLVidHeapReuseRatio",
          "value": 0
        }
      ]
    }
  ]
}
```

**Tradeoff:** Slightly more frequent GPU memory allocation/deallocation. Negligible on modern GPUs.

**Applies to:** NVIDIA + niri (and potentially other compositors).

---

### Power Management

NVIDIA GPUs have several power management modes:

**Auto (default):** GPU downclocks when idle, ramps up under load. Good balance of power and performance.

**Prefer Maximum Performance:** GPU always runs at maximum clocks. Higher power draw, zero ramp-up latency.

**Adaptive:** GPU scales with workload, more aggressive than Auto.

**Recommendation for desktop:** Keep `Auto` for daily use. Switch to `Prefer Maximum Performance` for gaming sessions (via `nvidia-smi -pm 1` or a script).

**Persistent setting:**
```bash
# Auto (default)
sudo nvidia-smi -pm 0

# Prefer Maximum Performance
sudo nvidia-smi -pm 1
```

Or via NVIDIA settings GUI or `nvidia-settings -a [gpu:0]/GPUPowerMizerMode=1`

**Applies to:** All NVIDIA GPUs.

---

### VSync and Compositing

**ForceCompositionPipeline:** Eliminates screen tearing by forcing all rendering through the compositor.

**ForceFullCompositionPipeline:** Same as above but also applies to direct scanout.

**Recommendation:** Enable on Wayland (compositors handle this). On X11, enable if you see tearing.

```bash
nvidia-settings -a "ForceCompositionPipeline=On"
nvidia-settings -a "ForceFullCompositionPipeline=On"
```

Persistent via `/etc/X11/xorg.conf.d/20-nvidia.conf` or NVIDIA application profiles.

**Applies to:** NVIDIA GPUs with screen tearing issues.

---

## AMD

### Video Acceleration

AMD GPUs support VA-API and VDPAU for hardware-accelerated video decoding.

```bash
# Install VA-API driver
sudo pacman -S libva-mesa-driver mesa-vdpau

# Verify
vainfo
```

**Applies to:** All AMD GPUs.

### OverDrive (undervolting/overclocking)

AMD GPUs can be undervolted via `corectrl` or `lact` for better performance-per-watt.

```bash
sudo pacman -S lact
```

**Tradeoff:** Reduces power consumption and temperatures, may reduce maximum clock slightly. Safe for daily use.

**Applies to:** AMD RDNA GPUs (RX 5000 series and newer).

---

## Intel

### Video Acceleration

Intel GPUs support VA-API for hardware decoding.

```bash
sudo pacman -S intel-media-driver libva-utils

# Verify
vainfo
```

### IPU Camera

Some Intel laptops have an IPU (Image Processing Unit) camera that needs specific firmware.

```bash
sudo pacman -S intel-ivsc-firmware
```

**Applies to:** Intel laptops with IPU cameras (12th gen+).

---

## Sources

- [NVIDIA DRM documentation](https://download.nvidia.com/XFree86/Linux-x86_64/535.129.03/README/kernel_open.html)
- [NVIDIA application profiles](https://download.nvidia.com/XFree86/Linux-x86_64/535.129.03/README/nvidia-application-profiles.html)
- [Mesa VA-API](https://docs.mesa3d.org/va.html)
- [Intel media driver](https://github.com/intel/media-driver)
