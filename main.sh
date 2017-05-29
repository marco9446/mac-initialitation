#!/bin/bash

# Global variables accessible by other scripts
USERNAME=`whoami`


# Identify what kind of machine, the script is running on
if [[ `uname` == "Darwin" ]]; then
	# we are on MACOS
	echo "Executing mac script ..."
	source ./mac_script.sh

elif [[ `uname` == "Linux" ]];then 
	# we are on Linux
	echo	echo "Executing Linux script ..."
	source ./linux_apt_script.sh
else 
	echo "not supported platform"
fi
