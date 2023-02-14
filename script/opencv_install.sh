#!/bin/bash

# Author: phatnt
# Date modify: Feb-12-23
# Usage: Install opencv from source

BBlue='\033[1;34m'
BGreen='\033[1;32m'
BRed='\033[1;31m'
BYellow='\033[1;33m'
NC='\033[0m'

export BBlue
export BGreen
export BRed
export BYellow
export NC

# Get script folder 
scriptFolder=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Global variables
opencvVer=""
cudaSupport=0
opencvLink="https://github.com/opencv/opencv.git"
contribLink="https://github.com/opencv/opencv_contrib.git"

# Check Sudo bash
if [[ "$SUDO_USER" == "" ]]; then
    >&2 echo -e "${BRed}[ERROR]: This script should be run with sudo privileges. Use 'sudo bash' before execute this script!${NC}"
    exit 1
fi
pip3 uninstall opencv_python

# Get version from repository
tags=$(git ls-remote --tags $opencvLink | sed 's/.*\///; s/\^{}//' | sort -u)
heads=$(git ls-remote --heads $opencvLink | sed 's/.*\///; s/\^{}//' | sort -u)
versions="$tags $heads"
readarray -d " " -t versionsArr <<< "$versions"
if [[ ${#versions} == 1 ]]; then
    echo -e "${BRed}[ERROR]: Cannot connect to $opencvLink!${NC}"
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
            echo -e "${BYellow}[WARNING]: Undefined version: '$A'${NC}"
        fi
    fi
done
echo -e "${BBlue}[INFO]: Selected OpenCV '$opencvVer' ...${NC}"
sleep 2

# Cuda support
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
cudaCheck=$(nvcc -V | sed -n 4p | cut -d" " -f5)
cudaCheck=${cudaCheck:0:4}
if [[ -n "$cudaCheck" ]]; then
    while : ; do
        read -p "$(echo -e $BBlue"Found Cuda '$cudaCheck'. Do you want install OpenCV with cuda support ? (Y\\\n): $NC")" A
        A=${A^^}
        if [[ "$A" == "Y" || "$A" == "y" || "$A" == "" ]]; then
            cudaSupport=1
            break
        elif [[ "$A" == "N" || "$A" == "n" ]]; then
            cudaSupport=0
            break
        fi
    done
fi

# Install
export opencvVer
export cudaSupport
cd "$scriptFolder"
bash -E ./scripts/opencv.sh
if [[ $? -ne 0 ]] ; then
    exit 1
fi


