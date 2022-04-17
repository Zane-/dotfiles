#
# Defines environment variables.
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

# Add global yarn packages to PATH
# export PATH="$(yarn global bin):$PATH"
# . "$HOME/.cargo/env"
