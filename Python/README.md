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
</ul>