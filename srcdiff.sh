#!/bin/bash

#set -x

if [[ $# != 2 ]]
then
    echo "Error: Expected two input paramaters."
    echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
    exit 1
fi

if [[ ! -d $1 ]]
then 
   echo "Error: Input parameter #1 $1 is not a directory."
   echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
   exit 2
fi

if [[ ! -d $2 ]]
then
    echo "Error: Input parameter #2 $2 is not a directory."
    echo "Usage: ./srcdiff.sh <originaldirectory> <comparisondirectory>"
    exit 2
fi

m=0

for x in $(ls $2)
do
  n=0
  for i in $(ls $1)
  do
    if [[ -d $x ]]
    then 
        break
    fi
  
    if [[ $x == $i ]]
    then
        n=$(expr $n + 1)
    fi
    
  done
  
  if [[ $n == 0 ]]
  then
      m=$(expr $m + 1)
      echo "$1/$x is missing"
  fi

done



for i in $(ls $1)
do
  n=0
  for x in $(ls $2)
  do
    if [[ -d $i ]]
    then
        break
    fi

    if [[ $i == $x ]]
    then
        n=$(expr $n + 1)
        diff $1/$i $2/$x >/dev/null
        c=$?
        if [[ $c != 0 ]]
        then 
            m=$(expr $m + 1)
            echo "$1/$i differs"
        fi

        break
    fi

  done

  if [[ $n == 0 ]]
  then
      m=$(expr $m + 1)
      echo "$2/$i is missing"
  fi  
      
done

if [[ $m == 0 ]]
then
    exit 0

else
    exit 3
fi
