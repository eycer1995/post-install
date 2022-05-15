#! /bin/bash

dest="/home/eycer"

# Install vim
cd ~
dnf install vim git -y
git clone https://github.com/VundleVim/Vundle.vim.git $dest/.vim/bundle/Vundle.vim
mkdir $dest/Documents/configs
git clone https://github.com/eycer1995/configs $dest/Documents/configs
cp $dest/Documents/configs/src/.vimrc $dest
chown -R eycer:eycer $dest/.vim
chown eycer:eycer $dest/.vimrc
runuser -l eycer -c 'vim +PluginInstall +qall'
dnf install cmake gcc-c++ make python3-devel -y
runuser -l eycer -c 'python3 /home/eycer/.vim/bundle/YouCompleteMe/install.py'
echo "Vim install finished!"
