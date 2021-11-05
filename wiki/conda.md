## Miniconda 

## I. Install Miniconda.

**[Download here](https://conda.io/en/latest/miniconda.html)**

```sh
sh Miniconda3-latest-Linux-x86_64.sh -b
~/miniconda3/bin/conda init
```

## II. Create Environment

### 1. Creating an environment.

```sh
#Create an environment:
conda create --name myenv
#Create an environment with a specific version of Python:
conda create --n myenv python=3.6
#Create an environment with a specific package:
conda create --n myenv scpicy
```

### 2. Creating an environment from environment.yml file.

```sh
conda env create -f environment.yml
```

### 3. Updating an environment.

You may need to update your environment for a variety of reasons. For example, it may be the case that:

- one of your core dependencies just released a new version (dependency version number update).  
- you need an additional package for data analysis (add a new dependency).  
- you have found a better package and no longer need the older package (add new dependency and remove old dependency).  

```sh
conda env update --prefix ./env --file environment.yml  --prune
```

### 4. Cloning an environment.

```sh
conda create --name myclone --clone myenv
conda info --envs
```

### 5. Building identical conda environments.

```sh
conda list --explicit

conda list --explicit > spec-file.txt

conda create --name myenv --file spec-file.txt

conda install --name myenv --file spec-file.txt
```

## III. Using Environments.

### 6. Activating an environment.

```sh
conda activate myenv
```

### 7. Deactivate an environment.

```sh
conda deactivate
```

### 8. Viewing list of environments.

```sh
conda info --envs
```

### 9. Viewing list of packages in an environments.

```sh
conda list -n myenv
```

### 10. Using pip in an environment.

```sh
conda install -n myenv pip
conda activate myenv
pip <pip_subcommand>
```

## IV. Sharing Environment.

### 11. Exporting the environment.yml file.

```sh
conda env export > environment.yml
```

### 12. Exporting an environment file across platforms.

```sh
conda env export --from-history
```

### 13. Creating an environments file manually.

```sh
name: stats2
channels:
  - javascript
dependencies:
  - python=3.6   # or 2.7
  - bokeh=0.9.2
  - numpy=1.9.*
  - nodejs=0.10.*
  - flask
  - pip:
    - Flask-Testing
```

## V. Restoring An Environment.

```sh
conda list --revisions
conda install --revision=REVNUM
```

## VI. Removing An Environment. 

```sh
conda remove --name myenv --all
```
