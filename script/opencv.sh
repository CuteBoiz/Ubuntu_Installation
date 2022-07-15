#!/bin/bash

BBLUE='\033[1;34m'
BGREEN='\033[1;32m'
BRED='\033[1;31m'
NC='\033[0m'

# Install folder
INSTALL_DIR=$PWD
while : ; do
    read -p "$(echo -e $BBLUE"Install in current directory ($BRED$PWD$BBLUE) (y\\\n): $NC")" A
    ! [[ "$A" == "y" || "$A" == "Y" || "$A" == "N" || "$A" == "n" ]] || break
done
if [[ "$A" == "y" || "$A" == "Y" ]]; then
    : #Pass
else
    exit 1
fi

# Use OpenCV_Cuda?
INSTALL_CUDA=0
while : ; do
    read -p "$(echo -e $BBLUE"Do you want install OpenCV with CUDA support? (y\\\n): $NC")" A
    ! [[ "$A" == "y" || "$A" == "Y" || "$A" == "N" || "$A" == "n" ]] || break
done
if [[ "$A" == "y" || "$A" == "Y" ]]; then
    NVIDIA_CHECK="$(lsmod | grep ^nvidia | awk {'print $1'})"
    if [[ "$NVIDIA_CHECK" ==  *"nvidia"* ]]; then
        echo -e "${BGREEN}Nvidia driver installed!${NC}"    
    else
        echo -e "${BRED}Error: System has not installed nvidia-driver yet!${NC}"
        exit 1
    fi
    CUDA_CHECK=$(find /usr/local/cuda-*   -maxdepth 0)
    if ! [[ "$CUDA_CHECK" == "" ]]; then
        echo -e "${BGREEN}CUDA installed!${NC}"
        INSTALL_CUDA=1
    else 
        echo -e "${BRED}Error: Could not found cuda installed!${NC}"
        exit 1
    fi 
fi
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
# Select tag version
cd opencv_contrib
while : ; do
    read -p "$(echo -e $BBLUE"Choose OpenCV Version $BRED(Press \"l\" to list all available tags)\n(Press Enter to install master branch ): $NC")" A
    ! [ $(git tag -l $A) ] && ! [[ $A = "" ]] || break
    if [[ $A == "l" || $A == "L" ]]; then
        tags=$(git tag)
        echo -e "${BGREEN}$tags${NC}"
    fi
done
INSTALL_VER=$A
if [[ $INSTALL_VER == "" ]]; then
    cd ..
else
    git checkout $INSTALL_VER
    cd ../opencv
    git checkout $INSTALL_VER
    cd ..
fi
mkdir -p OpenCV_$INSTALL_VER 
mv opencv OpenCV_$INSTALL_VER/
mv opencv_contrib OpenCV_$INSTALL_VER/
cd OpenCV_$INSTALL_VER/opencv

# Check virtual env path available
ENV_PATH="NONE"
read -p "$(echo -e $BBLUE"Enter path to your virtual enviroment \"site-packages\" (Press Enter/Return to skip): $NC")" B
if [[ "$B" != "" ]]; then
    ENV_PATH=$B
    if [ -d $ENV_PATH ]; then
        echo -e "\"$ENV_PATH\" exist"
        if ! [[ "$ENV_PATH" == *"site-packages"* ]]; then
            echo -e "${BRED}Error: \"$ENV_PATH\" not available (path must point to virtual env's \"lib/python3.x/site-packages\")!${NC}"
            exit 1
        else
             echo -e "${BGREEN}OpenCV will be install in \"$ENV_PATH\".${NC}"
             sleep 2
        fi
    else
        echo -e "${BRED}Error: \"$ENV_PATH\" not exist!${NC}"
        exit 1
    fi
else
    echo -e "${BGREEN}OpenCV will be install for default python.${NC}"
fi

# Install Addition Packages
sudo apt-get install -y build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev

sudo apt-get install -y libgstreamer1.0-0 gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x \
    gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 \
    gstreamer1.0-qt5 gstreamer1.0-pulseaudio

# Install
mkdir -p build && cd build
if [[ "INSTALL_CUDA" -eq 1 ]]; then
    if [[ "$ENV_PATH" == "NONE" ]]; then
        cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D_GLIBCXX_USE_CXX11_ABI=0 \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D OPENCV_EXTRA_MODULES_PATH=$INSTALL_DIR/OpenCV_$INSTALL_VER/opencv_contrib/modules \
            -D WITH_CUDA=ON \
            -D ENABLE_FAST_MATH=1 \
            -D CUDA_FAST_MATH=1 ..
    else
        cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D_GLIBCXX_USE_CXX11_ABI=0 \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D OPENCV_EXTRA_MODULES_PATH=$INSTALL_DIR/OpenCV_$INSTALL_VER/opencv_contrib/modules \
            -D OPENCV_PYTHON3_INSTALL_PATH=$ENV_PATH \
            -D WITH_CUDA=ON \
            -D ENABLE_FAST_MATH=1 \
            -D CUDA_FAST_MATH=1 ..
    fi
else
    if [[ "$ENV_PATH" == "NONE" ]]; then
        cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D_GLIBCXX_USE_CXX11_ABI=0 \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D OPENCV_EXTRA_MODULES_PATH=$INSTALL_DIR/OpenCV_$INSTALL_VER/opencv_contrib/modules ..
    else
        cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D_GLIBCXX_USE_CXX11_ABI=0 \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D OPENCV_EXTRA_MODULES_PATH=$INSTALL_DIR/OpenCV_$INSTALL_VER/opencv_contrib/modules \
            -D OPENCV_PYTHON3_INSTALL_PATH=$ENV_PATH ..
    fi
fi
sudo make -j$(($(nproc) - 1)) 
sudo make install
echo -e "#OpenCV\nexport LD_LIBRARY_PATH=$INSTALL_DIR/OpenCV_$INSTALL_VER/opencv/build/lib:\$LD_LIBRARY_PATH\n" >> ~/.bashrc
source ~/.bashrc
python3 -c "import cv2; print(cv2.__version__)"
echo -e "${BGREEN}Done!${NC}"