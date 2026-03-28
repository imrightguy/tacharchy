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
├── README.md           # Project overview
├── ROADMAP.md          # Development roadmap
├── BRAND.md            # Brand guidelines
├── LICENSE             # MIT
├── docs/               # Documentation
│   ├── sysctl.md       # Tuning explanations
│   ├── compositors.md  # Compositor setup guides
│   └── themes.md       # Theme system docs
├── packages/           # AUR package PKGBUILDs
│   ├── tacharchy-foundation/
│   ├── tacharchy-sysctl/
│   ├── tacharchy-audio/
│   ├── tacharchy-gpu/
│   ├── tacharchy-network/
│   ├── tacharchy-io/
│   ├── tacharchy-cpu/
│   └── tacharchy-detect/
├── install/            # Installer scripts
│   ├── boot.sh         # Entry point (curl | sh)
│   ├── preflight/      # System checks
│   ├── packaging/      # Package installation
│   ├── config/         # Configuration application
│   ├── themes/         # Theme system
│   ├── hardware/       # Hardware detection
│   └── post-install/   # First-run wizard
└── themes/             # Theme packs
    ├── tacharchy/      # Default (dark orange)
    ├── catppuccin/
    ├── gruvbox/
    └── ...
```

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(sysctl): add zram swap detection
fix(niri): correct theme color parsing
docs(readme): add installation instructions
refactor(detect): simplify GPU detection logic
```

## Code Style

- Shell scripts: follow the existing Omarchy patterns (set -eEo pipefail, helpers in lib/)
- Config files: clear comments explaining why, not just what
- PKGBUILDs: follow Arch packaging guidelines

## Adding a New Compositor

1. Create config template in `install/config/compositors/<name>/`
2. Add theme integration (border colors, background, text)
3. Add keybind defaults
4. Add to the compositor selection menu
5. Test with all supported themes
6. Document in `docs/compositors.md`

## Adding a New Theme

1. Create directory in `themes/<name>/`
2. Add `colors.toml` with the color palette
3. Add per-app configs (neovim.lua, vscode.json, btop.theme, etc.)
4. Add 1-3 background images
5. Add `preview.png` (1280x720 screenshot)
6. Test with all supported compositors
7. Submit PR

## Adding a Sysctl Tuning

Every tuning value must include:
1. The value and its file path
2. Why this value (not just what it does)
3. The research or reasoning behind it
4. Any tradeoffs or risks
5. Which systems it applies to (all, NVIDIA-only, hybrid CPU, etc.)

See `docs/sysctl.md` for the format.

## Reporting Issues

When reporting bugs, include:
- Distro and version
- Compositor and version
- Output of `tacharchy-doctor` (if available)
- Steps to reproduce
- Expected vs actual behavior

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
