#!/bin/bash

# Author: phatnt
# Date modify: Feb-12-23
# Usage: Install cuda/cudnn/tensorrt

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

# Check sudo bash
if [[ "$SUDO_USER" == "" ]]; then
    >&2 echo -e "${BRed}[ERROR]: Scrit should be run below sudo privileges. Use 'sudo bash' before execute this script!${NC}"
    exit 1
fi

# Global variable
isJetson=0
cudaVer=""

# Check jetson or not

if [ -f /etc/nv_tegra_release ]; then
    isJetson=1
fi

# Choose Version for x86_64 architecture
if [[ $isJetson == 0 ]]; then
    read -p "$(echo -e $BBlue"Choose CUDA Version $BGreen(10.2, 11.0, 11.1, 11.2, 11.3, 11.4): $NC")" X
    cudaVerArr=("10.2" "11.0" "11.1" "11.2" "11.3") 
    tempDir="./temp_cuda"
    cudaVer=""
    for VER in ${cudaVerArr[@]}; do
        if [[ "$X" == "$VER" ]]; then
            cudaVer=$VER
        fi
    done
    if [[ -z "$cudaVer" ]]; then
        >&2 echo -e "${BRed}[ERROR]: Undefined cuda version!${NC}"
        exit 1
    fi
fi

# Install
export isJetson
export cudaVer
cd "$scriptFolder"
bash -E ./scripts/cuda-cudnn-tensorrt.sh
if [[ $? -ne 0 ]] ; then
    exit 1
fi
