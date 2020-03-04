# Ubuntu
Some Linux Commands

## I.Prequiste Programs
### 1.Google Chorme

>Donwload:

`wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb`
 
>Install:
 
`sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb`

>Uninstall:

`sudo apt-get purge google-chrome-stable`

### 2.Update & Upgrade Packages

`sudo apt-get update`

`sudo apt-get upgrade`

### 3.Unikey
>Step 1: Install ibus-unikey

```
sudo add-apt-repository ppa:ubuntu-vn/ppa
sudo apt-get update
sudo apt-get install ibus-unikey
```
>Step 2: Restart ibus

`ibus restart`

>Step 3: Configure

`[Setting] -> [Region & Language] -> [Input Sources] -> [Add] -> [Vietnamese] -> [Unikey]`

>Step 4: Restart Ubuntu

### 4. Fonts

`sudo apt-get install ttf-mscorefonts-installer`
[Tab] -> [Enter]

### 5. GNOME Tweak Tool

`sudo apt install gnome-tweaks`

[Tweak configuring](https://itsfoss.com/gnome-tweak-tool/)

### 6.Sublime Text
>Step 1: Install GPG key

`wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -`

>Step 2: Ensure apt is set up to work with https sources:

`wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -`

>Step 3: Select channel to use

`echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list`

>Step 4: Update apt source and Install

`sudo apt-get update`

`sudo apt-get install sublime-text`

### 7. Git Bash

```
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
```

### 8. Clean apt cache to free up space

`sudo du -sh /var/cache/apt/archives`

`sudo apt clean`

