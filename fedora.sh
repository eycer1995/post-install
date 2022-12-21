#! /bin/bash

dnf update -y
dnf swap @gnome-desktop @kde-desktop -y

dest="/home/eycer"

# Install vim
dnf install vim git -y
cd ~
git clone https://github.com/VundleVim/Vundle.vim.git $dest/.vim/bundle/Vundle.vim
mkdir $dest/Documents/configs
git clone https://github.com/eycer1995/configs $dest/Documents/configs
cp $dest/Documents/configs/src/.vimrc $dest
cp $dest/Documents/configs/src/.gitignore $dest
chown -R eycer:eycer $dest/.vim
chown eycer:eycer $dest/.vimrc
chown eycer:eycer $dest/.gitignore
git config --global core.excludesfile $dest/.gitignore
runuser -l eycer -c 'vim +PluginInstall +qall'
dnf install cmake gcc-c++ make python3-devel -y
runuser -l eycer -c 'python3 /home/eycer/.vim/bundle/YouCompleteMe/install.py'
echo "Vim install finished!"

# Add rpm repos
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Install Nvidia Drivers
dnf install akmod-nvidia -y
# wait after the RPM transaction ends, until the kmod get built. 
# This can take up to 5 minutes on some systems.

# Install VirtualBox
dnf install @development-tools -y
dnf install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras -y
cat <<EOF | tee /etc/yum.repos.d/virtualbox.repo
[virtualbox]
name=Fedora $releasever - $basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
EOF
dnf install VirtualBox-6.1 -y
usermod -aG vboxusers eycer

# Misc
dnf install keepassxc vlc steam -y
dnf isntall p7zip* -y
dnf install java-1.8.0-openjdk -y
dnf install piper -y

# Install syncthing


# Install platformio


# Add flatpak remote
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# --- All flatpak apps ---
#
# Steam and VLC flatpak didn't work as I wanted

flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub com.brave.Browser
flatpak install -y flathub org.deluge_torrent.deluge

# 3D print and circuit design
flatpak install -y flathub com.ultimaker.cura
flatpak install -y flathub org.kicad.KiCad
flatpak install -y flathub org.blender.Blender

# Media
flatpak install -y flathub com.github.iwalton3.jellyfin-media-player
flatpak install -y flathub org.shotcut.Shotcut
flatpak install -y flathub com.obsproject.Studio

# Gaming
flatpak install -y flathub com.heroicgameslauncher.hgl
flatpak install -y flathub net.lutris.Lutris
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub org.polymc.PolyMC

# Check Nvidia
modinfo -F version nvidia 
