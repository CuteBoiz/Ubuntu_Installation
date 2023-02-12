#!/bin/bash

# Author: phatnt
# Date modify: Feb-12-23
# Usage: Install OpenCV from source
# Global variables:
#   + cudaSupport (int 0/1): install with cuda support
#   + opencvVer (string): OpenCv version (ex: 3.4.12, 4.5.5, master, etc)

opencvLink="https://github.com/opencv/opencv.git"
contribLink="https://github.com/opencv/opencv_contrib.git"

F_exportBashrc () {
    if ! grep -Fxq "$1" /home/$(logname)/.bashrc; then
        echo $1 >> /home/$(logname)/.bashrc
    fi
	if ! grep -Fxq "$1" /home/$(logname)/.bashrc; then
        echo $1 >> /home/$(logname)/.bashrc
    fi
}

# libopencv for C++/python
opencvCheck=$(pkg-config --modversion opencv)
opencv4Check=$(pkg-config --modversion opencv4)
contribCheck=$(python3 -c 'import cv2; print(cv2.aruco)')
if [[ -z "$opencvCheck" && -z "$opencv4Check" ]] || [[ -z "$contribCheck" ]]; then
    echo -e "${BBlue}[INFO]: Installing OpenCV $opencvVer ... ${NC}"
    sleep 2
    pip3 uninstall opencv-python
	pip3 uninstall opencv-python-headless
	pip3 uninstall opencv-contrib-python
	pip3 uninstall opencv-contrib-python-headless
    installDir="/home/$(logname)/Libraries/OpenCV_$opencvVer"
    mkdir -p $installDir && cd $installDir
    echo -e "${BBlue}[INFO]: OpenCV will be install in '$PWD'${NC}"
    sleep 2

    git clone $opencvLink -b $opencvVer
    git clone $contribLink -b $opencvVer
    cd opencv
    sudo apt-get update
    sudo apt purge -y libopencv-python libopencv-samples
    sudo apt-get -y install build-essential cmake git pkg-config libgtk-3-dev \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
        gfortran openexr libatlas-base-dev python3-dev python3-numpy \
        libtbb2 libtbb-dev libdc1394-22-dev python3-pip

    mkdir -p build && cd build
    if [ -f "CMakeCache.txt" ]; then
        sudo rm CMakeCache.txt
    fi
    if [[ $cudaSupport == 1 ]]; then
        cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D_GLIBCXX_USE_CXX11_ABI=0 \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D BUILD_opencv_python2=OFF \
            -D PYTHON3_EXECUTABLE=$(which python3) \
            -D PYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
            -D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
            -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
            -D ENABLE_FAST_MATH=1 \
            -D CUDA_FAST_MATH=1 \
            -D WITH_CUBLAS=1 \
            -D WITH_CUDA=ON \
            -D BUILD_opencv_cudacodec=OFF \
            -D WITH_CUDNN=ON \
            -D OPENCV_DNN_CUDA=ON ..
    else
        cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D_GLIBCXX_USE_CXX11_ABI=0 \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D BUILD_opencv_python2=OFF \
            -D PYTHON3_EXECUTABLE=$(which python3) \
            -D PYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
            -D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
            -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ..
    fi

    sudo make -j$(($(nproc) - 1))
    sudo make install
    F_exportBashrc "# OpenCV"
    F_exportBashrc "export LD_LIBRARY_PATH=$installDir/opencv/build/lib:\$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH=$installDir/opencv/build/lib:$LD_LIBRARY_PATH
    opencvCheck=$(pkg-config --modversion opencv)
    opencv4Check=$(pkg-config --modversion opencv4)
    contribCheck=$(python3 -c 'import cv2; print(cv2.aruco)') 
    if [[ -z "$opencvCheck" && -z "$opencv4Check" ]] || [[ -z "$contribCheck" ]]; then
        >&2 echo -e "${BRed}[ERROR]: Install OpenCV failed!${NC}"
        exit 1
    fi
    cd $installDir
    chmod 777 -R *
    echo -e "${BGreen}[INFO]: Install OpenCV-$opencvCheck-$opencv4Check successfully!${NC}"
    sleep 2
else
    echo -e "${BBlue}[INFO]: Found OpenCV-$opencvCheck and -$opencv4Check!${NC}"
    sleep 2
fi

