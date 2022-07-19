#!/bin/bash

BBlue='\033[1;34m'
BGreen='\033[1;32m'
BRed='\033[1;31m'
NC='\033[0m'
pythonLink="https://github.com/python/cpython"

if [[ "$SUDO_USER" == "" ]]; then
    echo -e "${BRed}Use \"sudo bash\" before executing this script!${NC}"
    exit 1
fi


# Choose version
read -p "$(echo -e $BBlue"Enter Python Version $BRed(3.6, 3.7, 3.8, 3.9, 3.10): $NC")" X
pythonVers=("3.6" "3.7" "3.8" "3.9" "3.10") 
installVer="NONE"

for VER in ${pythonVers[@]}; do
    if [[ "$X" == "$VER" ]]; then
        installVer=$VER
    fi
done
if [[ "$installVer" == "NONE" ]]; then
    echo -e "Error: ${BRed}Undifined Version: \"$X\"!${NC}"
    exit 0 
else
    echo -e "${BGreen}Install Python-$installVer ...${NC}"
fi

# Relative packages
sudo apt-get install -y libopenblas-dev libhdf5-serial-dev hdf5-tools libhdf5-dev \
   zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran

sudo apt-get install -y build-essential git libexpat1-dev libssl-dev zlib1g-dev \
   libncurses5-dev libbz2-dev liblzma-dev \
   libsqlite3-dev libffi-dev tcl-dev linux-headers-generic libgdbm-dev \
   libreadline-dev tk tk-dev libgtk2.0-dev pkg-config

# Install python
cd $HOME
if ! [ -d cpython ]; then
    git clone $pythonLink
fi
if ! [ -d cpython ]; then
    echo -e "${BRed}Error: Could not clone Python from \"$pythonLink\".${NC}"
    exit 1
fi
cd cpython
git checkout $installVer
./configure --enable-optimizations
sudo make -j$(($(nproc) - 1))
sudo make install
sudo python$installVer -m pip install --upgrade pip
echo -e "\n# Python3\nalias python=python3\nalias pip=pip3\nexport PYTHONPATH=/usr/local/lib/python$installVer/site-packages:\$PYTHONPATH\n" >> ~/.bashrc
source $HOME/.bashrc
sudo chmod 777 $HOME/.local/lib/python$installVer/site-packages

# Change python version
# old_ver_array=`find /usr/bin/python3.* -maxdepth 0 -type f -not -name "*m"`
# length=${#old_ver_array[@]}
# for (( j=0; j<${length}; j++ )); do
#     sudo update-alternatives --install /usr/bin/python3 python3 ${old_ver_array[$j]} $((j+1))
# done
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python$installVer $((j+1))
# echo -e "$((j+1))\n" | sudo update-alternatives --config python3

echo -e "${BGreen}Done!${NC}"