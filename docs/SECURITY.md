# Security Reference

Tacharchy applies sensible security defaults without being restrictive. These are opt-in basics, not hardening.

## Firewall (ufw)

Simple stateful firewall. Enabled during installation if the user opts in.

```bash
# Enable with default deny
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Common rules
sudo ufw allow ssh       # SSH (port 22)
sudo ufw allow 5353/udp  # mDNS (Avahi, local device discovery)

# Docker compatibility (needed if using Docker)
sudo ufw route allow in on eth0 out on docker0
```

**Note:** Docker manipulates iptables directly, which can conflict with ufw. The `ufw-docker` package (included in Omarchy's package list) resolves this.

## Sudo Configuration

### Increased tries

Default sudo allows 3 password attempts before locking. Tacharchy increases this to 5 for convenience.

### Passwordless toggle

Omarchy provides a `omarchy-sudo-passwordless-toggle` command. Tacharchy should ship the same:

```bash
tacharya config sudo-passwordless  # Toggle passwordless sudo
```

### Lockout limit

Increased to prevent rapid brute-force lockouts during typos.

## File Permissions

### Input group

Users are added to the `input` group for access to input devices (required for waybar volume/brightness controls, SwayOSD, etc.).

```bash
sudo usermod -aG input $USER
```

### Audio group

Required for PipeWire realtime scheduling. See [docs/audio.md](audio.md).

```bash
sudo usermod -aG audio $USER
```

## Secure Boot

Not configured by default. Users with Secure Boot enabled should:
1. Enroll their own keys via `sbctl`
2. Or disable Secure Boot in firmware

Tacharchy does not force Secure Boot — it's the user's choice.

## Kernel Hardening

Tacharchy does not apply aggressive kernel hardening by default. The following are documented for users who want them:

### Kernel Lockdown

```bash
# Check current mode
cat /sys/kernel/security/lockdown

# Enable via kernel parameter (in /etc/kernel/cmdline.d/)
lockdown=confidentiality
```

This restricts even root from accessing kernel memory. Useful for multi-user systems. Can break some tools (perf, kexec, some GPU drivers).

### Kernel Address Space Layout Randomization (KASLR)

Enabled by default in Arch's kernel. No action needed.

### Memory Protections

These are enabled by default in Arch's kernel:
- `CONFIG_STACKPROTECTOR` — stack canaries
- `CONFIG_SLUB_HARDENED` — hardened slab allocator
- `CONFIG_HARDENED_USERCOPY` — bounds checking on usercopy
- `CONFIG_RANDOMIZE_BASE` — KASLR
- `CONFIG_RANDOMIZE_MEMORY` — memory region randomization

No action needed.

## Not Included (By Design)

The following are intentionally not included because they can break desktop functionality:

- **`vm.min_free_kbytes`** — setting too high causes OOM kills on desktop workloads
- **Kernel `deny_new_usb`** — breaks USB peripherals
- **`kernel.kexec_load=0`** — breaks snapshot/rollback via Limine
- **MAC (SELinux/AppArmor) policies** — not applicable for Arch desktop; would require significant per-app policy writing
- **`kernel.yama.ptrace_scope=3`** — breaks debuggers, profiling tools
- **TCP hardening** (`syncookies`, `reverse path filtering`) — can cause issues on some networks

Users who need these (servers, HPC, compliance) should apply them manually after installation.

## Sources

- [Arch Wiki: Security](https://wiki.archlinux.org/title/Security)
- [Arch Wiki: UFW](https://wiki.archlinux.org/title/Uncomplicated_Firewall)
- [Kernel documentation: sysctl/kernel](https://www.kernel.org/doc/Documentation/sysctl/kernel.txt)
