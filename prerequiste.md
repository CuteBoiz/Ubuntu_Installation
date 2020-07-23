#  Prerequiste Programs

## 1. Google Chorme
<ul>
<li><b>Donwload:</b></li>

```sh
$ wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```

<li><b>Install:</b></li>
 
```sh
$ sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
```

<li><b>Uninstall:</b></li>

```sh
$ sudo apt-get purge google-chrome-stable
```
</ul>

## 2. Update & Upgrade Packages
If you install Ubuntu 18.10 on release day you can skip this step, but everyone else needs to check for security updates and bug fixes, and install any that are listed as available.

```sh
$ sudo apt-get update
$ sudo apt-get upgrade
```

## 3. Unikey
<ul>
<li><b>Step 1: Install ibus-unikey</b></li>

```sh
$ sudo add-apt-repository ppa:ubuntu-vn/ppa
$ sudo apt-get update
$ sudo apt-get install ibus-unikey
```
<li><b>Step 2: Restart ibus</b></li>

```sh
$ ibus restart
```

<li><b>Step 3: Configure</b></li>

```sh
[Setting] -> [Region & Language] -> [Input Sources] -> [Add] -> [Vietnamese] -> [Unikey]
```

<li><b>Step 4: Restart Ubuntu</b></li>
</ul>

## 4. Fonts
You might need to use some Microsoft fonts like: Arial, Time New Roman, ...
```sh
$ sudo apt-get install ttf-mscorefonts-installer [Tab] -> [Enter] -> [Yes]
```

## 5. GNOME Tweak Tool
GNOME Extensions are a great way to add more functionality to the Ubuntu desktop without having to install apps or touch hidden settings.

```sh
$ sudo apt install gnome-tweaks
```

[Tweak Configuring](https://itsfoss.com/gnome-tweak-tool/)

## 6. Sublime Text

<ul>
<li><b>Step 1: Install GPG key</b></li>

```sh
$ wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
```

<li><b>Step 2: Ensure apt is set up to work with https sources:</b></li>

```sh
$ sudo apt-get install apt-transport-https
```

<li><b>Step 3: Select channel to use</b></li>

```sh
$ echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
```

<li><b>Step 4: Update apt source and Install</b></li>

```sh
$ sudo apt-get update
$ sudo apt-get install sublime-text
```
</ul>

## 7. Clean apt cache to free up space
If you install lots of software and package updates often you should, from time to time, ensure your system is kept clean.

```sh
$ sudo du -sh /var/cache/apt/archives
$ sudo apt clean
```
