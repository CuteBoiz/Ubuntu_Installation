#!/bin/bash

BBLUE='\033[1;34m'
BGREEN='\033[1;32m'
BRED='\033[1;31m'
NC='\033[0m'

# Check nvidia-driver installed
NVIDIA_CHECK="$(lsmod | grep ^nvidia | awk {'print $1'})"
if [[ "$NVIDIA_CHECK" ==  *"nvidia"* ]]; then
    echo -e "${BGREEN}Nvidia driver installed!${NC}"    
else
    echo -e "${BRED}Error: System has not installed nvidia-driver yet!${NC}"
    echo -e "${BBLUE}Try \"sudo apt -y install nvidia-driver-470\". Then reboot.${NC}"
    exit 1
fi

# Choose Version
read -p "$(echo -e $BBLUE"Enter CUDA Version $BRED(10.2, 11.0, 11.1, 11.2, 11.3): $NC")" X
CUDA_VERS=("10.2" "11.0" "11.1" "11.2" "11.3") 
TEMP_DIR="./temp_cuda"
INSTALL_VER="NONE"
for VER in ${CUDA_VERS[@]}; do
    if [[ "$X" == "$VER" ]]; then
        INSTALL_VER=$VER
    fi
done

if [[ "$INSTALL_VER" == "NONE" ]]; then
    echo -e "${BRED}Undifined Version: \"$X\"! ${NC}"
    exit 1
elif [[ "$INSTALL_VER" == "10.2" ]]; then
    CUDA_LINK="https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run"
    MAX_GCC_VER="8"
elif [[ "$INSTALL_VER" == "11.0" ]]; then
    CUDA_LINK="https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda_11.0.3_450.51.06_linux.run"
    MAX_GCC_VER="9"
elif [[ "$INSTALL_VER" == "11.1" ]]; then
    CUDA_LINK="https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda_11.1.1_455.32.00_linux.run"
    MAX_GCC_VER="10"
elif [[ "$INSTALL_VER" == "11.2" ]]; then
    CUDA_LINK="https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run"
    MAX_GCC_VER="10"
elif [[ "$INSTALL_VER" == "11.3" ]]; then
    CUDA_LINK="https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda_11.3.1_465.19.01_linux.run"
    MAX_GCC_VER="10"
fi
sudo apt-get install g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
# Check available gcc version
CURRENT_GCC_VER="$(gcc --version  | head -n1 | cut -d" " -f4 )"
readarray -d . -t strarr <<< "$CURRENT_GCC_VER"
CURRENT_GCC_VER="${strarr[0]}"
if [[  $(($CURRENT_GCC_VER)) -gt $(($MAX_GCC_VER)) ]]; then
    echo -e "${BBLUE}Installing GCC-$MAX_GCC_VERSION${NC} ..."
    sleep 1
    sudo apt-get install -y gcc-$MAX_GCC_VERSION g++-$MAX_GCC_VERSION
    sudo ln -s /usr/bin/gcc-$MAX_GCC_VERSION /usr/local/cuda/bin/gcc 
    sudo ln -s /usr/bin/g++-$MAX_GCC_VERSION /usr/local/cuda/bin/g++
    source ~/.bashrc
    CURRENT_GCC_VER="$(gcc --version  | head -n1 | cut -d" " -f4 )"
    readarray -d . -t strarr <<< "$CURRENT_GCC_VER"
    CURRENT_GCC_VER="${strarr[0]}"
    if [[  $(($CURRENT_GCC_VER)) -gt $(($MAX_GCC_VER)) ]]; then
        echo -e "Error: ${BRED}Cannot Install GCC-$MAX_GCC_VERSION! Please Reinstall gcc or Choose Another Cuda version!${NC}"
        exit 1
    else
        echo -e "${BGREEN}Installed  GCC-$MAX_GCC_VERSION${NC}"
    fi
fi

# Install CUDA
echo -e "${BBLUE}Installing CUDA-$INSTALL_VER ${NC}"
sleep 1
readarray -d / -t strarr <<< "$CUDA_LINK"
CUDA_FILE_NAME="${strarr[${#strarr[@]}-1]}"
mkdir -p $TEMP_DIR
# Download
if ! [ -f $TEMP_DIR/$CUDA_FILE_NAME ]; then
    echo "HERE"
    wget $CUDA_LINK -O $TEMP_DIR/$CUDA_FILE_NAME
    if [[ $? -ne 0 ]]; then
        echo -e "${BRED}Error: Could not download from \"$CUDA_LINK\"!${NC}"
        exit 1
    fi 
fi

sh $TEMP_DIR/$CUDA_FILE_NAME

echo -e "\n# Cuda\nexport PATH=/usr/local/cuda-$INSTALL_VER/bin\${PATH:+:\${PATH}}" >> ~/.bashrc
echo -e "export LD_LIBRARY_PATH=/usr/local/cuda-$INSTALL_VER/lib64\${LD_LIBRARY_PATH:+:\${LD_LIBRARY_PATH}}" >> ~/.bashrc
echo -e "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64" >> ~/.bashrc
source ~/.bashrc
if [[ -d /usr/local/cuda-$INSTALL_VER ]]; then
    echo -e "${BGREEN}Installed CUDA-$INSTALL_VER successful!${NC}"
    sudo rm -rf $TEMP_DIR
    nvcc -V
    echo -e "${BGREEN}Done!${NC}"
else
    echo -e "${BRED}Error: No such directory \"/usr/local/cuda-$INSTALL_VER\"!${NC}"
    echo -e "${BRED}Error: Installation Failed!${NC}"
    exit 1
fi