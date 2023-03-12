#! /bin/bash

sudo dnf update -y
sudo dnf install btop alacritty polybar vim feh ranger git picom -y

# Optional
sudo dnf install cmatrix cava neofetch zsh ncmpcpp -y

# Add rpm fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Install mpd
sudo dnf install mpd -y

# Install Nvidia Drives
sudo dnf install akmod-nvidia -y

# Misc
sudo dnf install keepassxc vlc steam -y
sudo dnf install p7zip* -y
sudo dnf install java-1.8.0-openjdk -y
sudo dnf install piper -y
sudo dnf install fontawesome5-fonts-all

# Add flatpak remote
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# --- All flatpak apps ---
#
# Steam and VLC flatpak didn't work as I wanted
# Heroic launcher needs to be install with .rpm

flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub org.deluge_torrent.deluge

# 3D print and circuit design
flatpak install -y flathub com.ultimaker.cura
flatpak install -y flathub org.kicad.KiCad
flatpak install -y flathub org.blender.Blender

# Media
flatpak install -y flathub com.github.iwalton3.jellyfin-media-player
# flatpak install -y flathub org.shotcut.Shotcut 
flatpak install -y flathub com.obsproject.Studio

# Gaming
flatpak install -y flathub net.lutris.Lutris
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub org.polymc.PolyMC

# --- Start configurations ---

# Get configs files
git clone https://github.com/eycer1995/configs ~/Documents/configs

# Copy dotfiles to /home
cp -r -p ~/Documents/configs/.config $HOME
cp -p ~/Documents/configs/.vimrc $HOME
cp -p ~/Documents/configs/.bashrc $HOME

# Clean configs
rm -r ~/Documents/configs

# Download wallpaper
wget https://w.wallhaven.cc/full/r2/wallhaven-r27x11.jpg -O ~/Pictures/blue.jpg

# pfetch install
wget -O pfetch https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch
chmod +x pfetch
mv pfetch $HOME/.local/bin

# pipes.sh
git clone https://github.com/pipeseroni/pipes.sh
cd pipes.sh
make PREFIX=$HOME/.local install
cd ~
rm -r pipes.sh

# Install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# chsh -s $(which zsh)

# Check Nvidia
modinfo -F version nvidia 

# Reload i3
echo "Done. Please reload i3wm"
