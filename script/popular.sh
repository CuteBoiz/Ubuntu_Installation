#!/bin/bash
BBlue='\033[1;34m'
BGreen='\033[1;32m'
NC='\033[0m'

chromeLink="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
skypeLink="https://go.skype.com/skypeforlinux-64.deb"
isArm=0

# Check Sudo bash
if [[ "$SUDO_USER" == "" ]]; then
    echo -e "${BRed}Use 'sudo bash' before executing this script!${NC}"
    exit 1
fi

# Check architechture
checkArm=$(dpkg --print-architecture)
if [[ "$checkArm" == "arm64" ]]; then
	isArm=1
fi

sudo apt-get update
# Unikey
unikeyCheck=$(dpkg -l| grep ibus-bamboo)

if [[ -z "$unikeyCheck" ]]; then
	echo -e "${BBlue}Installing Unikey ...${NC}"
	echo -ne '\n' | sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
	sudo apt-get update
	sudo apt-get -y install ibus-bamboo
	ibus restart
	echo -e "${BGreen}Installed Unikey.\n${NC}"
fi

# C/C++
sudo apt-get -y install build-essential
sudo apt-get -y install git


# VSCode
vscodeCheck=$(dpkg -l| grep editing)
if [[ -z "$vscodeCheck" ]]; then
	echo -e "${BBlue}Installing VSCode ...${NC}"
	sleep 1
	sudo apt-get -y install software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	if [[ $isArm == 0 ]]; then
		sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	else
		sudo add-apt-repository "deb [arch=arm64] https://packages.microsoft.com/repos/vscode stable main"
	fi
	sudo apt-get -y install code
	echo -e "${BGreen}Installed VSCode.\n${NC}"
fi

if [[ $isArm == 0 ]]; then
	sudo apt update
	# Chrome
	chromeCheck=$(dpkg -l| grep google-chrome-stable)
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
	# Skype
	snapCheck=$(snap list | grep skype)
	if [[ -z "$snapCheck" ]]; then
		echo -e "${BBlue}Installing Skype ...${NC}"
		sleep 1
		sudo apt-get -y install snap
		sudo snap install skype --classic
		echo -e "${BGreen}Installed Skype.\n${NC}"
	fi
fi

sudo apt-get update
sudo apt-get -y upgrade
echo -e "${BGreen}Done!${NC}"
