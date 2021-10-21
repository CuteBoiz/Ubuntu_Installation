#  Popular Programs

<details>
<summary><b>1. Google Chrome</b></summary>
  
- **Download:**
  
  ```sh
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  ```
  
- **Install:**
  
  ```sh
  sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb
  ```
  
</details>

<details>
<summary><b>2. Unikey (Vietnamese Keyboard)</b></summary>
 
- **Unikey**
  
  ```sh
  sudo apt-get install ibus-unikey
  ibus restart
  [Setting] -> [Region & Language] -> [Input Sources] -> [Add] -> [Vietnamese] -> [Unikey]
  ```
  
- **Unicode fonts**
  
  ```sh
  sudo apt-get -y install ttf-mscorefonts-installer 
  [Tab] -> [Enter] -> [Yes]
  ```
  
</details>

<details>
<summary><b>3. GNOME Tweak Tool.</b></summary>
  
- *GNOME Extensions are a great way to add more functionality to the Ubuntu desktop without having to install apps or touch hidden settings.*
  
  ```sh
  sudo apt -y install gnome-tweaks
  ```
  
- [Tweak Configuring](https://itsfoss.com/gnome-tweak-tool/)

</details>
  
<details>
<summary><b>4. Sublime Text.</b></summary>
  
 - **Install:**
    ```sh
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get -y install sublime-text
    ```
  
 - **Popular Package:**
    - ***Package Control:***
      ```sh
      # Install Package Control
      [Ctrl + Shift + P] => [Install Package Control]
      # Install a Sublime Package
      [Ctrl + Shift + P] => [Package Control: Install Package] => "Name of Package"
      ```
    - ***Emmet.***
      ```sh
      A toolkit that can greatly improve your workflow.
      ```
    - ***SublimeCodeIntel.***
      ```sh
      A full-featured code intelligence and smart autocomplete engine for Sublime Text.
      ```
    - ***Material Theme.***
      ```sh
      [Preferences] -> [Package Setting] -> [Material Theme] -> [Activate].
      ```
    - ***SidebarEnhancements.***
      ```sh
      Add some usefull functions to sidebar.
      ```
    - ***AdvancedNewfile.***
      ```sh
      This tool help you create a newfile dricetly inside sidebar's folder by ":fileName".
      ```
    - ***DocBlockr.***
      ```sh
      Comment `/** + [Tab]` above a function to note all your function's variables.
      ```
    - ***A File Icon.***
      ```sh
      Sublime Text File-Specific Icons for Improved Visual Grepping.
      ```
  
</details>

<details>
<summary><b>5. C/C++ Compiler.</b></summary>

- **Install:**
  ```sh
  sudo apt-get -y install build-essential
  sudo apt-get -y install gcc
  ```
- **Write a simple C/C++ scripts:**
  ```sh
  gedit sampleProgram.c
  ```
- **Compile the C program with gcc/g++:**
  ```sh
  gcc [programNanme].c -o programName
  g++ [programNanme].cpp -o programName
  ```
- **Run the program:**
  ```sh
  ./[progamName]
  ```
  
</details>

