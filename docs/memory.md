# Memory Tuning Reference

## Swap Strategy

### NVMe Swap File (Recommended)

On modern NVMe storage, a swap file is indistinguishable from RAM for most workloads. Random read/write on Gen4 NVMe is ~5-10μs — fast enough that the kernel's own formula says swappiness should equal or exceed 100.

```bash
# Create a swap file on an NVMe filesystem
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make persistent
echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab
```

**Recommended size:** Equal to RAM, or RAM × 1.5 for systems < 16GB.

### ZRAM (Alternative)

ZRAM creates a compressed RAM block device used as swap. Effectively gives you more memory at the cost of CPU cycles for compression/decompression.

```bash
# /etc/systemd/zram-generator.conf
[zram0]
zram-size = min(ram, 8192)
compression-algorithm = zstd
swap-priority = 100
```

With ZRAM, `vm.swappiness` should be higher (100-200) since ZRAM swap is "free" — it's just compressed RAM.

**Tradeoff:** ZRAM uses CPU for compression. On systems with plenty of RAM and fast NVMe, a plain swap file is simpler and equally effective. ZRAM shines on memory-constrained systems (8GB or less) or systems without NVMe.

### Why Not HDD Swap?

HDD swap has millisecond latency. When the kernel pages to HDD swap, applications freeze. The tuning values change:
- `vm.swappiness = 10` (avoid swapping unless desperate)
- `vm.page-cluster = 3` (default — readahead helps HDD)
- Consider disabling swap entirely on systems with sufficient RAM

## Sysctl Values

### `vm.swappiness`

| Storage | Value | Reasoning |
|---|---|---|
| NVMe swap | 100 | Kernel formula: swap cost ≈ filesystem cost when both are NVMe |
| SSD swap | 60 | Moderate — SSD is fast but not NVMe-fast |
| HDD swap | 10 | Avoid — HDD latency causes visible stalls |
| ZRAM | 100-200 | Compressed RAM is cheap, use it aggressively |

### `vm.vfs_cache_pressure = 50`

Controls how aggressively the kernel reclaims dentry and inode cache. Default is 100. Lower values keep more VFS cache in memory, improving file operation responsiveness.

**Tradeoff:** Uses more RAM. On systems < 8GB, the default of 100 may be more appropriate.

### `vm.dirty_bytes = 268435456` (256MB)

Maximum dirty data a single process can accumulate before being forced to write. Prevents I/O spikes that freeze the system.

### `vm.dirty_background_bytes = 67108864` (64MB)

Background writeback starts at this threshold. Ensures flushing begins before hitting the hard limit.

### `vm.dirty_writeback_centisecs = 1500` (15s)

How often the kernel wakes to flush dirty pages. Default is 5s. Longer intervals reduce I/O interruptions.

**Tradeoff:** Up to 15s of data could be lost on crash (vs 5s default). Acceptable for desktop use.

### `vm.page-cluster = 0`

Number of pages read ahead from swap. Disabled because NVMe doesn't benefit from readahead (random ≈ sequential on NVMe). Keep at 3 for HDD swap.

### `vm.min_free_kbytes`

Not set by default in Tacharchy. This reserves memory for the kernel and can cause OOM kills if set too high. Some guides recommend 65536 (64MB) but this is system-dependent. Leave at kernel default unless you have a specific reason to change it.

## Transparent HugePages

`transparent_hugepage=always` can cause latency spikes on desktop workloads due to khugepaged compacting memory. The kernel default of `madvise` is correct — let applications that benefit from huge pages (databases, VMs) opt in via `madvise(MADV_HUGEPAGE)`.

```bash
# Verify (should show madvise)
cat /sys/kernel/mm/transparent_hugepage/enabled
```

Do not change this value.

## Memory Information

### Check Current State

```bash
# Memory usage
free -h

# Swap usage and priority
swapon --show

# Swappiness
sysctl vm.swappiness

# Dirty page settings
sysctl vm.dirty_bytes vm.dirty_background_bytes vm.dirty_writeback_centisecs

# VFS cache pressure
sysctl vm.vfs_cache_pressure

# Page cluster
sysctl vm.page_cluster

# Transparent HugePages
cat /sys/kernel/mm/transparent_hugepage/enabled

# Per-process memory usage
ps aux --sort=-%mem | head -20
```

## Sources

- [Kernel documentation: VM](https://www.kernel.org/doc/Documentation/sysctl/vm.txt)
- [CachyOS sysctl defaults](https://github.com/CachyOS/CachyOS-Settings)
- [Arch Wiki: Swap](https://wiki.archlinux.org/title/Swap)
- [Arch Wiki: ZRAM](https://wiki.archlinux.org/title/Zram)
