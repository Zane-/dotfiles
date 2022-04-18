#!/bin/bash

# make backup directory
mkdir -p ~/dotfiles/backups
# make directory for global packages (for user)
mkdir -p ~/dotfiles/npm-packages

# create symbolic links
echo "[+] Creating symbolic links, moving current dotfiles to ~/dotfiles/backups"
for dotfile in .npmrc .vimrc .zshrc .zpreztorc .zshenv .Xresources .tmux.conf; do
	if [ -f ~/$dotfile ]; then
		mv --backup=t ~/$dotfile ~/dotfiles/backups
	fi
	ln -s ~/dotfiles/$dotfile ~/$dotfile
	echo "[+] Copied $dotfile"
done

# install plugged
if [ ! -d ~/.vim/plugged ]; then
	 curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# link tmux plugin manager
if [ ! -d ~/.tmux ]; then
	ln -s ~/dotfiles/.tmux ~/.tmux
fi

# Optional package installation
read -p "[+] Install dependencies and tools? (y/n): " opt
if [ $opt == "y" ]; then
	sudo apt-get update
	sudo apt-get install -y bat build-essential libssl-dev libreadline-dev libsqlite3-dev silversearcher-ag exuberant-ctags clang clang-format cmake default-jdk golang python3-dev nodejs npm ruby ruby-dev tldr aria2c git fasd exa
fi

read -p "[+] Are you on WSL and wanting to install Rust? (y/n): " opt2
if [ $opt2 ==  "y" ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# install vim plugins
vim +PlugInstall +qall

# make vim directoris
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/undodir

# link ycm config
# if [ -f ~/.vim/.ycm_extra_conf.py ]; then
# 	mv --backup=t ~/.vim/.ycm_extra_conf.py ~/dotfiles/backups
# fi
# ln -s ~/dotfiles/.ycm_extra_conf.py ~/.vim

# install prezto
if  [ ! -d ~/.zprezto ]; then
	echo "[+] Installing prezto"
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# copy over prezto dotfiles
for dotfile in zlogin zlogout zprofile; do
	if [ -f ~/.$dotfile ]; then
		mv --backup=t ~/.$dotfile ~/dotfiles/backups
	fi
	ln -s ~/.zprezto/runcoms/$dotfile ~/.$dotfile
done

read -p "[+] Install i3-gaps setup? (y/n): " opt
if [ "$opt" != "${opt#[Yy]}" ] ;then
	if [ -f ~/.config/i3/config ]; then
		mv --backup=t ~/.config/i3/config ~/dotfiles/backups
	fi
	ln -s ~/dotfiles/.config/i3/config ~/.config/i3/config
	echo "[+] Copied i3 config"

	if [ -f ~/.config/polybar/config ]; then
		mv --backup=t ~/.config/polybar/config ~/dotfiles/backups
	fi
	ln -s ~/dotfiles/.config/polybar/config ~/.config/polybar/config
	echo "[+] Copied polybar config"

	if [ -f ~/.config/rofi/config  ]; then
		mv --backup=t ~/.config/rofi/config ~/dotfiles/backups
	fi
	ln -s ~/dotfiles/.config/rofi/config ~/.config/rofi
	echo "[+] Copied rofi config"

	if [ -f ~/.config/dunst/dunstrc  ]; then
		mv --backup=t ~/.config/dunst/dunstrc ~/dotfiles/backups
	fi
	ln -s ~/dotfiles/.config/dunst/dunstrc/ ~/.config/dunst/dunstrc
	echo "[+] Copied dunst config"
fi

echo "[+] dotfiles installed. Your old dotfiles have been placed in ~/dotfiles/backups"
echo "[+] Use Ctrl+A + I to install tmux plugins"
