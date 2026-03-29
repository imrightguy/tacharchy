# Allow unprivileged access to the Framework 16 keyboard for RGB control via qmk_hid.

# Check if this is a Framework 16
product_name="$(cat /sys/class/dmi/id/product_name 2>/dev/null)"
if [[ $product_name =~ Framework.*16 ]]; then
  if [[ ! -f /etc/udev/rules.d/50-framework16-qmk-hid.rules ]]; then
    # TODO: Add udev rules to Tacharchy defaults
    # sudo cp "$TACHARCHY_PATH/default/udev/framework16-qmk-hid.rules" /etc/udev/rules.d/50-framework16-qmk-hid.rules
    sudo udevadm control --reload-rules
    sudo udevadm trigger
  fi
fi
