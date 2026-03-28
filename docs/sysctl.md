# Sysctl Tuning Reference

Every value Tacharchy sets is documented here with reasoning.

## Memory

### `vm.swappiness = 100`

**What:** Controls how aggressively the kernel swaps pages to disk vs dropping filesystem cache.

**Why 100:** The kernel's own formula says swappiness should be >= 100 when the swap device I/O cost is equal to or lower than the filesystem I/O cost. On modern NVMe swap (especially a swap file on a Gen4 NVMe), random read/write latency is comparable to or faster than filesystem access. Higher swappiness lets the kernel use swap as an extension of memory rather than waiting until the last moment.

**Tradeoff:** Slightly more swap usage when RAM is under moderate pressure. On systems with fast swap and plenty of RAM, this is negligible.

**Applies to:** Systems with NVMe swap. Systems with HDD swap should use a lower value (10-30).

---

### `vm.vfs_cache_pressure = 50`

**What:** Controls how aggressively the kernel reclaims dentry and inode cache memory.

**Why 50 (default 100):** The VFS cache stores directory entries and inode metadata. Reclaiming it means every file access needs to re-read from disk. On systems with sufficient RAM, keeping more VFS cache improves file operation responsiveness. 50 means the kernel is half as aggressive about reclaiming VFS cache as the default.

**Tradeoff:** Uses more RAM for cache. On memory-constrained systems (< 8GB), the default of 100 may be more appropriate.

**Applies to:** Systems with 16GB+ RAM.

---

### `vm.dirty_bytes = 268435456` (256MB)

**What:** Maximum amount of dirty (modified but unwritten) data a single process can accumulate.

**Why 256MB:** Without this limit, a process writing large amounts of data can accumulate many GB of dirty pages in memory. When the kernel finally flushes them, it causes a massive I/O spike that freezes the system for seconds. Capping at 256MB ensures writes happen more frequently and smoothly.

**Tradeoff:** Slightly lower write throughput for large sequential writes (like copying big files). The smoothness tradeoff is worth it for desktop responsiveness.

**Applies to:** All systems.

---

### `vm.dirty_background_bytes = 67108864` (64MB)

**What:** Threshold at which background writeback starts.

**Why 64MB:** When dirty data reaches 64MB, the kernel starts writing it to disk in the background before it hits the hard limit (256MB). This ensures the system starts flushing early rather than all at once at the dirty_bytes limit.

**Tradeoff:** More frequent background I/O. On battery-powered laptops, this can slightly reduce battery life.

**Applies to:** All systems.

---

### `vm.page-cluster = 0`

**What:** Number of pages the kernel reads ahead from swap in a single cluster.

**Why 0 (disabled):** Swap readahead was designed for HDD swap where sequential access is much faster than random. On NVMe swap, random and sequential access are nearly identical, so readahead just wastes memory bandwidth. Disabling it gives the kernel more control over which pages to read.

**Tradeoff:** None meaningful on NVMe. On HDD swap, keeping the default (3) would be better.

**Applies to:** Systems with NVMe swap.

---

### `vm.dirty_writeback_centisecs = 1500` (15 seconds)

**What:** How often the kernel wakes up to write dirty pages to disk.

**Why 15s (default 5s):** More frequent wakeups cause more I/O interruptions. Desktop responsiveness benefits from longer intervals between background flushes, since the dirty_bytes/dirty_background_bytes limits already ensure data gets written before it's a problem.

**Tradeoff:** Slightly longer delay before dirty data reaches disk. If the system crashes, up to 15 seconds of data could be lost vs 5 seconds. For desktop use this is acceptable.

**Applies to:** All systems.

---

## Network

### `net.ipv4.tcp_congestion_control = bbr`

**What:** TCP congestion control algorithm.

**Why BBR:** BBR (Bottleneck Bandwidth and Round-trip propagation time) is Google's congestion control algorithm. It measures actual bandwidth and RTT rather than using packet loss as a signal (which cubic does). This results in better throughput on modern networks, especially high-bandwidth high-latency connections. It also reduces bufferbloat.

**Tradeoff:** Minimal. BBR is mature (kernel 4.9+, 2016) and widely used in production. Some very specific network setups may benefit from cubic.

