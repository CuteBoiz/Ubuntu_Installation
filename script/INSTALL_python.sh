#!/bin/bash
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

# Check sudo bash
if [[ "$SUDO_USER" == "" ]]; then
    echo -e "${BRed}Use \"sudo bash\" before executing this script!${NC}"
    exit 1
fi

# Choose version
read -p "$(echo -e $BBlue"Enter Python Version $BRed(3.6, 3.7, 3.8, 3.9, 3.10): $NC")" X
pythonVers=("3.6" "3.7" "3.8" "3.9" "3.10") 
pythonVer="NONE"

for VER in ${pythonVers[@]}; do
    if [[ "$X" == "$VER" ]]; then
        pythonVer=$VER
    fi
done
if [[ "$pythonVer" == "NONE" ]]; then
    echo -e "Error: ${BRed}Undifined Version: \"$X\"!${NC}"
    exit 0 
else
    echo -e "${BGreen}Install Python-$pythonVer ...${NC}"
fi

export pythonVer
cd "$scriptFolder"
sudo bash -E ./scripts/python3.sh
if [[ $? -ne 0 ]] ; then
    exit 1
fi

echo -e "${BGreen}Done!${NC}"