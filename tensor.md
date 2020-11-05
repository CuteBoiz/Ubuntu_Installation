# Install Tensorflow & Keras with GPU support

## I. Prerequiste

### 1. CUDA + cuDNN + TensorRT


### 2. Bazel

#### Step 1: Add Bazel distribution URI as a package source:
```sh
sudo apt install curl gnupg
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
```

#### Step 2: Install and update Bazel:

```sh
sudo apt update && sudo apt install bazel
sudo apt update && sudo apt full-upgrade
sudo apt install bazel-3.1.0
```
#### Step 3: Install a JDK (Optional)
```sh
sudo apt install openjdk-11-jdk
```

## II. Install

#### Step 1: Dowload:
```sh
pip install -U --user pip six 'numpy<1.19.0' wheel setuptools mock 'future>=0.17.1' 'gast==0.3.3' typing_extensions
pip install -U --user keras_applications --no-deps
pip install -U --user keras_preprocessing --no-deps

git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
```

#### Step 2: Configure:
```sh
./configure
```
You will see those message:
```sh
You have bazel 3.1.0 installed.
Please specify the location of python. [Default is /usr/local/bin/python3]: 


Found possible Python library paths:
  /usr/local/lib/python3.7/site-packages
Please input the desired Python library path to use.  Default is [/usr/local/lib/python3.7/site-packages]

Do you wish to build TensorFlow with ROCm support? [y/N]: 
No ROCm support will be enabled for TensorFlow.

Do you wish to build TensorFlow with CUDA support? [y/N]: y
CUDA support will be enabled for TensorFlow.

Do you wish to build TensorFlow with TensorRT support? [y/N]: y
TensorRT support will be enabled for TensorFlow.
```
When you have message like this:
```sh
Could not find any NvInferVersion.h matching version '' in any subdirectory:
        ''
        'include'
        'include/cuda'
        'include/*-linux-gnu'
        'extras/CUPTI/include'
        'include/cuda/CUPTI'
        'local/cuda/extras/CUPTI/include'
of:
        '/lib'
        '/lib/x86_64-linux-gnu'
        '/usr'
        '/usr/local/cuda'
        '/usr/local/cuda-11.0/targets/x86_64-linux/lib'
```
Just put the directories below the `of` separated by comma like this:
```sh
/lib,/lib/x86_64-linux-gnu,/usr,/usr/local/cuda,/usr/local/cuda,/usr/local/cuda-11.0/targets/x86_64-linux/lib
```
Then add them with your TensorRT install directory:

Mine was `/home/tanphatnguyen/TensorRT-7.2.1.6`:
```sh
/lib,/lib/x86_64-linux-gnu,/usr,/usr/local/cuda,/usr/local/cuda,/usr/local/cuda-11.0/targets/x86_64-linux/lib,/home/tanphatnguyen/TensorRT-7.2.1.6
```
Fill your CUDA, cuDNN, TensorRT version + the above directories into those:
```sh
Please specify the CUDA SDK version you want to use. [Leave empty to default to CUDA 10]: 11


Please specify the cuDNN version you want to use. [Leave empty to default to cuDNN 7]: 8


Please specify the TensorRT version you want to use. [Leave empty to default to TensorRT 6]: 7


Please specify the locally installed NCCL version you want to use. [Leave empty to use http://github.com/nvidia/nccl]: 


Please specify the comma-separated list of base paths to look for CUDA libraries and headers. [Leave empty to use the default]: /lib,/lib/x86_64-linux-gnu,/usr,/usr/local/cuda,/usr/local/cuda,/usr/local/cuda-11.0/targets/x86_64-linux/lib,/home/tanphatnguyen/TensorRT-7.2.1.6
```

#### Step 3: Build:
```sh
bazel build --config=cuda --local_cpu_resources=HOST_CPUS-2 //tensorflow/tools/pip_package:build_pip_package
```


