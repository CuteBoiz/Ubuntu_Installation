# Git Command

[I. Install Git](https://github.com/CuteBoiz/Ubuntu/tree/master/git.md#i-install-git)

[II. Autorization](https://github.com/CuteBoiz/Ubuntu/tree/master/git.md#ii-authorization)

[III. Create A Repository](https://github.com/CuteBoiz/Ubuntu/tree/master/git.md#iii-create-a-repository)

[IV. Download Data From Repository](https://github.com/CuteBoiz/Ubuntu/tree/master/git.md#iv-download-data-from-repository)

[V. Push to Remote Repository](https://github.com/CuteBoiz/Ubuntu/tree/master/git.md#v-push-to-remote-repository)

[VI. Branches](https://github.com/CuteBoiz/Ubuntu/tree/master/git.md#vi-branches)


## I. Install Git
```sh
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
```


## II. Authorization

```sh
git config --global user.name "CuteBoiz"
git config --global user.email "CuteBoiz@example.com"
git config --global credential.helper store 	#Git will never ask for password again
```

## III. Create A Repository

<li><b>Initalizing a Repository in an Existing Directory </b></li>

```sh
git init
git remote add origin [repositoryUrl] 	#Connect to remote repository
git fetch origin
git checkout master
git add .
git commit -a
git push origin master
```

</ul>

## IV. Download Data From Repository
<ul>
<li><b>Clone a repository: </b></li>

```sh
git clone https://github.com/[ownerName]/[reposName]
```

<li><b>Fetch</b></li>

- *Fetch only download new data.*
- *Fetch will NEVER manipulate, destroy or screw up anything*
```sh
git fetch origin
```

<li><b>Pull</b></li>

- *To update your current HEAD branch with the lastest changes*
- *`Git pull` tries to merge remote change with local one, so "merge conflict" can occur*
```sh
git pull origin master
git pull origin [branchName]
```

</ul>

## V. Push to Remote Repository

```sh
git add .		#Add all files to commit
git add [fileName]	#Add specific file

git status 			

git commit -m "Message"	#Commit changes to head

git push origin master 
```
If you met
```sh
error: src refspec master does not match any
error: failed to push some refs to "https:github.com/..."
```
Replace `git push origin master` with `git push origin main`

## VI. Branches
<ul>
<li><b>Create, push & delete branches</b></li>

```sh
git checkout -b [branchName]	#Create a branch and switch to it
git checkout [branchName] 	#Switch branch

git branch 			#List all the branches
git branch -d [branchName]	#Delete the feature branch
git push origin :[branchname]	#Delete a braches

git push origin [branchName]	#Push the branch
git push -all origin		#Push all branches
```
<li><b>Merge a branch to remote Repository</b></li>

```sh
git checkout master
git pull https://github.com/[ownerName]/[reposName].git [branchName]
git push origin master
```

</ul>


