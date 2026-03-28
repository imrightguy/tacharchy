# CPU Tuning Reference

## Intel Hybrid Architecture (12th Gen+)

### The Problem

Intel's hybrid architecture combines Performance-cores (P-cores) and Efficient-cores (E-cores) on the same die:

| | P-cores | E-cores |
|---|---|---|
| Max frequency | Up to 5.8 GHz (varies by model) | Up to 4.3 GHz |
| Purpose | High-performance tasks | Background/efficiency tasks |
| Hyperthreading | Yes (2 threads per core) | No (1 thread per core) |
| Cache | Larger L2/L3 | Smaller L2, shared L3 |

The challenge: the Linux kernel scheduler (even with BORE) treats all cores somewhat equally. Background processes can end up on P-cores, and interactive processes can end up on E-cores. This wastes performance and creates inconsistent latency.

### The Solution

#### 1. Governor: powersave + EPP: performance

**What:** Set the CPU frequency governor to `powersave` with Energy Performance Preference set to `performance`.

**Why this combination:**

The `powersave` governor in Intel HWP (Hardware P-States) mode does NOT mean slow. HWP gives the CPU hardware autonomy to scale frequencies based on workload. The governor name is inherited from older CPU scaling drivers where "powersave" meant "lowest frequency."

With HWP:
- `powersave` governor = "let the CPU decide frequency freely"
- `performance` governor = "lock all cores at maximum frequency always"

The `performance` EPP (Energy Performance Preference) biases the CPU's internal decisions toward higher performance. Combined:

| Governor | EPP | Behavior |
|---|---|---|
| `powersave` | `balance_performance` | CPU scales freely, slightly biased toward power saving (default) |
| `powersave` | `performance` | CPU scales freely, biased toward performance → **our setting** |
| `performance` | `performance` | All cores locked at max frequency constantly |

**How to apply:**

Per-core EPP (P-cores → performance, E-cores → balance_performance):

```bash
# Get core mapping
for i in /sys/devices/system/cpu/cpu[0-9]*; do
  core=$(basename $i)
  type=$(cat $i/topology/core_type 2>/dev/null)
  echo "$core: $type"
done

# Set EPP per core type
for i in /sys/devices/system/cpu/cpu[0-9]*; do
  core=$(basename $i)
  type=$(cat $i/topology/core_type 2>/dev/null)
  if [ "$type" = "efficiency" ]; then
    echo balance_performance > "$i/cpufreq/energy_performance_preference"
  else
    echo performance > "$i/cpufreq/energy_performance_preference"
  fi
done
```

Persistent via systemd tmpfiles or udev rule.

**Tradeoff:** P-cores may use slightly more power at idle (due to performance EPP bias). The difference is small because HWP still downclocks idle P-cores.

**Applies to:** Intel 12th gen+ (Alder Lake, Raptor Lake, Meteor Lake, Arrow Lake).

---

#### 2. User Session → P-Cores Only

**What:** Restrict all user processes to P-cores via systemd `AllowedCPUs`.

**File:** `/etc/systemd/system/user.slice.d/affinity.conf`
```ini
[Slice]
AllowedCPUs=0-11
```

**Why:** Your interactive session (desktop, games, browser, editor) should run on the fastest cores. System background services (pacman, log rotation, indexing) can use all cores including E-cores.

**Tradeoff:** User processes can't use E-cores. With 6 P-cores (12 threads), this is sufficient for most desktop workloads. Only becomes a limitation with heavily multi-threaded workloads (compiling large projects, rendering).

**Applies to:** Intel 12th gen+ hybrid systems.

---

#### 3. Audio → Dedicated P-Cores

**What:** Pin PipeWire to 2 specific P-cores.

**File:** `~/.config/systemd/user/pipewire.service.d/audio.conf`
```ini
[Service]
CPUAffinity=6-7
OOMScoreAdjust=-1000
MemoryMin=64M
```

**Why:** Audio needs consistent, low-latency processing. Pinning it to dedicated P-cores guarantees availability regardless of system load.

**Which cores:** Pick P-cores in the middle range (not core 0 which handles a lot of system interrupts, not the last P-cores which you want for interactive work).

For i5-13600KF (P-cores 0-5, E-cores 12-19): cores 6-7 maps to P-core threads 6-7.
For i7-13700K (P-cores 0-7, E-cores 16-31): cores 4-5 or 6-7.
For i9-13900K (P-cores 0-15, E-cores 16-31): cores 6-7 or 8-9.

**See:** [docs/audio.md](audio.md) for full details.

---

#### 4. Detecting Core Topology

Tacharchy's `tacharchy-detect` script automatically identifies P-cores and E-cores:

```bash
# Core type is exposed by the kernel
cat /sys/devices/system/cpu/cpu*/topology/core_type

# CPU numbers mapped to physical cores
lscpu -e=CPU,CORE,SOCKET,ONLINE,MAXMHZ,MINMHZ

# Or more detailed
cat /proc/cpuinfo | grep "model name" | head -1
cat /proc/cpuinfo | grep "cpu cores"
```

The `core_type` sysfs attribute returns `performance` or `efficiency` on Intel hybrid CPUs.

---

## AMD

### Preferred Cores

AMD Ryzen processors with preferred cores (Ryzen 7000 series with X3D variants) have some cores with higher priority scheduling. The kernel handles this automatically with the `amd_pstate` driver.

```bash
# Verify preferred core support
cat /sys/devices/system/cpu/amd_pstate/status
# Should show: active

# Check which cores are preferred
cat /sys/devices/system/cpu/cpu*/priority | paste - - - - - - - - - - - - - - -
```

**No manual tuning needed** — the kernel schedules workloads on preferred cores automatically.

### Power Saving

AMD's `amd_pstate` driver supports EPP similar to Intel:

```bash
# Check current EPP
cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference

# Set to performance
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
```

**Recommendation:** Keep `balance_performance` for daily use. Switch to `performance` for gaming.

---

## Sources

- [Intel HWP documentation](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3b-part-2.pdf)
- [Intel hybrid architecture](https://www.intel.com/content/www/us/en/architecture-and-technology/12th-gen-intel-core-processors.html)
- [systemd AllowedCPUs](https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html)
- [amd_pstate driver](https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html)
- [CachyOS CPU settings](https://github.com/CachyOS/CachyOS-Settings)
