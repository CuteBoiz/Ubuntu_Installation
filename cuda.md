# Install CUDA + cuDNN + TensorRT for Deep Learning Model Inference 

## Content 

- [I - Download CUDA Toolkit and Preprequisted.](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#i-download-cuda-toolkit-and-preprequisted)
- [II - CUDA Toolkit](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#ii-cuda-toolkit)
- [III - cuDNN](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#iii-cudnn)
- [IV - TensorRT](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/cuda.md#iv-tensorrt)

## I. Download CUDA Toolkit and Preprequisted.

### 1. Download Cuda ToolKit.
- Go to [NVIDIA CUDA Download Page](https://developer.nvidia.com/cuda-toolkit-archive)
- Choose Version
- `[Linux] -> [x86_64] -> [Ubuntu] -> [xx.04] -> [runfile(local)]`
- Just download the CUDA by the following `wget` command. ***DON'T INSTALL!***

### 2. Install NVIDIA Driver:

The downloaded Cuda file similar to: `cuda_11.1.0_455.23.05_linux.run` which `455` stand for NVIDIA Driver version. Install that version:
```sh
sudo apt-get install --no-install-recommends nvidia-driver-4xx 
sudo reboot
```

  - Use `nvidia-smi` to check NVIDIA driver installed.(Don't care about the CUDA Version or Driver Version show)
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

### 3. GCC:
- Check GCC Version: `gcc --version`

- Check below table to get the coressponding gcc version with your CUDA Driver.

<table align="center" style="width:100%">
  <tr align="center">
    <th>CUDA Version</th>
    <th>max supported GCC version</th>
  </tr>
  <tr align="center">
	<td>11.1, 11.2, 11.3</td>
    	<td>10</td>
  </tr>
  <tr align="center">
	<td>11.0</td>
	<td>9</td>
  </tr>
  <tr align="center">
	<td>10.1, 10.2</td>
	<td>8</td>
  </tr>
  <tr align="center">
	<td>9.2, 10.0</td>
	<td>7</td>
  </tr>
  <tr align="center">
	<td>9.0, 9.1</td>
	<td>6</td>
  </tr>
  <tr align="center">
	<td>8.0</td>
	<td>5.3</td>
  </tr>
  <tr align="center">
	<td>7.0</td>
	<td>4.9</td>
  </tr>
  <tr align="center">
	<td>5.5, 6.0</td>
	<td>4.8</td>
  </tr>
  <tr align="center">
	<td>4.2, 5.0</td>
	<td>4.6</td>
  </tr>
  <tr align="center">
	<td>4.1</td>
	<td>4.5</td>
  </tr>
  <tr align="center">
	<td>4.0</td>
	<td>4.4</td>
  </tr>	
</table>

- Re-install gcc if you have unsupported gcc Version:
	```sh
	MAX_GCC_VERSION=x #x stand for the supported GCC version
	sudo apt install gcc-$MAX_GCC_VERSION g++-$MAX_GCC_VERSION
	```

- Change Gcc current version (Example: change from `9.0` to `8.0`):
	- Remove Alternative:
	```
	sudo update-alternatives --remove-all gcc 
	sudo update-alternatives --remove-all g++
	```
	- Set priority:
	```
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9.0 10
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8.0 20

	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9.0 10
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8.0 20

	sudo update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
	sudo update-alternatives --set cc /usr/bin/gcc

	sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
	sudo update-alternatives --set c++ /usr/bin/g++
	```
	
	- Update Alternatives:
	```
	sudo update-alternatives --config gcc
	sudo update-alternatives --config g++
	```

## II. CUDA Toolkit.
 
- **Install CUDA Toolkit:**
  - Go to downloaded CUDA folder.
  - `sudo sh cuda_xx.x.x_4xx.xx.xx_linux.run`.
  - `continue`.
  - `accept`
  - Uncheck NVIDIA Driver:
  	```sh
	| CUDA Installer                                                               │
	│ - [ ] Driver                                                                 │
	│      [ ] 450.51.06                                                           │
	│ + [X] CUDA Toolkit 11.0                                                      │
	│   [X] CUDA Samples 11.0                                                      │
	│   [X] CUDA Demo Suite 11.0                                                   │
	│   [X] CUDA Documentation 11.0                                                │
	│   Options                                                                    │
	│   Install 								       |
	```
- **Result:**
	```sh
	= Summary =
	===========

	Driver:   Not Selected
	Toolkit:  Installed in /usr/local/cuda-11.0/
	Samples:  Installed in /home/phatnt/, but missing recommended libraries

	Please make sure that
	 -   PATH includes /usr/local/cuda-11.0/bin
	 -   LD_LIBRARY_PATH includes /usr/local/cuda-11.0/lib64, or, add /usr/local/cuda-11.0/lib64 to /etc/ld.so.conf and run ldconfig as root

	To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-11.0/bin
	***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least .00 is required for CUDA 11.0 functionality to work.
	To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
	    sudo <CudaInstaller>.run --silent --driver

	Logfile is /var/log/cuda-installer.log
	```
  - `sudo reboot`
  - Add below scripts to `~/.bashrc`

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
	exec bash
	nvcc -V
	```

## III. cuDNN.

- **Download:**

	- Go to [NVIDIA cuDNN home page](https://developer.nvidia.com/cudnn)
  	- Click `Download cuDNN`.
  	- Login then `Submit` short survey if first time download.
  	- Check `Accept the Terms and Conditions`.
  	- Click `Archived cuDNN Releases`.
  	- **Choose the corresponding version with your CUDA Toolkit Version.**
  	- Download the `cuDNN Library for Linux (x86_64)`.

- ***Install:***
	```sh 
	tar -xzvf cudnn-x.x-linux-x64-v8.x.x.x.tgz
	sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
	sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
	sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
	```

## IV. TensorRT.

- **Download:**
  	- Go to: [TensorRT Page](https://developer.nvidia.com/tensorrt).
  	- Click `Get Started`.
  	- Click `Download Now`.
  	- Login then `Submit` short survey if first time download.
  	- Select the version of TensorRT that you're interested in.
  	- Check `I Agree To the Terms of the NVIDIA TensorRT License Agreement`.
  	- Download `TAR Package` with corresponding CUDA ToolkitVersion.
  	- Extract downloaded file to `/home/username/` folder. This place will become installed folder.

- **Install with Tar File:**

  - ***Step 1: Go to installed folder.***
  	```sh
	cd TensorRT-7.x.x.x...
	```

  - ***Step 2: Install the Python `TensorRT` wheel file.***
	Choose the Python version using in your system: (mine was 3.7)
	```sh
	cd python 
	pip install tensorrt-*-cp37-none-linux_x86_64.whl
	```

  - ***Step 3: Install the Python `UFF` wheel file.***
	```sh
	cd ../uff
	pip install uff-*-py2.py3-none-any.whl
	```

  - ***Step 4: Install the Python `graphsurgeon` wheel file.***
	```sh 
	cd ../graphsurgeon
	pip install graphsurgeon-*-py2.py3-none-any.whl
	```

  - ***Step 5: Install the Python `onnx-graphsurgeon` wheel file.***
	```sh 
	cd ../onnx_graphsurgeon
	pip install onnx_graphsurgeon-*-py2.py3-none-any.whl
	```
  - ***Step 6: Add below srcipt to ~/.bashrc:*** `gedit ~/.bashrc`
 
  	**Change username and "x" to your TensorRT version:**
	```sh
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/username/TensorRT-7.x.x.x/lib
	```
- **Verify:**
  - ***Python:*** [TensorRT Parser Python](https://github.com/CuteBoiz/TensorRT_Parser_Python)
	 ```sh
	 exec bash #Reload terminal
	 python3 -c "import tensorrt as trt; print(trt.__version__)"
	 ```
	 ***Note:*** Python had not support TensorRT on Windows yet. 
	 
  - ***C++:***  [TensorRT Parser C++](https://github.com/CuteBoiz/TensorRT_Parser_Cpp)

	- Add those script to **CMakeLists** flie:
		```sh
		#Cuda
		include_directories(/usr/local/cuda/include)
		link_directories(/usr/local/cuda/lib64)

		#TensorRT
		include_directories(path/to/TensorRT-7.x.x.x/include) #X is your TensorRT version
		link_directories(path/to/TensorRT-7.x.x.x/lib)
		```
		
 	- In Cpp file:
		```sh
		#include <NvInferRuntime.h>
		#include <NvInfer.h>
		#include <NvOnnxParser.h>
		```
