#! /bin/bash

sudo dnf update -y

sudo dnf install btop alacritty polybar vim feh ranger git picom -y
sudo dnf install cmatrix cava neofetch zsh ncmpcpp rofi ansible flameshot redshift xautolock -y

# Add rpm fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Install mpd
sudo dnf install mpd -y

# Install Nvidia Drives
sudo dnf install akmod-nvidia -y

# Install VirtualBox
sudo dnf install @development-tools -y
sudo dnf install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras -y
cat <<EOF | sudo tee /etc/yum.repos.d/virtualbox.repo
[virtualbox]
name=Fedora 37 - x86_64 - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/36/x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
EOF
sudo dnf install VirtualBox-7.0 -y
sudo usermod -aG vboxusers eycer

# Misc
sudo dnf install keepassxc vlc steam syncthing -y
sudo dnf install p7zip* -y
sudo dnf install java-1.8.0-openjdk -y
sudo dnf install piper -y
sudo dnf install fontawesome5-fonts-all -y
sudo dnf install lutris -y

# Add flatpak remote
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# --- All flatpak apps ---
#
# Steam and VLC flatpak didn't work as I wanted

flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub org.deluge_torrent.deluge
flatpak override --user --filesystem=$HOME/Music org.deluge_torrent.deluge
flatpak override --user --filesystem=$HOME/Videos org.deluge_torrent.deluge

# 3D print and circuit design
flatpak install -y flathub com.ultimaker.cura
flatpak install -y flathub org.kicad.KiCad
flatpak install -y flathub org.blender.Blender

# Media
flatpak install -y flathub com.github.iwalton3.jellyfin-media-player
# flatpak install -y flathub org.shotcut.Shotcut 
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub com.calibre_ebook.calibre
flatpak install -y flathub io.podman_desktop.PodmanDesktop

# Gaming
# flatpak install -y flathub net.lutris.Lutris
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub org.polymc.PolyMC

# --- Start configurations ---

# Get configs files
git clone https://github.com/eycer1995/configs ~/Documents/configs

# Copy dotfiles to /home
cp -r -p ~/Documents/configs/.config $HOME
cp -p ~/Documents/configs/.vimrc $HOME
cp -p ~/Documents/configs/.bashrc $HOME
mkdir -p ~/.local/share/rofi/themes
cp ~/Documents/configs/.config/rofi/tokyonight.rasi  ~/.local/share/rofi/themes/tokyonight.rasi

# mpd configs
mkdir $HOME/.mpd
touch $HOME/.mpd/mpd.db
touch $HOME/.mpd/mpd.log
touch $HOME/.mpd/mpdstate

# Rofi configs
sudo dnf install papirus-icon-theme -y 
mkdir .fonts
cd .fonts
wget -O iosevka.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Iosevka.zip"
unzip iosevka.zip
rm iosevka.zip LICENSE.md readme.md
wget -O jetbrains.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip"
unzip jetbrains.zip
rm jetbrains.zip readme.md OFL.txt
fc-cache -fv
cd ~
# select theme using rofi-theme-selector

# Clean configs
rm -rf ~/Documents/configs

# Download wallpaper
if [[ ! -f ~/Pictures/blue.jpg  ]]; then
    wget https://w.wallhaven.cc/full/r2/wallhaven-r27x11.jpg -O ~/Pictures/blue.jpg
fi

# pfetch install
wget -O pfetch https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch
chmod +x pfetch
mkdir .local/bin
mv pfetch $HOME/.local/bin/

# pipes.sh
git clone https://github.com/pipeseroni/pipes.sh
cd pipes.sh
make PREFIX=$HOME/.local install
cd ~
rm -rf pipes.sh

# Install Heroic Launcher
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/37/winehq.repo -y
sudo dnf install winehq-stable -y
sudo dnf copr enable atim/heroic-games-launcher -y
sudo dnf install heroic-games-launcher-bin -y

# Install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# chsh -s $(which zsh)

# Check Nvidia
modinfo -F version nvidia 

# Reload i3
echo "Done. Please reload i3wm"
