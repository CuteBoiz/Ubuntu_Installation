#!/bin/bash

# Enter version
read -p "Enter Python Version (3.6, 3.7, 3.8, 3.9, 3.10): " X
PYTHON_VERS=("3.6" "3.7" "3.8" "3.9" "3.10") 
INSTALL_VER="NONE"

for VER in ${PYTHON_VERS[@]}; do
    if [[ "$X" == *"$VER"* ]]; then
        INSTALL_VER=$VER
    fi
done
if [[ "$INSTALL_VER" == "NONE" ]]; then
    echo "Undifined Version: \"$X\"!"
    exit 0 
else
    echo "Install Python-$INSTALL_VER"
fi

# Relative packages
sudo apt-get install -y libopenblas-dev libhdf5-serial-dev hdf5-tools libhdf5-dev \
   zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran

sudo apt-get install -y build-essential git libexpat1-dev libssl-dev zlib1g-dev \
   libncurses5-dev libbz2-dev liblzma-dev \
   libsqlite3-dev libffi-dev tcl-dev linux-headers-generic libgdbm-dev \
   libreadline-dev tk tk-dev libgtk2.0-dev pkg-config

sudo apt-get install libopencv-*

# Install python
git clone https://github.com/python/cpython
cd cpython
git checkout $INSTALL_VER
./configure --enable-optimizations
sudo make -j$(($(nproc) - 1))
sudo make install
sudo python$INSTALL_VER -m pip install --upgrade pip
echo -e "#Python3\nalias python=python3\nalias pip=pip3\nexport PYTHONPATH=/usr/local/lib/python$INSTALL_VER/site-packages:\$PYTHONPATH\n" >> ~/.bashrc

# Change python version
old_ver_array=`find /usr/bin/python3.* -maxdepth 0 -type f -not -name "*m"`
length=${#old_ver_array[@]}
for (( j=0; j<${length}; j++ )); do
    sudo update-alternatives --install /usr/bin/python3 python3 ${old_ver_array[$j]} $((j+1))
done
sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python$INSTALL_VER $((j+1))
echo -e "$((j+1))\n" | sudo update-alternatives --config python3
source ~/.bashrc
cd ..
rm -rf cpython
python3