# Set identification from install inputs
if [[ -n ${TACHARCHY_USER_NAME//[[:space:]]/} ]]; then
  git config --global user.name "$TACHARCHY_USER_NAME"
fi

if [[ -n ${TACHARCHY_USER_EMAIL//[[:space:]]/} ]]; then
  git config --global user.email "$TACHARCHY_USER_EMAIL"
fi
