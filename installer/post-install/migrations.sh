# Run Tacharchy migrations after installation

echo "Running Tacharchy migrations..."

if [[ -f "$TACHARCHY_PATH/bin/tacharchy" ]]; then
  export PATH="$TACHARCHY_PATH/bin:$PATH"
  tacharchy migrate || echo "Warning: Some migrations failed"
else
  echo "Tacharchy CLI not found, skipping migrations"
fi

echo "Tacharchy migrations complete"
