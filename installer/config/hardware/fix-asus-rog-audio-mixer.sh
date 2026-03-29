# Fix audio volume on Asus ROG laptops by using a soft mixer.

# Check if this is an ASUS ROG laptop
product_name="$(cat /sys/class/dmi/id/product_name 2>/dev/null)"
if [[ $product_name =~ ROG ]]; then
  mkdir -p ~/.config/wireplumber/wireplumber.conf.d/
  # TODO: Add wireplumber config to Tacharchy defaults
  # cp $TACHARCHY_PATH/default/wireplumber/wireplumber.conf.d/alsa-soft-mixer.conf ~/.config/wireplumber/wireplumber.conf.d/
  rm -rf ~/.local/state/wireplumber/default-routes

  # Unmute the Master control on the ALC285 card (often muted by default)
  card=$(aplay -l 2>/dev/null | grep -i "ALC285" | head -1 | sed 's/card \([0-9]*\).*/\1/')
  if [[ -n $card ]]; then
    amixer -c "$card" set Master 80% unmute 2>/dev/null
  fi
fi
