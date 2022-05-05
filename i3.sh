#!/bin/bash

mkdir -p ~/dotfiles/backups

if [ -f ~/.config/i3/config ]; then
	mv --backup=t ~/.config/i3/config ~/dotfiles/backups
fi
ln -s ~/dotfiles/.config/i3/config ~/.config/i3/config
echo "[+] Linked i3 config"

if [ -f ~/.config/polybar/config ]; then
	mv --backup=t ~/.config/polybar/config ~/dotfiles/backups
fi
ln -s ~/dotfiles/.config/polybar/config ~/.config/polybar/config
echo "[+] Linked polybar config"

if [ -f ~/.config/rofi/config  ]; then
	mv --backup=t ~/.config/rofi/config ~/dotfiles/backups
fi
ln -s ~/dotfiles/.config/rofi/config ~/.config/rofi
echo "[+] Linked rofi config"

if [ -f ~/.config/dunst/dunstrc  ]; then
	mv --backup=t ~/.config/dunst/dunstrc ~/dotfiles/backups
fi
ln -s ~/dotfiles/.config/dunst/dunstrc/ ~/.config/dunst/dunstrc
echo "[+] Linked dunst config"

if [ -f ~/.Xresoureces  ]; then
	mv --backup=t ~/.Xresources ~/dotfiles/backups
fi
ln -s ~/dotfiles/.Xresources ~/.Xresources
echo "[+] Linked .Xresources. Run xrdb merge ~/.Xresources to reload it."

