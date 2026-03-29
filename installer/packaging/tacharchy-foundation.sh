# Install Tacharchy performance tuning packages
# This installs the tacharchy-foundation meta-package which pulls in all 8 tuning packages

echo "Installing Tacharchy performance tuning packages..."

# Check if paru is installed (needed for AUR packages)
if ! command -v paru &>/dev/null; then
  echo "Installing paru (AUR helper)..."
  tacharchy-pkg-add paru
fi

# Install tacharchy-foundation meta-package from local PKGBUILDs
TACHARCHY_PACKAGES="$TACHARCHY_PATH/../packages"

if [[ -d "$TACHARCHY_PACKAGES/tacharchy-foundation" ]]; then
  echo "Installing tacharchy-foundation from local source..."
  cd "$TACHARCHY_PACKAGES/tacharchy-foundation"
  paru -U --noconfirm -i
else
  echo "Installing tacharchy-foundation from AUR..."
  paru -S --noconfirm tacharchy-foundation
fi

echo "Tacharchy performance packages installed"
