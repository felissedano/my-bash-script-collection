#!/bin/bash

# echo $#

if [[ $# < 1 ]]
then
   echo "Error: No log file given."
   echo "Usage: ./webmetrics.sh <logfile>"
   exit 1
fi

if [[ ! -f $1 ]]
then
   echo "Error: File $1 does not exist."
   echo "Usage: ./webmetrics.sh <logfile>"
   exit 2
fi

echo "Number of requests per web browser"

sacount=$(grep -c Safari $1)
ficount=$(grep -c Firefox $1)
chcount=$(grep -c Chrome $1)

echo "Safari,$sacount"
echo "Firefox,$ficount"
echo "Chrome,$chcount"

echo ""
# awk -F'[ "[":]' '{a[$5]++} END {for (b in a) {print $5}}'

echo "Number of distinct users per day"

awk -F'[ "[":]' '{c[$1$5]++} {if(c[$1$5] == 1) a[$5]++} END {for (b in a) {print b","a[b]}}' $1 | sed 's/,/\/a/g' | sort -t '/' -k 3n -k 2M -k 1n | sed 's/\/a/,/g'


echo ""

echo "Top 20 popular product requests"

sed -n '/GET .product[/][0-9]*[/]./p' $1 | awk -F'[/]' '{a[$5]++} END {for (b in a) {print b","a[b]}}' | sort -t ',' -k 2nr -k 1nr | head -20

# sed -n 's/.*\(GET\).*/\1/p' < testweb.txt
