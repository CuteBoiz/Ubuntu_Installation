# Install CUDA + cuDNN + TensorRT.

## I. CUDA.

```sh
git clone https://github.com/CuteBoiz/Ubuntu_Installation.git
cd Ubuntu_Installation
sudo bash script/cuda_install.sh
```

  - select `continue`.
  - type `accept`
  - Uncheck NVIDIA Driver & Samples:
  	```sh
	| CUDA Installer                                                               │
	│ - [ ] Driver                                                                 │
	│      [ ] 450.51.06                                                           │
	│ + [X] CUDA Toolkit 11.0                                                      │
	│   [ ] CUDA Samples 11.0                                                      │
	│   [ ] CUDA Demo Suite 11.0                                                   │
	│   [ ] CUDA Documentation 11.0                                                │
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
		
## III. cuDNN.

```sh
git clone https://github.com/CuteBoiz/Ubuntu_Installation.git
cd Ubuntu_Installation
sudo bash script/cudnn_install.sh
```

<details>
<summary><b>Install Cudnn Manually</b></summary>

- **Download:**

	- Go to [NVIDIA cuDNN home page](https://developer.nvidia.com/cudnn)
	- Click `Download cuDNN`.
	- Login then `Submit` short survey if first time download.
	- Check `Accept the Terms and Conditions`.
	- Click `Archived cuDNN Releases`.
	- **Choose the corresponding version with your CUDA Toolkit Version.**
	- Download the `cuDNN Library for Linux (x86_64)`.

- **Copy CuDNN library to Cuda installed place:**
	```sh 
	tar -xvf cudnn-x.x-linux-x64-v8.x.x.x.tar.xz
	#Replace 1x.x with you installed version(e.g: 10.2, 11.1, 11.3, ...).
	CUDA_VER=1x.x
	sudo cp cuda/include/cudnn*.h /usr/local/cuda-$CUDA_VER/include
	sudo cp cuda/lib/libcudnn* /usr/local/cuda-$CUDA_VER/lib64
	sudo chmod a+r /usr/local/cuda-$CUDA_VER/include/cudnn*.h /usr/local/cuda-$CUDA_VER/lib64/libcudnn* 
	```
- **Delete extracted folder**.

</details>		

## IV. TensorRT.

```sh
git clone https://github.com/CuteBoiz/Ubuntu_Installation.git
cd Ubuntu_Installation
sudo bash script/tensorrt_install.sh
```

<details>
<summary><b>Install TensorRT Manually</b></summary>

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
	
	
- ***Install TensorRT-Python (Linux Only / not support Windows yet)***

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
