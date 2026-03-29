# Show installation environment variables
gum log --level info "Installation Environment:"

env | grep -E "^(TACHARCHY_CHROOT_INSTALL|TACHARCHY_ONLINE_INSTALL|TACHARCHY_USER_NAME|TACHARCHY_USER_EMAIL|USER|HOME|TACHARCHY_REPO|TACHARCHY_REF|TACHARCHY_PATH)=" | sort | while IFS= read -r var; do
  gum log --level info "  $var"
done
