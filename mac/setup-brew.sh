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
echo You may want to run the following:  sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
echo Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.

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
if asktocontinue "Do you want to newly installed shell to the list of allowed shells?"; then
	# Prompts for password
    LINE='/usr/local/bin/bash'
    grep -q "$LINE" /etc/shells || sudo bash -c "echo $LINE >> /etc/shells"
    # Change to the new shell, prompts for password
    # echo "$SHELL" | grep -q $LINE || chsh -s /usr/local/bin/bash
fi

# tmux 2.9 doesn't do formatting the same way which breaks my styling
brew install tmux
#brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/c48bcf0cdcdd795efaf5c85200b889ef6471bb50/Formula/tmux.rb
brew install reattach-to-user-namespace
#brew install tmux-xpanes
#pip install --user tmuxp

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
brew install maven
#brew install yarn

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Install Docker
if asktocontinue "Do you want to install docker?"; then
    brew install docker
    brew install --cask docker
fi

# Install Java
if asktocontinue "Do you want to install Java?"; then
    #brew tap homebrew/cask-versions
    brew install --cask temurin
    brew install --cask temurin17
    brew install --cask temurin11
fi

if asktocontinue "Do you want to install cask applications?"; then
  # Core casks
  #brew install --cask alfred
  brew install --cask iterm2
  brew install --cask postman
  brew install --cask spectacle
  brew install --cask google-chrome
  brew install --cask firefox
  brew install --cask slack
fi

# Remove outdated versions from the cellar.
brew cleanup
