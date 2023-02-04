#!/bin/bash

# Author: phatnt
# Date modify: Feb-03-23
# Usage: Install opencv from source


BBlue='\033[1;34m'
BGreen='\033[1;32m'
BRed='\033[1;31m'
BYellow='\033[1;33m'
NC='\033[0m'

scriptFolder=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
export BBlue
export BGreen
export BRed
export BYellow
export NC

opencvLink="https://github.com/opencv/opencv.git"
contribLink="https://github.com/opencv/opencv_contrib.git"
opencvVer=""

# Check Sudo bash
if [[ "$SUDO_USER" == "" ]]; then
    echo -e "${BRed}Use 'sudo bash' before executing this script!${NC}"
    exit 1
fi
pip3 uninstall opencv_python

# Get version from repo
tags=$(git ls-remote --tags $opencvLink | sed 's/.*\///; s/\^{}//' | sort -u)
heads=$(git ls-remote --heads $opencvLink | sed 's/.*\///; s/\^{}//' | sort -u)
versions="$tags $heads"
readarray -d " " -t versionsArr <<< "$versions"
if [[ ${#versions} == 1 ]]; then
    echo -e "${BRed}Error: Cannot connect to $opencvLink!${NC}"
    exit 1
fi

# Choose version
while : ; do
    read -p "$(echo -e $BBlue"Choose OpenCV Version
${NC}(Press ${BBlue}l${NC} to list all available tags)
(Press ${BBlue}Return/Enter${NC} to install master branch)${BBlue}: $NC")" A
    if [[ $A == "l" || $A == "L" ]]; then
        for ver in ${versionsArr[@]}; do
            echo -e "$ver"
        done
    else
        if [[ "$A" == "" ]]; then
            opencvVer="master"
        fi
        for ver in ${versionsArr[@]}; do
            if  [[ "$ver" == "$A" ]]; then
                opencvVer=$A
            fi
        done
        if [[ "$opencvVer" != "" ]]; then

            break;
        else
            echo -e "Undefined version: \"$A\""
        fi
    fi
done
echo -e "Installing OpenCV_$opencvVer ..."

# Install
export opencvVer
cd "$scriptFolder"
sudo bash -E ./scripts/opencv.sh
if [[ $? -ne 0 ]] ; then
    exit 1
fi


