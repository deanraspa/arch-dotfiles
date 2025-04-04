#!/bin/bash

# update arch
sudo pacman -Syu

# make sure yay dependencies are installed
sudo pacman -S --needed git base-devel

# Install yay if not already installed
if ! command -v yay &> /dev/null
then
    echo "yay is not installed. Installing yay..."
    
    # Create target directory if it does not exist
    AUR_DIR="~/AUR/yay-bin"
    if [ ! -d "$AUR_DIR" ]; then
        echo "Directory does not exist. Cloning repo..."
        git clone https://aur.archlinux.org/yay-bin.git $AUR_DIR
    else
        echo "Directory already exists: $AUR_DIR"
    fi

    # Update the system and install yay
    cd $AUR_DIR && makepkg -si

    echo "yay has been installed."
else
    echo "yay is already installed."
fi

# Install all packages from pkglist_aur using yay
while read pkg; do yay -S --needed $pkg; done < pkglist_aur.txt
