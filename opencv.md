# Install OpenCV From Source

## I. Install the required dependencies:

```sh 
sudo apt install -y build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev
```

## II. Clone the OpenCV’s and OpenCV contrib repositories:

```sh 
mkdir ~/opencv_build && cd ~/opencv_build
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
```

Use `git checkout <opencv-version>` to change OpenCV version.


## III. Build

```sh
cd ~/opencv_build/opencv
mkdir build && cd build
```

```sh 
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..
```

Use `nproc` to check number of processes then minus it by 2 then start make with:

```sh
make -j8
sudo make install
```
`8` stand for number of precesses

## IV. Verify

```sh 
python3 -c "import cv2; print(cv2.__version__)"
```