#!/bin/bash

#set -x

#echo "arg0 is"$0
#echo "or it could be"$1
#echo $2
#echo $3

#echo "$#"

if [[ $# != 2 ]]
then 
    echo "Error: Expected two input parameters."
    echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
    exit 1
fi

#echo "checking exstse"

if [[ ! -e $2 ]]
then
    echo "Error: The target file or directory "$2" does not exist"
    exit 2
fi

#echo "checking exstfi"

if [[ ! -e $1 ]]
then
    echo "Error: The directory "$1" does not exist"
    exit 2
fi

#echo "checking basenames"

basefi=$(basename $1)

basese=$(basename $2)

if [[ $basefi == $basese ]]
then
     echo "Error: The two directories are the same"
     exit 2
fi

#b="$?"

#echo "$b"

#if [[ $b != 0 ]]
#then
#    echo "Error 1 i suppose"
#    exit 1
#fi

c=$(date "+%Y%m%d")   

#echo $c

 
#echo "checking if tarfile exist"

if [[ -e $1/$basese.$c.tar ]]
then
    read -p "Back up file "$basese.$c.tar" already exists. Overwrite? (y/n)" answer
    if [[ $answer != y ]]
    then
        #echo "no overwrite"
        exit 3
    fi
fi

#echo "continuing"

#echo "datetransgetr"

#c=$(date "+%Y%m%d")
#echo $c

#echo "about to tar"


tar -cvf $1/$basese.$c.tar $2

#echo "check it out"

exit 0
