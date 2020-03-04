# Ubuntu
Some Linux Commands

# I.Prequiste Programs
## 1.Google Chorme
<ul>
<li><b>Donwload:</b></li>

```
$ wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```
 
<li><b>Install:</b></li>
 
```
$ sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
```

<li><b>Uninstall:</b></li>

```
$ sudo apt-get purge google-chrome-stable
```
</ul>

## 2.Update & Upgrade Packages
```
$ sudo apt-get update
$ sudo apt-get upgrade
```

## 3.Unikey
<ul>
<li><b>Step 1: Install ibus-unikey</b></li>

```
$ sudo add-apt-repository ppa:ubuntu-vn/ppa
$ sudo apt-get update
$ sudo apt-get install ibus-unikey
```
<li><b>Step 2: Restart ibus</b></li>

```
$ ibus restart
```

<li><b>Step 3: Configure</b></li>

```
[Setting] -> [Region & Language] -> [Input Sources] -> [Add] -> [Vietnamese] -> [Unikey]
```

<li><b>Step 4: Restart Ubuntu</b></li>
</ul>

## 4. Fonts

```
$ sudo apt-get install ttf-mscorefonts-installer [Tab] -> [Enter]
```

## 5. GNOME Tweak Tool
```
$ sudo apt install gnome-tweaks
```

[Tweak Configuring](https://itsfoss.com/gnome-tweak-tool/)

## 6.Sublime Text

<ul>
<li><b>Step 1: Install GPG key</b></li>

```
$ wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
```

<li><b>Step 2: Ensure apt is set up to work with https sources:</b></li>

```
$ wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
```

<li><b>Step 3: Select channel to use</b></li>

```
$ echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
```

<li><b>Step 4: Update apt source and Install</b></li>

```
$ sudo apt-get update
$ sudo apt-get install sublime-text
```
</ul>

## 7. Git Bash
```
$ sudo add-apt-repository ppa:git-core/ppa
$ sudo apt-get update
$ sudo apt-get install git
```

## 8. Clean apt cache to free up space

```
$ sudo du -sh /var/cache/apt/archives
$ sudo apt clean
```

