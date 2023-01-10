#!/bin/bash

while [ $# -gt 0 ]
do
  echo "Web metrics for log file $1"
  echo "===================="
  . ./webmetrics.sh $1
  echo -e "\n"
  shift
done

exit 0
