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

Output:
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
$ sudo docker 		#View all subcommands
$ sudo docker [subCommand] --help 	#View options available to a specific command
```

## Step 3 - Working With Docker Images

- **Check whether you can access and download images from Docker Hub:**

```sh
$ sudo docker run hello World

Output:
	Unable to find image 'hello-world:latest' locally
	latest: Pulling from library/hello-world
	9bb5a5d4561a: Pull complete
	Digest: sha256:3e1764d0f546ceac4565547df2ac4907fe46f007ea229fd7ef2718514bcec35d
	Status: Downloaded newer image for hello-world:latest

	Hello from Docker!
	This message shows that your installation appears to be working correctly.
	...
```
- **Search for images**

```sh
$ sudo docker search ubuntu
```

- **Download the offical `Ubuntu` image:**

```sh
$ sudo docker pull ubuntu 
```

- **Check downloaded images**

```sh
$ sudo docker images 
```

## Step 4 - Running a Docker Container

```sh
$ sudo docker run -it ubuntu 	#Acces Container
$ exit 		#Exit Container
```

## Step 5: Managing Docker Container

- **Check container**
```sh
$ sudo docker ps 	#View active containers
$ sudo docker ps -a 	#View all containers
$ sudo docker ps -l 	#View the lastest container you created
```
- **Start a stopped container:**
`$ sudo docker start [dockerID]/[dockerName]`
- **Stop a running container:**
`$ sudo docker stop [dockerID]/[dockerName]`
- **Delete a container:**
`$ sudo docker rm [dockerName]`

## Step 6: Committing Changes in a Container to a Docker Image

