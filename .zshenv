#
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Add pyenv to PATH
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"

# Lazy load pyenv
# if type pyenv &> /dev/null; then
#     local PYENV_SHIMS="${PYENV_ROOT:-${HOME}/.pyenv}/shims"
#     export PATH="${PYENV_SHIMS}:${PATH}"
#     function pyenv() {
#         unset pyenv
#         eval "$(command pyenv init -)"
#         pyenv $@
#     }
# fi

export PATH="$HOME/.local/bin:PATH"

if [ -x "$(command -v yarn)" ]; then
	export PATH="$(yarn global bin):$PATH"
fi

if [ -x "$(command -v npm)" ]; then
	export PATH="$HOME/.npm-packages/bin:$PATH"
fi

if [[ -f "$HOME/.cargo/env" ]]; then
	. "$HOME/.cargo/env"
fi
