# Contributing to Tacharchy

Thank you for your interest! Here's how to get started.

## Getting Started

1. **Fork the repo** and clone your fork
2. **Pick an issue** from the [issue tracker](https://github.com/imrightguy/tacharchy/issues) labeled `good first issue`
3. **Create a branch** from `main` (e.g. `feat/sysctl-nvidia` or `fix/niri-theme`)
4. **Make your changes** with clear commit messages
5. **Open a pull request**

## Project Structure

```
tacharchy/
├── README.md               # Project overview
├── ROADMAP.md              # Development roadmap
├── BRAND.md                # Brand guidelines
├── LICENSE                 # MIT
├── docs/                   # Documentation
│   ├── ARCHITECTURE.md     # System architecture and design
│   ├── COMPOSITORS.md      # Supported Wayland compositors
│   ├── THEMING.md          # Theme system (matugen + colors.toml)
│   ├── HARDWARE.md         # Hardware detection and vendor fixes
│   ├── sysctl.md           # Sysctl tuning reference
│   ├── cpu.md              # CPU tuning reference
│   ├── gpu.md              # GPU tuning reference
│   ├── audio.md            # Audio tuning reference
│   ├── network.md          # Network tuning reference
│   └── io.md               # I/O tuning reference
├── packages/               # AUR package PKGBUILDs
│   ├── tacharchy-foundation/
│   ├── tacharchy-sysctl/
│   ├── tacharchy-audio/
│   ├── tacharchy-gpu/
│   ├── tacharchy-network/
│   ├── tacharchy-io/
│   ├── tacharchy-cpu/
│   └── tacharchy-detect/
├── tms/                    # TMS shell (forked from DankMaterialShell)
│   ├── quickshell/         # QML shell interface
│   ├── core/               # Go backend + CLI
│   └── distro/             # Cross-distro packaging specs
├── themes/                 # Static theme packs (colors.toml format)
│   ├── tacharchy/          # Default (dark orange)
│   └── ...
└── migrations/             # Omarchy-style timestamped migrations
    └── 1xxxxxxxxx.sh
```

## What We Fork

- **[DankLinux/DMS](https://github.com/AvengeMedia/DankMaterialShell)** — TMS shell, Go backend, cross-distro packaging, plugins
- **[Omarchy](https://github.com/basecamp/omarchy)** — Hardware detection, migrations, theme library, app configs

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the full breakdown.

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(sysctl): add zram swap detection
fix(niri): correct theme color parsing
docs(readme): add installation instructions
refactor(detect): simplify GPU detection logic
```

## Code Style

- **Go:** follow the existing DMS/core patterns (standard gofmt, tests in same package)
- **QML:** follow the existing DMS/quickshell patterns (Qt naming conventions)
- **Shell scripts:** `set -eEo pipefail`, helper functions in shared files
- **Config files:** clear comments explaining *why*, not just *what*
- **PKGBUILDs:** follow Arch packaging guidelines

## Adding a Tuning Value

Every tuning value must include:

1. The value and its file path
2. **Why** this value (not just what it does)
3. The research or reasoning behind it
4. Any tradeoffs or risks
5. Which systems it applies to (all, NVIDIA-only, hybrid CPU, NVMe-only, etc.)
6. Source links (kernel docs, upstream projects, papers)

See `docs/sysctl.md` for the reference format.

## Adding Hardware Support

1. Identify the vendor/model and the specific issue
2. Write a detection script (shell or Go, matching the existing pattern)
3. Write the fix script with clear comments
4. Test on real hardware (or VM with matching PCI IDs)
5. Add to the hardware detection flow
6. Document in `docs/HARDWARE.md`
7. Submit PR with hardware details in the description

## Adding a Compositor

1. Create config template in the TMS shell or config layer
2. Add theme integration (border colors, background, text)
3. Add keybind defaults matching our consistency table
4. Add to the compositor selection menu in the installer
5. Test with TMS shell and standalone (no shell)
6. Test with multiple themes
7. Document in `docs/COMPOSITORS.md`

## Adding a Theme

1. Create directory in `themes/<name>/`
2. Add `colors.toml` with the full color palette
3. Add per-app configs (neovim.lua, vscode.json, btop.theme, ghostty config, etc.)
4. Add 1-3 background images
5. Add `preview.png` (1280x720 screenshot)
6. Test with all supported compositors
7. Submit PR

## TMS Plugin Compatibility

TMS maintains API compatibility with DMS plugins. When modifying the shell:

- **Do not** change the plugin API without discussion
- **Do** add new plugin hooks (extending is fine)
- **Test** with existing DMS plugins before merging
- See [DankMaterialShell plugin docs](https://danklinux.com/docs/dankmaterialshell/plugins-overview)

## Reporting Issues

Include:
- Distro and version
- Compositor and version
- Output of `tacharya doctor`
- Steps to reproduce
- Expected vs actual behavior

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
