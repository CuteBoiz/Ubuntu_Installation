#!/bin/bash
BBLUE='\033[1;34m'
BGREEN='\033[1;32m'
BRED='\033[1;31m'
NC='\033[0m'
OPENCV_LINK="https://github.com/opencv/opencv.git"
OPENCV_CONTRIB_LINK="https://github.com/opencv/opencv_contrib.git"
# Install folder
INSTALL_DIR=""
TEMP=0
while : ; do
    read -p "$(echo -e $BBLUE"Where to put opencv (defaut ${NC}\"/home/$SUDO_USER/Libraries\"${BBLUE}): $NC")" A
    if  [[ "$A" == "" ]]; then
        INSTALL_DIR=/home/$SUDO_USER/Libraries
    elif [[ "${A::1}" == "." ]]; then
        INSTALL_DIR="$PWD${A:1}"
    elif [[ "${A::1}" == "~" ]]; then
        INSTALL_DIR="/home/$SUDO_USER${A:1}"
    else
        INSTALL_DIR=$A
    fi
    if [[ $INSTALL_DIR != "" ]]; then
        while : ; do
            read -p "$(echo -e $BBLUE"OpenCV will be install in $NC\"$INSTALL_DIR\" $BBLUE(y/n): $NC")" A
            if [[ "$A" == "y" || "$A" == "Y" ]]; then
                TEMP=1
                break
            elif [[ "$A" == "n" || "$A" == "N" ]]; then
                TEMP=0
                break
            fi
        done
    fi
    if [[ $TEMP -eq 1 ]]; then
        break
    fi
done
mkdir -p $INSTALL_DIR && cd $INSTALL_DIR
echo -e "OpenCV will be install in \"$PWD\""
sleep 2
# Use OpenCV_Cuda?
INSTALL_CUDA=0
while : ; do
    read -p "$(echo -e $BBLUE"Do you want install OpenCV with CUDA support? (y\\\n): $NC")" A
    ! [[ "$A" == "y" || "$A" == "Y" || "$A" == "N" || "$A" == "n" ]] || break
done
if [[ "$A" == "y" || "$A" == "Y" ]]; then
    NVIDIA_CHECK="$(lsmod | grep ^nvidia | awk {'print $1'})"
    if [[ "$NVIDIA_CHECK" ==  *"nvidia"* ]]; then
        echo -e "Nvidia driver installed!"    
    else
        echo -e "${BRED}Error: System has not installed nvidia-driver yet!${NC}"
        exit 1
    fi
    CUDA_CHECK=$(find /usr/local/cuda-*   -maxdepth 0)
    if ! [[ "$CUDA_CHECK" == "" ]]; then
        echo -e "CUDA installed!"
        INSTALL_CUDA=1
    else 
        echo -e "${BRED}Error: Could not found cuda installed!${NC}"
        exit 1
    fi 
fi

# Select version
TAGS=$(git ls-remote --tags $OPENCV_LINK | sed 's/.*\///; s/\^{}//' | sort -u)
HEADS=$(git ls-remote --heads $OPENCV_LINK | sed 's/.*\///; s/\^{}//' | sort -u)
VERSIONS="$TAGS $HEADS"
readarray -d " " -t VERSIONS_ARR <<< "$VERSIONS"
if [[ ${#VERSIONS} == 1 ]]; then
    echo -e "${BRED}Error: Cannot connect to $OPENCV_LINK!${NC}"
    exit 1
fi
INSTALL_VER=""
while : ; do
    read -p "$(echo -e $BBLUE"Choose OpenCV Version \n(Press \"l\" to list all available tags)\n(Press Enter to install master branch ): $NC")" A
    if [[ $A == "l" || $A == "L" ]]; then
        for VER in ${VERSIONS_ARR[@]}; do
            echo -e "$VER"
        done
    else
        if [[ "$A" == "" ]]; then
            INSTALL_VER="master"
        fi
        for VER in ${VERSIONS_ARR[@]}; do
            if  [[ "$VER" == "$A" ]]; then
                INSTALL_VER=$A
            fi
        done
        if [[ "$INSTALL_VER" != "" ]]; then

            break;
        else
            echo -e "Undefined version: \"$A\""
        fi
    fi
done
echo -e "Installing OpenCV-$INSTALL_VER ..."
sleep 2
    
INSTALL_DIR="$PWD/OpenCV_$INSTALL_VER" 
mkdir -p $INSTALL_DIR && cd $INSTALL_DIR

# Clone opencv and opencv_contrib repo
if ! [ -d opencv ]; then
    git clone https://github.com/opencv/opencv.git
fi
if ! [ -d opencv_contrib ]; then
    git clone https://github.com/opencv/opencv_contrib.git
fi

if ! [ -d opencv ]; then
    echo -d "${BRED}Error: Could not clone opencv from \"https://github.com/opencv/opencv.git\"${NC}"
    exit 1
fi
if ! [ -d opencv_contrib ]; then
    echo -d "${BRED}Error: Could not clone opencv_contrib from \"https://github.com/opencv/opencv_contrib.git\"${NC}"
    exit 1
fi
if [[ $INSTALL_VER == "master" ]]; then
    cd opencv
else
    cd opencv_contrib
    git checkout $INSTALL_VER
    cd ../opencv
    git checkout $INSTALL_VER
fi

# Install Addition Packages
sudo apt purge libopencv-dev libopencv-python libopencv-samples libopencv*

sudo apt-get install -y build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev python3-pip

# Install
mkdir -p build && cd build
if [ -f "CMakeCache.txt" ]; then
    rm CMakeCache.txt
fi
if [[ "INSTALL_CUDA" -eq 1 ]]; then
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D_GLIBCXX_USE_CXX11_ABI=0 \
        -D OPENCV_GENERATE_PKGCONFIG=ON \
        -D PYTHON3_EXECUTABLE=$(which python3) \
        -D PYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
        -D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
        -D OPENCV_EXTRA_MODULES_PATH=$INSTALL_DIR/opencv_contrib/modules \
        -D WITH_CUDA=ON \
        -D ENABLE_FAST_MATH=1 \
        -D CUDA_FAST_MATH=1 ..
else
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D_GLIBCXX_USE_CXX11_ABI=0 \
        -D OPENCV_GENERATE_PKGCONFIG=ON \
        -D PYTHON3_EXECUTABLE=$(which python3) \
        -D PYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
        -D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
        -D OPENCV_EXTRA_MODULES_PATH=$INSTALL_DIR/opencv_contrib/modules \ ..
fi
sudo make -j$(($(nproc) - 1)) 
sudo make install
echo -e "\n# OpenCV\nexport LD_LIBRARY_PATH=$INSTALL_DIR/opencv/build/lib:\$LD_LIBRARY_PATH\n" >> ~/.bashrc
source ~/.bashrc
python3 -c "import cv2; print(cv2.__version__)"
echo -e "${BGREEN}Done!${NC}"