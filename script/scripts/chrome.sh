#!/bin/bash

# Author: Leonard
# Date modify: Jan-03-23
# Usage: Install Google Chrome

chromeLink="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# Check architechture
checkArm=$(dpkg --print-architecture)
if [[ "$checkArm" == "arm64" ]]; then
	echo -e "${BRed}Error: Google chrome is not supported arm64 yet!${NC}"
    sleep 3
fi

# Chrome
chromeCheck=$(dpkg -l | grep google-chrome-stable)
if [[ -z "$chromeCheck" ]]; then
    echo -e "${BBlue}Installing Chrome ...${NC}"
    sleep 1
    cd /tmp
    wget $chromeLink -O google.deb
    if [[ $? -ne 0 ]]; then
        echo -e "${BRed}Error: Could not download google chrome!${NC}"
        sleep 3
    else
        sudo dpkg -i --force-depends google.deb
        echo -e "${BGreen}Installed Chrome.\n${NC}"
        rm google.deb
    fi
fi