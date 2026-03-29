if [[ -n ${TACHARCHY_ONLINE_INSTALL:-} ]]; then
  # Install build tools
  tacharchy-pkg-add base-devel

  # Configure pacman (will use Arch mirrors for now)
  # TODO: Set up Tacharchy mirrors when available
  # sudo cp -f ~/.local/share/tacharchy/default/pacman/pacman-${TACHARCHY_MIRROR:-stable}.conf /etc/pacman.conf
  # sudo cp -f ~/.local/share/tacharchy/default/pacman/mirrorlist-${TACHARCHY_MIRROR:-stable} /etc/pacman.d/mirrorlist

  # For now, use standard Arch mirrors
  sudo pacman -Sy

  # TODO: Add Tacharchy keyring when available
  # sudo pacman-key --recv-keys <TACHARCHY_KEY> --keyserver keys.openpgp.org
  # sudo pacman-key --lsign-key <TACHARCHY_KEY>
  # tacharchy-pkg-add tacharchy-keyring

  # Refresh all repos
  sudo pacman -Syyuu --noconfirm
fi
