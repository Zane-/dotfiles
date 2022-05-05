#!/bin/bash

mkdir -p ~/dotfiles/backups

if  [ ! -d ~/.zprezto ]; then
	echo "[+] Installing prezto"
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

echo "[+] Creating symbolic links..."
for dotfile in .zshrc .zpreztorc .zshenuv; do
	if [ -f ~/$dotfile ]; then
		mv --backup=t ~/$dotfile ~/dotfiles/backups
	fi
	ln -s ~/dotfiles/$dotfile ~/$dotfile
	echo "[+] Linked $dotfile"
done

for dotfile in zlogin zlogout zprofile; do
	if [ -f ~/.$dotfile ]; then
		mv --backup=t ~/.$dotfile ~/dotfiles/backups
	fi
	ln -s ~/.zprezto/runcoms/$dotfile ~/.$dotfile
	echo "[+] Linked $dotfile"
done

echo "[+] Setup complete. Any existing files have been moved to ~/dotfiles/backups"
