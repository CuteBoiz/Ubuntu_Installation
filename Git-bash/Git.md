# Git Command

# 		BEGIN PATH

### Tell Git who you are

`git config --global user.name "CuteBoiz"`

`git config --global user.email "CuteBoiz@example.com"`

###Make git store user name and password and will never ask for it:

`git config --global credential.helper store`

### Create a new local respository

`git init`

### Connect to a remote repository
>If you haven't connected your local repository to a remote server, add the server to be able to push to it:

`git remote add origin <server>`

>List add currently configured remote repositories:

`git remote -v`

### Check out a repository

`git clone /path/to/repository`

# 		FILE EXCUTION 

### Add file
>Add one or more files to staging:

`git add <filename>`

`git add .`

### Status
>List the files you've changed and those still need to add or commit:

`git status`

### Commit
>Commit changes to head(but not yet to the remote repository):

`git commit -m "Commit message"`

>Commit any files you're added with `git add` and also commit any files you've changed since then:

`git commit -a`


### Push
>Send changes to the master branch of your remote repository

`git push origin master`


# UPDATE FROM THE REMOTE REPOSITORY

### Pull
>Fetch and Merge changes on the remote server to your working directory:

```
git pull
```

### Merge
>To merge a diffrent branch into your active branch:

`git merge <brachname>`

### Differences
>View all the merge conflicts:
`git diff`

>View the conflicts against the base file:
`git diff --base <filename>`

>Preview changes, before merging:
`git diff <sourcebranch> <targetbranch>`

>After you've manually resolved any conflicts, you mark the changed file:
`git add <file name`

# UNDO LOCAL CHANGES
>If you mess up, you can replace changes in your working tree with the last content in head:

```
git checkout -- <file name>
```
>Changes already added to the index, as well as new files, will be kept.



>Instead, to drop all your local chagnes and commits, fetch the lastest history from the server and point your local master branch at it, do this:
```
git fetch origin
git reset --hard origin/master
```
# BRANCHES


