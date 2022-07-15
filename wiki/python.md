# Python Installation

*Install Python 3 From Source.*

## I. Install.
```sh
wget https://raw.githubusercontent.com/CuteBoiz/Ubuntu_Installation/master/script/python.sh
sudo bash
bash python.sh
```

## II. Virtual Environment Python

- **Install:** `sudo apt install -y python3-venv`

- **Create Virtual Environment:** `python -m venv [projectName]`

- **Activate Virtual Environment:** `source [projectName]/bin/activate`

- **Deactivate Virtual Enviroment:** `deactivate`

- **Export Requirement:** `pip freeze > requirement.txt`

- **Import Requirement:** `pip install -r requirement.txt`



