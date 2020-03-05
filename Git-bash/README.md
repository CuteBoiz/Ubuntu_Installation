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
```

<li><b>Clone a repository: </b></li>

```sh
$ git clone [repositoryUrl]
```
</ul>

## II. File Execution
<ul>

<li><b>Add</b></li>
Add one or more files to staging:

```sh
$ git add <filename>
$ git add .
```

<li><b>Status</b></li>

List the files you've changed and those still need to add or commit:

```
$ git status
```

<li><b>Commit</b></li>

Commit changes to head(but not yet to the remote repository):

```
$ git commit -m "Commit message"
```

Commit any files you're added with `git add` and also commit any files you've changed since then:

```
$ git commit -a
```

<li><b>Push</b></li>

Send changes to the master branch of your remote repository:

```
$ git push origin master
```
</ul>

## III. Push to Remote Repository

```sh
$ git add . ***or*** git add [fileName]
$ git status
$ git commit -m "Message"
$ git push origin master 
```

## V. Branches

```sh
$ git checkout -b <branchname> #Create a branch and switch to it
$ git checkout <branchname> #Switch branch

```


***Switch branch:***
` `

***List all the branches:***
`$ git branch`

***Delete the feature branch:***
`$ git branch -d <branchname> `

***Push the branch:***
`$ git push origin <branchname> `

***Push all branches:***
`$ git push --all origin `

***Delete a branch:***
`$ git push origin :<branchname>`




