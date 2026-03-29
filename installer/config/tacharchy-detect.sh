# Run Tacharchy hardware detection and apply performance tuning
echo "Running Tacharchy hardware detection..."

if command -v tacharchy-detect &>/dev/null; then
  sudo tacharchy-detect --apply
  echo "Tacharchy hardware detection and tuning applied"
else
  echo "Warning: tacharchy-detect not found, skipping hardware-specific tuning"
fi
