#!/bin/bash

# Author: phatnt
# Date modify: Jan-14-23
# Usage: Install cudnn 
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
    versionCheck=$(pip3 show $A)
    if [[ -n "$versionCheck" ]]; then
        echo -e "[INFO]: Already installed $A"
    else
        python3 -m pip install $1
        versionCheck=$(pip3 show $A)
        if [[ -z "$versionCheck" ]]; then
            echo -e "${BRed}[ERROR]: Install package '$1' failed!${NC}"
            exit 1
        fi
    fi
}

# Prerequisted
cudaPath="/usr/local/cuda-$cudaVer"

F_checkAndInstall "python3-pip"
F_installPythonPackage "gdown"

F_exportBashrc "# Python local package"
F_exportBashrc "export PATH=\"`python3 -m site --user-base`/bin:\$PATH\""
export PATH="`python3 -m site --user-base`/bin:$PATH"

# Get Links
cudnnLink=""
cudnnFilename=""
cudnnFoldername=""

if [[ "$cudaVer" == "10.2" ]]; then
    # cudnn link for cuda 10.2
    cudnnLink="https://drive.google.com/uc?id=1wrttm0Db0ZY464_vMXLGHJIDxhTUIunM" #10.2
    cudnnFilename="cudnn-linux-x86_64-8.4.1.50_cuda10.2-archive.tar.xz"
    cudnnFoldername="cudnn-linux-x86_64-8.4.1.50_cuda10.2-archive"
else
    # cudnn link for cuda 11.x
    cudnnLink="https://drive.google.com/uc?id=1VENLVmYK6yuKtu-UAhA0Su5XE5Sp89Qf" #11.x
    cudnnFilename="cudnn-linux-x86_64-8.4.1.50_cuda11.6-archive.tar.xz"
    cudnnFoldername="cudnn-linux-x86_64-8.4.1.50_cuda11.6-archive"
fi

# CuDNN
cudnnCheck1=$(find $cudaPath/include/cudnn*.h)
cudnnCheck2=$(find $cudaPath/lib64/libcudnn*)
if [[ -z "$cudnnCheck1" ]] || [[ -z "$cudnnCheck2" ]]; then
    echo -e "${BYellow}[WARNING]: Cudnn not installed!${NC}"
    echo -e "${BBlue}[INFO]: Installing cuDNN ...${NC}"
    sleep 2
    cd /tmp
    if ! [ -f $cudnnFilename ]; then
        gdown $cudnnLink 
        if ! [ -f $cudnnFilename ]; then
            >&2 echo -e "${BRed}[ERROR]: Could not download from '$cudnnLink'!${NC}"
            exit 1
        fi
    fi
    if ! [ -d $cudnnFoldername ]; then
        tar -xvf $cudnnFilename
    fi
    if ! [ -d $cudnnFoldername ]; then
        >&2 echo -e "${BRed}[ERROR]: Could not extract '$PWD/$cudnnFilename'!${NC}"
        exit 1
    fi
    cd $cudnnFoldername
    cp include/cudnn*.h $cudaPath/include
    cp lib/libcudnn* $cudaPath/lib64
    sudo chmod a+r $cudaPath/include/cudnn*.h $cudaPath/lib64/libcudnn*
    cudnnCheck1=$(find $cudaPath/include/cudnn*.h)
    cudnnCheck2=$(find $cudaPath/lib64/libcudnn*)
    if [[ -z "$cudnnCheck1" ]] || [[ -z "$cudnnCheck2" ]]; then
        >&2 echo -e "${BRED}[ERROR]: Copy cudnn files failed. Please copy downloaded cudnn files from '/tmp' to '$cudaPath' manually!${NC}"
        exit 1
    fi
    cd /tmp
    rm $cudnnFilename
    rm -rf $cudnnFoldername
    echo -e "${BGreen}[INFO]: Install Cudnn successfully!${NC}"
    sleep 2
else
    echo -e "${BBlue}[INFO]: Installed Cudnn.${NC}"
    sleep 2
fi