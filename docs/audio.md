# Audio Tuning Reference

## PipeWire Realtime Scheduling

### The Problem

Audio processing is latency-sensitive. Even small scheduling delays cause pops, crackles, or latency spikes. When the kernel schedules other processes on the same cores as audio threads, or when the system is under memory pressure and swaps out audio buffers, quality degrades.

### The Solution

Three layers of protection:

#### 1. Realtime Scheduling Priority

File: `/etc/security/limits.d/20-tacharchy-audio.conf`

```
@audio - rtprio 99
@audio - memlock unlimited
```

**What:** Grants the `audio` group permission to use realtime scheduling (priority 99) and lock memory pages.

**Why:** PipeWire's audio processing threads run with SCHED_FIFO (realtime FIFO) at priority 20. The `@audio - rtprio 99` limit in limits.conf allows this. `memlock unlimited` prevents audio buffer pages from being swapped to disk.

**How it works:** PipeWire tries to set realtime priority directly first (fails without CAP_SYS_NICE), then falls back to rtkit-daemon which successfully grants RT priority to audio threads. The limits.conf entry is what makes rtkit's grant succeed.

**Applies to:** All systems with PipeWire.

---

#### 2. CPU Affinity — Pin Audio to Dedicated P-Cores

File: `~/.config/systemd/user/pipewire.service.d/audio.conf`

```ini
[Service]
CPUAffinity=6-7
OOMScoreAdjust=-1000
MemoryMin=64M
```

Same for `pipewire-pulse.service.d/audio.conf` and `wireplumber.service.d/audio.conf`.

**What:** Pins all PipeWire processes to specific CPU cores and protects them from OOM killer.

**Why CPU affinity:**
- On Intel hybrid CPUs, P-cores run at up to 5.1GHz while E-cores max at 3.9GHz
- Pinning audio to P-cores ensures consistent processing time
- Prevents audio threads from being scheduled onto slower E-cores where the lower clock could cause buffer underruns
- Frees the rest of the P-cores for interactive work (desktop, games, browser)

**Why OOMScoreAdjust=-1000:**
- The OOM killer selects processes with the highest `oom_score` to kill under memory pressure
- Setting -1000 adjusts the score so the kernel will kill literally everything else before PipeWire
- Audio stuttering from partial process death is worse than other apps being killed

**Why MemoryMin=64M:**
- Sets a guaranteed memory floor for the PipeWire cgroup
- Even under severe memory pressure, 64MB is reserved and won't be reclaimed
- Audio buffers stay in RAM regardless of system memory state

**Which cores to use:**
- Depends on your CPU topology
- The goal is to dedicate 2 P-cores (4 threads) to audio
- On 6+8 hybrid (like i5-13600KF): cores 6-7 (P-cores, threads 12-15)
- On 8+8 hybrid (like i7-13700K): cores 6-7 or 4-5
- On 8+16 hybrid (like i9-13900K): any 2 P-cores from the middle range

**Tradeoff:** 2 P-cores permanently reserved for audio. On a desktop with 6 P-cores, you lose 2 of them. But modern desktop workloads rarely saturate all cores, and audio processing uses very little CPU time — the cores are mostly idle and just guaranteed to be available when needed.

**Applies to:** Intel 12th gen+ hybrid systems. Non-hybrid systems should skip CPU affinity (not needed).

---

#### 3. User Session Pinned to P-Cores

File: `/etc/systemd/system/user.slice.d/affinity.conf`

```ini
[Slice]
AllowedCPUs=0-11
```

**What:** Restricts all user processes to P-cores only (on hybrid CPUs).

**Why:** Ensures your interactive session (desktop, games, browser, terminal) never gets scheduled onto E-cores. Background system services (updates, logging, indexing) can still use all cores including E-cores.

**Tradeoff:** User processes can't use E-cores. On a 14-core system (6P + 8E), you're limiting yourself to 6 P-cores for all user work. For most desktop use this is fine — the P-cores are much faster and the E-cores handle background work.

**Applies to:** Intel 12th gen+ hybrid systems.

---

## Audio Group

Users must be in the `audio` group for realtime scheduling:

```bash
sudo usermod -aG audio $USER
```

On most modern distributions, this is already the default. Check with:

```bash
groups | grep audio
```

---

## PCI Latency (for sound cards)

Some systems (especially laptops) need PCI latency timer adjustments for audio interfaces.

File: `/etc/modprobe.d/tacharchy-audio.conf` (when applicable)

```
options snd_hda_intel power_save=0
```

**What:** Disables HD audio power saving.

**Why:** HD audio power saving can cause audible pops when the codec powers up/down. Disabling it keeps the codec always on. The power savings are minimal (a few hundred mW).

**Applies to:** Systems with audible pop/click on audio output, especially laptops.

---

## Sources

- [PipeWire documentation](https://docs.pipewire.org/)
- [rtkit-daemon](https://gitlab.freedesktop.org/pipewire/rtkit)
- [systemd resource control](https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html)
- [Intel hybrid architecture](https://www.intel.com/content/www/us/en/architecture-and-technology/12th-gen-intel-core-processors.html)
