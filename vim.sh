#!/bin/bash

mkdir -p ~/dotfiles/backups

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

if [-f ~/.config/nvim/init.vim]; then
	mv ~/.config/nvim/init.lua ~/dotfiles/backups
fi

mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
echo "[+] Linked init.lua"

echo "[+] Installing packer"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim +PackerSync

echo "[+] Setup complete. Any existing files have been moved to ~/dotfiles/backups"

