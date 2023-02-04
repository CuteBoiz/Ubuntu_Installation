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

# Choose Version
read -p "$(echo -e $BBlue"Enter CUDA Version $BRed(10.2, 11.0, 11.1, 11.2, 11.3): $NC")" X
cudaVers=("10.2" "11.0" "11.1" "11.2" "11.3") 
tempDir="./temp_cuda"
cudaVer="NONE"
for VER in ${cudaVers[@]}; do
    if [[ "$X" == "$VER" ]]; then
        cudaVer=$VER
    fi
done

export cudaVer
cd "$scriptFolder"
sudo bash -E ./scripts/cuda-cudnn-tensorrt.sh
if [[ $? -ne 0 ]] ; then
    exit 1
fi
