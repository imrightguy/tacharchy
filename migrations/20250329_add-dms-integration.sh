#!/bin/bash
# Migration kept for compatibility after removing DMS dependency
# Date: 2025-03-29
# Description: No-op placeholder so older installs do not fail when replaying migrations

set -euo pipefail

echo "Applying compatibility migration: skip removed DMS integration..."
echo "Nothing to do. Tacharchy no longer depends on DMS."
exit 0
