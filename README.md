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
*Step 1: Install ibus-unikey*

```
sudo add-apt-repository ppa:ubuntu-vn/ppa
sudo apt-get update
sudo apt-get install ibus-unikey
```
*Step 2: Restart ibus*

`ibus restart`

*Step 3: Configure*

[Setting] -> [Region & Language] -> [Input Sources] -> [Add] -> [Vietnamese] -> [Unikey]

*Step 4: Restart Ubuntu*

### 4. Fonts
`sudo apt-get install ttf-mscorefonts-installer`
[Tab] -> [Enter]


