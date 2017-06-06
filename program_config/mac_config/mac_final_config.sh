
# Expand Save Panel by Default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true && \
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Enable sound when charger is connected
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true; open /System/Library/CoreServices/PowerChime.app &

# cleanup brew installations
brew cleanup --force

defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

# Set wallpaper
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/marcoravazzini/mac-initialitation/program_config/mac_config/house.jpg"'
