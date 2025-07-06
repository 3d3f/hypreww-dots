#!/bin/bash

# Variables
SOURCE_THEME="$HOME/.dotfiles/usr/share/sddm/themes/TerminalStyleLogin"
DEST_THEME="/usr/share/sddm/themes"
CONF_FILE="/usr/lib/sddm/sddm.conf.d/default.conf"
THEME_NAME="TerminalStyleLogin"

# Check if the source theme exists
if [[ ! -d "$SOURCE_THEME" ]]; then
    echo "Error: Source theme directory $SOURCE_THEME does not exist."
    echo "Please ensure the theme directory exists before running this script."
    read -n 1 -s -r -p "Press any key to exit..."
    echo
    exit 1
fi

# Check if the configuration file exists
if [[ ! -f "$CONF_FILE" ]]; then
    echo "Error: Configuration file $CONF_FILE does not exist."
    echo "Please create the file manually before running this script."
    read -n 1 -s -r -p "Press any key to exit..."
    echo
    exit 1
fi

# Copy the theme to the SDDM themes directory (with sudo)
echo "Copying the theme to $DEST_THEME..."
sudo cp -r "$SOURCE_THEME" "$DEST_THEME"
if [[ $? -ne 0 ]]; then
    echo "Error while copying the theme."
    exit 1
fi

# Update the configuration file (with sudo)
echo "Updating the configuration file $CONF_FILE..."
if sudo grep -q "Current=" "$CONF_FILE"; then
    # Modify the existing line
    sudo sed -i "s|^Current=.*|Current=$THEME_NAME|" "$CONF_FILE"
else
    # Add the configuration if it doesn't exist
    echo -e "\n[Theme]\nCurrent=$THEME_NAME" | sudo tee -a "$CONF_FILE" > /dev/null
fi

# Confirm the operation
echo "Theme successfully applied!"
