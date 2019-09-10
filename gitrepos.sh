#!/bin/bash

cloneRepos() {
    echo $1
    repoFile=$1
    DIR=$(dirname "${repoFile}")
    mkdir -p $DIR/grading
    total=0
    fail=0
    while read repo; do
        repoPath="git@github.com:$repo.git"
        #echo "cloning $repoPath "
        cd $DIR/grading > /dev/null 2>&1
        #git clone $repoPath 
        echo $(pwd)
        git clone $repoPath > git.log 2>&1
        ((total+=1))
        OUTPUT=$(egrep -i "ERROR:" git.log)
        #echo $OUTPUT
        if [ -n "$OUTPUT" ]
        then
            ((fail+=1))
            echo "$OUTPUT: $repoPath"
        fi
    done < $repoFile
    echo "Failed cloning $fail of $total repositotires!"
    rm git.log
}

pullRepos() {
    rootFolder=$1
    for d in $(ls $rootFolder); do
        repo="$rootFolder/$d"
        echo "pulling $repo"
        git -C $repo stash # stash local changes so won't affect pull
        git -C $repo pull
    done
    echo "All done pulling repos for grading!"
}

if [[ $# < 2 ]]; then 
    echo "Usage: ${0} command file or folder"
    echo "comand = clone or pull"
    echo "Example: ${0} clone <gitrepos.txt>"
    echo "Example: ${0} pull <CS2/grading/>"
    echo "Not enough arguments provided... Exiting"
    exit 1
fi

if [[ $1 == "clone" ]]; then
    echo "cloning repos from DIR/file $2"
    cloneRepos $2
elif [[ $1 == "pull" ]]; then
    echo "pulling repos in root directory $2"
    pullRepos $2
else
    echo "not a command!"
fi
