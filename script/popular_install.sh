#!/bin/bash

# Author: phatnt
# Date modify: Feb-03-23
# Usage: Install popular programs for ubuntu

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

# Check Sudo bash
if [[ "$SUDO_USER" == "" ]]; then
    >&2 echo -e "${BRed}[ERROR]: This script should be run with sudo privileges. Use 'sudo bash' before execute this script!${NC}"
    exit 1
fi

sudo apt-get update
sudo apt-get -y upgrade

# Prerequisite
cd "$scriptFolder"
bash -E ./scripts/prerequisite.sh
if [[ $? -ne 0 ]] ; then
    exit 1
fi

# Unikey
while : ; do
    read -p "$(echo -e $BBlue"Do you want install Unikey ? (Y\\\n): $NC")" A
    A=${A^^}
    if [[ "$A" == "Y" || "$A" == "y" || "$A" == "" ]]; then
		cd "$scriptFolder"
		bash -E ./scripts/unikey.sh
		if [[ $? -ne 0 ]] ; then
			exit 1
		fi
		break
	elif [[ "$A" == "N" || "$A" == "n"  ]]; then
		break
	fi
done


# VSCode
while : ; do
    read -p "$(echo -e $BBlue"Do you want install VSCode ? (Y\\\n): $NC")" A
    A=${A^^}
    if [[ "$A" == "Y" || "$A" == "y" || "$A" == "" ]]; then
		cd "$scriptFolder"
		bash -E ./scripts/vscode.sh
		if [[ $? -ne 0 ]] ; then
			exit 1
		fi
		break
	elif [[ "$A" == "N" || "$A" == "n"  ]]; then
		break
	fi
done


# Microsoft Edge
while : ; do
    read -p "$(echo -e $BBlue"Do you want install Microsoft Edge ? (Y\\\n): $NC")" A
    A=${A^^}
    if [[ "$A" == "Y" || "$A" == "y" || "$A" == "" ]]; then
		cd "$scriptFolder"
		sudo bash -E ./scripts/microsoft-edge.sh
		if [[ $? -ne 0 ]] ; then
			exit 1
		fi
		break
	elif [[ "$A" == "N" || "$A" == "n"  ]]; then
		break
	fi
done

# Chrome
while : ; do
    read -p "$(echo -e $BBlue"Do you want install Google Chrome ? (Y\\\n): $NC")" A
    A=${A^^}
    if [[ "$A" == "Y" || "$A" == "y" || "$A" == "" ]]; then
		cd "$scriptFolder"
		bash -E ./scripts/chrome.sh
		if [[ $? -ne 0 ]] ; then
			exit 1
		fi
		break
	elif [[ "$A" == "N" || "$A" == "n"  ]]; then
		break
	fi
done

# Skype
while : ; do
    read -p "$(echo -e $BBlue"Do you want install Skype ? (Y\\\n): $NC")" A
    A=${A^^}
    if [[ "$A" == "Y" || "$A" == "y" || "$A" == "" ]]; then
		cd "$scriptFolder"
		bash -E ./scripts/skype.sh
		if [[ $? -ne 0 ]] ; then
			exit 1
		fi
		break
	elif [[ "$A" == "N" || "$A" == "n"  ]]; then
		break
	fi
done

echo -e "${BGreen}Done!${NC}"
