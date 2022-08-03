#!/bin/bash

BBlue='\033[1;34m'
BGreen='\033[1;32m'
BRed='\033[1;31m'
NC='\033[0m'

export_bashrc () {
    if ! grep -Fxq "$1" $HOME/.bashrc; then
        echo $1 >> $HOME/.bashrc
    fi
}

installCuda () {
    """
    Install Cuda
    Args: 
        + \$1: Cuda version
    """
    # Check nvidia-driver installed
    nvidiaCheck="$(lsmod | grep ^nvidia | awk {'print $1'})"
    if [[ "$nvidiaCheck" ==  *"nvidia"* ]]; then
        echo -e "${BGreen}Nvidia driver installed!${NC}"    
    else
        echo -e "${BRed}Error: System has not installed nvidia-driver yet!${NC}"
        echo -e "${BBlue}Try \"sudo apt -y install nvidia-driver-470\". Then reboot.${NC}"
        exit 1
    fi
    
    if [[ "$1" == "NONE" ]]; then
        echo -e "${BRed}Undifined Version: \"$X\"! ${NC}"
        exit 1
    elif [[ "$1" == "10.2" ]]; then
        cudaLink="https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run"
        maxGccVer="8"
    elif [[ "$1" == "11.0" ]]; then
        cudaLink="https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda_11.0.3_450.51.06_linux.run"
        maxGccVer="9"
    elif [[ "$1" == "11.1" ]]; then
        cudaLink="https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda_11.1.1_455.32.00_linux.run"
        maxGccVer="10"
    elif [[ "$1" == "11.2" ]]; then
        cudaLink="https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run"
        maxGccVer="10"
    elif [[ "$1" == "11.3" ]]; then
        cudaLink="https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda_11.3.1_465.19.01_linux.run"
        maxGccVer="10"
    fi
    sudo apt-get install -y g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
    # Check available gcc version
    curGccVer="$(gcc --version  | head -n1 | cut -d" " -f4 )"
    readarray -d . -t strarr <<< "$curGccVer"
    curGccVer="${strarr[0]}"
    if [[  $(($curGccVer)) -gt $(($maxGccVer)) ]]; then
        echo -e "${BBlue}Installing GCC-$maxGccVerSION${NC} ..."
        sleep 1
        sudo apt-get install -y gcc-$maxGccVerSION g++-$maxGccVerSION
        sudo ln -s /usr/bin/gcc-$maxGccVerSION /usr/local/cuda/bin/gcc 
        sudo ln -s /usr/bin/g++-$maxGccVerSION /usr/local/cuda/bin/g++
        curGccVer="$(gcc --version  | head -n1 | cut -d" " -f4 )"
        readarray -d . -t strarr <<< "$curGccVer"
        curGccVer="${strarr[0]}"
        if [[  $(($curGccVer)) -gt $(($maxGccVer)) ]]; then
            echo -e "Error: ${BRed}Cannot Install GCC-$maxGccVerSION! Please Reinstall gcc or Choose Another Cuda version!${NC}"
            exit 1
        else
            echo -e "${BGreen}Installed  GCC-$maxGccVerSION${NC}"
        fi
    fi

    # Download & Install
    echo -e "${BBlue}Installing CUDA-$1 ${NC}"
    sleep 1
    readarray -d / -t strarr <<< "$cudaLink"
    cudaFilename="${strarr[${#strarr[@]}-1]}"
    mkdir -p $tempDir
    # Download
    if ! [ -f $tempDir/$cudaFilename ]; then
        echo "HERE"
        wget $cudaLink -O $tempDir/$cudaFilename
        if [[ $? -ne 0 ]]; then
            echo -e "${BRed}Error: Could not download from \"$cudaLink\"!${NC}"
            exit 1
        fi 
    fi
    sh $tempDir/$cudaFilename
    if [[ -d /usr/local/cuda-$1 ]]; then
        echo -e "${BGreen}Installed CUDA-$1 successful!${NC}"
        sudo rm -rf $tempDir
        export_bashrc "# Cuda-$1"
        export_bashrc "export PATH=/usr/local/cuda-$1/bin\${PATH:+:\${PATH}}"
        export_bashrc "export LD_LIBRARY_PATH=/usr/local/cuda-$1/lib64\${LD_LIBRARY_PATH:+:\${LD_LIBRARY_PATH}}"
        export_bashrc "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda-$1/extras/CUPTI/lib64"
        export PATH=/usr/local/cuda-$1/bin${PATH:+:${PATH}}
        export LD_LIBRARY_PATH=/usr/local/cuda-$1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
        nvcc -V
        echo -e "${BGreen}Done!${NC}"
    else
        echo -e "${BRed}Error: No such directory \"/usr/local/cuda-$1\"!${NC}"
        echo -e "${BRed}Error: Installation Failed!${NC}"
        exit 1
    fi
}

# Check sudo bash
if [[ "$SUDO_USER" == "" ]]; then
    echo -e "${BRed}Use \"sudo bash\" before executing this script!${NC}"
    exit 1
fi

# Choose Version
read -p "$(echo -e $BBlue"Enter CUDA Version $BRed(10.2, 11.0, 11.1, 11.2, 11.3): $NC")" X
cudaVers=("10.2" "11.0" "11.1" "11.2" "11.3") 
tempDir="./temp_cuda"
installVersion="NONE"
for VER in ${cudaVers[@]}; do
    if [[ "$X" == "$VER" ]]; then
        installVersion=$VER
    fi
done

installCuda $installVersion