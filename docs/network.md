# Network Tuning Reference

## TCP Congestion Control: BBR

### The Problem

The default TCP congestion control algorithm (cubic) uses packet loss as a signal to reduce throughput. On modern networks, this causes suboptimal performance because:

1. Packet loss is rare on wired connections but the algorithm still assumes it means congestion
2. Cubic can't distinguish between congestion and random packet loss
3. Bufferbloat (large buffers in routers) causes cubic to ramp up too slowly

### The Solution

**BBR (Bottleneck Bandwidth and Round-trip propagation time)** is Google's congestion control algorithm that:

1. Measures actual bottleneck bandwidth and RTT directly
2. Doesn't rely on packet loss as a signal
3. Achieves higher throughput on high-bandwidth, high-latency connections
4. Reduces bufferbloat by pacing packets appropriately

### How to Enable

```bash
# Load the kernel module
sudo modprobe tcp_bbr

# Make persistent
echo "tcp_bbr" | sudo tee /etc/modules-load.d/bbr.conf

# Set as default congestion control
echo "net.ipv4.tcp_congestion_control = bbr" | sudo tee /etc/sysctl.d/99-tacharchy-network.conf

# Apply immediately
sudo sysctl -p /etc/sysctl.d/99-tacharchy-network.conf

# Verify
sysctl net.ipv4.tcp_congestion_control
# Should output: net.ipv4.tcp_congestion_control = bbr

sysctl net.ipv4.tcp_available_congestion_control
# Should include: reno cubic bbr
```

### Tradeoff

BBR is mature (merged in kernel 4.9, 2016) and used by Google, Cloudflare, and most large CDNs. No meaningful downsides for desktop use.

### Applies to

All systems. BBR is beneficial for any network connection.

---

## NIC Ring Buffers

### The Problem

Network interfaces have ring buffers — circular queues where incoming and outgoing packets wait to be processed. The default size is often 256-512 entries. Under burst traffic (gaming, large file transfers, video calls), the buffer can fill up faster than the kernel processes packets, causing packet drop.

### The Solution

Increase ring buffer size to the maximum supported by the NIC:

```bash
# Check current and max sizes
ethtool -g enp0s31f6

# Output:
# Ring parameters for enp0s31f6:
# Pre-set maximums:
# RX:		4096
# RX Mini:	0
# RX Jumbo:	0
# TX:		4096
# Current hardware settings:
# RX:		256
# RX Mini:	0
# RX Jumbo:	0
# TX:		256

# Set to maximum
sudo ethtool -G enp0s31f6 rx 4096 tx 4096
```

### Make Persistent

File: `/etc/systemd/network/10-wired.link`

```ini
[Match]
OriginalName=enp0s31f6

[Link]
RxBufferSize=4096
TxBufferSize=4096
```

### Tradeoff

Uses slightly more memory for packet queues. At 4096 entries × ~2KB per entry ≈ 8MB. Negligible on modern systems.

### Applies to

All systems with gigabit+ network interfaces. Detect interface name automatically.

---

## Network Backlog

### `net.core.netdev_max_backlog = 4096`

Maximum number of packets queued on the input side of an interface when the interface receives packets faster than the kernel can process them.

Default is often 1000-2000. Increasing to 4096 reduces packet drop under burst conditions (gaming, streaming, large downloads).

---

## Sources

- [Google BBR paper](https://research.google/pubs/pub45646/)
- [BBR v2 IETF draft](https://datatracker.ietf.org/doc/draft-ietf-tcpm-bbr/)
- [ethtool documentation](https://www.kernel.org/doc/Documentation/networking/ethtool.rst)
- [systemd network files](https://www.freedesktop.org/software/systemd/man/systemd.link.html)
