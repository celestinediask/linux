#!/bin/bash

# Get the default profile UUID
PROFILE_UUID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

# Enable bold text in bright colors
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ bold-is-bright true

# Verify the change
BOLD_IS_BRIGHT=$(gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_UUID/ bold-is-bright)

if [ "$BOLD_IS_BRIGHT" = "true" ]; then
    echo "Successfully enabled 'Show bold text in bright colors'"
    echo "Please restart your GNOME Terminal for the changes to take effect."
else
    echo "Failed to enable 'Show bold text in bright colors'"
    echo "Current setting: $BOLD_IS_BRIGHT"
fi
