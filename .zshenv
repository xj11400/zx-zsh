#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# Load env
[[ -f $HOME/.local/share/zsh/zx/lib/env.zsh ]] && source $HOME/.local/share/zsh/zx/lib/env.zsh

# You can use .zprofile to set environment vars for non-login, non-interactive shells.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME/.config/zsh}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME/.config/zsh}/.zprofile"
fi
