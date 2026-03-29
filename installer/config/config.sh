# Copy over Tacharchy configs
mkdir -p ~/.config
cp -R ~/.local/share/tacharchy/config/* ~/.config/

# Use default bashrc from Tacharchy
cp ~/.local/share/tacharchy/default/bashrc ~/.bashrc
