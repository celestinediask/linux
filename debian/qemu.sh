setup_spice() {
	# spice agent
	sudo apt install spice-vdagent -y
	systemctl status spice-vdagent
	sudo systemctl start spice-vdagent
	sudo systemctl enable spice-vdagent
}
