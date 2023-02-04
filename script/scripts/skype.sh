#!/bin/bash

# Author: phatnt
# Date modify: Feb-04-23
# Usage: Install skype


# Check architechture
checkArm=$(dpkg --print-architecture)
if [[ "$checkArm" == "arm64" ]]; then
	echo -e "${BRed}Error: Skype is not supported arm64 yet!${NC}"
    sleep 3
fi

# Skype
snapCheck=$(snap list | grep skype)
if [[ -z "$snapCheck" ]]; then
    echo -e "${BBlue}Installing Skype ...${NC}"
    sleep 1
    sudo apt-get -y install snap
    sudo snap install skype --classic
    echo -e "${BGreen}Installed Skype.\n${NC}"
fi