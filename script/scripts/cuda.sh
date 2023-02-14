#!/bin/bash

# Author: phatnt
# Date modify: Jan-12-23
# Usage: Install cuda - cudnn - tensorrt
# Global variables:
#   + isJetson (int 0/1): is jetson architecture
#   + cudaVer (string) [For x86_64 only]: cuda version (10.2, 11.0, 11.1, 11.2, 11.3, 11.4)

cudaPath="/usr/local/cuda-$cudaVer"

# Install Jetpack for jetson architecture (included cuda/cudnn/tensorrt/opencv)
if [[ $isJetson == 1 ]]; then
    # Jetson Architechture
	tensorrtCheck=$(pip3 list --format=columns | grep tensorrt)
	if [[ -z "$tensorrtCheck" ]]; then
		echo -e "${BRYellow}[WARNING]: TensorRT not installed!${NC}"
		sleep 2
		echo -e "${BBlue}[INFO]: Installing TensorRT ... ${NC}"
        sleep 2
        sudo apt-get update
        F_checkAndInstall "nvidia-jetpack"
	else
		echo -e "${BGreen}Found $tensorrtCheck!${NC}"
		sleep 2
	fi
    exit 1
fi

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

# Get Links 
cudaLink=""
maxGccVer=0

if [[ "$cudaVer" == "10.2" ]]; then
    cudaLink="https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run"
    maxGccVer="8"
elif [[ "$cudaVer" == "11.0" ]]; then
    cudaLink="https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda_11.0.3_450.51.06_linux.run"
    maxGccVer="9"
elif [[ "$cudaVer" == "11.1" ]]; then
    cudaLink="https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda_11.1.1_455.32.00_linux.run"
    maxGccVer="10"
elif [[ "$cudaVer" == "11.2" ]]; then
    cudaLink="https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run"
    maxGccVer="10"
elif [[ "$cudaVer" == "11.3" ]]; then
    cudaLink="https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda_11.3.1_465.19.01_linux.run"
    maxGccVer="10"
elif [[ "$cudaVer" == "11.4" ]]; then 
    cudaLink="https://developer.download.nvidia.com/compute/cuda/11.4.4/local_installers/cuda_11.4.4_470.82.01_linux.run"
    maxGccVer="11"
else
    >&2 echo -e "${BRed}[ERROR]: Undefined Cuda version: '$cudaVer'! ${NC}"
    exit 1
fi

# Nvidia-driver
nvidiaDriverVer="$(lsmod | grep ^nvidia | awk {'print $1'})"
if [[ "$nvidiaDriverVer" ==  *"nvidia"* ]]; then
    echo -e "${BBlue}[INFO]: Nvidia driver installed.${NC}"
    sleep 2
else
    echo -e "${BYellow}[WARNING]: Could not found Nvidia driver!${NC}"
    echo -e "${BBlue}[INFO]: Installing nvidia driver ...${NC}"
    sleep 2
    sudo apt-get install -y nvidia-driver-525
    >&2 echo -e "${BRed}[REBOOT REQUIRED]: ${NC}Reboot to apply nvidia-driver installation then re-run this script!"
    exit 1
fi


# Install cuda
if ! [ -d $cudaPath ]; then
    echo -e "${BYellow}[WARNING]: Cuda not installed!${NC}"
    echo -e "${BBlue}[INFO] Installing Cuda-$cudaVer ...${NC}"
    sleep 2
    # Check GCC
    sudo apt-get -y install g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
    curGccVer="$(gcc --version  | head -n1 | cut -d" " -f4 )"
    readarray -d . -t strarr <<< "$curGccVer"
    curGccVer="${strarr[0]}"
    if [[  $(($curGccVer)) -gt $(($maxGccVer)) ]]; then
        >&2 echo -e "${BRed}[ERROR]: Cuda-$cudaVer only support gcc version that <= '$maxGccVer'!${NC}"
        >&2 echo -e "${BRed}Please chose other cuda verssion or reinstall gcc manually and check by 'gcc --version' (<= '$maxGccVer')!${NC}"
        exit 1
    fi
    # Install Cuda
    readarray -d / -t strarr <<< "$cudaLink"
    cudaFilename="${strarr[${#strarr[@]}-1]}"
    cd /tmp
    if ! [ -f $cudaFilename ]; then
        wget $cudaLink
        if ! [ -f $cudaFilename ]; then
            >&2 echo -e "${BRed}[ERROR]: Could not download from '$cudaLink'!${NC}"
            exit 1
        fi
    fi
    sh $cudaFilename
    if ! [ -d $cudaPath ]; then
        >&2 echo -e "${BRed}[ERROR]: Install cuda-$cudaVer failed!${NC}"
        exit 1
    fi
    # Add nvcc
    F_exportBashrc "# Cuda"
    F_exportBashrc "export PATH=$cudaPath/bin\${PATH:+:\${PATH}}"
    F_exportBashrc "export LD_LIBRARY_PATH=$cudaPath/lib64\${LD_LIBRARY_PATH:+:\${LD_LIBRARY_PATH}}"
    export PATH=$cudaPath/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=$cudaPath/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
    cudaCheck=$(nvcc -V | sed -n 4p | cut -d" " -f5)
    cudaCheck=${cudaCheck:0:4}
    if [[ -n "$cudaCheck" ]]; then
        cd /tmp
        rm $cudaFilename
        echo -e "${BGreen}[INFO]: Install CUDA-$cudaCheck successfully!${NC}"
        sleep 2
    fi
else
    # Check nvcc
    cudaCheck=$(nvcc -V | sed -n 4p | cut -d" " -f5)
    cudaCheck=${cudaCheck:0:4}
    if [[ -z "$cudaCheck"  ]]; then
        if [ -d "$cudaPath/bin" ] & [ -d "$cudaPath/lib64" ]; then
            F_exportBashrc "# Cuda"
            F_exportBashrc "export PATH=$cudaPath/bin\${PATH:+:\${PATH}}"
            F_exportBashrc "export LD_LIBRARY_PATH=$cudaPath/lib64\${LD_LIBRARY_PATH:+:\${LD_LIBRARY_PATH}}"
            export PATH=$cudaPath/bin${PATH:+:${PATH}}
            export LD_LIBRARY_PATH=$cudaPath/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
        else
            >&2 echo -e "${BRed}[ERROR]: Cuda Install error at '$cudaPath'!${NC}"
            exit 1
        fi
    fi
    echo -e "${BBlue}[INFO]: Found CUDA-$cudaCheck.${NC}"
    sleep 2
fi
