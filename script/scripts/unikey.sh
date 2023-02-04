#!/bin/bash

# Author: phatnt
# Date modify: Feb-04-23
# Usage: Install ibus bamboo

unikeyCheck=$(dpkg -l| grep ibus-bamboo)
if [[ -z "$unikeyCheck" ]]; then
	echo -e "${BBlue}Installing Unikey ...${NC}"
	echo -ne '\n' | sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
	sudo apt-get update
	sudo apt-get -y install ibus-bamboo
	echo -e "${BGreen}Install ibus-bamboo sucess!\n${NC}"
	sleep 1
else
	echo -e "${BGreen}Installed ibus-bamboo already.\n${NC}"
	sleep 1
fi


