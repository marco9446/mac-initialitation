#!/bin/bash

printf "This script will install some programs automatically \n\n"

# check if homebrew is installed
sudo which brew > /dev/null
if [[ $? == 1 ]]; then
	# brew isn't installed
	echo "\nInstalling Xcode command line and  Homebrew ..."
	xcode-select --install
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo ''
echo "Updating Homebrew ..."
brew update && brew upgrade;