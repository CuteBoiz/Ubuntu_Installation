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
Output:
```sh
You have bazel 3.0.0 installed.
Please specify the location of python. [Default is /usr/bin/python3]: 


Found possible Python library paths:
  /usr/lib/python3/dist-packages
  /usr/local/lib/python3.6/dist-packages
Please input the desired Python library path to use.  Default is [/usr/lib/python3/dist-packages]

Do you wish to build TensorFlow with OpenCL SYCL support? [y/N]: 
No OpenCL SYCL support will be enabled for TensorFlow.

Do you wish to build TensorFlow with ROCm support? [y/N]: 
No ROCm support will be enabled for TensorFlow.

Do you wish to build TensorFlow with CUDA support? [y/N]: Y
CUDA support will be enabled for TensorFlow.

Do you wish to build TensorFlow with TensorRT support? [y/N]: 
No TensorRT support will be enabled for TensorFlow.

Found CUDA 10.1 in:
    /usr/local/cuda-10.1/targets/x86_64-linux/lib
    /usr/local/cuda-10.1/targets/x86_64-linux/include
Found cuDNN 7 in:
    /usr/lib/x86_64-linux-gnu
    /usr/include


Please specify a list of comma-separated CUDA compute capabilities you want to build with.
You can find the compute capability of your device at: https://developer.nvidia.com/cuda-gpus Each capability can be specified as "x.y" or "compute_xy" to include both virtual and binary GPU code, or as "sm_xy" to only include the binary code.
Please note that each additional compute capability significantly increases your build time and binary size, and that TensorFlow only supports compute capabilities >= 3.5 [Default is: 3.5,7.0]: 6.1


Do you want to use clang as CUDA compiler? [y/N]: 
nvcc will be used as CUDA compiler.

Please specify which gcc should be used by nvcc as the host compiler. [Default is /usr/bin/gcc]: 


Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -march=native -Wno-sign-compare]: 


Would you like to interactively configure ./WORKSPACE for Android builds? [y/N]: 
Not configuring the WORKSPACE for Android builds.

Preconfigured Bazel build configs. You can use any of the below by adding "--config=<>" to your build command. See .bazelrc for more details.
    --config=mkl            # Build with MKL support.
    --config=monolithic     # Config for mostly static monolithic build.
    --config=ngraph         # Build with Intel nGraph support.
    --config=numa           # Build with NUMA support.
    --config=dynamic_kernels    # (Experimental) Build kernels into separate shared objects.
    --config=v2             # Build TensorFlow 2.x instead of 1.x.
Preconfigured Bazel build configs to DISABLE default on features:
    --config=noaws          # Disable AWS S3 filesystem support.
    --config=nogcp          # Disable GCP support.
    --config=nohdfs         # Disable HDFS support.
    --config=nonccl         # Disable NVIDIA NCCL support.
Configuration finished
```

#### Step 3: Build:
```sh
bazel build --config=cuda --local_cpu_resources=HOST_CPUS-2 //tensorflow/tools/pip_package:build_pip_package
```


