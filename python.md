# Python Commands

## I. Install Newest Python Version


- **Get Lastest Python Version**

Go to: **https://www.python.org/downloads/source/** to get the lastest version's source


```sh
Example: (the lastest version is 3.7.4)
wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
```
Extract the source: `tar -xvf Python-3.7.4.tgz `


- **Install Prerequistes (IMPORTANT)**

```sh
sudo apt-get install gcc

sudo apt-get install -y build-essential git libexpat1-dev libssl-dev zlib1g-dev \
  libncurses5-dev libbz2-dev liblzma-dev \
  libsqlite3-dev libffi-dev tcl-dev linux-headers-generic libgdbm-dev \
  libreadline-dev tk tk-dev
```

- **Install**
  
```sh
cd Python-3.7.4
./configure --enable-optimizations
sudo make
sudo make install
"[Some errors will occur here. Solution is below.]"
python3.7 -V
```

- **TYPE "python" instead of "python3"**

This will help you avoid confusing between python 3 and python 2.

```sh
gedit ~/.bashrc
```
Add this to Bottom of the file:
```sh
alias python=python3
alias pip=pip3
```
- **Update current Python3 version to newest version (If you have same Python 3 versions)**

```sh
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
sudo update-alternatives --config python3
2
```

- **Problems & Solutions**

- **<i>Problem 1:</i>**

```
/usr/bin/install: cannot create regular file '/usr/local/bin/python3.8': Permission denied
```

- <i>Solution:</i>

You'll meet a lot of those problems. All you need to do is open a new terminal window and use root permission ```sudo -i``` and go to /usr folder. 

Then use ```chmod 777``` to change the permission access for the following folder

(example: /usr/local/bin/python3.8 the "bin" folder need to be change permission).

```sh
sudo -i
cd /usr/local/
sudo chmod 777 bin
```

Then go back to Python3.7.4 folder and type ```$ make install```

- **<i>Problem 2:</i>**

```
sh: 1: cannot create build/temp.linux-x86_64-3.8/multiarch: Permission denied
```
- <i>Solution:</i>

This folder is located at Python3.7.4 folder so you don't have to use root permission.

```sh
cd build
sudo chmod 777 temp.linux-x86_64-3.8
```

## II. Virtual Environment Python


- **Install Prerequistes**
	
```sh
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
sudo apt-get update
sudo pip3 install --upgrade pip 
sudo apt install python3-pip
sudo apt install -y python3-venv
```

- **Create Virtual Environment**

```sh
python -m venv [projectName]
```

- **Activate Virtual Environment**

```sh
source [projectName]/bin/activate
```

- **Deactivate Virtual Enviroment**

```sh
deactivate
```

- **Export Requirement**

```sh
pip freeze > requirement.txt
```

- **Import Requirement**

```sh
pip install -r requirement.txt
```


## III. Jupyter Notebook

```sh
pip install jupyter notebook
jupyter notebook
```
*Then open your web browser at: http://localhost:8888/*

## IV. Popular Packages For Programing

### 1. Open CV

```sh 
sudo apt update 
sudo apt-get install python3-opencv
```

### 2. Numpy, SciPy, Matplotlib

```sh 
sudo apt install python3-venv python3-pip python3-tk
pip install numpy scipy matplotlib
pip install opencv-python
```
