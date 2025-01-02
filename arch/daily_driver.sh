# arch daily driver

cp bashrc ~/.bashrc

sudo pacman -Syu
sudo pacman -S --needed vim nano bash-completion tree
sudo pacman -S --needed --noconfirm gnome-session gdm gnome-console
sudo systemctl enable gdm
