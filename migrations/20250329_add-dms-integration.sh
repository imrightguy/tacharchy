#!/bin/bash
# Migration: Add DMS integration to Tacharchy
# Date: 2025-03-29
# Description: Ensure DMS is properly integrated with Tacharchy system

set -euo pipefail

echo "Applying migration: Add DMS integration..."

# Ensure user is in required groups
echo "  Adding user to required groups..."
sudo usermod -aG video "$USER" 2>/dev/null || true
sudo usermod -aG audio "$USER" 2>/dev/null || true

# Create DMS config directory if it doesn't exist
DMS_CONFIG="$HOME/.config/dms"
if [[ ! -d "$DMS_CONFIG" ]]; then
  echo "  Creating DMS config directory..."
  mkdir -p "$DMS_CONFIG"
fi

# Ensure DMS config has correct permissions
if [[ -d "$DMS_CONFIG" ]]; then
  echo "  Setting DMS config permissions..."
  chmod 755 "$DMS_CONFIG"
fi

echo "Migration complete: DMS integration configured"
exit 0
