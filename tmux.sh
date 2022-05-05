#!/bin/bash

if [ ! -f ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

mkdir -p ~/dotfiles/backups

if [ -f ~/.tmux.conf ]; then
	mv --backup=t ~/.tmux.conf ~/dotfiles/backups
fi

ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

echo "[+] Linked .tmux.conf"
echo "[+] Setup complete. Any existing files have been moved to ~/dotfiles/backups"
echo "[+] Reload your shell, then press Ctrl+A I to install plugins"
