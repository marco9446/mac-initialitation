#!/bin/bash

# Global variables accessible by other scripts
USERNAME=`whoami`
OS=""


macInitialization(){
	sudo which brew > /dev/null
	if [[ $? == 1 ]]; then
		# brew isn't installed
		printf "\nInstalling Xcode command line and  Homebrew ...\n"
		xcode-select --install
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	printf "\nUpdating Homebrew ...\n"
	brew update #&& brew upgrade;
	#  install python3
	brew install python3
	#  intsall node
	brew install node
	brew install lastpass-cli --with-pinentry
	brew install wget

}

# Identify what kind of machine, the script is running on
if [[ `uname` == "Darwin" ]]; then
	# we are on MACOS
	OS="Osx"
	macInitialization

elif [[ `uname` == "Linux" ]];then 
	# we are on Linux
	OS="Linux"
	sudo apt-get update
	printf "\nInstalling nodejs npm and pip3 \n"
	curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
	sudo apt-get -y install nodejs
	sudo apt-get -y install npm
	sudo apt -y install python3-pip
	sudo apt -y install ubuntu-make
	sudo apt -y install lastpass-cli
	sudo apt -y install git
else 
	printf "not supported platform"
fi

status="$(lpass status)"
echo $status 
if [[ "$status" == "Not logged in." ]]; then
	echo "Please enter your Lastpass username (mail)"
	read laspass_username
	lpass login $laspass_username

fi

printf "\nInstalling the yaml parser\n"
pip3 install PyYAML

python3 yaml_parser.py $OS $1

if [[ "$OS" == "Osx"]]; then
	source ./program_config/mac_config/mac_final_config.sh
elif [[ "$OS" == "Linux" ]]; then 
	source ./program_config/linux_config/linux_final_config.sh
fi


lpass logout -f

