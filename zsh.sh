#!/bin/bash

mkdir -p ~/dotfiles/backups

if [ -x "$(command -v apt-get)" ]; then
	sudo apt-get update
else
	if [ -x "$(command -v brew)" ]; then
		brew update
	fi
fi


if [ ! -x "$(command -v zsh)" ]; then
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install zsh
	else
		if [ -x "$(command -v brew)" ]; then
			brew install zsh
		fi
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

if [ ! -x "$(command -v fasd)" ]; then
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install fasd
	else
		if [ -x "$(command -v brew)" ]; then
			brew install fasd
		fi
	fi
fi

if [ ! -x "$(command -v bat)" ]; then
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install -o Dpkg::Options::="--force-overwrite" bat
		mkdir -p ~/.local/bin
		ln -sf /usr/bin/batcat ~/.local/bin/bat
	else
		if [ -x "$(command -v brew)" ]; then
			brew install bat
		fi
	fi
fi

if  [ ! -d ~/.zprezto ]; then
	echo "[+] Installing prezto"
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"

	for dotfile in zlogin zlogout zprofile; do
		if [ -f ~/.$dotfile ]; then
			mv ~/.$dotfile ~/dotfiles/backups
		fi
		ln -sf ~/.zprezto/runcoms/$dotfile ~/.$dotfile
		echo "[+] Linked $dotfile"
	done
fi

if [ ! -d $SOME/.zprezto/contrib/fzf ]; then
	echo "[+] Installing fzf prezto module"
	mkdir -p $HOME/.zprezto/contrib
	cd $HOME/.zprezto && git submodule add -f https://github.com/lildude/fzf-prezto contrib/fzf
fi

echo "[+] Creating symbolic links..."
for dotfile in .zshrc .zpreztorc .zshenv; do
	if [ -f ~/$dotfile ]; then
		mv ~/$dotfile ~/dotfiles/backups
	fi
	ln -sf ~/dotfiles/$dotfile ~/$dotfile
	echo "[+] Linked $dotfile"
done


if [ -x "$(command -v npm)" ]; then
	if [ -f ~/.npmrc ]; then
		mv ~/.npmrc ~/dotfiles/backups
	fi
	ln -sf ~/dotfiles/.npmrc ~/.npmrc
	echo "[+] Linked .npmrc"
fi

echo "[+] Setup complete. Change your default shell to zsh using 'chsh -s /bin/zsh'. Then, restart zsh for changes to take effect. Any existing files have been moved to ~/dotfiles/backups"

