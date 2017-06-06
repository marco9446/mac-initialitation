# Description
This script configure most of the software I use on my Mac or Linux machines 

# Installation
1. (on Mac) Ensure Apple's command line tools are installed ( you will ask to install it automatically or you can do it manually by running xcode-select --install to launch the installer).
2. Clone this repository to your local drive.
3. Move into the repo and run the main script with `$ ./main.sh`


# List of Programs
The list of the program that will be installed is contained in the `program_list.yaml` file, you can add more programs or modify the existing ones using the parameters listed below

# Feature

Currently my script is capable of installing programs using the following package managers in a Unix environment.

- [pip3](https://pypi.python.org/pypi/pip?)
- [npm](https://www.npmjs.com/)  
- [apt](https://en.wikipedia.org/wiki/Advanced_Packaging_Tool)
- [homebrew](https://brew.sh/)
- [umake](https://wiki.ubuntu.com/ubuntu-make)

The installation procedure is very customizable. The user can specify a variety of yaml attributes for each program, in order to fulfill all his/her requirements.

| Attribute | Type | Description |
| --------- |:---:|:-----------:|
| name  | String | friendly name of the program |
| os | List | list of operating systems on which the program can be installed. Possible choices are: Osx, Linux, Raspberry.|
| installers | List | Possible choices are: brew, brewcask, apt, umake, pip, npm |
| configurator | String | (Optional) Path of the script to execute after the successful installation of the program |
| brew_name | String | (Optional) name of the brew formula to be installed. If not specified it would be used the name parameter |
| apt_name | String | (Optional) name of the apt or umake packet to be installed. If not specified it would be used the name parameter |
| pip_npm_name | String | (Optional) name of the pip or npm packet to be called. If not specified it would be used the name parameter|
| confirm_installation | Boolean | (Optional, Default true) if true the script will ask a confirmation, before the installation of the program | 
| shell | Object | A shell command that has to be executed BEFORE the installation of the program. To use it you have to specify these 2 keys: 'os: List // list of operating systems on which the command should be executed. ' and 'command: String // shell command'

You can also modify 2 bash scripts, the `program_config/mac_config/mac_final_config.sh` and `program_config/linux_config/linux_final_config.sh` that will be executed at the end of the installation procedure 

# Dependencies
To operate, my script requires the installations of some programs (don't worry it will install them automatically)

* python3
* node and npm
* lastpass-cli (very usefully to secretly store tokens or password for your scripts)
* wget (Only Mac)
* xcode-select (Only Mac)
* git
* umake (Only Linux)


# Tips
1. you can install a single program ( for example for testing your configuration ) by passing his name parameter to the main.sh script. ex `./main.sh "Chrome Beta"`


