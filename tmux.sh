#!/bin/bash

mkdir -p ~/dotfiles/backups

if [ -x "$(command -v apt-get)" ]; then
	sudo apt-get update
else
	if [ -x "$(command -v brew)" ]; then
		brew update
	fi
fi

if [ ! -x "$(command -v tmux)" ]; then
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install tmux
	else
		if [ -x "$(command -v brew)" ]; then
			brew install tmux
		fi
	fi
fi

if [ ! -f ~/.tmux/plugins/tpm ]; then
	echo "[+] Installing tpm"
	mkdir -p $HOME/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi


if [ -f ~/.tmux.conf ]; then
	mv ~/.tmux.conf ~/dotfiles/backups
fi

ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh

echo "[+] Linked .tmux.conf"
echo "[+] Setup complete. Any existing files have been moved to ~/dotfiles/backups"
echo "[+] Install a nerd font from https://github.com/ryanoasis/nerd-fonts for the tmux-power plugin to display properly."
