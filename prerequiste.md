#  Prerequiste Programs

## 1. Google Chorme
- **Download:**
```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```
- **Install:**
```sh
sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
```

## 2. Update & Upgrade Packages
If you install Ubuntu 18.10 on release day you can skip this step, but everyone else needs to check for security updates and bug fixes, and install any that are listed as available.

```sh
sudo apt-get update
sudo apt-get upgrade
```

## 3. Unikey (Vietnamese Keyboard)

```sh
sudo apt-get install ibus-unikey
ibus restart
[Setting] -> [Region & Language] -> [Input Sources] -> [Add] -> [Vietnamese] -> [Unikey]
```

## 4. Fonts
You might need to use some Microsoft fonts like: Arial, Time New Roman, ...
```sh
sudo apt-get -y install ttf-mscorefonts-installer 
[Tab] -> [Enter] -> [Yes]
```

## 5. GNOME Tweak Tool
GNOME Extensions are a great way to add more functionality to the Ubuntu desktop without having to install apps or touch hidden settings.
```sh
sudo apt -y install gnome-tweaks
```
[Tweak Configuring](https://itsfoss.com/gnome-tweak-tool/)

## 6. Sublime Text
One of best code editor for developer
```sh
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text
```


