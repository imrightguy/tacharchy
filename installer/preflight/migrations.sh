TACHARCHY_MIGRATIONS_STATE_PATH=~/.local/state/tacharchy/migrations
mkdir -p $TACHARCHY_MIGRATIONS_STATE_PATH

for file in ~/.local/share/tacharchy/migrations/*.sh; do
  touch "$TACHARCHY_MIGRATIONS_STATE_PATH/$(basename "$file")"
done
