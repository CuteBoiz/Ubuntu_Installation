#!/bin/bash

# Author: phatnt
# Date modify: Feb-04-23
# Usage: Install prerequisted package


F_checkAndInstall () {
    versionCheck=$(dpkg -s $1 | grep Version)
    versionCheck=${versionCheck:9:-1}
    if [[ -n "$versionCheck" ]]; then
        echo -e "Already installed $1-$versionCheck"
    else
        sudo apt-get -y install $1
        versionCheck=$(dpkg -s $1 | grep Version)
        versionCheck=${versionCheck:9:-1}
        if [[ -z "$versionCheck" ]]; then
            >&2 echo -e "${BRed}[ERROR]: 'sudo apt-get -y install $1' failed!${NC}"
            exit 1
        fi
    fi
}

sudo apt-get update
sudo apt-get -y upgrade
F_checkAndInstall "build-essential"
F_checkAndInstall "git"
F_checkAndInstall "checkinstall"
F_checkAndInstall "pkg-config"
F_checkAndInstall "automake"
F_checkAndInstall "curl"

