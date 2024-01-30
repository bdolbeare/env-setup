#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# Pull in some common functions
. ./common-functions.sh

echoingreen This script will update your mac with available OS updates

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osxprep.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#  Update the OS 
echo "------------------------------"
echo "Updating OSX.  If this requires a restart, run the script again." 
sudo softwareupdate -l
if asktocontinue "Do you want to instll these OS updates?"; then 
	sudo softwareupdate -iaR --verbose
fi

#  Install Xcode Tools
echo "------------------------------"
echo "Installing XCode."
if xcode-select -v > /dev/null 2>&1; then
	echo "XCode already installed"
	xcode-select -v
else
	if asktocontinue "Do you want to insatll Xcode Command Line Tools?"; then 
		xcode-select --install
	fi
fi

#  Setting defaults
echo "------------------------------"
echo "Setting defaults."

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# Save screenshots to the Pictures/Screenshots
mkdir ${HOME}/Pictures/Screenshots
defaults write com.apple.screencapture "location" -string "${HOME}/Pictures/Screenshots" && killall SystemUIServer

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture "type" -string "png" && killall SystemUIServer


# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "true" && killall Finder
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "true" && killall Finder
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool "true" && killall Finder
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool "true" && killall Finder

# Finder: show hidden files by default
defaults write com.apple.finder "AppleShowAllFiles" -bool "true" && killall Finder

# Finder: show all filename extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" && killall Finder

# Finder: show status bar
#defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder

# Finder: default to list view
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv" && killall Finder

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf" && killall Finder

# Disable the warning when changing a file extension
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false" && killall Finder

# Finder: Keep folders on top when sorting
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true" && killall Finder

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Show item info at the bottom of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist

# Set the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 24" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 24" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 24" ~/Library/Preferences/com.apple.finder.plist

# Show the ~/Library folder
chflags nohidden ~/Library

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true \
    && killall Finder

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36 && killall Dock

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true && killall Dock

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false && killall Dock

# Remove the auto-hiding Dock delay
defaults write com.apple.dock "autohide-time-modifier" -float "0" && killall Dock

# Don't show recent apps in Dock
defaults write com.apple.dock "show-recents" -bool "false" && killall Dock

# Use Genie effect for minimize windows
defaults write com.apple.dock "mineffect" -string "genie" && killall Dock

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true && killall Dock

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0


echo "Done. Note that some of these changes require a logout/restart of your OS to take effect.  At a minimum, be sure to restart your Terminal."



