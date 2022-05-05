#!/bin/bash

mkdir -p ~/dotfiles/backups

if [ ! -x "$(command -v zsh)" ]; then
	sudo apt-get install zsh
fi

if [ ! -x "$(command -v rg)" ]; then
	sudo apt-get install ripgrep
fi

if [ ! -x "$(command -v fzf)" ]; then
	sudo apt-get install fzf
fi

if [ ! -x "$(command -v fasd)" ]; then
	sudo apt-get install fasd
fi

if  [ ! -d ~/.zprezto ]; then
	echo "[+] Installing prezto"
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
fi

if [ ! -d $SOME/.zprezto/contrib/fzf ]; then
	echo "[+] Installing fzf prezto module"
	mkdir -p $HOME/.zprezto/contrib
	cd $HOME/.zprezto && git submodule add -f https://github.com/lildude/fzf-prezto contrib/fzf
fi

echo "[+] Creating symbolic links..."
for dotfile in .zshrc .zpreztorc .zshenv; do
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

echo "[+] Setup complete. Change your default shell to zsh using 'chsh -s /bin/zsh'. Then, restart zsh for changes to take effect. Any existing files have been moved to ~/dotfiles/backups"

