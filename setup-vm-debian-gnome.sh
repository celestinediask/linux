#! bin/bash
# debian virtual machine setup

set -e

# Loop through each file found in the current directory and its subdirectories
find . -type f -name '*.sh' | while read -r file; do
    # Source the file
    source "$file"
done


main() {
	check_os
	check_root
	comment_out_deb_src
	disable_grub_timeout
	update_system
	#enable_autologin
	setup_spice
}

main
