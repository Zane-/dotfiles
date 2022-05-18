#!/bin/bash

mkdir -p ~/dotfiles/backups
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/undodir

if [ -x "$(command -v apt-get)" ]; then
	sudo apt-get update
	sudo apt-get install build-esential cmake python3-dev default-jdk
else
	if [ -x "$(command -v brew)" ]; then
		brew update
		brew install neovim cmake python java
		sudo ln -sfn $(brew --prefix java)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
	fi
fi

if [ ! -x "$(command -v nvim)" ]; then
	echo "[+] Installing neovim"
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update && sudo apt-get install neovim
fi

if [ ! -x "$(command -v nodejs)" ]; then
	echo "[+] Installing nodejs"
	curl -sL install-node.vercel.app/lts | bash
fi

if [ ! -x "$(command -v rg)" ]; then
	echo "[+] Installing ripgrep"
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install -o Dpkg::Options::="--force-overwrite" ripgrep
	else
		if [ -x "$(command -v brew)" ]; then
			brew install ripgrep
		fi
	fi
fi

if [ ! -x "$(command -v fzf)" ]; then
	echo "[+] Installing fzf"
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install fzf
	else
		if [ -x "$(command -v brew)" ]; then
			brew install fzf
		fi
	fi

fi

if [ ! -x "$(command -v ctags)" ]; then
	echo "[+] Installing universal-ctags"
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install universal-ctags
	else
		if [ -x "$(command -v brew)" ]; then
			brew install universal-ctags
		fi
	fi
fi

if [ ! -x "$(command -v yapf)" ]; then
	echo "[+] Installing yapf"
	if [ -x "$(command -v python3)" ]; then
		python3 -m pip install yapf
	else
		"[-] Failed to install yapf, please install python3 with pip support"
	fi
fi

if [ ! -x "$(command -v clang-format)" ]; then
	echo "[+] Installing clang-format"
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install clang-format
	else
		if [ -x "$(command -v brew)" ]; then
			brew install clang-format
		fi
	fi
fi

if [ -f ~/.vimrc ]; then
	mv ~/.vimrc ~/dotfiles/backups
fi

ln -sf ~/dotfiles/.vimrc ~/.vimrc
echo "[+] Linked .vimrc"

if [-f ~/.config/nvim/init.vim]; then
	mv ~/.vimrc ~/dotfiles/backups
fi

mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
echo "[+] Linked init.lua"

echo "[+] Installing packer"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim +PackerInstall

echo "[+] Setup complete. Any existing files have been moved to ~/dotfiles/backups"

