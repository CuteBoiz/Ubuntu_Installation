#!/bin/bash

# Author: phatnt
# Date modify: Feb-04-23
# Usage: Install skype


# Check architechture
checkArm=$(dpkg --print-architecture)
if [[ "$checkArm" == "arm64" ]]; then
	echo -e "${BRed}[ERROR]: Skype is not supported arm64 yet!${NC}"
    sleep 3
fi

# Skype
snapCheck=$(snap list | grep skype)
if [[ -z "$snapCheck" ]]; then
    echo -e "${BBlue}[INFO]: Installing Skype ...${NC}"
    sleep 2
    sudo apt-get -y install snap
    sudo snap install skype --classic
    echo -e "${BGreen}[INFO]: Installed Skype already.${NC}"
fi