# First-Boot Experience

The first boot is where Tacharchy stops being "an Arch install" and becomes **your** system.

This is the heart of the project: a beautiful, fullscreen configurator that runs after the minimal base install. It should feel polished, guided, and calm — not like a wall of shell output.

## Goal

No matter how the user got here:
- Tacharchy ISO
- Omarchy ISO
- Existing Arch install

…the first-boot experience should feel identical.

## Phase Split

### Phase 1 — Base Install

Handled before first boot. Forked from Omarchy installer.

This phase only does the boring but necessary platform work:
- Disk placement / partitioning
- User creation
- Timezone
- Keyboard layout
- Arch base system
- Limine bootloader
- btrfs + snapper

No desktop choices here. No theming. No app bundles. No giant opinion dump.

Just get to a bootable, recoverable system.

### Phase 2 — Fullscreen Tacharchy Setup

This runs on first login.

This is where the real product lives.

## Design Principles

### 1. Beautiful, not busy

It should feel more like a premium onboarding flow than an installer.

- Fullscreen
- Big typography
- Clean spacing
- Minimal chrome
- Strong previews
- Smooth transitions
- No giant terminal wall unless something fails

### 2. Explain choices without overexplaining

Each screen should answer:
- what this choice is
- why someone would pick it
- what the recommended default is

But it should not become a wiki article.

### 3. Defaults should be sane

The flow should be fast for people who want to keep moving:
- recommend niri
- recommend DMS
- enable performance tuning by default
- recommend a default theme/wallpaper

### 4. Everything optional except the base identity

Tacharchy should make strong recommendations without forcing junk.

No 150-package dump.
No weird preinstalls.
No fake "minimal" mode that still installs everything.

## Screen Flow

### 1. Welcome

Purpose: establish confidence and tone.

Content:
- Tacharchy logo/branding
- short one-line statement of what this setup will do
- continue button

Suggested copy:

> Welcome to Tacharchy.
> Fast, beautiful, Wayland-first Linux — tuned for your hardware.

### 2. Hardware Summary

Purpose: prove the system already understands the machine.

Show detected:
- CPU
- GPU(s)
- RAM
- storage type
- laptop/vendor quirks detected
- recommended tuning notes

This builds trust immediately.

### 3. Compositor Choice

Primary candidates:
- niri
- Hyprland
- Sway
- labwc
- other DMS-supported compositors later

Each option should show:
- what kind of compositor it is
- who it is for
- current support quality

Suggested defaults:
- **Recommended:** niri
- **Power user / highly configurable:** Hyprland
- **Stable / traditional tiling:** Sway

### 4. Desktop Shell

Options:
- **DMS** — full shell experience (consumed as-is)
- **Minimal** — compositor + essential integrations only
- **Custom** — skip shell, configure later

This is important because Christopher explicitly does **not** want forced choices.

### 5. Theme / Visual Identity

Since we use **one theme engine** (matugen, ported into DMS), this should all go through matugen.

Input modes:
- pick a bundled wallpaper
- pick a named seed theme
- import your own wallpaper
- set a seed color manually

This is where the system begins to feel personal.

### 6. Performance Tuning

This screen should not ask "do you want optimization?" in a dumb generic way.

Instead it should show what will be applied:
- CPU tuning
- GPU fixes
- audio low-latency configuration
- I/O scheduler setup
- network tuning
- sysctl tuning

Then offer:
- Recommended (default)
- Review advanced options
- Skip specific categories

### 7. Optional Components

Keep this modular and restrained.

Possible sections:
- Development tools
- Communication apps
- Media / creative tools
- Web apps
- Terminal extras

This should feel like a curated menu, not an app store explosion.

### 8. Apply

Show a clean progress screen with meaningful steps:
- Detecting hardware quirks
- Installing compositor
- Installing DMS shell
- Applying performance tuning
- Generating theme
- Writing configs
- Finishing setup

If something fails, show the failure clearly and give recovery options.

### 9. Done

End with:
- success summary
- next steps
- commands worth knowing
- suggestion to create a snapshot

Example:

```bash
dms doctor
tacharchy status
tacharchy snapshot
```

## Architecture Notes

### UI Technology

The best fit is probably a **fullscreen DMS/Quickshell app**.

Why:
- it proves the shell stack early
- it looks consistent with the final product
- it becomes reusable for later onboarding/settings flows

Alternative:
- a lighter terminal/TUI first-boot flow

But long term, the fullscreen graphical setup is the stronger identity.

### State Model

The setup flow should be resumable.

If the machine crashes halfway through, rebooting should bring the user back into setup instead of leaving them stranded.

Track setup progress in a small state file, e.g.:

```json
{
  "phase": "first-boot",
  "step": "theme",
  "completed": ["welcome", "hardware", "compositor", "shell"]
}
```

### Recommended Documentation Hooks

The first-boot flow should link back to docs for deeper explanations:
- hardware detection → `docs/HARDWARE.md`
- performance tuning → tuning docs
- themes → `docs/THEMING.md`
- compositor choice → `docs/COMPOSITORS.md`

## What Good Looks Like

A new user should finish first boot feeling:
- the system understood their hardware
- the choices were clear
- nothing unnecessary was forced on them
- the machine now feels fast and intentional

That is the product.
