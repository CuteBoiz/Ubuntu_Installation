#!/bin/bash

# Author: phatnt
# Date modify: Jan-14-23
# Usage: Install tensorrt
# Global variables:
#   + cudaVer (string) [For x86_64 only]: cuda version (10.2, 11.0, 11.1, 11.2, 11.3, 11.4)

F_exportBashrc () {
    if ! grep -Fxq "$1" /home/$(logname)/.bashrc; then
        echo $1 >> /home/$(logname)/.bashrc
    fi
	if ! grep -Fxq "$1" /home/$(logname)/.bashrc; then
        echo $1 >> /home/$(logname)/.bashrc
    fi
}

F_checkAndInstall () {
    versionCheck=$(dpkg -s $1 | grep Version)
    versionCheck=${versionCheck:9:-1}
    if [[ -n "$versionCheck" ]]; then
        echo -e "Already installed $1-$versionCheck"
    else
        sudo apt-get -y install $1
        versionCheck=$(dpkg -s $1 | grep Version)
        versionCheck=${versionCheck:9:-1}
        if [[ -z "$versionCheck" ]]; then
            >&2 echo -e "${BRed}[ERROR]: 'sudo apt-get -y install $1' failed!${NC}"
            exit 1
        fi
    fi
}

F_installPythonPackage () {
    readarray -d = -t strarr <<< "$1"
	A=${strarr[0]}
    versionCheck=$(pip3 list --format=columns | grep $A)
    if [[ -n "$versionCheck" ]]; then
        echo -e "[INFO]: Already installed $A"
    else
        python3 -m pip install $1
        versionCheck=$(pip3 list --format=columns | grep $A)
        if [[ -z "$versionCheck" ]]; then
            echo -e "${BRed}[ERROR]: Install package '$1' failed!${NC}"
            exit 1
        fi
    fi
}

# Prerequisted
F_checkAndInstall "python3-pip"
F_installPythonPackage "gdown"

F_exportBashrc "# Python local package"
F_exportBashrc "export PATH=\"`python3 -m site --user-base`/bin:\$PATH\""
export PATH="`python3 -m site --user-base`/bin:$PATH"

# Get Links
tensorrtLink=""
trtFilename=""
trtFoldername=""

if [[ "$cudaVer" == "10.2" ]]; then
    # tensorrt link for cuda 10.2
    tensorrtLink="https://drive.google.com/uc?id=1ctoI59nTkNJl00QllAYKw2AdIxFHhcxN" #10.2
    trtFilename="TensorRT-8.4.3.1.Linux.x86_64-gnu.cuda-10.2.cudnn8.4.tar.gz"
    trtFoldername="TensorRT-8.4.3.1"
else
    # tensorrrt link for cuda 11.x
    tensorrtLink="https://drive.google.com/uc?id=1G8eKDyB88C7Pqiy-9UJ7RALivcbAMlK9" #11.x
    trtFilename="TensorRT-8.4.3.1.Linux.x86_64-gnu.cuda-11.6.cudnn8.4.tar.gz"
    trtFoldername="TensorRT-8.4.3.1"
fi


# Install TensorRT
tensorrtCheck=$(pip3 list --format=columns | grep tensorrt)
if [[ -z "$tensorrtCheck" ]]; then
    echo -e "[INFO]: Installing TensorRT ..."
    sleep 2
    mkdir -p /home/$(logname)/Libraries && cd /home/$(logname)/Libraries
    # Download and extract
    if ! [ -d $trtFoldername ]; then
        if ! [ -f $trtFilename ]; then
            gdown $tensorrtLink
            if ! [ -f $trtFilename ]; then
                >&2 echo -e "${BRed}[ERROR]: Could not download from '$tensorrtLink'!${NC}"
                exit 1
            fi
        fi
        tar -xvf $trtFilename
        if ! [ -d $trtFoldername ]; then
            >&2 echo -e "${BRed}[ERROR]: Could not extract '$PWD/$trtFilename'!${NC}"
            exit 1
        fi
    fi
    echo -e "[INFO]: TensorRT will be installed in ${BGreen}'$/home/$(logname)/Libraries/$trtFoldername'${NC}"
    sleep 2
    # Add TensorRT to LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(logname)/Libraries/$trtFoldername/lib
    F_exportBashrc "# TensorRT"
    F_exportBashrc "LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/home/$(logname)/Libraries/$trtFoldername/lib"
    # Install TensorRT python packages
    sudo chmod 777 -R $trtFoldername
    cd $trtFoldername
    cd python
    pythonMinorVer=$(python3 -c 'import sys; print(sys.version_info[1])')
    pip3 install tensorrt-*-cp3$pythonMinorVer-none-linux_x86_64.whl
    cd ../uff
    pip3 install uff-*-py2.py3-none-any.whl
    cd ../graphsurgeon
    pip3 install graphsurgeon-*-py2.py3-none-any.whl
    cd ../onnx_graphsurgeon
    pip3 install onnx_graphsurgeon-*-py2.py3-none-any.whl
    # Verify
    tensorrtCheck=$(pip3 list --format=columns | grep tensorrt)
    if [[ -z "$tensorrtCheck" ]]; then
        >&2 echo -e "${BRed}Install TensorRT Failed!${NC}"
        exit 1
    fi
    cd /home/$(logname)/Libraries
    rm $trtFilename
    echo -e "${BGreen}[INFO]: Install $tensorrtCheck successfully!${NC}"
    sleep 2
else
    echo -e "${BBlue}[INFO]: Found $tensorrtCheck.${NC}"
    sleep 2
fi
