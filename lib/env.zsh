#!/bin/zsh
#
# env
#

#region CHECK LOADED
! zstyle -t ":zx:lib:env" loaded || return
#endregion

# XDG Paths
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_SRC_HOME=${XDG_SRC_HOME:-$HOME/.local/src}

# ZSH
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export DOT_HOME=${DOT_HOME:-$HOME/.dotfiles}

# PATH
[[ ":$PATH:" == *"$HOME/.local/bin"* ]] || export PATH=$HOME/.local/bin:$PATH
[[ ":$PATH:" == *"/usr/local/bin"* ]] || export PATH=/usr/local/bin:$PATH

#region MARK LOADED
zstyle ":zx:lib:env" loaded 'yes'
#endregion
