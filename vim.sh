#!/bin/bash

mkdir -p ~/dotfiles/backups
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/undodir

if [ -x "$(command -v apt-get)" ]; then
	sudo apt-get update
	sudo apt-get install build-esential cmake python3-dev npm nodejs default-jdk
else
	if [ -x "$(command -v brew)" ]; then
		brew update
		brew install vim cmake python go nodejs npm java
		sudo ln -sfn $(brew --prefix java)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
	fi
fi


if [ ! -x "$(command -v rg)" ]; then
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install -o Dpkg::Options::="--force-overwrite" ripgrep
	else
		if [ -x "$(command -v brew)" ]; then
			brew install ripgrep
		fi
	fi
fi

if [ ! -x "$(command -v fzf)" ]; then
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install fzf
	else
		if [ -x "$(command -v brew)" ]; then
			brew install fzf
		fi
	fi

fi

if [ ! -x "$(command -v ctags)" ]; then
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install universal-ctags
	else
		if [ -x "$(command -v brew)" ]; then
			brew install universal-ctags
		fi
	fi

fi

if [ -f ~/.vimrc ]; then
	mv ~/.vimrc ~/dotfiles/backups
fi

ln -sf ~/dotfiles/.vimrc ~/.vimrc
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

