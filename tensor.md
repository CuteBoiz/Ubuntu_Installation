# Install Tensorflow & Keras with GPU support

## Table of Content

- [NVIDIA GPU Driver](https://github.com/CuteBoiz/Ubuntu/blob/master/tensor.md#i-nvidia-gpu-drivers)
- [CUDA Toolkit](https://github.com/CuteBoiz/Ubuntu/blob/master/tensor.md#ii-cuda-toolkit)
- [cuDNN SDK](https://github.com/CuteBoiz/Ubuntu/blob/master/tensor.md#iii-cudnn-sdk)
- [TensorRT](https://github.com/CuteBoiz/Ubuntu/blob/master/tensor.md#iv-tensorrt)
- [Tensorflow + Keras](https://github.com/CuteBoiz/Ubuntu/blob/master/tensor.md#v-tensorflow-with-gpu-support)


## I. NVIDIA GPU Drivers.

***Check NVIDIA Driver Installed:***
Use `nvidia-smi` to check NVIDIA driver. If your system installed NVIDIA driver, it will look similar to this:
```sh
Sun Aug 16 12:34:19 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.51.06    Driver Version: 450.51.06    CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  GeForce GTX 950     On   | 00000000:01:00.0  On |                  N/A |
| 35%   38C    P8    11W /  75W |    330MiB /  1999MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
```                                                                             
If your system installed NVIDIA driver you **must** skip the NVIDIA GPU Driver Install step. Or it will **conflict**.

***Download & Install:***  
***!!!MAKE SURE THAT YOUR SYSTEM HAVEN'T INSTALL NVIDIA DRIVER YET***

- Go to [NVIDIA Download Drivers](https://www.nvidia.com/download/index.aspx?lang=en-us)
- Choose the corresponding OS & GPU
- **Download**
- run file `./NVIDIA-Linux-x86_64-4xx.xx.run`

## II. CUDA Toolkit.

***Verify the system has a CUDA-capable GPU.***  

```sh 
lspci | grep -i nvidia
```

Output: 
```sh
01:00.0 VGA compatible controller: NVIDIA Corporation GM206 [GeForce GTX 950] (rev a1)
01:00.1 Audio device: NVIDIA Corporation GM206 High Definition Audio Controller (rev a1)

```
- If you do not see any settings, update the PCI hardware `update-pciids` then return the previous command.

- If your GPU is from NVIDA and listed in https://developer.nvidia.com/cuda-gpus, your GPU is CUDA-capable.

***Download the NVIDA CUDA Toolkit:*** 

- Go to [NVIDIA CUDA Download Page](https://developer.nvidia.com/cuda-toolkit-archive).
- Choose CUDA Toolkit **10.1**
- Choose your corresponding OS.
- Download the deb(local).
- Then follow instructions step.

## III. cuDNN SDK.

***Download:***

- Go to [NVIDIA cuDNN home page](https://developer.nvidia.com/cudnn)
- Click **Download**
- Complete short survey and click **Submit**
- Accept the Terms and Conditions.
- Download 3 **.deb** files for Ubuntu.


***Install:***

- Install the runtime library, for example: `sudo dpkg -i libcudnn8_x.x.x-1+cudax.x_amd64.deb`
- Install the developer library, for example: `sudo dpkg -i libcudnn8-dev_8.x.x.x-1+cudax.x_amd64.deb`
- Install the code samples and the cuDNN library documentation, for example: `sudo dpkg -i libcudnn8-doc_8.x.x.x-1+cudax.x_amd64.deb`

***Verify cuDNN Install:***

To verify that cuDNN is installed and is running properly, compile the `mnistCUDNN` sample located in the `/usr/src/cudnn_samples_v8` directory in the Debian file.

```sh
cp -r /usr/src/cudnn_samples_v8/ $HOME
cd  $HOME/cudnn_samples_v8/mnistCUDNN
make clean && make
./mnistCUDNN

```
Output:
```sh 
Test passed!
```

## IV. TensorRT.

***Download:***
- Go to: [TensorRT Page](https://developer.nvidia.com/tensorrt).
- Click Download Now.
- Select the version of TensorRT that you are interested in.
- Select the check-box to agree to the license terms.
- Download **.deb** file 

***Install:*** 

Install TensorRT from the Debian local repo package:
```sh
os="ubuntuxx04"
tag="cudax.x-trt7.x.x.x-ga-yyyymmdd"
sudo dpkg -i nv-tensorrt-repo-${os}-${tag}_1-1_amd64.deb
sudo apt-key add /var/nv-tensorrt-repo-${tag}/7fa2af80.pub

sudo apt-get update
sudo apt-get install tensorrt cuda-nvrtc-x-y
```
Where `x-y` for `cuda-nvrtc` is either `10-2` or `11-0`.

```
sudo apt-get install python3-libnvinfer-dev
sudo apt-get install uff-converter-tf
```

## V. Tensorflow with GPU support. 

```sh
pip install tensorflow-gpu
pip install keras
```










