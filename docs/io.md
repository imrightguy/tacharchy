# I/O Tuning Reference

## I/O Scheduler Selection

### The Problem

Linux offers multiple I/O schedulers that determine how block I/O requests are ordered and merged. Different storage devices have different optimal schedulers:

| Storage Type | Characteristics | Optimal Scheduler |
|---|---|---|
| NVMe SSD | Extremely low latency, many queues, no seek penalty | `none` (noop) |
| SATA SSD | Low latency, no seek penalty | `mq-deadline` |
| HDD | High seek latency, benefits from sorting/merging | `bfq` or `mq-deadline` |
| USB storage | Variable, often HDD-based | `bfq` |

### Why NVMe → none

NVMe drives have:
- Tens of thousands of I/O queues (vs 1-2 for SATA)
- Microsecond latency (vs milliseconds for HDD)
- No mechanical seek time
- Internal command reordering in the drive's own controller

The kernel's I/O scheduler adds overhead (context switches, locking) without benefit. The NVMe controller handles everything better internally.

### Why HDD → bfq

`bfq` (Budget Fair Queueing) is designed for rotational media:
- Groups I/O by process (prevents one process from starving others)
- Anticipates sequential access patterns and optimizes for them
- Reduces seek distance between requests

### Why SATA SSD → mq-deadline

`mq-deadline` provides deadline-based scheduling:
- Assigns deadlines to I/O requests
- Sorts by deadline to prevent starvation
- Merges adjacent requests
- Low overhead

### How to Apply

Via udev rules:

File: `/etc/udev/rules.d/60-tacharchy-io-scheduler.rules`

```bash
# NVMe: no scheduler needed
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"

# SATA/SAS SSDs: mq-deadline
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"

# HDDs: bfq
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
```

**Note:** On modern kernels, `none` is already the default for NVMe. The udev rule ensures it stays correct even if defaults change.

### How to Verify

```bash
# Check all block devices
lsblk -o NAME,TYPE,FSTYPE,SIZE

# Check scheduler for each device
for dev in /sys/block/*; do
  name=$(basename $dev)
  scheduler=$(cat $dev/queue/scheduler)
  rotational=$(cat $dev/queue/rotational)
  echo "$name: scheduler=$scheduler, rotational=$rotational"
done
```

### Tradeoff

No meaningful tradeoff for NVMe (scheduler is disabled). For HDD→bfq vs mq-deadline: bfq uses slightly more CPU for the per-process tracking, but on modern CPUs this is negligible.

### Applies to

All systems. Rules are auto-detected by drive type.

---

## fstrim (SSD Trim)

### What

TRIM tells an SSD which blocks are no longer in use, allowing the drive's internal garbage collection to work efficiently. Without TRIM, SSD performance degrades over time as the drive fills up.

### How

Tacharchy enables the systemd `fstrim.timer`:

```bash
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
```

This runs `fstrim` weekly, which sends TRIM commands for all unused blocks on mounted filesystems.

Alternatively, for SSDs that support it, continuous discard via mount option:

```bash
# In fstab or mount options
discard=async
```

**Recommendation:** Use `fstrim.timer` (periodic) rather than continuous `discard`. Continuous discard adds a small I/O operation to every file deletion, which can cause micro-stutters.

### Applies to

All SSDs (NVMe and SATA). Not applicable to HDDs.

---

## Sources

- [Linux block layer documentation](https://www.kernel.org/doc/html/latest/block/index.html)
- [bfq design](https://www.kernel.org/doc/html/latest/block/bfq-iosched.html)
- [fstrim(8)](https://man7.org/linux/man-pages/man8/fstrim.8.html)
- [udev rules](https://www.kernel.org/doc/html/latest/admin-guide/udev.html)
