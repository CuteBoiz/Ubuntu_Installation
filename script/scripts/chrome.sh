#!/bin/bash

# Author: Leonard
# Date modify: Jan-03-23
# Usage: Install Google Chrome

chromeLink="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# Check architechture
checkArm=$(dpkg --print-architecture)
if [[ "$checkArm" == "arm64" ]]; then
	echo -e "${BRed}[ERROR]: Google chrome is not supported arm64 yet!${NC}"
    sleep 3
fi

# Chrome
chromeCheck=$(dpkg -l | grep google-chrome-stable)
if [[ -z "$chromeCheck" ]]; then
    echo -e "${BBlue}[INFO]: Installing Chrome ...${NC}"
    sleep 2
    cd /tmp
    wget $chromeLink -O google.deb
    if [[ $? -ne 0 ]]; then
        echo -e "${BRed}[ERROR]: Could not download google chrome!${NC}"
        sleep 3
    else
        sudo dpkg -i --force-depends google.deb
        chromeCheck=$(dpkg -l | grep google-chrome-stable)
        if [[ -z "$chromeCheck" ]]; then
            echo -e "${BRed}[ERROR]: Install Google chrome failed! ${NC}"
            sleep 3
        fi
        rm google.deb
        echo -e "${BGreen}[INFO]: Install Google chrome successfully.\n${NC}"
        sleep 2
    fi
else
    echo -e "${BBlue}[INFO]: Installed Google chrome  already.\n${NC}"
    sleep 2
fi