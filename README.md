# git assignments

script to work with assignments as git repositories

## Using this script

1. create a list of repositiories for each class in username/Repo-Name format
2. save the file inside the course folder
3. download gitrepos.sh script somewhere inside your semester folder e.g., Fall2019
    - folder structure:
    - Fall2019/gitrepos.sh
    - Fall2009/00P/repos.txt # list of repositories <username>/<repo_name> in OOP course
    
4. to clone all the repositories run:

```bash
$ bash gitrepos.sh clone OOP/repos.txt 
```

4. to pull new submissions run:

```bash
$ ./gitrepos.sh pull OOP/grading
```
