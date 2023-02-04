# Sever Management

## 1. Connect to a server.
```sh
ssh -p port_num username@server-ip-address
```

## 2. User.
- **Add user:**
  ```sh
  sudo useradd [Options] username

  -m:                 Create the user’s home directory.
  -d [directory]:     Set scpecific home directory. Default /home/username/ .
  -u [id]:            Add user ID.
  -g [group_name]:    Assign user to group.
  -e [yyyy-mm-dd]:    Add expire date.
  -G sudo:            Give admin access to user.
  ```

- **Set password to be able to access or change user's password:**
  ```sh
  sudo passwd username
  ```

- **Delete a user:**
  - Kill all processes of a user: `pkill -U $(id -u username)`
  - Delete an user: `sudo userdel username`

## 3. Management.

<details>
<summary><b>Users.</b></summary>
  
- List all users: `getent passwd | cut -d: -f1`

- Check account expire day: `sudo chage -l username`

- Add HomeDir for a user: `sudo mkhomedir_helper username`

</details>

<details>
<summary><b>Files/Folders.</b></summary>
  
- Assign a folder/file to a user: `sudo chown username foldername/filename`
  
- Assign a folder/file to a group: `sudo chown :groupname foldername/filename`

</details>

<details>
<summary><b>Groups.</b></summary>
  
- Create a group: `sudo groupadd groupname`

- Delete a group: `sudo groupdel groupname`

- Add user to a group: `sudo usermod -a -G groupname username`

- Give a user admin access: `sudo usermod -a -G sudo username`
  
- Check user's groups: `id -gn username`

- Remove user from a group: `sudo gpasswd -d username groupname`

</details>

<details>
<summary><b>System.</b></summary>

- Check CPU & RAM Performance: `htop`

- Check Disk Space: `df -H`

- Check all users's disk usage: `cd /home/ && sudo du -h --max-depth=1 | sort -hr`

- Check GPU Usage: `gpustat` or `nvidia-smi`
  
</details>
  
## 4. Tools

<details>
<summary><b>Tranfer a file via SSH. </b></summary>
  
  **Type below command at local computer.**
  - *From local computer to ssh server:*
    ```sh
    scp -P port_number path/to/file_name username@server-ip:/path/to/destiny
    ```
  - *From ssh server to local computer:*
    ```sh
    scp -P port_number username@server-ip:/path/to/file_name path/to/destiny 
    ```
  If you want transfer a folder add `-r` prefix

</details>

<details>
<summary><b>Limit cpu usage of a running process.</b></summary>
  
  ```sh
  cpulimit -l cpu_usage_limitation(%) -p PID_num_of_process
  cpulimit -l 120 -p 3198
  ```
  To check PID_num of a running prosess use `htop`.
  
</details>

<details>
<summary><b>Check Server's Tensorboard-Logs on Local machine.</b></summary>
  
  ```sh
  tensorboard --logdir=logs_dir --host localhost --port 8888
  ```
  
</details>


