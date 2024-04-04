#! /bin/bash

#user prefs
trash_path=~/.local/share/Trash/files
script=$0

# defining bold and plain text
bold=$(tput bold)
plain=$(tput sgr0)

user=$(whoami)

show_help() {
  echo -e "\n    ${bold}NAME${plain}"
  echo -e "\n         del - delete files"
  echo -e "\n    ${bold}SYNOPSIS${plain}"
  echo -e "\n         del [OPTION]... [FILE]..."
  echo -e "\n    ${bold}DESCRIPTION${plain}"
  echo -e "\n         Move files to trash. Deleted files will still"
  echo -e "         be available at here: $(echo $trash_path)."
  echo -e "\n    ${bold}OPTIONS${plain}"
  echo -e "\n         ${bold}-p, --path${plain}      show delete path"
  echo -e "\n         ${bold}-l, --list${plain}      list deleted files"
  echo -e "\n         ${bold}-u, --undo${plain}      undo delete"
  echo -e "\n         ${bold}-r, --restore${plain}   restore a specific file"
  echo -e "\n         ${bold}    --install${plain}   install this script"
  echo -e "\n         ${bold}    --uninstall${plain} uninstall this script"
  echo -e "\n         ${bold}    --empty-old${plain} empty files older than 10 days from trash"
  echo -e "\n         ${bold}    --empty-all${plain} empty all files from recycle bin"
  echo -e "\n         ${bold}    --perm-del${plain}  permanantly delete a file"
  echo -e "\n         ${bold}-h, --help,${plain}     show help"
  echo -e "\n     ${bold}AUTHOR${plain}"
  echo -e "\n         Written by @author_name"
  echo -e "\n     ${bold}REPORTING BUGS${plain}"
  echo -e "\n         Link:example.com"
  echo -e "\n     ${bold}COPYRIGHT${plain}"
  echo -e "\n         Copyright @celestinediask\n"
}

del_file() {
   if [ -z $file_path ]; then echo "file name not specified!"; exit; fi
   file=$(echo $file_path | grep -o '[^/]\+$') #filtering file from path
   if [ ! -e $file_path ]; then echo "$file_path does not exist!"; exit; fi
   if [ -e $trash_path/$file ]; then echo "${bold}$file${plain} already exists in trash. Rename file and try again."; exit; fi
   if [ ! -e $trash_path ]; then mkdir -p $trash_path; fi
   mv -n $file_path $trash_path
   if [ ! -e $trash_path/$file ]; then echo "Error: $file not found in trash!"; fi
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then show_help
 elif [ "$1" = "--in" ]; then cd $trash_path
 elif [ "$1" = "--list" ] || [ "$1" = "-l" ]; then ls -a $trash_path
 elif [ "$1" = "--path" ] || [ "$1" = "-p" ]; then echo $trash_path
 elif [[ $1 = -* ]]; then echo "$1 check your typo or maybe not implemented yet"
 else file_path=$1; del_file
fi
