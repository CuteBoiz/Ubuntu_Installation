#!/bin/bash
BBLUE='\033[1;34m'
BGREEN='\033[1;32m'
BRED='\033[1;31m'
NC='\033[0m'
OPENCV_LINK="https://github.com/opencv/opencv.git"
OPENCV_CONTRIB_LINK="https://github.com/opencv/opencv_contrib.git"
INSTALL_CUDA=0

# Install folder
INSTALL_DIR="$HOME/Libraries"
mkdir -p $INSTALL_DIR && cd $INSTALL_DIR
echo -e "OpenCV will be install in \"$PWD\""
sleep 2

# Use OpenCV with Cuda support
while : ; do
    read -p "$(echo -e $BBLUE"Do you want install OpenCV with CUDA support? (y\\\n): $NC")" A
    A=${A^^}
    if [[ "$A" == "Y" || "$A" == "YES" ]]; then
        # Check Nvidia driver installed
        NVIDIA_CHECK="$(lsmod | grep ^nvidia | awk {'print $1'})"
        if [[ "$NVIDIA_CHECK" ==  *"nvidia"* ]]; then
            echo -e "Nvidia driver installed!"    
        else
            echo -e "${BRED}Error: System has not installed nvidia-driver yet!${NC}"
            exit 1
        fi
        # Check Cuda
        CUDA_CHECK=$(find /usr/local/cuda-*   -maxdepth 0)
        CUDA_VER=$(nvcc -V | sed -n 4p | cut -d" " -f5)
        CUDA_VER=${CUDA_VER:0:4}
        if [[ "$CUDA_CHECK" == "" ]]; then            
            echo -e "${BRED}Error: Cuda not installed!${NC}"
            exit 1
        else
            if [[ "$CUDA_VER" == "" ]]; then
                echo -e "${BRED}Found Cuda installed. But did not add it to \$PATH. Add cuda to $PATH then use \"nvcc -V\" to check!"
                exit 1
            else
                echo -e "Found CUDA-$CUDA_VER"
                INSTALL_CUDA=1
            fi
        fi
        break
    elif [[ "$A" == "N" || "$A" == "NO" ]]; then
        echo -e "Install OpenCV without CUDA support" 
        break
    fi
done


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
    read -p "$(echo -e $BBLUE"Choose OpenCV Version
${NC}(Press ${BBLUE}l${NC} to list all available tags)
(Press ${BBLUE}Return/Enter${NC} to install master branch)${BBLUE}: $NC")" A
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
echo -e "Installing OpenCV_$INSTALL_VER ..."
INSTALL_DIR="$PWD/OpenCV_$INSTALL_VER" 
mkdir -p $INSTALL_DIR && cd $INSTALL_DIR
sleep 2

# Clone opencv and opencv_contrib repo
if ! [ -d opencv ]; then
    git clone $OPENCV_LINK
fi
if ! [ -d opencv_contrib ]; then
    git clone $OPENCV_CONTRIB_LINK
fi

if ! [ -d opencv ]; then
    echo -d "${BRED}Error: Could not clone opencv from \"$OPENCV_LINK\"${NC}"
    exit 1
fi
if ! [ -d opencv_contrib ]; then
    echo -d "${BRED}Error: Could not clone opencv_contrib from \"$OPENCV_CONTRIB_LINK\"${NC}"
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
    sudo rm CMakeCache.txt
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
        -D OPENCV_EXTRA_MODULES_PATH=$INSTALL_DIR/opencv_contrib/modules ..
fi
sudo make -j$(($(nproc) - 1)) 
sudo make install
echo -e "\n# OpenCV\nexport LD_LIBRARY_PATH=$INSTALL_DIR/opencv/build/lib:\$LD_LIBRARY_PATH\n" >> ~/.bashrc
source ~/.bashrc
python3 -c "import cv2; print(cv2.__version__)"
echo -e "${BGREEN}Done!${NC}"