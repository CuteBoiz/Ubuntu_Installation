# Install CUDA + cuDNN + TensorRT.

## Content 

- [I - Download CUDA Toolkit and Prerequisted.](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/wiki/cuda.md#i-download-cuda-toolkit-and-prerequisted)
- [II - Install CUDA Toolkit](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/wiki/cuda.md#ii-cuda-toolkit)
- [III - Install cuDNN](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/wiki/cuda.md#iii-cudnn)
- [IV - Install TensorRT](https://github.com/CuteBoiz/Ubuntu_Installation/blob/master/wiki/cuda.md#iv-tensorrt)

## I. Download CUDA Toolkit and Prerequisted.

- **Download Cuda ToolKit.**
	- Go to [NVIDIA CUDA Download Page](https://developer.nvidia.com/cuda-toolkit-archive)
	- Choose Version
	- `[Linux] -> [x86_64] -> [Ubuntu] -> [xx.04] -> [runfile(local)]`
	- Just **download** the Cuda Toolkit by the following `wget` command. 
	- **DON'T INSTALL!**

- **Install coresponding NVIDIA Driver:**

	- The downloaded Cuda Toolkit file's name similar to: `cuda_11.1.0_455.23.05_linux.run` which `455` stand for NVIDIA Driver version.
		```sh
		#Replace 455 with your coresponding version.
		sudo apt-get install --no-install-recommends nvidia-driver-455 
		sudo reboot
		```

	- Use `nvidia-smi` to verify NVIDIA driver installed. ***(Don't care the version shown)***
		<details>
		<summary><b>Output Logs:</b></summary>

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

		</details>

- **Install supported gcc & g++.**
	- Install:
		```sh
		MAX_GCC_VERSION=x #x stand for the max supported GCC version
		sudo apt install gcc-$MAX_GCC_VERSION g++-$MAX_GCC_VERSION
		``` 
		
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
	
	- Verify the install gcc version: `gcc --version`		

		<details>
		<summary><b>If you have unsupported gcc Version.</b></summary>

		- ***Note:*** There aren't safety way to remove gcc. So we will install both version then switch to the supported one. 

		- **Change Gcc current version (Example: change from `9.0` to `8.0`):**
			- ***Remove Alternative:***
				```sh
				sudo update-alternatives --remove-all gcc 
				sudo update-alternatives --remove-all g++
				```
			- ***Add alternatives for gcc/g++ and set their priority:***
				```sh
				sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9.0 10
				sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8.0 20

				sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9.0 10
				sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8.0 20

				sudo update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
				sudo update-alternatives --set cc /usr/bin/gcc

				sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
				sudo update-alternatives --set c++ /usr/bin/g++
				```

			- ***Update Alternatives:***
				```sh
				sudo update-alternatives --config gcc #Choose coressponding index with installed gcc version
				sudo update-alternatives --config g++	#Choose coressponding index with installed g++ version
				```

		</details>

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
	
	<details>
	<summary><b>Install Complete logs.</b></summary>
		
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
	
	</details>
		
  - `sudo reboot`
  - Add below scripts to `~/.bashrc` **(Choose one)**:
	
	<details open>
	<summary><b>Single CUDA version.</b></summary>
	
	```sh
	export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
	export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
	```
	
	</details>
	
	<details open>
	<summary><b>Specific CUDA version.</b></summary>
	
	```sh
	export PATH=/usr/local/cuda-11.1/bin${PATH:+:${PATH}}
	export LD_LIBRARY_PATH=/usr/local/cuda-11.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
	```
	
	</details>
		
	<details open>
	<summary><b>Multiple CUDA versions.<i>(Enable all installed Cuda)</i></b></summary>
	
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
	
	</details>
		
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

- **Install: *(You can do both below methods)*.**
	- ***If you use only one Cuda version.***
		```sh 
		tar -xzvf cudnn-x.x-linux-x64-v8.x.x.x.tgz
		sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
		sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
		sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
		```
	- ***If you use specific version or multiple cuda versions.***
		```sh 
		tar -xzvf cudnn-x.x-linux-x64-v8.x.x.x.tgz
		#Replace 11.1 with you installed version.
		sudo cp cuda/include/cudnn*.h /usr/local/cuda-11.1/include
		sudo cp cuda/lib64/libcudnn* /usr/local/cuda-11.1/lib64
		sudo chmod a+r /usr/local/cuda-11.1/include/cudnn*.h /usr/local/cuda-11.1/lib64/libcudnn* 
		```
- **Delete extracted `cuda` folder**.
		

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

- **Add below srcipt to ~/.bashrc:**
	```sh
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/TensorRT-7.x.x.x/lib #Chage path to your installed TensorRT folder.
	```
	
<details open>
<summary><b>Install TensorRT-Python <i>(Linux Only / Windows does not support TensorRT-Python yet)</i></b></summary>
	
- ***Go to installed folder:***
	```sh
	cd TensorRT-7.x.x.x...
	```

- ***Install coresponding Python `TensorRT` wheel file (cp37 stand for python 3.7):***
	```sh
	cd python 
	pip install tensorrt-*-cp37-none-linux_x86_64.whl
	```

- ***Install addition wheel files:***
	```sh
	cd ../uff
	pip install uff-*-py2.py3-none-any.whl
	cd ../graphsurgeon
	pip install graphsurgeon-*-py2.py3-none-any.whl
	cd ../onnx_graphsurgeon
	pip install onnx_graphsurgeon-*-py2.py3-none-any.whl
	```

</details>
	
<details>
<summary><b>Verify and Use.</b></summary>

  - ***Python:*** [TensorRT Parser Python](https://github.com/CuteBoiz/TensorRT_Parser_Python)
	 ```sh
	 exec bash #Reload terminal
	 python3 -c "import tensorrt as trt; print(trt.__version__)"
	 ```
	 ***Note:*** Python does not support TensorRT on Windows yet. 
	 
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
</details>