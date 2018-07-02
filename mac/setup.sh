#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

echo $SCRIPT_DIR

. ${SCRIPT_DIR}/common-functions.sh


exit 1 

brew install neovim
brew install tree

brew cask install spectacle
brew cask install virtualbox
brew cask install vagrant

brew install tmux
gem install tmuxinator


# get yarn as an alternative to npm
brew install yarn

# get a modern version of gradle
brew update gradle


# most is a better pager as it provides styling (e.g. run 'man ls' with most set as your pager)
brew install most

echo "Add this stuff to your .bashrc" 
echo export PAGER=most
echo source ~/.bin/tmuxinator.bash

