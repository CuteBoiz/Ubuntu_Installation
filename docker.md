# Docker 

## Introduction

*Docker* is an application that simplifies the process of managing application processes in containers. Containers let you run your applications in resource-isolated processes. They’re similar to virtual machines, but containers are more portable, more resource-friendly, and more dependent on the host operating system.

## Prerequiste

- One Ubuntu 18.04
- An account on Docker hub

## Step 1 - Installing Docker

```sh
sudo apt update 	#Update packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
```

Output:
```bash
	docker-ce:
 		Installed: (none)
  		Candidate: 18.03.1~ce~3-0~ubuntu
  		Version table:
     		18.03.1~ce~3-0~ubuntu 500
        		500 https://download.docker.com/linux/ubuntu bionic/stable amd64 Packages
```

```sh
sudo apt install docker-ce
sudo systemctl status docker 	#Check deamon 
```

## Step 2 - Using Docker Command 

```sh
sudo docker [option] [commnad] [arguments]
sudo docker 				#View all subcommands
sudo docker [subCommand] --help 	#View options available to a specific command
```

## Step 3 - Working With Docker Images
<ul>
<li><b>Check whether you can access and download images from Docker Hub:</b></li>

```sh
sudo docker run hello World
```
Output:
```
	Unable to find image 'hello-world:latest' locally
	latest: Pulling from library/hello-world
	9bb5a5d4561a: Pull complete
	Digest: sha256:3e1764d0f546ceac4565547df2ac4907fe46f007ea229fd7ef2718514bcec35d
	Status: Downloaded newer image for hello-world:latest

	Hello from Docker!
	This message shows that your installation appears to be working correctly.
	...
```
<li><b>Search for images:</b></li>

`sudo docker search ubuntu`


<li><b>Download the offical `Ubuntu` image:</b></li>

`sudo docker pull ubuntu`

<li><b>Check downloaded images:</b></li>

`sudo docker images `
</ul>

## Step 4 - Running a Docker Container

```sh
sudo docker run -it ubuntu 	#Acces Container
exit 				#Exit Container
```

## Step 5 - Managing Docker Container
<ul>

<li><b>Check container: </b></li>

```sh
sudo docker ps 	#View active containers
sudo docker ps -a 	#View all containers
sudo docker ps -l 	#View the lastest container you created
```

<li><b>Start a stopped container:</b></li>

`sudo docker start [dockerID]/[dockerName]`

<li><b>Stop a running container:</b></li>

`sudo docker stop [dockerID]/[dockerName]`

<li><b>Delete a container:</b></li>

`sudo docker rm [dockerName]`
</ul>

## Step 6 - Committing Changes in a Container to a Docker Image

When you start up a Docker image, you can create, modify, and delete file just like virtual machine. The changes that you make will only apply to that container. You can start and stop it, but once you destroy it with the `docker rm`, the change will be lost for good.


This section show you how to save the state of a container as a new Docker image.

```sh
sudo docker commit -m "Message" -a [authorName] [containerID] [repository]/[newImgName]

Example:
sudo docker commit -m "Added Nodejs" -a "sammy" d9b100f2f636 sammy/ubuntu-nodejs
```

When you commit an image, the new image is save locally on your comupter.

## Step 7 - Pushing Docker Images to a Docker Repository

<ul>

<li><b> To push your image, first log into [Docker Hub](https://hub.docker.com/): </b></li>

```sh
sudo docker login -u [dockerUsername]
```
 **Note:** If your docker registry username is different from the **local username** You will have to rename it:
```sh
sudo tag [oldName]/ubuntu-nodejs [newName]/ubuntu-nodejs
```

<li><b> Push your own image: </b></li>

```sh 
sudo docker push [userName]/[dockerImgName]
```
