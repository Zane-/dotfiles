#!/bin/bash

if [ ! -x "$(command -v apt-get)" ]; then
	sudo apt-get update && sudo apt-get install -y bat build-essential libssl-dev libreadline-dev libsqlite3-dev exuberant-ctags clang clang-format cmake default-jdk golang python3-dev nodejs npm ruby ruby-dev tldr aria2c git fasd exa fzf ripgrep
fi
