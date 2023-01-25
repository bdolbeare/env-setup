#!/usr/bin/env bash

# Lets print out all of the commands on this one since there are so many
set -x

cd "$(dirname "${BASH_SOURCE}")";

# Pull in some common functions
. ./common-functions.sh

echoingreen This script will update install or upgrade brew and then use brew to install or upgrade command-line tools and some applications


# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install findutils 
brew install gnu-sed 
brew install gnu-tar 
brew install gnu-which 
brew install grep 
brew install openssh
brew install wget 

# Install Bash 4.
brew install bash
brew install bash-completion2

# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
LINE='/usr/local/bin/bash'
grep -q "$LINE" /etc/shells || sudo bash -c "echo $LINE >> /etc/shells"
# Change to the new shell, prompts for password
echo "$SHELL" | grep -q $LINE || chsh -s /usr/local/bin/bash

# Install Python
brew install python
brew install python3

# Install ruby-build and rbenv
brew install ruby-build
brew install rbenv
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

brew install screen
# tmux 2.9 doesn't do formatting the same way which breaks my styling
#brew install tmux
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/c48bcf0cdcdd795efaf5c85200b889ef6471bb50/Formula/tmux.rb
brew install reattach-to-user-namespace
brew install tmux-xpanes
pip install --user tmuxp
#gem install tmuxinator

# Install more recent versions of some OS X tools.
brew install neovim
brew install vim 

# Install other useful binaries.
brew install ack
brew install colordiff
brew install dark-mode
brew install git
brew install git-lfs
brew install git-extras
brew install p7zip
brew install rename
brew install speedtest_cli
brew install most
brew install tree
brew install gradle
brew install yarn

# Install Docker, which requires virtualbox
brew install docker
brew install boot2docker

base=https://github.com/docker/machine/releases/download/v0.14.0 &&
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/usr/local/bin/docker-machine &&
chmod +x /usr/local/bin/docker-machine

mkdir -p ~/.bin > /dev/null 2>&1
base=https://raw.githubusercontent.com/docker/machine/v0.14.0
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
  wget --no-check-certificate -q "$base/contrib/completion/bash/${i}" -P ~/.bin
done



# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

if asktocontinue "Do you want to install cask applications?"; then 
				# Core casks
				brew cask install --appdir="/Applications" alfred
				brew cask install --appdir="~/Applications" iterm2
				brew cask install --appdir="~/Applications" java
				brew cask install --appdir="/Applications" spectacle

				# Development tool casks
				brew cask install --appdir="/Applications" sublime-text
				brew cask install --appdir="/Applications" atom
				brew cask install --appdir="/Applications" virtualbox
				brew cask install --appdir="/Applications" vagrant
				brew cask install --appdir="/Applications" macdown

				# Misc casks
				brew cask install --appdir="/Applications" google-chrome
				brew cask install --appdir="/Applications" firefox
				brew cask install --appdir="/Applications" skype
				brew cask install --appdir="/Applications" slack
				brew cask install --appdir="/Applications" dropbox
				brew cask install --appdir="/Applications" evernote
fi

# Remove outdated versions from the cellar.
brew cleanup
