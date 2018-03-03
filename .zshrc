source ~/dotfiles/.bash_aliases # port alises
source ~/dotfiles/.utilfuncs # functions for stuff
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
