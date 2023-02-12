#!/bin/bash

# Author: phatnt
# Date modify: Jan-03-23
# Usage: Install VSCode

# VSCode
vscodeCheck=$(dpkg -s code | grep Version)
if [[ -z "$vscodeCheck" ]]; then
	echo -e "${BBlue}[INFO]: Installing VSCode ...${NC}"
	sleep 2
	sudo apt-get update 
	sudo apt-get -y install software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt-get update 
	sudo apt-get -y install code
	vscodeCheck=$(dpkg -s code | grep Version)
	vscodeCheck=$(dpkg -s code| grep Version)
    if [[ -z "$vscodeCheck" ]]; then
        echo -e "${BRed}[ERROR]: Install VSCode failed!${NC}"
        sleep 3
    fi
    echo -e "${BGreen}[INFO]: Install VSCode successfully!${NC}"
else
	echo -e "${BBlue}[INFO]: Installed VSCode already.${NC}"
	sleep 2
fi