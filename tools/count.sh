#!/bin/bash

if [[ $1 = "" ]]; then
	echo "No argument given! Exiting.";
	exit 1;
fi

count () {
  i=$1
  while [ $i -ge 0 ]
  do
    echo -ne "$i $(sleep 1)\b\b"
    let "i--"
  done
}

count $1
