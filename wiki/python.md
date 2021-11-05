# Python Installation

*Install Python 3 From Source.*

## I. Install.

- ***Download***
	- [Python download page](https://www.python.org/downloads/source/)
	- Choose version. (Stable versions are 3.6, 3.7 or 3.8)
	- Download `Gzipped source tarball` one.
	- Extract downloaded file at `/home/username/` this place will be your Python installed Path.

- ***Install Prerequistes (IMPORTANT)***
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

- ***Install***
	```sh
	#Install python 3.7.4 example
	cd Python-3.7.4
	./configure --enable-optimizations
	sudo make -j$(($(nproc) - 1))
	sudo make install
	python3.7 -V
	sudo python3.7 -m pip install --upgrade pip
	```
- ***Verify:***
	```sh
	exec bash
	python3
	```

<details>
<summary><b>If the version doesn't match with your installed version.</b></summary>

- **DON'T REMOVE ANY PYTHON VERSION.** This can cause some OS errors.
- Example: If you want change from python 3.6 to 3.7: 
	```sh
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
	sudo update-alternatives --config python3
	2
	python3 #verify
	```
**Note:** *The python you installed might be on different directory.*	
</details>

<details>
<summary><b>Type "python" instead of "python3".</b></summary>
	
- This will help you avoid confusing between **python3** and **python2**.
- Add below srcipts to bottom of the file: `gedit ~/.bashrc`
	```sh
	alias python=python3
	alias pip=pip3
	```
	
</details>
	

## II. Virtual Environment Python

- **Install:** `sudo apt install -y python3-venv`

- **Create Virtual Environment:** `python -m venv [projectName]`

- **Activate Virtual Environment:** `source [projectName]/bin/activate`

- **Deactivate Virtual Enviroment:** `deactivate`

- **Export Requirement:** `pip freeze > requirement.txt`

- **Import Requirement:** `pip install -r requirement.txt`



