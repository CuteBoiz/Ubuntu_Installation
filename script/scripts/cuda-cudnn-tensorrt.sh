#!/bin/bash

# Author: Leonard
# Date modify: Jan-03-23
# Usage: Install TOMO imaging-server packages

cudaPath="/usr/local/cuda-$cudaVer"
cudnnFilename="cudnn.tar.xz"
cudnnFoldername="cudnn-linux-x86_64-8.4.1.50_cuda11.6-archive"
trtFilename="tensorrt.tar.gz"
trtFoldername="TensorRT-8.2.5.1"
cudnnLink=""
tensorrtLink=""

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
            >&2 echo -e "${BRed}Error: 'sudo apt-get -y install $1' failed!${NC}"
            exit 1
        fi
    fi
}

F_exportBashrc () {
    if ! grep -Fxq "$1" /home/$(logname)/.bashrc; then
        echo $1 >> /home/$(logname)/.bashrc
    fi
	if ! grep -Fxq "$1" /home/$(logname)/.bashrc; then
        echo $1 >> /home/$(logname)/.bashrc
    fi
}

if [[ $isXavier == 0 ]]; then
    # x86_64  Architechture
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
        >&2 echo -e "${BRed}Undifined Version: \"$X\"! ${NC}"
        exit 1
    fi

    # Check Nvidia-driver
    nvidiaDriverVer="$(lsmod | grep ^nvidia | awk {'print $1'})"
    if [[ "$nvidiaDriverVer" ==  *"nvidia"* ]]; then
        echo -e "${BGreen}Nvidia driver installed!${NC}"
        sleep 1
    else
        echo -e "${BRed}Could not found Nvidia driver!${NC}"
        echo -e "Installing nvidia driver ..."
        sleep 1
        sudo apt-get -y install nvidia-driver-470
        >&2 echo -e "${BRed}Reboot to apply nvidia driver then run this script again!${NC}"
        exit 1
    fi

    # Check Cuda - cudnn -tensorrt
    tensorrtCheck=$(pip3 list --format=columns | grep tensorrt)
    if [[ -z "$tensorrtCheck" ]]; then
        # Cuda
        if ! [ -d $cudaPath ]; then
            echo -e "${BRed}Cuda not installed!${NC}"
            echo -e "Installing Cuda-$cudaVer ..."
            sleep 2
            # Check GCC
            sudo apt-get -y install g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
            curGccVer="$(gcc --version  | head -n1 | cut -d" " -f4 )"
            readarray -d . -t strarr <<< "$curGccVer"
            curGccVer="${strarr[0]}"
            if [[  $(($curGccVer)) -gt $(($maxGccVer)) ]]; then
                >&2 echo -e "${BRed}Cuda-$cudaVer only support gcc version that <= '$maxGccVer'!${NC}"
                >&2 echo -e "${BRed}Please reinstall gcc and check by 'gcc --version' (<= '$maxGccVer')!${NC}"
                exit 1
            fi
            # Install Cuda
            readarray -d / -t strarr <<< "$cudaLink"
            cudaFilename="${strarr[${#strarr[@]}-1]}"
            cd /tmp
            if ! [ -f $cudaFilename ]; then
                wget $cudaLink
                if [[ $? -ne 0 ]]; then
                    >&2 echo -e "${BRed}Error: Could not download from '$cudaLink'!${NC}"
                    exit 1
                fi
            fi
            if [ -f $cudaFilename ]; then
                sh $cudaFilename
            else
                >&2 echo -e "${BRed}Error: Could not found '$PWD/$cudaLink' !${NC}"
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
            if [[ "$cudaCheck" != "" ]]; then
                cd /tmp
                rm $cudaFilename
                echo -e "${BGreen}Installed CUDA-$cudaCheck success!${NC}"
                sleep 1
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
                    >&2 echo -e "${BRed}Error: Cuda Install error at '$cudaPath'!${NC}"
                    exit 1
                fi
            fi
            echo -e "${BGreen}Found CUDA-$cudaCheck!${NC}"
            sleep 1
        fi
        # CuDNN
        cudnnCheck1=$(find $cudaPath/include/cudnn*.h)
        cudnnCheck2=$(find $cudaPath/lib64/libcudnn*)
        if [[ -z "$cudnnCheck1" ]] || [[ -z "$cudnnCheck2" ]]; then
            echo -e "Installing cuDNN ..."
            sleep 1
            cd /tmp
            if ! [ -f $cudnnFilename ]; then
                wget $cudnnLink -O $cudnnFilename
                if [[ $? -ne 0 ]]; then
                    >&2 echo -e "${BRed}Error: Could not download from '$cudnnLink'!${NC}"
                    exit 1
                fi
            fi
            tar -xvf $cudnnFilename
            sudo cp $cudnnFoldername/include/cudnn*.h $cudaPath/include
            sudo cp $cudnnFoldername/lib/libcudnn* $cudaPath/lib64
            sudo chmod a+r $cudaPath/include/cudnn*.h $cudaPath/lib64/libcudnn*
            cudnnCheck1=$(find $cudaPath/include/cudnn*.h)
            cudnnCheck2=$(find $cudaPath/lib64/libcudnn*)
            if [[ -z "$cudnnCheck1" ]] || [[ -z "$cudnnCheck2" ]]; then
                >&2 echo -e "${BRED}Copy cudnn files failed!${NC}"
                exit 1
            fi
            cd /tmp
            rm $cudnnFilename
            rm -rf cuda
            echo -e "${BGreen}Install Cudnn successfully!${NC}"
            sleep 1
        else
            echo -e "${BGreen}Found Cudnn!${NC}"
            sleep 1
        fi
	    # TensorRT
		echo -e "Installing TensorRT ..."
        sleep 1
		mkdir -p /home/$(logname)/Libraries && cd /home/$(logname)/Libraries
		if ! [ -d $trtFoldername ]; then
			if ! [ -f $trtFilename ]; then
				wget $tensorrtLink -O $trtFilename
				if [[ $? -ne 0 ]]; then
					echo -e "${BRed}Error: Could not download from '$tensorrtLink'!${NC}"
					>&2 exit 1
				fi
			fi
			tar -xvf $trtFilename
		fi
		export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(logname)/Libraries/$trtFoldername/lib
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
		echo -e "${BGreen}Install $tensorrtCheck successfully!${NC}"
		sleep 1
	else
		echo -e "${BGreen}Found $tensorrtCheck!${NC}"
		sleep 1
	fi
else
    # Jetson Architechture
	# TensorRT
	tensorrtCheck=$(pip3 list --format=columns | grep tensorrt)
	if [[ -z "$tensorrtCheck" ]]; then
		echo -e "${BRed}TensorRT not installed!${NC}"
		sleep 1
		echo -e "${BBlue}Installing TensorRT ... ${NC}"
        sleep 1
        sudo apt-get update
        F_checkAndInstall "nvidia-jetpack"
	else
		echo -e "${BGreen}Found $tensorrtCheck!${NC}"
		sleep 1
	fi
fi