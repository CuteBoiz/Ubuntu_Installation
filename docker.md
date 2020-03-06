# Docker 

## Introduction

*Docker* is an application that simplifies the process of managing application processes in containers. Containers let you run your applications in resource-isolated processes. They’re similar to virtual machines, but containers are more portable, more resource-friendly, and more dependent on the host operating system.

## Prerequiste

- One Ubuntu 18.04
- An account on Docker hub

## Step 1 - Installing Docker

```sh
$ sudo apt update 	#Update packages
$ sudo apt install apt-transport-https ca-certificates curl software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
$ sudo apt update
$ apt-cache policy docker-ce

docker-ce:
  Installed: (none)
  Candidate: 18.03.1~ce~3-0~ubuntu
  Version table:
     18.03.1~ce~3-0~ubuntu 500
        500 https://download.docker.com/linux/ubuntu bionic/stable amd64 Packages

$ sudo apt install docker-ce
$ sudo systemctl status docker 	#Check deamon 

```

## Step 2 - Using Docker Command 

```sh
$ sudo docker [option] [commnad] [arguments]
$ sudo docker 	#View all subcommands
$ sudo docker [subCommand] --help 	#View options available to a specific command
```

## Step 3 - Working With Docker Images

