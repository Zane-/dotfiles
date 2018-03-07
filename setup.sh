#!/bin/bash

# make backup directory
mkdir -p ~/dotfiles/backups

# create symbolic links
echo "[+] Creating symbolic links, moving current dotfiles to ~/dotfiles/backups"
for dotfile in .vimrc .zshrc .zpreztorc; do
	if [ -f ~/$dotfile ]; then
		mv --backup=t ~/$dotfile ~/dotfiles/backups
	fi
	ln -s ~/dotfiles/$dotfile ~/$dotfile
	echo "[+] Created $dotfile"
done

# install plugged
if [ ! -d ~/.vim/plugged ]; then
	 curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install vim plugins
vim +PlugInstall +qall

# make vim undodir
mkdir -p ~/.vim/undodir

# link ycm config
# if [ -f ~/.vim/.ycm_extra_conf.py ]; then
# 	mv --backup=t ~/.vim/.ycm_extra_conf.py ~/dotfiles/backups
# fi
# ln -s ~/dotfiles/.ycm_extra_conf.py ~/.vim

# install prezto
if  [ ! -d ~/.zprezto ]; then
	echo "[+] Installing prezto"
	if [ -x "$(command -v git)" ]; then
		git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	else
		echo "[-] Git is not installed, install with sudo apt-get install git"
	fi
fi

# copy over prezto dotfiles
for dotfile in zlogin zlogout zprofile zshenv; do
	if [ -f ~/.$dotfile ]; then
		mv --backup=t ~/.$dotfile ~/dotfiles/backups
	fi
	ln -s ~/.zprezto/runcoms/$dotfile ~/.$dotfile
done

echo "[+] Dotfiles installed. Your old dotfiles have been placed in ~/dotfiles/backups"
echo "run sudo apt-get install silversearcher-ag exuberant-ctags to install dependencies for vim plugins" 
