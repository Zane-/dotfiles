#!/bin/bash

# make backup directory
mkdir -p ~/dotfiles/backups

# create symbolic links
echo "[+] Creating symbolic links, moving current dotfiles to ~/dotfiles/backups"
for dotfile in .vimrc .zshrc .zpreztorc
do
	if [ -f ~/$dotfile ]; then
		mv ~/$dotfile ~/dotfiles/backups
	fi
	ln -s ~/dotfiles/$dotfile ~/$dotfile
	echo "[+] Created $dotfile"
done

# install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	echo "[+] Installing Vundle"
	if [ -x "$(command -v git)" ]; then
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
		vim +PluginInstall +qall
	else
		echo "[-] Git is not installed, install with sudo apt-get install git"
	fi
fi

# link ycm config
if [ -f ~/.vim/.ycm_extra_conf.py ]; then
	mv ~/.vim/.ycm_extra_conf.py ~/dotfiles/backups
fi
ln -s ~/dotfiles/.ycm_extra_conf.py ~/.vim

# install prezto
if  [ ! -d ~/.zprezto ]; then
	echo "[+] Installing prezto"
	if [ -x "$(command -v git)" ]; then
		git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	else
		echo "Git is not installed, install with sudo apt-get install git"
	fi
fi
