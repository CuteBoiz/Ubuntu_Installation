cd ~/Downloads
mkdir -p .temp

#Unikey
sudo apt-get install ibus-unikey
ibus restart
sudo apt-get -y install ttf-mscorefonts-installer 

# C/C++
sudo apt-get -y install build-essential

# Git
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install -y git

# VSCode
sudo apt-get update
sudo apt-get install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt-get install code


# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ./.temp/google.deb
sudo dpkg -i --force-depends ./.temp/google.deb

# Skype
wget https://go.skype.com/skypeforlinux-64.deb -O ./.temp/skype.deb
sudo apt-get install ./.temp/skype.deb

rm -rf .temp
sudo apt-get update
sudo apt-get upgrade