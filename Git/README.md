# Git Command

[I. Autorization](https://github.com/CuteBoiz/Ubuntu/tree/master/Git#i-authorization)

[II. Create A Repository](https://github.com/CuteBoiz/Ubuntu/tree/master/Git#ii-create-a-repository)

[III. Download Data From Repository](https://github.com/CuteBoiz/Ubuntu/tree/master/Git#iii-download-data-from-repository)

[IV. Push to Remote Repository](https://github.com/CuteBoiz/Ubuntu/tree/master/Git#iv-push-to-remote-repository)

[V. Branches](https://github.com/CuteBoiz/Ubuntu/tree/master/Git#v-branches)

## I. Authorization

```sh
$ git config --global user.name "CuteBoiz"
$ git config --global user.email "CuteBoiz@example.com"
$ git config --global credential.helper store 	#Git will never ask for password again
```

## II. Create A Repository

<li><b>Initalizing a Repository in an Existing Directory </b></li>

```sh
$ git init
$ git remote add origin [repositoryUrl] 	#Connect to remote repository
$ git fetch origin
$ git checkout master
$ git add .
$ git commit -a
$ git push origin master
```

</ul>

## III. Download Data From Repository
<ul>
<li><b>Clone a repository: </b></li>

```sh
$ git clone https://github.com/[ownerName]/[reposName]
```

<li><b>Fetch</b></li>

- *Fetch only download new data.*
- *Fetch will NEVER manipulate, destroy or screw up anything*
```sh
$ git fetch origin
```

<li><b>Pull</b></li>

- *To update your current HEAD branch with the lastest changes*
- *`Git pull` tries to merge remote change with local one, so "merge conflict" can occur*
```sh
$ git pull origin master
$ git pull origin [branchName]
```

</ul>

## IV. Push to Remote Repository

```sh
$ git add .		#Add all files to commit
$ git add [fileName]	#Add specific file

$ git status 			

$ git commit -m "Message"	#Commit changes to head
$ git commit -a 		#Commit tracking file to head

$ git push origin master 
```

## V. Branches
<ul>
<li><b>Create, push & delete branches</b></li>

```sh
$ git checkout -b [branchName]	#Create a branch and switch to it
$ git checkout [branchName] 	#Switch branch

$ git branch 			#List all the branches
$ git branch -d [branchName]	#Delete the feature branch
$ git push origin :[branchname]	#Delete a braches

$ git push origin [branchName]	#Push the branch
$ git push -all origin		#Push all branches
```
<li><b>Merge a branch to remote Repository</b></li>

```sh
$ git checkout master
$ git pull https://github.com/[ownerName]/[reposName].git [branchName]
$ git push origin master
```

</ul>


