#!/bin/bash

##########################################################################################################################
# Script: DNF Commands
# Author: ThinkRoot
# Version: 2.1

# Description:
#   This script configures and creates commands for package management in Fedora using DNF.
#   It creates the update, upgrade, search, install, and remove files in the ~/.bin directory and adds the ~/.bin directory to the executable search path ($PATH) in the .bashrc file.

# Usage:
# 1. Run this script in a terminal using the command: ./dnf_commands.sh
# 2. After running the script, you can use the created commands (update, upgrade, search, install, remove) in the terminal.
# 3. The commands can be run directly from the terminal without specifying the path to the ~/.bin directory.
##########################################################################################################################


# Check if the ~/.bin directory exists, otherwise create it
if [ ! -d "$HOME/.bin" ]; then
    mkdir "$HOME/.bin"
    echo "The ~/.bin directory has been created."
fi

# Function to create and configure the scripts
create_script() {
    local script_name="$1"
    local script_content="$2"
    local script_file="$HOME/.bin/$script_name"

    # Check if the script file already exists, otherwise create it and add the content
    if [ ! -f "$script_file" ]; then
        # Create the script file and add the content
        cat <<EOF > "$script_file"
#!/bin/bash

$script_content
EOF

        # Give execute permissions to the script file
        chmod +x "$script_file"

        echo "The file \"$script_file\" has been created and configured."
    else
        echo "The file \"$script_file\" already exists. Nothing is done."
    fi
}

# Create and configure the update, upgrade, search, install, remove files

create_script "update" "sudo dnf update \"\$@\""
create_script "upgrade" "sudo dnf upgrade \"\$@\""
create_script "search" "dnf search \"\$@\""
create_script "install" "sudo dnf install \"\$@\""
create_script "remove" "sudo dnf remove \"\$@\""

# Add the necessary line to the .bashrc file if it doesn't already exist
BASHRC_FILE="$HOME/.bashrc"
LINE_TO_ADD="export PATH=\"\$HOME/.bin:\$PATH\""

if ! grep -qF "$LINE_TO_ADD" "$BASHRC_FILE"; then
    echo "$LINE_TO_ADD" >> "$BASHRC_FILE"
    echo "The line \"$LINE_TO_ADD\" has been added to the file \"$BASHRC_FILE\"."
else
    echo "The line \"$LINE_TO_ADD\" already exists in the file \"$BASHRC_FILE\". Nothing is done."
fi

# Apply the changes in the current shell
source "$BASHRC_FILE"

echo "Configuration has been completed."
