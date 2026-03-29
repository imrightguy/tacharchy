#!/bin/bash

# Set install mode to online since boot.sh is used for curl installations
export TACHARCHY_ONLINE_INSTALL=true

# Tacharchy ASCII art — τ (tau) symbol, sharp and fast
ansi_art='
                    τ
  ████████ ██    ██ ██████  ███████ ██████  ████████ ███████
  ██        ██  ██  ██   ██ ██      ██   ██    ██    ██
  █████     ████   ██████  █████   ██████     ██    ███████
  ██        ██  ██  ██   ██ ██      ██   ██    ██         ██
  ████████ ██    ██ ██   ██ ███████ ██   ██    ██    ███████
'

clear
echo -e "\n$ansi_art\n"

# Use custom branch if instructed, otherwise default to main
TACHARCHY_REF="${TACHARCHY_REF:-main}"

# TODO: Set up Tacharchy mirrors when available
# For now, use standard Arch mirrors
echo "Using Arch Linux mirrors (Tacharchy mirrors coming soon)"

sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified, otherwise default to rightguy/tacharchy
TACHARCHY_REPO="${TACHARCHY_REPO:-rightguy/tacharchy}"

echo -e "\nCloning Tacharchy from: https://github.com/${TACHARCHY_REPO}.git"
rm -rf ~/.local/share/tacharchy/
git clone "https://github.com/${TACHARCHY_REPO}.git" ~/.local/share/tacharchy >/dev/null

echo -e "\e[32mUsing branch: $TACHARCHY_REF\e[0m"
cd ~/.local/share/tacharchy
git fetch origin "${TACHARCHY_REF}" && git checkout "${TACHARCHY_REF}"
cd -

echo -e "\nInstallation starting..."
source ~/.local/share/tacharchy/install.sh
