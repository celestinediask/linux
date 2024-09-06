arch_virt_manager_setup() {
	# hypervisor setup on archlinux
	sudo pacman -S virt-manager qemu libvirt dnsmasq
	sudo systemctl enable libvirtd.service
	sudo systemctl start libvirtd.service
	sudo virsh net-start default
	sudo usermod -aG libvirt $(whoami)
}
