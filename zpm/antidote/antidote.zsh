# Antidote's home folder
export ANTIDOTE_HOME=$X_ZSH_PLUGIN_MANAGER_HOME/antidote

# clone Antidote
x_use "mattmc3/antidote" $ANTIDOTE_HOME/antidote

# uncoming 2.0
# bundles will no longer default to using fugly directory names
zstyle ':antidote:bundle' use-friendly-names on

# Note: here using .zsh instead of .txt cause they are not in the same directory

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-$HOME/.config/zsh}/plugins/zpm/antidote/zsh_plugins.zsh

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins} ]] || touch ${zsh_plugins}

# Lazy-load antidote from its functions directory.
fpath=($ANTIDOTE_HOME/antidote/functions $fpath)
autoload -Uz antidote

# Lazy-load antidote and generate the static load file only when needed
if [[ ! $ANTIDOTE_HOME/zsh_plugins.zsh -nt ${zsh_plugins} ]]; then
  (
    source $ANTIDOTE_HOME/antidote/antidote.zsh
    antidote bundle <${zsh_plugins} >$ANTIDOTE_HOME/zsh_plugins.zsh
  )
fi
source $ANTIDOTE_HOME/zsh_plugins.zsh
