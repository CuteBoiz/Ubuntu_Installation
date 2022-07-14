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

- ***Install & Verify:***
	```sh
	# Replace X and Y with your installing python version. (Example 3.7.12 => X=7, Y=12)
	X=7 #major_ver
	Y=12 #minor_ver
	```
	```sh
	cd Python-3.$X.$Y
	./configure --enable-optimizations
	sudo make -j$(($(nproc) - 1))
	sudo make install
	python3.$X -V
	sudo python3.$X -m pip install --upgrade pip
	echo "export PYTHONPATH=/usr/local/lib/python3.$X/site-packages:\$PYTHONPATH" >> ~/.bashrc
	source ~/.bashrc
	python3
	```
	NOTE: ***If the version doesn't match with which version you just installed earlier. Use `Change Python version` below.***

<details>
<summary><b>Change Python version.</b></summary>
	
- `DON'T REMOVE ANY PYTHON VERSION`. **This can cause some OS errors.**
- **Example**: If you just installed `3.7` earlier and the defauft os version was `3.10` **(3.10 -> Downgrade to 3.7): 
	```sh
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.7 2
	sudo update-alternatives --config python3
	2
	```
- **Verify:** `python3`
</details>

<details>
<summary><b>Type "python" instead of "python3".</b></summary>
	
- This will help you avoid confusing between **python3** and **python2**.
	```sh
	echo $'#Python3\nalias python=python3\nalias pip=pip3' >> ~/.bashrc
	```
	
</details>

## II. Virtual Environment Python

- **Install:** `sudo apt install -y python3-venv`

- **Create Virtual Environment:** `python -m venv [projectName]`

- **Activate Virtual Environment:** `source [projectName]/bin/activate`

- **Deactivate Virtual Enviroment:** `deactivate`

- **Export Requirement:** `pip freeze > requirement.txt`

- **Import Requirement:** `pip install -r requirement.txt`



