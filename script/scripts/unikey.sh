#!/bin/bash

# Author: phatnt
# Date modify: Feb-04-23
# Usage: Install ibus bamboo

unikeyCheck=$(dpkg -l| grep ibus-bamboo)
if [[ -z "$unikeyCheck" ]]; then
	echo -e "${BBlue}[INFO]: Installing ibus-bamboo ...${NC}"
	echo -ne '\n' | sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
	sudo apt-get update
	sudo apt-get -y install ibus-bamboo
	echo -e "${BGreen}[INFO]: Install ibus-bamboo sucess!${NC}"
	sleep 2
else
	echo -e "${BBlue}[INFO]: Installed ibus-bamboo already.${NC}"
	sleep 2
fi


