#!/bin/bash

# Author: phatnt
# Date modify: Feb-04-23
# Usage: Install microsoft edge

edgeCheck=$(dpkg -s microsoft-edge-stable| grep Version)
if [[ -z "$edgeCheck" ]]; then
    cd /tmp
    sudo apt-get update 
    sudo apt-get -y install software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://packages.microsoft.com/repos/edge stable main"
    sudo apt-get update 
    sudo apt-get -y install microsoft-edge-stable
    edgeCheck=$(dpkg -s microsoft-edge-stable| grep Version)
    if [[ -z "$edgeCheck" ]]; then
        echo -e "${BRed}Error: Install Microsoft Edge failed!${NC}"
        sleep 3
    fi
    echo -e "${BGreen}Install Microsoft Edge success!${NC}"
    sleep 1
else
    echo -e "${BGreen}Installed Microsoft Edge already!${NC}"
    sleep 1
fi