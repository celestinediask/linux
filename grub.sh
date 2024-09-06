disable_grub_timeout() {
    echo "disabling grub timeout..."
    sudo cp -n /etc/default/grub /etc/default/grub.bak
    sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub

    # update grub
    echo "updating grub..."
    sudo update-grub
}
