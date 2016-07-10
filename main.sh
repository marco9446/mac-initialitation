#!/bin/bash
# This script will help you to restore your working environment,
# 		installing all the main programs and dev tools

echo "This script will install some programs automatically"
read -n1 -r -p "Press any key to continue, otherwise quit... "

# check if homebrew is installed
sudo which brew > /dev/null
if [[ $? == 1 ]]; then
	# brew isn't installed
	echo "\nInstalling Xcode command line and  Homebrew ..."
	xcode-select --install
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	if [[ $? != 0 ]]; then
		echo "The installation of Homebrew had some problems, you probably need to change the /user/local permission "
		echo "changing permission ...\n"
		sudo chown -R $(whoami):admin /usr/local
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
fi

echo ''
echo "Updating Homebrew ..."
brew update && brew upgrade;


# automatically install some useful brew packages
brew cask install java
brew cask install logitech-control-center
brew install node
brew install python3
brew install mongodb

# ask to install some applications
echo ""

function decisionMaker() {
	# pass the name of package as parameter
	printf '\e[0;32m'
    read -p "Do you want to install ___"$1"___ via Homebrew? (y/N) " decision
    printf '\e[0m'
    decision=${decision:-n} #default value is n
    if [[ $decision == 'n' || $decision == 'N' ]]; then
    	return 1;
    else
    	return 0;
    fi
}

# Sublime-text3
if decisionMaker 'Sublime_Text3' ; then
	brew install caskroom/cask/brew-cask
	brew tap caskroom/versions
	brew cask install sublime-text3
	open /Applications/Sublime\ Text.app
	echo "Copy these lines in sublime terminal to install package control"
	echo "import urllib.request,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)"
	read -p "waiting until press enter..." waits
fi

# list of program to install
programs=( 'google-chrome-beta' 'chrome-remote-desktop-host' 'spectacle' 'github-desktop' 'yujitach-menumeters' 'intellij-idea' 'vlc'
						'skype' 'youtube-to-mp3' 'kodi' 'flux' 'spotify' 'android-studio' 'firefox-beta'
						'smcfancontrol' 'google-drive'
					)

for i in "${programs[@]}"
do
	if decisionMaker $i; then
		brew cask install $i
	fi
done


# Atom
if decisionMaker 'Atom'; then
	brew cask install atom;
	# install Sync settings
	echo 'Insatlling Sync settings Atoom package...'
	apm install sync-settings
	open https://github.com/atom-community/sync-settings
	read -n1 -r -p "Follow the instructions than press any key to continue..."
fi

# Firebase cli
if decisionMaker 'Firebase_CLI'; then
	sudo npm install -g firebase-tools;
fi

# Polymer cli
if decisionMaker 'Polymer_CLI'; then
	sudo npm install -g polymer-cli;
fi

# Android sdk
if decisionMaker 'Android_SDK'; then
	brew install android-sdk;
fi

# Gulp
if decisionMaker 'Gulp'; then
	sudo npm install --global gulp-cli;
fi

# Iterm2
if decisionMaker 'iTerm2'; then
	bower install git://github.com/adobe-fonts/source-code-pro.git#release
	brew cask install iterm2
	open /Applications/iTerm.app
	echo "\033[0;33m\033[5mCopy these command in iterm2 to install zsh\033[25m\033[0m";
	echo '$ sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"';
	echo "remember to change the font to 'source code pro'\n";
	read -n1 -r -p "When finished press any key to continue... "
	cp ./zshConfiguration.sh ~/.zshrc
fi
echo ''
echo "Making some final adjustments"


#_______________ 	OSX settings   ________________


# Expand Save Panel by Default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true && \
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Enable sound when charger is connected
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true; open /System/Library/CoreServices/PowerChime.app &

# cleanup brew installations
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*
echo "
  ______       _
 |  ____|     (_)
 | |__   _ __  _  ___  _   _   _   _  ___  _   _ _ __   _ __ ___   __ _  ___
 |  __| | '_ \| |/ _ \| | | | | | | |/ _ \| | | | '__| | '_ ' _ \ / _' |/ __|
 | |____| | | | | (_) | |_| | | |_| | (_) | |_| | |    | | | | | | (_| | (__
 |______|_| |_| |\___/ \__, |  \__, |\___/ \__,_|_|    |_| |_| |_|\__,_|\___|
             _/ |       __/ |   __/ |
            |__/       |___/   |___/                                         \n";

exit 0;