**Applies to:** All systems with `tcp_bbr` kernel module available.

---

### `net.core.netdev_max_backlog = 4096`

**What:** Maximum number of packets queued on the input side of a network interface.

**Why 4096 (default varies, often 1000):** When a network interface receives packets faster than the kernel can process them, they're queued here. The default is often too low for gigabit networks under load (gaming, large transfers, streaming). Increasing to 4096 reduces packet drop under burst conditions.

**Tradeoff:** Slightly more memory used for packet queues. Negligible on modern systems.

**Applies to:** Systems with gigabit+ network interfaces.

---

## Kernel

### `kernel.nmi_watchdog = 0`

**What:** Disables the Non-Maskable Interrupt watchdog.

**Why disabled:** The NMI watchdog periodically checks if the kernel is stuck. While useful for debugging kernel hangs, it adds slight overhead from the periodic timer interrupts. On desktop systems where kernel hangs are rare and you can just reboot, this overhead isn't worth it.

**Tradeoff:** Won't automatically detect and report kernel hangs. If you're running a server or doing kernel development, keep this enabled.

**Applies to:** Desktop systems only.

---

### `kernel.printk = 3 3 3 3`

**What:** Controls kernel log levels printed to the console.

**Why 3 3 3 3:** Level 3 (KERN_ERR) only shows errors and more severe messages. The default (4 4 1 7) shows warnings and notices on the console, which can cause visible text flicker and minor I/O overhead from console output. Reducing to errors-only keeps the console clean.

**Tradeoff:** Kernel warnings won't appear on console. They're still logged to `dmesg`/journalctl for debugging.

**Applies to:** All systems.

---

## File System

### `fs.inotify.max_user_instances = 1024`

**What:** Maximum number of inotify instances per user.

**Why 1024 (default typically 128):** Inotify is used by file watchers (VS Code, node_modules watchers, webpack, etc.). Modern development workflows can easily exceed 128 instances. Increasing to 1024 prevents "too many open files" errors from file watchers.

**Tradeoff:** Slightly more kernel memory allocated for inotify structures. Each instance uses a few KB.

**Applies to:** Development workstations.

---

### `fs.inotify.max_user_watches = 524288`

**What:** Maximum number of inotify watches per user.

**Why 524288 (default typically 8192 or 524288):** Similar reasoning. Large projects with many files (monorepos, node_modules) need more watches. 524288 is the common recommendation for developer machines.

**Tradeoff:** ~512KB of kernel memory for the watch structures.

**Applies to:** Development workstations.

---

### `fs.file-max = 2097152`

**What:** System-wide maximum number of open file descriptors.

**Why 2097152 (default varies, often 100000-200000):** Modern desktop applications and servers can open many files. Docker containers, development tools, browsers, and databases all contribute. 2M provides headroom.

**Tradeoff:** Slightly more kernel memory for file descriptor tables. Negligible on systems with 8GB+ RAM.

**Applies to:** All systems.

---

## CPU (Intel Hybrid)

### Governor: `powersave` + EPP: `performance` on P-cores

**What:** Intel Hardware P-States (HWP) governor setting.

**Why this combination:** On Intel HWP, the governor name is misleading. `performance` governor locks ALL cores at maximum frequency constantly — wasting power and generating heat for no desktop benefit, since HWP ramps up in microseconds when needed. `powersave` governor gives HWP autonomy to scale freely. Combined with `performance` EPP (Energy Performance Preference), P-cores ramp up aggressively when there's load while E-cores can downclock when idle.

**Tradeoff:** None meaningful. `performance` governor + `performance` EPP would only matter for sustained multi-second workloads where the ramp-up time matters (e.g., benchmarking).

**Applies to:** Intel 12th gen+ (hybrid P/E core architecture).

---

## Sources

- [CachyOS sysctl defaults](https://github.com/CachyOS/CachyOS-Settings) — inspiration for memory, kernel, and filesystem values
- [Kernel documentation](https://www.kernel.org/doc/Documentation/sysctl/) — canonical reference
- [Google BBR paper](https://research.google/pubs/pub45646/) — TCP BBR congestion control
- [Intel HWP documentation](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3b-part-2.pdf) — hardware P-states and EPP
