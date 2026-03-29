if [[ $(plymouth-set-default-theme) != "tacharchy" ]]; then
  sudo cp -r "$HOME/.local/share/tacharchy/default/plymouth" /usr/share/plymouth/themes/tacharchy/
  sudo plymouth-set-default-theme tacharchy
fi
