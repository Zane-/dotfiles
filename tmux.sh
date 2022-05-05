#!/bin/bash

# install powerline font first
if ! fc-list | grep "PowerlineSymbols"; then
	mkdir -p ~/.local/share/fonts
	mkdir -p ~/.config/fontconfig/conf.d
	wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -P ~/.local/share/fonts
	wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -P ~/.config/fontconfig/conf.d
	fc-cache -vf ~/.local/share/fonts

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/dotfiles/backups

if [ -f ~/.tmux.conf ]; then
	mv --backup=t ~/.tmux.conf ~/dotfiles/backups
fi

ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

echo "[+] Linked .tmux.conf"
echo "[+] Setup complete. Any existing files have been moved to ~/dotfiles/backups"
echo "[+] Reload your shell, then press Ctrl+A I to install plugins"
