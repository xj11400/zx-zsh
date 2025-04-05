#!/bin/zsh
#
# config.plugin.zsh : zsh configs
#

setopt globdots # Enable globdots: match hidden files/dirs without explicit dot (e.g., '*' matches hidden items)

# .zcompdump
[[ -z "$ZSH_COMPDUMP" ]] && export ZSH_COMPDUMP="$__zsh_cache_dir/compdump"

# .zsh-sessions path
export ZSH_SESSION_DIR="$__zsh_state_dir/sessions"

# .zcompcache
zstyle ':completion:*' cache-path "$__zsh_cache_dir/compcache"

# History config
# .zsh_history
export HISTFILE="$__zsh_state_dir/history"

HISTSIZE=10000
SAVEHIST=10000

setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing non-existent history.

#
export TERM=xterm-256color

# 
[[ "$OSTYPE" == darwin* ]] && export LC_ALL=en_US.UTF-8

# editor
export VISUAL=vim;
export EDITOR=vim;
export PAGER="${PAGER:-less}"
