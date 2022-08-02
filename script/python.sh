#!/bin/bash

BBlue='\033[1;34m'
BGreen='\033[1;32m'
BRed='\033[1;31m'
NC='\033[0m'
pythonLink="https://github.com/python/cpython"

export_bashrc () {
    if ! grep -Fxq "$1" $HOME/.bashrc; then
        echo $1 >> $HOME/.bashrc
    fi
}

installPython () {
    """
    Install Python Function
    Args:
        + \$1: Python Version 
    """
    # Relative packages
    sudo apt-get install -y libopenblas-dev libhdf5-serial-dev hdf5-tools libhdf5-dev \
    zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran

    sudo apt-get install -y build-essential git libexpat1-dev libssl-dev zlib1g-dev \
    libncurses5-dev libbz2-dev liblzma-dev \
    libsqlite3-dev libffi-dev tcl-dev linux-headers-generic libgdbm-dev \
    libreadline-dev tk tk-dev libgtk2.0-dev pkg-config
    # Clone & Install 
    cd $HOME
    if ! [ -d cpython ]; then
        git clone $pythonLink
    fi
    if ! [ -d cpython ]; then
        echo -e "${BRed}Error: Could not clone Python from \"$pythonLink\".${NC}"
        exit 1
    fi
    cd cpython
    git checkout $1
    ./configure --enable-optimizations
    sudo make -j$(($(nproc) - 1))
    sudo make install
    sudo python$1 -m pip install --upgrade pip
    export_bashrc "# Python3"
    export_bashrc "alias python=python3"
    export_bashrc "alias pip=pip3"
    export_bashrc "export PYTHONPATH=/usr/local/lib/python$1/site-packages:\$PYTHONPATH\n"
    sudo chmod 777 $HOME/.local/lib/python$1/site-packages
}

changePythonVersion () {
    """
    Change Current Python version (only Use when type 'python3''s output is different version)
    Args:
        + \$1: Installed Python version 
    """
    old_ver_array=`find /usr/bin/python3.* -maxdepth 0 -type f -not -name "*m"`
    length=${#old_ver_array[@]}
    for (( j=0; j<${length}; j++ )); do
        sudo update-alternatives --install /usr/bin/python3 python3 ${old_ver_array[$j]} $((j+1))
    done
    sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python$1 $((j+1))
    echo -e "$((j+1))\n" | sudo update-alternatives --config python3
}


# Check sudo bash
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

installPython $installVer
echo -e "${BGreen}Done!${NC}"