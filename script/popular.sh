#!/bin/bash
BBlue='\033[1;34m'
BGreen='\033[1;32m'
NC='\033[0m'

tempDir="./temp_downloads"
chromeLink="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
skypeLink="https://go.skype.com/skypeforlinux-64.deb"
mkdir -p $tempDir

# Unikey
echo -e "${BBlue}Installing Unikey ...${NC}"
sudo apt-get -y install ibus-unikey
ibus restart
echo -e "${BGreen}Installed Unikey.\n${NC}"

# C/C++
echo -e "${BBlue}Installing C/C++ Build essential ...${NC}"
sleep 1
sudo apt-get -y install build-essential
echo -e "${BGreen}Installed C/C++ Build essential.\n${NC}"

# Git
echo -e "${BBlue}Installing GitBash ...${NC}"
sudo apt-get -y install git
echo -e "${BGreen}Installed GitBash.\n${NC}"

# VSCode
echo -e "${BBlue}Installing VSCode ...${NC}"
sleep 1
sudo apt-get -y install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt-get -y install code
echo -e "${BGreen}Installed VSCode.\n${NC}"

# Chrome
echo -e "${BBlue}Installing Chrome ...${NC}"
sleep 1
wget $chromeLink -O  $tempDir/google.deb
if [[ $? -ne 0 ]]; then
    echo -e "${BRed}Error: Could not download google chrome!${NC}"
    sleep 3
else
    sudo dpkg -i --force-depends $tempDir/google.deb
    echo -e "${BGreen}Installed Chrome.\n${NC}"
fi 

# Skype
echo -e "${BBlue}Installing Skype ...${NC}"
sleep 1
wget $skypeLink -O $tempDir/skype.deb
if [[ $? -ne 0 ]]; then
    echo -e "${BRed}Error: Could not download google chrome!${NC}"
    sleep 3
else
    sudo apt-get -y install $tempDir/skype.deb
    echo -e "${BGreen}Installed Skype.\n${NC}"
fi 

sudo rm -rf $tempDir
sudo apt-get update
sudo apt-get -y upgrade
echo -e "${BGreen}Done!${NC}"
