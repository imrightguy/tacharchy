# Tacharchy Migrations

This directory contains timestamp-based migrations that are applied via `tacharchy migrate`. Older migrations may remain as no-op compatibility shims when project direction changes.

## Naming Convention

Migrations should be named using the format: `YYYYMMDD_description.sh`

Example: `20250329_adjust-theme-layout.sh`

## Migration Script Format

Each migration should be a bash script that:

1. Checks if the migration is needed
2. Performs the migration steps
3. Returns 0 on success, non-zero on failure

Example:

```bash
#!/bin/bash
set -euo pipefail

echo "Applying migration: Adjust theme layout..."

# Migration logic here...

echo "Migration complete."
exit 0
```

## Applied Migrations

The file `migrations-applied.txt` in the parent directory tracks which migrations have been applied.
