# Git Command

[I. Begin](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/Git.md#i-begin)

[II. File Excution](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/Git.md#ii-file-execution)

[III. Update The Remote Repository](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/Git.md#iii-update-the-remote-repository)

[IV. Undo Local Changes](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/Git.md#iv-undo-local-changes)

[V. Branches](https://github.com/CuteBoiz/Ubuntu/blob/master/Git-bash/Git.md#v-branches)

## I. Begin
<ul>
<li><b>Tell Git who you are </b></li>

```
$ git config --global user.name "CuteBoiz"
$ git config --global user.email "CuteBoiz@example.com"
```

<li><b>Make git store user name and password and will never ask for it: </b></li>

```
$ git config --global credential.helper store
```

<li><b>Create a new local respository: </b></li>

```
$ git init
```

<li><b>Connect to a remote repository: </b></li>

If you haven't connected your local repository to a remote server, add the server to be able to push to it:

```
$ git remote add origin <server>
```

List add currently configured remote repositories:

```
$ git remote -v
```

<li><b>Check out a repository: </b></li>

```
$ git clone /path/to/repository
```
</ul>

## II. File Execution
<ul>

<li><b>Add</b></li>
Add one or more files to staging:

```
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

## III. Update The Remote Repository

<ul>

<li><b>Pull </b></li>

Fetch and Merge changes on the remote server to your working directory:

```
$ git pull
```

<li><b>Merge</b></li>

To merge a diffrent branch into your active branch:

```
$ git merge <brachname>
```

<li><b>Differences</b></li>
<ul>

<li><b><i>View all the merge conflicts:</i></b></li>

```
$ git diff
```
<li><b><i>View the conflicts against the base file:</i></b></li>

```
$ git diff --base <filename>
```

<li><b><i>Preview changes, before merging:</i></b></li>

```
$ git diff <sourcebranch> <targetbranch>
```

<li><b><i>After you've manually resolved any conflicts, you mark the changed file:</i></b></li>

```
$ git add <file name>
```
</ul>
</ul>

## IV. Undo Local Changes
If you mess up, you can replace changes in your working tree with the last content in head:

```
$ git checkout -- <file name>
```
Changes already added to the index, as well as new files, will be kept.
</br>
</br>

Instead, to drop all your local chagnes and commits, fetch the lastest history from the server and point your local master branch at it, do this:
```
$ git fetch origin
$ git reset --hard origin/master
```
## V. Branches

***Create a branch and switch to it:***
`$ git checkout -b <branchname> ` 

***Switch branch:***
`$ git checkout <branchname> `

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




