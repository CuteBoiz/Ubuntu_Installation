# SSH Setup


## I. Setup as a Client.

- **Install:**
	```sh
	sudo apt update
	sudo apt upgrade
	sudo apt-get install openssh-client
	```

- **Connect to a server:**
	```sh
	ssh -p port_number username@server-ip
	```

## II. Setup as a Server.

- **Setup as a LAN Server.**
	- ***Install.***
		```sh
		sudo apt update
		sudo apt upgrade
		sudo apt install openssh-server
		```

	- ***Verify:***
		```sh
		sudo systemctl status ssh
		```

		If not running enable the ssh server and start it as follows by typing the systemctl command:

		```sh
		sudo systemctl enable ssh
		sudo systemctl start ssh
		```

	- ***Config:***
		```sh
		sudo ufw allow ssh #Port 22
		sudo ufw allow port_num/tcp #With specific port_num
		
		sudo ufw enable
		sudo ufw status
		```

- **Setup Global server with ngrok.**
	- Setup ssh LAN server.
	- Create account and get Authtoken & download ngrok [here](https://dashboard.ngrok.com/get-started/setup)
	- `./ngrok authtoken AUTHTOKEN_ID`
	- `./ngrok tcp 22`
	- Connect Example: `ssh <YOUR_USERNAME>@0.tcp.jp.ngrok.io -p 11111`



