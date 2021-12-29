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

		If not running, typing the systemctl command:

		```sh
		sudo systemctl enable ssh
		sudo systemctl start ssh
		```

	- ***Config:***
		```sh
		sudo ufw allow ssh #Port 22 as default
		# or specific port_num: sudo ufw allow port_num/tcp
		
		sudo ufw enable
		sudo ufw status
		```

- **Setup Global server with ngrok.**
	- Setup ssh LAN server.
	- Download [ngrok](https://ngrok.com/download).
	- `./ngrok` or `ngrok` to verify.
	- Create account & Get Authtoken [here](https://dashboard.ngrok.com/get-started/setup).
	- `./ngrok authtoken AUTHTOKEN_ID` or `ngrok authtoken AUTHTOKEN_ID`.
	- `./ngrok tcp 22` or `ngrok tcp 22`.
	- Connect Example: `ssh <server_username>@0.tcp.jp.ngrok.io -p 11111`.



