# Install OpenCV From Source With CUDA Support

## I. Install:

```sh
git clone https://github.com/CuteBoiz/Ubuntu_Installation.git
cd Ubuntu_Installation
sudo bash
# If you want to install for specific python-env. Activate the python-env before run below script.
bash script/opencv_install.sh
```

## II. Verify and use.
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
