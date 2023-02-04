

## Git.

- **a. Install.**
  ```sh
  sudo add-apt-repository ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get install -y git
  ```

- **b. Authorization.**
  ```sh
  git config --global user.name "CuteBoiz"
  git config --global user.email "CuteBoiz@example.com"
  git config --global credential.helper store   #Git will never ask for password again
  ```

- **c. Download from a repository.**
  - ***Clone***
    ```sh
    git clone https://github.com/[ownerName]/[reposName]
    ```

  - ***Fetch.***
    ```sh
    #Fetch only download new data.
    #Fetch will NEVER manipulate, destroy or screw up anything
    git fetch origin
    ```

  - ***Pull.***
    ```sh
    #To update your current HEAD branch with the lastest changes
    #Git pull tries to merge remote change with local one, so "merge conflict" can occur
    git pull origin master
    git pull origin [branchName]
    ```

- **d. Push from local to Remote Respository.**
  - ***Step 1: Add changed files.***
    ```sh
    #Add single file.
    git add fileName
    #Add all changed in a single folder.
    git add folderName
    #Add all changed in whole respository.
    git add .

    #Undo git add
    git reset fileName
    #Unstage all changes
    git reset 

    ```

  - ***Step 2: Check changed status.***
    ```sh
    git status
    ```

  - ***Step 3: Commit to respository.***
    ```sh
    git commit -m "Commit Message"
    ```

  - ***Step 4: Push the added files to remote respository.***
    ```sh
    git push origin master
    #or
    git push origin main #For respos which created after summer 2020
    ```

- **e. Branches.**
  - ***Create, push & delete branches.***
    ```sh
    git checkout -b branchName  #Create a branch and switch to it
    git checkout branchName   #Switch branch

    git branch      #List all the branches
    git branch -d branchName  #Delete the feature branch
    git push origin :branchname #Delete a branch

    git push origin branchName  #Push the branch
    git push -all origin    #Push all branches
    ```

  - ***Merge a branch to remote Repository.***
    ```sh
    git checkout master
    git pull https://github.com/[ownerName]/[reposName].git [branchName]
    git push origin master
    ```