# Python Commands

## I. Install Newest Python Version

<ul>
<li><b>Get Lastest Python Version </b></li>

Go to: https://www.python.org/downloads/source/ to get the lastest version's source
```sh
$ wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
```
Extract the source: `$ tar -xvf Python-3.7.4.tgz `
<li><b>Install Prerequistes</b></li>

```sh
$ sudo apt-get install gcc
$ sudo apt install zlib1g-dev 
$ sudo apt-get install libffi-dev libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
```
<li><b>Install</b></li>
  
```sh
$ cd Python-3.7.4
$ ./configure
$ sudo make && make install
$ python3.7 -V
```
<li><b>Change From Current Version To Newest Version</b></li>

```sh
$ sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
$ sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
$ sudo update-alternatives --config python3
$ 2
```
<li><b>Change "python" to "python3" </b></li>

```sh
$ gedit ~/.bashrc
```
Add this to TOP of the file:
```sh
alias python=python3
alias pip=pip3
```

<li><b>Problems & Solutions</b></li>
<ul>
<li><b><i>Problem 1:</i></b></li>

```sh
/usr/bin/install: cannot create regular file '/usr/local/bin/python3.8': Permission denied
```
<li><i>Solution:</i></li>

```sh
cd /usr/local/
sudo chmod 777 bin
```

<li><b><i>Problem 2:</i></b></li>

```sh
sh: 1: cannot create build/temp.linux-x86_64-3.8/multiarch: Permission denied
```
<li><i>Solution:</i></li>

```sh
cd build
sudo chmod 777 temp.linux-x86_64-3.8
```
</ul>
</ul>

## II. Virtual Environment Python

<ul>
<li><b>Install Prerequistes</b></li>
	
```sh
$ sudo apt-get install build-essential libssl-dev libffi-dev python-dev
$ sudo apt-get update
$ sudo pip3 install --upgrade pip 
$ sudo apt install python3-pip
$ sudo apt install -y python3-venv
```

<li><b>Create Virtual Environment</b></li>

```sh
$ python -m env [projectName]
```

<li><b>Activate Virtual Environment</b></li>

```sh
$ source [projectName]/bin/activate
```

<li><b>Deactivate Virtual Enviroment</b></li>

```sh
$ deactivate
```

<li><b>Export Requirement </b></li>

```sh
$ pip freeze > requirement.txt
```

<li><b>Import Requirement </b></li>

```sh
pip install -r requirement.txt
```

</ul>

## 3. Jupyter Notebook

```sh
$ pip install jupyter notebook
$ jupyter notebook
```
*Then open your web browser at: http://localhost:8888/*

