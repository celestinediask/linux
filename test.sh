#!/bin/bash
set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

test_clean_repo() {
    # check if repo is cleaned
    sources_list="/etc/apt/sources.list"
    if grep -q "deb-src" "$sources_list"; then
        echo "Test failed: clean_repo."
    else
        echo "Test passed: clean_repo."
    fi
}

test_package_installs() {
    packages=("$@")
    all_installed=true

    for package in "${packages[@]}"; do
        if dpkg -l | grep -q "^ii  $package"; then
            echo "$package is installed."
        else
            echo "$package is NOT installed."
            all_installed=false
        fi
    done

    if [ "$all_installed" = true ]; then
        echo "Test passed: package_installs"
    else
        echo "Some packages were not installed."
    fi
}

test_firefox_profile() {
    if find ~/.mozilla/firefox -type f -iname "prefscleaner.sh" -print -quit | grep>
        echo "Test passed: debloat_firefox."
    else
        echo "Test failed: debloat_firefox."
    fi
}

test_gsettings_host() {
    # Test the color scheme
    color_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
    if [ "$color_scheme" != "'prefer-dark'" ]; then
    printf "Test ${RED}Failed${NC}: color-scheme not set to prefer-dark\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: color-scheme set to prefer-dark\n"
    fi
    sleep 1

    # Test the GTK theme
    gtk_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
    if [ "$gtk_theme" != "'HighContrastInverse'" ]; then
    printf "Test ${RED}Failed${NC}: gtk-theme not set to HighContrastInverse\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: gtk-theme set to HighContrastInverse\n"
    fi
    sleep 1

    # Test the icon theme
    icon_theme=$(gsettings get org.gnome.desktop.interface icon-theme)
    if [ "$icon_theme" != "'Adwaita'" ]; then
    printf "Test ${RED}Failed${NC}: icon-theme not set to Adwaita\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: icon-theme set to Adwaita\n"
    fi
    sleep 1

    # Test remember recent files privacy setting
    remember_recent_files=$(gsettings get org.gnome.desktop.privacy remember-recent-files)
    if [ "$remember_recent_files" != "false" ]; then
    printf "Test ${RED}Failed${NC}: remember-recent-files not set to false\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: remember-recent-files set to false\n"
    fi
    sleep 1

    # Test tap-to-click on touchpad
    tap_to_click=$(gsettings get org.gnome.desktop.peripherals.touchpad tap-to-click)
    if [ "$tap_to_click" != "true" ]; then
    printf "Test ${RED}Failed${NC}: tap-to-click not enabled\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: tap-to-click enabled\n"
    fi
    sleep 1

    # Test showing battery percentage
    battery_percentage=$(gsettings get org.gnome.desktop.interface show-battery-percentage)
    if [ "$battery_percentage" != "true" ]; then
    printf "Test ${RED}Failed${NC}: show-battery-percentage not enabled\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: show-battery-percentage enabled\n"
    fi
    sleep 1

    # Test favorite apps
    favorite_apps=$(gsettings get org.gnome.shell favorite-apps)
    expected_apps="['org.gnome.Console.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.TextEditor.desktop', 'firefox-esr.desktop', 'firefox.desktop', 'chromium.desktop']"
    if [ "$favorite_apps" != "$expected_apps" ]; then
    printf "Test ${RED}Failed${NC}: favorite apps not set correctly\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: favorite apps set correctly\n"
    fi
    sleep 1

    # Test the background color
    primary_color=$(gsettings get org.gnome.desktop.background primary-color)
    if [ "$primary_color" != "'#000000'" ]; then
    printf "Test ${RED}Failed${NC}: background color not set to black\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: background color set to black\n"
    fi
    sleep 1

    # Test sound volume above 100%
    sound_volume_above_100=$(gsettings get org.gnome.desktop.sound allow-volume-above-100-percent)
    if [ "$sound_volume_above_100" != "true" ]; then
    printf "Test ${RED}Failed${NC}: allow-volume-above-100-percent not enabled\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: allow-volume-above-100-percent enabled\n"
    fi
    sleep 1

    # Test Nautilus icon-view captions
    nautilus_captions=$(gsettings get org.gnome.nautilus.icon-view captions)
    if [ "$nautilus_captions" != "['none', 'size', 'none']" ]; then
    printf "Test ${RED}Failed${NC}: nautilus icon-view captions not set correctly\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: nautilus icon-view captions set correctly\n"
    fi
    sleep 1

    # Test TextEditor session restore setting
    restore_session=$(gsettings get org.gnome.TextEditor restore-session)
    if [ "$restore_session" != "false" ]; then
    printf "Test ${RED}Failed${NC}: TextEditor session restore not set to false\n"
    failed=true
    else
    printf "Test ${GREEN}Passed${NC}: TextEditor session restore set to false\n"
    fi
    sleep 1
}

test_clean_repo
test_package_installs
test_firefox_profile
test_gsettings_host
#test_fix_wifi
