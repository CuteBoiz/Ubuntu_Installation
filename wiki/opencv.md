# Install OpenCV From Source With CUDA Support

## I. Install the required dependencies.

- **Required Packages:**
    ```sh 
    sudo apt install -y build-essential cmake git pkg-config libgtk-3-dev \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
        gfortran openexr libatlas-base-dev python3-dev python3-numpy \
        libtbb2 libtbb-dev libdc1394-22-dev
    ```

- **GStreamer packages for video execute (optional)**:
    ```sh 
    sudo apt-get install -y libgstreamer1.0-0 gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
        gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x \
        gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 \
        gstreamer1.0-qt5 gstreamer1.0-pulseaudio
    ```

## II. Clone the OpenCV’s and OpenCV contrib repositories.
- **Clone opencv:**
    ```sh 
    mkdir ~/opencv_build && cd ~/opencv_build
    git clone https://github.com/opencv/opencv.git
    git clone https://github.com/opencv/opencv_contrib.git
    ```
<details> 
<summary><b>Switch version (optional):</b></summary>
    
```sh
cd ~/opencv_build/opencv
git checkout <opencv-version>
cd ~/opencv_build/opencv_contrib
git checkout <opencv-version>
```
**Note:** *`opencv` and `opencv_contrib` version must match!*
    
</details> 
    
## III. Build.

```sh
cd ~/opencv_build/opencv
mkdir build && cd build
```

***Note:*** *You must installed CUDA and cuDNN before use below script*
- **Build CMakeCache:**
    ```sh 
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D_GLIBCXX_USE_CXX11_ABI=0 \
        -D INSTALL_C_EXAMPLES=ON \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_GENERATE_PKGCONFIG=ON \
        -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON \
        -D WITH_CUDA=ON \
        -D ENABLE_FAST_MATH=1 \
        -D CUDA_FAST_MATH=1 ..
    ```
- **Make & make install:**
    ```sh
    sudo make -j$(($(nproc) - 1)) && sudo make install
    ```

- **Export Path:**
    
    Add below script to ~/.bashrc file by: `gedit ~/.bashrc`
    ```sh
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/opencv_build/opencv/build/lib
    ```
    
## IV. Verify and use.
<details>
<summary><b>Using in Python:</b></summary>

- Remove opencv-python ***(if installed)***.

- **Verify:**
    ```sh
    exec bash #Reload Terminal
    python3 -c "import cv2; print(cv2.__version__)"
    ```
    
</details>
    
<details>
<summary><b>Using in C++:</b></summary>
    
- **Add below script to `CMakeLists.txt`:**
    ```sh
    find_package(OpenCV REQUIRED)
    ...
    target_link_libraries( main ${OpenCV_LIBS})
    ```
- **In Cpp file:**
    ```c++
    #include <opencv2/imgproc/imgproc.hpp>
    #include <opencv2/highgui/highgui.hpp>
    ...
    ```
    
</details>
