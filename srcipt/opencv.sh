#!/bin/bash

# Install folder
INSTALL_DIR=$PWD
read -p "Install in current directory ($PWD) (y\n): " A
if [[ "$A" == "y" || "$A" == "Y" ]]; then
    :
else
    exit 0
fi

# Select version
read -p "Enter Install OpenCV Version (3.4, 4.x, 5.x, 3.4.12, 4.4.0, 4.5.5): " X
OPENCV_VERS=("3.4" "4.x" "5.x" "3.4.12" "4.4.0" "4.5.5") 
INSTALL_VER="NONE"

for VER in ${OPENCV_VERS[@]}; do
    if [[ "$X" == "$VER" ]]; then
        INSTALL_VER=$VER
    fi
done
if [[ "$INSTALL_VER" == "NONE" ]]; then
    echo -e "Undifined Version: \"$X\"!"
    exit 0 
else
    echo "Install Python-$INSTALL_VER"
fi

# Install for env
ENV_PATH="NONE"
read -p "Enter path to your virtual enviroment \"site-packages\" (Enter to install for default python): " B
if [[ "$B" != "" ]]; then
    ENV_PATH=$B
    if [ -d $ENV_PATH ]; then
        echo -e "\"$ENV_PATH\" exist"
        if ! [[ "$ENV_PATH" == *"site-packages"* ]]; then
            echo -e "\"$ENV_PATH\" not available (path must point to virtual env's \"lib/python3.x/site-packages\")!"
            exit 0
        else
             echo -e "OpenCV will be install in \"$ENV_PATH\"."
        fi
    else
        echo -e "\"$ENV_PATH\" not exist"
        exit 0
    fi
else
    echo -e "OpenCV will be install for default python."
fi

# Packages
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

# Clone repo
mkdir OpenCV_$INSTALL_VER && cd OpenCV_$INSTALL_VER
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

cd opencv_contrib
git checkout $INSTALL_VER

cd ../opencv
git checkout $INSTALL_VER
mkdir build && cd build

# Install
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

sudo make -j$(($(nproc) - 1)) 
sudo make install
echo -e "#OpenCV\nexport LD_LIBRARY_PATH=$INSTALL_DIR/OpenCV_$INSTALL_VER/opencv/build/lib:\$LD_LIBRARY_PATH\n" >> ~/.bashrc
source ~/.bashrc