# Python Installation

*Install Python 3 Version From Source Code.*

## I. Install Lastest Python 3 Version

- **Download Lastest Python Version**
	- Go to [Python download page](https://www.python.org/downloads/source/)
	- Choose version. (If you use with TensorRT use the version 3.6.x or 3.7.x)
	- Download `Gzipped source tarball`.
	- Extract downloaded file in `/home/` this place will be your Python installed Path.

- **Install Prerequistes (IMPORTANT)**
	```sh
	sudo apt-get install gcc

	sudo apt-get install -y libopenblas-dev libhdf5-serial-dev hdf5-tools libhdf5-dev \
	  zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran

	sudo apt-get install -y build-essential git libexpat1-dev libssl-dev zlib1g-dev \
	  libncurses5-dev libbz2-dev liblzma-dev \
	  libsqlite3-dev libffi-dev tcl-dev linux-headers-generic libgdbm-dev \
	  libreadline-dev tk tk-dev libgtk2.0-dev pkg-config

	sudo apt-get install libopencv-*
	```

- **Install**
	```sh
	cd Python-3.7.4
	./configure --enable-optimizations
	sudo make
	sudo make install
	python3.7 -V
	sudo python3 -m pip install --upgrade pip
	```

- **TYPE "python" instead of "python3".**
	- This will help you avoid confusing between **python3** and **python2**.
	- Add below srcipts to bottom of the file: `gedit ~/.bashrc`
	```sh
	alias python=python3
	alias pip=pip3
	```
	
- **Verify:**
	```sh
	exec bash
	python
	```
	You will see something similar to this:
	```sh
	Python 3.8.10 (default, Jun  2 2021, 10:49:15) 
	[GCC 9.4.0] on linux
	Type "help", "copyright", "credits" or "license" for more information.
	>>> 
	```
	**Note:** If it does not match with your installed one. Go to below step.

- Update current Python3 version to installed version **(If you have multiple Python 3 versions)**
	```sh
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
	sudo update-alternatives --config python3
	2
	python3 #verify
	```
	*[Cannot find python ERROR Handle](https://askubuntu.com/questions/1070610/having-troubles-updating-to-python-3-6-on-ubuntu-16-04)*



## II. Virtual Environment Python

- **Install:** `sudo apt install -y python3-venv`

- **Create Virtual Environment:** `python -m venv [projectName]`

- **Activate Virtual Environment:** `source [projectName]/bin/activate`

- **Deactivate Virtual Enviroment:** `deactivate`

- **Export Requirement:** `pip freeze > requirement.txt`

- **Import Requirement:** `pip install -r requirement.txt`

## III. Popular Packages For Programming.
```sh 
pip install numpy scipy matplotlib
pip install opencv-python

export DISABLE_BCOLZ_AVX2=true
pip install bcolz

pip install jupyter notebook
jupyter notebook #Then open your web browser at: http://localhost:8888/
```


