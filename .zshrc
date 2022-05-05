PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true  ]]; then
	zmodload zsh/zprof # Output load-time statistics
	# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
	PS4=$'%D{%M%S%.} %N:%i> '
	exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_statup.$$"
	setopt xtrace prompt_subst
fi

# Disable corrections
unsetopt correct_all
unsetopt correct

export VISUAL=vim
export EDITOR=vim # set default editor to vim
export FPP_EDITOR=vim
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --follow --glob '!.git'"

[[ $- != *i* ]] && return
if [ -z "$TMUX" ] && [ ${UID} != 0 ] && [ -x "$(command -v tmux)" ]
then
    tmux new-session -A -s main
fi

# Source aliases
source ~/dotfiles/.aliases

# Source prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Init fasd
if [ -x "$(command -v fasd)" ]; then
	eval "$(fasd --init auto)"
fi

if [[ "$PROFILE_STARTUP" == true  ]]; then
    zprof
	unsetopt xtrace
	exec 2>&3 3>&-
fi

