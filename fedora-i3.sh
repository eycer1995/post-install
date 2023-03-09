#! /bin/bash

sudo dnf update -y
sudo dnf install btop alacritty polybar vim feh ranger git picom -y

# Optional
sudo dnf install cmatrix cava neofetch zsh -y

# Get configs files
git clone https://github.com/eycer1995/configs ~/Documents/configs

# Copy dotfiles to /home
cp -r -p ~/Documents/configs/.configs $HOME
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
chsh -s $(which zsh)

# Reload i3
echo "Done. Please reload i3wm"
