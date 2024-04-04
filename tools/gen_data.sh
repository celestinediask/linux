#!/bin/bash

# Define the number of lines and characters
  dir_name=$1
  num_lines=100
  num_chars=126
  num_files=5
  filename=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

if [ -z $dir_name ]; then echo "Folder name not given. Exiting."; exit 1; fi
mkdir $dir_name

for ((j=1; j<=num_files; j++)); do
    for ((i=1; i<=num_lines; i++)); do
        random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $num_chars | head -n 1)
        echo $random_string >> $dir_name/$filename
    done
    new_filename=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
    mv -i $dir_name/$filename $dir_name/$new_filename
done

