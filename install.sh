# Remove nvim old plugins
rm -rf ~/.local/share/nvim
 
# Open nvim to start packer installation
nvim --headless +qa 

# Open nvim to start other plugins installations
nvim --noplugin +PackerSync
