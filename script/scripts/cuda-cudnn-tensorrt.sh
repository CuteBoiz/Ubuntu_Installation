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
cudaLink=""
maxGccVer=0
cudnnLink=""
cudnnFilename=""
cudnnFoldername=""
tensorrtLink=""
trtFilename=""
trtFoldername=""

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

if [[ "$cudaVer" == "10.2" ]]; then
    # cudnn link for cuda 10.2
    cudnnLink="https://drive.google.com/uc?id=1wrttm0Db0ZY464_vMXLGHJIDxhTUIunM" #10.2
    cudnnFilename="cudnn-linux-x86_64-8.4.1.50_cuda10.2-archive.tar.xz"
    cudnnFoldername="cudnn-linux-x86_64-8.4.1.50_cuda10.2-archive"
    # tensorrt link for cuda 10.2
    tensorrtLink="https://drive.google.com/uc?id=1ctoI59nTkNJl00QllAYKw2AdIxFHhcxN" #10.2
    trtFilename="TensorRT-8.4.3.1.Linux.x86_64-gnu.cuda-10.2.cudnn8.4.tar.gz"
    trtFoldername="TensorRT-8.4.3.1"
else
    # cudnn link for cuda 11.x
    cudnnLink="https://drive.google.com/uc?id=1VENLVmYK6yuKtu-UAhA0Su5XE5Sp89Qf" #11.x
    cudnnFilename="cudnn-linux-x86_64-8.4.1.50_cuda11.6-archive.tar.xz"
    cudnnFoldername="cudnn-linux-x86_64-8.4.1.50_cuda11.6-archive"
    # tensorrrt link for cuda 11.x
    tensorrtLink="https://drive.google.com/uc?id=1G8eKDyB88C7Pqiy-9UJ7RALivcbAMlK9" #11.x
    trtFilename="TensorRT-8.4.3.1.Linux.x86_64-gnu.cuda-11.6.cudnn8.4.tar.gz"
    trtFoldername="TensorRT-8.4.3.1"
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


# Cuda
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
    tar -xvf $cudnnFilename
    if ! [ -d $cudnnFoldername ]; then
        >&2 echo -e "${BRed}[ERROR]: Could not extract '$PWD/$cudnnFilename'!${NC}"
        exit 1
    fi
    sudo cp $cudnnFoldername/include/cudnn*.h $cudaPath/include
    sudo cp $cudnnFoldername/lib/libcudnn* $cudaPath/lib64
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

# TensorRT
tensorrtCheck=$(pip3 list --format=columns | grep tensorrt)
if [[ -z "$tensorrtCheck" ]]; then
    echo -e "Installing TensorRT ..."
    sleep 2
    mkdir -p /home/$(logname)/Libraries && cd /home/$(logname)/Libraries
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
            >&2 echo -e "${BRed}[ERROR]: Could not extract '$PWD/$cudnnFilename'!${NC}"
            exit 1
        fi
    fi
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(logname)/Libraries/$trtFilename/lib
    F_exportBashrc "# TensorRT"
    F_exportBashrc "LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/home/$(logname)/Libraries/$trtFoldername/lib"
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
