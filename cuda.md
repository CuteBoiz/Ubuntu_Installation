# Install CUDA + cuDNN + TensorRT for deeplearning 

## Content 

- [I - NVIDIA package](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#i-add-nvidia-package-repositories)
- [II - NIVIDA GPU Driver](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#ii-nvidia-gpu-drivers)
- [III - CUDA Toolkit](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#iii-cuda-toolkit)
- [IV - cuDNN](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#iv-cudnn)
- [V - TensorRT](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#v-tensorrt)

## I. Add NVIDIA package repositories.

```sh
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo dpkg -i cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
sudo apt-get update
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt-get update
```

## II. NVIDIA GPU Drivers.

- **Step 1: Check NVIDIA Driver Installed:**
	Use `nvidia-smi` to check NVIDIA driver. If your system installed NVIDIA driver, it looked similar to this:
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
	If your system installed NVIDIA driver you **MUST** skip the NVIDIA GPU Driver Install step. Or it will **conflict**.

-  **Step 2: Download & Install:** 
`!!!MAKE SURE THAT YOUR SYSTEM HAVEN'T INSTALL NVIDIA DRIVER YET`

	- Go to [NVIDIA Download Drivers](https://www.nvidia.com/download/index.aspx?lang=en-us)
	- Choose the corresponding OS & GPU
	- run `sudo sh NVIDIA-Linux-x86_64-4xx.xx.run`
	- reboot
	
	OR:
	```sh
	sudo apt-get install --no-install-recommends nvidia-driver-4x0
	reboot
	```

## III. CUDA Toolkit.

- **Download CUDA Toolkit:**

  - Go to [NVIDIA CUDA Download Page](https://developer.nvidia.com/cuda-toolkit-archive)
  - Choose Version
  - [Linux] -> [x86_64] -> [Ubuntu] -> [xx.04] -> [runfile(local)]
  - Follow the instruction
  - Reboot
  - Add those script to `~/.bashrc`

	```sh 
	/sbin/modprobe nvidia

	if [ "$?" -eq 0 ]; then
	  # Count the number of NVIDIA controllers found.
	  NVDEVS=`lspci | grep -i NVIDIA`
	  N3D=`echo "$NVDEVS" | grep "3D controller" | wc -l`
	  NVGA=`echo "$NVDEVS" | grep "VGA compatible controller" | wc -l`

	  N=`expr $N3D + $NVGA - 1`
	  for i in `seq 0 $N`; do
	    mknod -m 666 /dev/nvidia$i c 195 $i
	  done

	  mknod -m 666 /dev/nvidiactl c 195 255

	else
	  exit 1
	fi

	/sbin/modprobe nvidia-uvm

	if [ "$?" -eq 0 ]; then
	  # Find out the major device number used by the nvidia-uvm driver
	  D=`grep nvidia-uvm /proc/devices | awk '{print $1}'`

	  mknod -m 666 /dev/nvidia-uvm c $D 0
	else
	  exit 1
	fi		

	for CUDA_BIN_DIR in `find /usr/local/cuda-*/bin   -maxdepth 0`; do export PATH="$PATH:$CUDA_BIN_DIR"; done;
	for CUDA_LIB_DIR in `find /usr/local/cuda-*/lib64 -maxdepth 0`; do export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}$CUDA_LIB_DIR"; done;

	export            PATH=`echo $PATH            | tr ':' '\n' | awk '!x[$0]++' | tr '\n' ':' | sed 's/:$//g'` # Deduplicate $PATH
	export LD_LIBRARY_PATH=`echo $LD_LIBRARY_PATH | tr ':' '\n' | awk '!x[$0]++' | tr '\n' ':' | sed 's/:$//g'` # Deduplicate $LD_LIBRARY_PATH

	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64

	```
		
  - Verify Installation.
	```sh 
	nvcc -V
	```

## IV. cuDNN.

- **Download:**

	- Go to [NVIDIA cuDNN home page](https://developer.nvidia.com/cudnn)
  	- Click **Download**
  	- Complete short survey and click **Submit**
  	- Accept the Terms and Conditions.
  	- **Choose the corresponding version with your CUDA Toolkit Version(Important)**
  	- Download the ***cuDNN Library for Linux (x86_64)***

- ***Install:***

	```sh 
	tar -xzvf cudnn-x.x-linux-x64-v8.x.x.x.tgz
	sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
	sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
	sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
	```

## V. TensorRT.

- **Download:**
  	- Go to: [TensorRT Page](https://developer.nvidia.com/tensorrt).
  	- Click Download Now.
  	- Select the version of TensorRT that you are interested in.
  	- Select the check-box to agree to the license terms.
  	- Download ***TAR*** package with corresponding CUDA ToolkitVersion.

- **Install with Tar File:**

  - ***Step 1: Unzip.***
	```sh 
	tar xzvf TensorRT-7.x.x.x......
	cd TensorRT-7.x.x.x...
	pwd #Then copy the path and paste it below
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<TensorRT-PATH-coppied>
	```

  - ***Step 2: Install the Python `TensorRT` wheel file.***
	Choose the Python version using in your system: (mine was 3.7)
	```sh
	cd python 
	sudo pip3 install tensorrt-*-cp37-none-linux_x86_64.whl
	```

  - ***Step 3: Install the Python `UFF` wheel file.***
	```sh
	cd ../uff
	sudo pip3 install uff-0.6.9-py2.py3-none-any.whl
	```

  - ***Step 4: Install the Python `graphsurgeon` wheel file.***
	```sh 
	cd ../graphsurgeon
	sudo pip3 install graphsurgeon-0.4.5-py2.py3-none-any.whl
	```

  - ***Step 5: Install the Python `onnx-graphsurgeon` wheel file.***
	```sh 
	cd ../onnx_graphsurgeon
	sudo pip3 install onnx_graphsurgeon-0.2.6-py2.py3-none-any.whl
	```
  - ***Step 6: Add $PATH***
	```sh
	gedit ~/.bashrc
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/tanphatnguyen/TensorRT-7.x.x.x/lib
	#Change installed folder and "x" to your TensorRT version
	```
- **Use:**
  - ***Python***
	 ```sh
	 python3 -c "import tensorrt as trt; print(trt.__version__)"
	 ```
  - ***C++***

	Add those script to **CMakeLists** flie:
	```sh
	#Cuda
	include_directories(/usr/local/cuda/include)
	link_directories(/usr/local/cuda/lib64)

	#TensorRT
	include_directories(path/to/TensorRT-7.x.x.x/include) #X is your TensorRT version
	link_directories(path/to/TensorRT-7.x.x.x/lib)
	```
 
	```sh
	#include <NvInferRuntime.h>
	#include <NvInfer.h>
	#include <NvOnnxParser.h>
	```
