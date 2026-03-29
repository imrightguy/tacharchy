# Install and configure DMS (DankMaterialShell)
# DMS is consumed as-is from upstream AUR packages

echo "Configuring DMS (DankMaterialShell)..."

# DMS is already installed via tacharchy-base.packages (dms-shell-bin)
# This script handles post-install configuration and setup

# Check if DMS binary is available
if ! command -v dms &>/dev/null; then
  echo "WARNING: dms-shell-bin not found. Installation may have failed."
  echo "Please run: paru -S dms-shell-bin"
  exit 1
fi

# Ensure user is in necessary groups for DMS to function
echo "Adding user to required groups..."
sudo usermod -aG video "$USER" 2>/dev/null || true
sudo usermod -aG audio "$USER" 2>/dev/null || true

# Initialize DMS configuration if it doesn't exist
DMS_CONFIG="$HOME/.config/dms"
if [[ ! -d "$DMS_CONFIG" ]]; then
  echo "Initializing DMS configuration directory..."
  mkdir -p "$DMS_CONFIG"
fi

# Set up DMS to autostart in supported compositors
# This will be handled by the DMS package itself in future versions
# For now, we rely on user to enable DMS manually

echo "DMS configured successfully"
echo "To start DMS, run: dms"
echo "To enable DMS autostart in your compositor, see DMS documentation at https://danklinux.com/docs"
