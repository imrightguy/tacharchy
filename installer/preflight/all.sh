source $TACHARCHY_INSTALL/preflight/guard.sh
source $TACHARCHY_INSTALL/preflight/begin.sh
run_logged $TACHARCHY_INSTALL/preflight/show-env.sh
run_logged $TACHARCHY_INSTALL/preflight/pacman.sh
run_logged $TACHARCHY_INSTALL/preflight/migrations.sh
run_logged $TACHARCHY_INSTALL/preflight/first-run-mode.sh
run_logged $TACHARCHY_INSTALL/preflight/disable-mkinitcpio.sh
