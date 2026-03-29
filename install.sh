#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Tacharchy locations
export TACHARCHY_PATH="$HOME/.local/share/tacharchy"
export TACHARCHY_INSTALL="$TACHARCHY_PATH/installer"
export TACHARCHY_INSTALL_LOG_FILE="/var/log/tacharchy-install.log"
export PATH="$TACHARCHY_PATH/bin:$PATH"

# Install
source "$TACHARCHY_INSTALL/helpers/all.sh"
source "$TACHARCHY_INSTALL/preflight/all.sh"
source "$TACHARCHY_INSTALL/packaging/all.sh"
source "$TACHARCHY_INSTALL/config/all.sh"
source "$TACHARCHY_INSTALL/login/all.sh"
source "$TACHARCHY_INSTALL/post-install/all.sh"
