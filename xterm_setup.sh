# A script to install and make xterm look good.

# create xterm config file at home dir
create_config() {
echo '
! Set the background and foreground colors
xterm*background: black
xterm*foreground: white
xterm*promptColor: green


! Set the font size
xterm*faceName: DejaVu Sans Mono
xterm*faceSize: 12

! Add key bindings
xterm*VT100.Translations: #override \n\
    Ctrl Shift <Key>C: copy-selection(CLIPBOARD) \n\
    Ctrl Shift <Key>V: insert-selection(CLIPBOARD)

! Set the color scheme
xterm*color0: #2e3436
xterm*color1: #cc0000
xterm*color2: #4e9a06
xterm*color3: #c4a000
xterm*color4: #3465a4
xterm*color5: #75507b
xterm*color6: #06989a
xterm*color7: #d3d7cf
xterm*color8: #555753
xterm*color9: #ef2929
xterm*color10: #8ae234
xterm*color11: #fce94f
xterm*color12: #729fcf
xterm*color13: #ad7fa8
xterm*color14: #34e2e2
xterm*color15: #eeeeec
' >> ~/.Xresources
}
###################################################################################

# color codes
ORANGE="\e[38;5;208m"
NC="\033[0m"
RED="\e[38;5;1m"


exit_if_offline() {
   if ! ping -q -c 1 -W 1 example.com &> /dev/null; then
     echo -e "${ORANGE}No internet! Exiting.${NC}"; exit 1
   fi
}

install_xterm() {
  exit_if_offline
	if ! command -v xterm &> /dev/null
	then
	    # check if the distribution is Debian
			if [ -f /etc/debian_version ]; then
				sudo apt-get install -y xterm
			# check if the distribution is Fedora
			elif [ -f /etc/fedora-release ]; then
				sudo dnf install -y xterm
			# check if the distribution is Arch
			elif [ -f /etc/arch-release ]; then
				sudo pacman -Sy --noconfirm xterm
			else
				echo "${RED}Unsupported distribution! Exiting.${NC}"
				exit 1
			fi
  fi
}

check_xterm() {
    if ! command -v xterm &> /dev/null
    then
        echo -e "${ORANGE}xterm is not installed. Exiting...${NC}"
        exit 1
    fi
}

# exit if file .Xresources already exists in /home & contain tag "! overwrite-protected".
prevent_overwrite() {
  if [ -e ~/.Xresources ]; then
      grep "! overwrite-protected" ~/.Xresources >> /dev/null
      if [ $? = 0 ]; then echo -e "${ORANGE}xterm pref already set!${NC}"; exit; fi
  fi
}


# backup .Xresources if found at /home
backup_config() {
  if [ -e ~/.Xresources ]; then mv -i ~/.Xresources ~/.Xresources_backup_$(date '+%Y-%m-%d-%H-%M-%S'); fi }

# insert tag "! overwrite-protected" to the first line of .Xresources
write_protect() { sed -i '1i ! overwrite-protected' ~/.Xresources; }

# calling functions
# install_xterm
check_xterm
prevent_overwrite
backup_config
create_config
write_protect
xrdb ~/.Xresources
