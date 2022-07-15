#!/bin/bash
BBLUE='\033[1;34m'
BGREEN='\033[1;32m'
NC='\033[0m'

TEMP_DIR="./temp_downloads"
CHROME_LINK="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
SKYPE_LINK="https://go.skype.com/skypeforlinux-64.deb"
mkdir -p $TEMP_DIR

# Unikey
echo -e "${BBLUE}Installing Unikey ...${NC}"
sudo apt-get -y install ibus-unikey
ibus restart
echo -e "${BGREEN}Installed Unikey.\n${NC}"

# C/C++
echo -e "${BBLUE}Installing C/C++ Build essential ...${NC}"
sleep 1
sudo apt-get -y install build-essential
echo -e "${BGREEN}Installed C/C++ Build essential.\n${NC}"

# Git
echo -e "${BBLUE}Installing GitBash ...${NC}"
sudo apt-get -y install git
echo -e "${BGREEN}Installed GitBash.\n${NC}"

# VSCode
echo -e "${BBLUE}Installing VSCode ...${NC}"
sleep 1
sudo apt-get -y install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt-get -y install code
echo -e "${BGREEN}Installed VSCode.\n${NC}"

# Chrome
echo -e "${BBLUE}Installing Chrome ...${NC}"
sleep 1
wget $CHROME_LINK -O  $TEMP_DIR/google.deb
if [[ $? -ne 0 ]]; then
    echo -e "${BRED}Error: Could not download google chrome!${NC}"
    sleep 3
else
    sudo dpkg -i --force-depends $TEMP_DIR/google.deb
    echo -e "${BGREEN}Installed Chrome.\n${NC}"
fi 

# Skype
echo -e "${BBLUE}Installing Skype ...${NC}"
sleep 1
wget $SKYPE_LINK -O $TEMP_DIR/skype.deb
if [[ $? -ne 0 ]]; then
    echo -e "${BRED}Error: Could not download google chrome!${NC}"
    sleep 3
else
    sudo apt-get -y install $TEMP_DIR/skype.deb
    echo -e "${BGREEN}Installed Skype.\n${NC}"
fi 

sudo rm -rf temp
sudo apt-get update
sudo apt-get -y upgrade
echo -e "${BGREEN}Done!${NC}"
