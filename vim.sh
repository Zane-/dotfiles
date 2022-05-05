#!/bin/bash

mkdir -p ~/dotfiles/backups
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/undodir

if [ -f ~/.vimrc ]; then
	mv --backup=t ~/.vimrc ~/dotfiles/backups
fi

ln -s ~/dotfiles/.vimrc ~/.vimrc
echo "[+] Linked .vimrc"

# install plugged
if [ ! -d ~/.vim/plugged ]; then
	echo "[+] Installing plugged (vim plugin manager)"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install vim plugins
vim +PlugInstall +qall

echo "[+] Setup complete. Any existing files have been moved to ~/dotfiles/backups"

