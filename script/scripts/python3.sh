#!/bin/bash

# Author: phatnt
# Date modify: Jan-03-23
# Usage: Install python package

pythonLink="https://github.com/python/cpython.git"

F_exportBashrc () {
    if ! grep -Fxq "$1" /home/$(logname)/.bashrc; then
        echo $1 >> /home/$(logname)/.bashrc
    fi
	if ! grep -Fxq "$1" /home/$(logname)/.bashrc; then
        echo $1 >> /home/$(logname)/.bashrc
    fi
}

# Check Python
pythonCheck=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
if [[ "$pythonCheck" != "3.6" ]] && [[ "$pythonCheck" != "3.7" ]] && [[ "$pythonCheck" != "3.8" ]] && [[ "$pythonCheck" != "3.9" ]]; then
	echo -e "Installing Python-$pythonVer from source"
	sleep 2
	sudo apt-get update
	sudo apt-get -y install libopenblas-dev libhdf5-serial-dev hdf5-tools libhdf5-dev \
		zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran

	sudo apt-get -y install build-essential git libexpat1-dev libssl-dev zlib1g-dev \
		libncurses5-dev libbz2-dev liblzma-dev \
		libsqlite3-dev libffi-dev tcl-dev linux-headers-generic libgdbm-dev \
		libreadline-dev tk tk-dev libgtk2.0-dev pkg-config
	cd /home/$(logname)
	if ! [ -d cpython ]; then
		git clone $pythonLink -b $pythonVer
	else
		rm -rf cpython
	fi
	if ! [ -d cpython ]; then
		>&2 echo -e "${BRed}Error: Could not clone Python from '$pythonLink'.${NC}"
		exit 1
	fi
	cd cpython
	./configure --enable-optimizations
	sudo make -j$(($(nproc) - 1))
	sudo make install
	sudo python$pythonVer -m pip install --upgrade pip
	F_exportBashrc "# Python3"
	F_exportBashrc "alias python=python3"
	F_exportBashrc "alias pip=pip3"
	F_exportBashrc "export PYTHONPATH=/usr/local/lib/python$pythonVer/site-packages:\$PYTHONPATH"
	export PYTHONPATH=/usr/local/lib/python$pythonVer/site-packages:$PYTHONPATH
	sudo chmod 777 /usr/local/lib/python$pythonVer/site-packages
	sudo chmod 777 $HOME/.local/lib/python$pythonVer/site-packages
	cd $HOME
	pythonCheck=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
	if ! [[ "$pythonCheck" == "$pythonVer" ]]; then
		>&2 echo -e "${BRed}[ERROR]: Install Python from source failed!${NC}"
		exit 1
	else
		echo -e "${BGreen}[INFO]: Install Python-$pythonVer successfully!${NC}"
		sleep 2
	fi
else
	F_exportBashrc "# Python3"
	F_exportBashrc "alias python=python3"
	F_exportBashrc "alias pip=pip3"
	pythonPathCheck=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")
	readarray -d / -t strarr <<< "$pythonPathCheck"
	if [[ "${strarr[2]}" == "local" ]]; then
		F_exportBashrc "export PYTHONPATH=/usr/local/lib/python$pythonCheck/site-packages:\$PYTHONPATH"
		export PYTHONPATH=/usr/local/lib/python$pythonCheck/site-packages:$PYTHONPATH
		sudo chmod 777 /usr/local/lib/python$pythonCheck/site-packages
		sudo chmod 777 $HOME/.local/lib/python$pythonCheck/site-packages
	fi
	echo -e "${BGreen}[INFO]: Found Python-$pythonCheck!${NC}"
	sleep 2
fi
