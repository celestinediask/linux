#! /bin/bash

if [[ $1 = --install ]]; then
	sudo cp -i md5dir.sh /usr/bin/md5dir
	sudo chmod +x /usr/bin/md5dir
	exit
fi

if [ -z $1 ]; then echo "Folder name not given. Exiting."; exit 1; fi

if [ ! -e $1 ]; then echo "'$1' not found in current directory. Exiting."; exit 1; fi

if [[ -f $1 ]]; then echo "'$1' is a file, should be a folder. Exiting."; exit 1; fi


find $1 -type f -exec md5sum {} + | awk '{print $1}' | sort | md5sum | sed 's/-//'
