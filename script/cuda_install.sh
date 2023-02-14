#!/bin/bash

# Author: phatnt
# Date modify: Feb-12-23
# Usage: Install cuda

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
    # Check cuda exist
    reInstall=0
    export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
    cudaCheck=$(nvcc -V | sed -n 4p | cut -d" " -f5)
    cudaCheck=${cudaCheck:0:4}
    if [[ -n "$cudaCheck" ]]; then
        while : ; do
            read -p "$(echo -e $BBlue"Found Cuda '$cudaCheck'. Do you want install another version ? (N\\\y): $NC")" A
            A=${A^^}
            if [[ "$A" == "Y" || "$A" == "y" ]]; then
                reInstall=1
                break
            elif [[ "$A" == "N" || "$A" == "n" || "$A" == ""  ]]; then
                reInstall=0
                cudaVer=$cudaCheck
                break
            fi
        done
    fi
    # Choose version
    if [[ -z "$cudaCheck" ]] || [[ $reInstall == 1 ]]; then
        cudaVer=""
        while : ; do
            read -p "$(echo -e $BBlue"Choose CUDA Version $BGreen(10.2, 11.0, 11.1, 11.2, 11.3, 11.4): $NC")" X
            cudaVerArr=("10.2" "11.0" "11.1" "11.2" "11.3") 
            for VER in ${cudaVerArr[@]}; do
                if [[ "$X" == "$VER" ]]; then
                    cudaVer=$VER
                fi
            done
            if [[ -z "$cudaVer" ]]; then
                echo -e "${BYellow}[WARNING]: Undefined cuda version: '$X'!${NC}"
            else 
                echo -e "${BBlue}[INFO]: Cuda '$cudaVer' selected!${NC}"
                sleep 2
                break
            
            fi
        done
    fi
fi

# Install
export isJetson
export cudaVer
cd "$scriptFolder"
bash -E ./scripts/cuda.sh
if [[ $? -ne 0 ]] ; then
    exit 1
fi
