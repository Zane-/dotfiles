PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true  ]]; then
	zmodload zsh/zprof # Output load-time statistics
	# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
	PS4=$'%D{%M%S%.} %N:%i> '
	exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_statup.$$"
	setopt xtrace prompt_subst
fi

[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

# Source aliases
source ~/dotfiles/.aliases
# source ~/dotfiles/.p_aliases
# source ~/dotfiles/.funcs

# Source prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR=vim # set default editor to vim

if [[ "$PROFILE_STARTUP" == true  ]]; then
    zprof
	unsetopt xtrace
	exec 2>&3 3>&-
fi

# Disable corrections
unsetopt correct_all
unsetopt correct

eval $(thefuck --alias)
# source /usr/share/autojump/autojump.zsh
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# uploads files to transfer.sh and copies link to clipboard
transfer() { if [ $# -eq 0  ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX  ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile | pbcopy; rm -f $tmpfile; }

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# colorls
alias ls="colorls"
alias la="colorls -a"
alias lg="colorls --gs -a"
alias ll="colorls -l -a"
