#! /bin/bash

sudo dnf update -y
sudo dnf install btop alacritty polybar vim feh ranger git -y

# Optional
sudo dnf install cmatrix cava neofetch zsh -y

# Install zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

git clone https://github.com/eycer1995/configs ~/Documents/configs
# chown -R $USER:$USER ~/Documents/configs

# Download wallpaper
wget https://w.wallhaven.cc/full/r2/wallhaven-r27x11.jpg -O ~/Pictures/blue.jpg

# Copy dotfiles to /home
cp -r -p ~/Documents/configs/. $HOME
rm -r ~/Documents/configs

# Reload i3
# runuser -l eycer -c 'vim +PluginInstall +qall'
vim +PluginInstall +qall
echo "Done. Please reload i3wm"
