# Install all base packages
mapfile -t packages < <(grep -v '^#' "$TACHARCHY_INSTALL/tacharchy-base.packages" | grep -v '^$')
tacharchy-pkg-add "${packages[@]}"
