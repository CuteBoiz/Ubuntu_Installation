#!/bin/bash

# Author: phatnt
# Date modify: Feb-14-23
# Usage: Install tensorrt

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

export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
cudaVer=$(nvcc -V | sed -n 4p | cut -d" " -f5)
cudaVer=${cudaCheck:0:4}
if [[ -z "$cudaVer" ]]; then
    echo -e "${BRed}[ERROR]: Could not found Cuda installed!${NC}"
    exit 1
fi

# Install
export cudaVer
cd "$scriptFolder"
bash -E ./scripts/tensorrt.sh
if [[ $? -ne 0 ]] ; then
    exit 1
fi