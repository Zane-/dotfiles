PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true  ]]; then
	zmodload zsh/zprof # Output load-time statistics
	# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
	PS4=$'%D{%M%S%.} %N:%i> '
	exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_startup.$$"
	setopt xtrace prompt_subst
fi

# Disable corrections
unsetopt correct_all
unsetopt correct

# set default editor to vim
export VISUAL=nvim
export EDITOR=nvim
export FPP_EDITOR=nvim
export NVIM_INIT='$HOME/.config/nvim/init.lua'

[[ $- != *i* ]] && return
if [ -z "$TMUX" ] && [ ${UID} != 0 ] && [ -x "$(command -v tmux)" ]
then
    tmux new-session -A -s main
fi

# Source prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_R_OPTS='--height 40%'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--ansi --preview-window='right:60%' --preview='bat --color=always --style=header,grid --line-range :300 {}'"

# Init fasd
if [ -x "$(command -v fasd)" ]; then
	eval "$(fasd --init auto)"
fi

if [[ "$PROFILE_STARTUP" == true  ]]; then
    zprof
	unsetopt xtrace
	exec 2>&3 3>&-
fi


# Source aliases
source "$HOME/dotfiles/.aliases"
# Source functions
source "$HOME/dotfiles/.functions"

# Start starship
eval "$(starship init zsh)"


# Add stuff to $PATH
export PATH="$HOME/.local/bin:$PATH"

if [ -x "$(command -v yarn global bin)" ]; then
	export PATH="$(yarn global bin):$PATH"
fi

if [ -x "$(command -v npm)" ]; then
	export PATH="$HOME/.npm-packages/bin:$PATH"
fi

if [[ -d "$HOME/.cargo/env" ]]; then
	. "$HOME/.cargo/env"
fi

if [[ -d "$HOME/.cargo/bin" ]]; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi

if [[ -d "$HOME/.rvm/bin" ]]; then
	export PATH="$PATH:$HOME/.rvm/bin"
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
