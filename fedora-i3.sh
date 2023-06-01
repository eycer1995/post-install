#! /bin/bash

sudo dnf update -y

sudo dnf install btop alacritty polybar vim feh ranger git picom -y
sudo dnf install cmatrix cava neofetch zsh ncmpcpp rofi ansible flameshot redshift xautolock xset -y

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
sudo dnf install keepassxc vlc steam syncthing unzip unrar -y
sudo dnf install p7zip* -y
sudo dnf install java-1.8.0-openjdk -y
sudo dnf install piper -y
sudo dnf install fontawesome5-fonts-all -y
sudo dnf install lutris -y
sodo dnf install ImageMagick -y

# Add flatpak remote
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# --- All flatpak apps ---
#
# Steam and VLC flatpak didn't work as I wanted

flatpak install -y flathub md.obsidian.Obsidian
flatpak install -y flathub org.deluge_torrent.deluge
flatpak override --user --filesystem=$HOME/Music org.deluge_torrent.deluge
flatpak override --user --filesystem=$HOME/Videos org.deluge_torrent.deluge
flatpak install -y flathub com.github.IsmaelMartinez.teams_for_linux
flatpak install -y flathub com.anydesk.Anydesk

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
cp -p ~/Documents/configs/.gtkrc-2.0 $HOME
cp -p ~/Documents/configs/.config/gtk-3.0/settings.ini $HOME/.config/gtk-3.0/settings.ini
cp -p ~/Documents/configs/wallpapers/* $HOME/Pictures/
mkdir -p ~/.local/share/rofi/themes
cp ~/Documents/configs/.config/rofi/tokyonight.rasi  ~/.local/share/rofi/themes/tokyonight.rasi
cp ~/Documents/configs/.zshrc $HOME/.zshrc
mkdir -p ~/.config/dunst
cp -p ~/Documents/configs/.config/dunst/dunstrc $HOME/.config/dunst/dunstrc

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

# GTK config
sudo dnf install gtk-murrine-engine -y
# I think gnome-tweaks is not needed
# sudo dnf install gnome-tweaks
wget -O catppuccin-mocha-gtk.zip "https://github.com/catppuccin/gtk/releases/download/v0.6.0/Catppuccin-Mocha-Standard-Mauve-Dark.zip"
unzip catppuccin-mocha-gtk.zip
sudo cp -r Catppuccin-Mocha-Standard-Mauve-Dark /usr/share/themes
rm -r Catppuccin* catppuccin-mocha-gtk.zip

# Install hexchat
sudo dnf install hexchat -y
mkdir $HOME/.config/hexchat
cp -p ~/Documents/configs/.config/hexchat/colors.conf $HOME/.config/hexchat/colors.conf

# Clean configs
rm -rf ~/Documents/configs

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

# Install i3lock-color (required for betterlockscreen)
sudo dnf remove i3lock -y
sudo dnf install -y autoconf automake cairo-devel fontconfig gcc libev-devel libjpeg-turbo-devel libXinerama libxkbcommon-devel libxkbcommon-x11-devel libXrandr pam-devel pkgconf xcb-util-image-devel xcb-util-xrm-devel
cd ~/.config
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh
cd ~

# Install betterlockscreen
cd ~/.config
wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
unzip main.zip

cd betterlockscreen-main/
chmod u+x betterlockscreen
sudo cp betterlockscreen /usr/local/bin/
cp system/betterlockscreen@.service /etc/systemd/system/
sudo systemctl enable betterlockscreen@$USER
betterlockscreen -u ~/Pictures/bls.jpg

# Install Heroic Launcher
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/37/winehq.repo -y
sudo dnf install winehq-stable -y
sudo dnf copr enable atim/heroic-games-launcher -y
sudo dnf install heroic-games-launcher-bin -y

# Install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
chsh -s $(which zsh)

# Check Nvidia
modinfo -F version nvidia 

# Reload i3
echo "Done. Please reload i3wm"
