# Git Command

[I. Begin](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/README.md#i-begin)

[II. File Excution](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/README.md#ii-file-execution)

[III. Update The Remote Repository](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/README.md#iii-update-the-remote-repository)

[IV. Undo Local Changes](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/README.md#iv-undo-local-changes)

[V. Branches](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/README.md#v-branches)

## I. Authorization

```sh
$ git config --global user.name "CuteBoiz"
$ git config --global user.email "CuteBoiz@example.com"
$ git config --global credential.helper store #Git will never ask for password again
```

## II. Create A Repository

<li><b>Initalizing a Repository in an Existing Directory </b></li>

```sh
$ git init
$ git remote add origin [repositoryUrl] #Connect to remote repository
$ git fetch origin
$ git checkout master
$ git add .
$ git commit -a
$ git push origin master
```

</ul>

## II. Download Data From Repository
<ul>
<li><b>Clone a repository: </b></li>

```sh
$ git clone https://github.com/[ownerName]/[reposName]
```

<li><b>Fetch</b></li>

- Fetch only download new data. But does'nt intergate any of new data intoyour working files.
- Fetch will manipulate, destroy or screw up anything
```sh
$ git fetch origin
```

<li><b>Pull</b></li>

```sh
$ git pull origin master
$ git pull origin [branchName]
```

</ul>

## III. Push to Remote Repository

```sh
$ git add . 			#Add all files to commit
$ git add [fileName]	#Add specific file

$ git status 			

$ git commit -m "Message"	#Commit changes to head
$ git commit -a 			#Commit tracking file to head

$ git push origin master 
```

## IV. Branches
<ul>
<li><b>Create, Push & Delete Branches</b></li>

```sh
$ git checkout -b [branchName]	#Create a branch and switch to it
$ git checkout [branchName] 	#Switch branch

$ git branch 					#List all the branches
$ git branch -d [branchName]	#Delete the feature branch
$ git push origin :[branchname]	#Delete a braches

$ git push origin [branchName]	#Push the branch
$ git push -all origin			#Push all branches
```
<li><b>Merge a branch to remote Repository</b></li>

```sh
$ git checkout master
$ git pull https://github.com/[ownerName]/[reposName].git [branchName]
$ git push origin master
```

</ul>


