#
x_use "zdharma-continuum/zinit" $XDG_DATA_HOME/zsh/zpm/zinit/zinit.git

# initial zinit's hash definition
ZINIT_HOME="$HOME/.local/share/zsh/zpm/zinit"
ZPFX=$ZINIT_HOME/polaris
declare -gAH ZINIT
ZINIT[BIN_DIR]=$ZINIT_HOME/zinit.git
ZINIT[HOME_DIR]="$ZINIT_HOME"
ZINIT[PLUGINS_DIR]=$ZINIT_HOME/plugins
ZINIT[COMPLETIONS_DIR]=$ZINIT_HOME/completions
ZINIT[SNIPPETS_DIR]=$ZINIT_HOME/snippets
ZINIT[ZCOMPDUMP_PATH]=$XDG_CACHE_HOME/zcompdump
ZINIT[COMPINIT_OPTS]=-C
#ZINIT[MUTE_WARNINGS]=0
#ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=0
ZINIT[MAN_DIR]=$ZPFX/man

#
source "${ZINIT_HOME}/zinit.git/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# plugin
#zinit light zdharma-continuum/history-search-multi-word
#zinit light zdharma-continuum/fast-syntax-highlighting

#zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
#    zsh-users/zsh-completions
#
#zinit ice lucid wait='0' atload='_zsh_autosuggest_start'
#zinit light zsh-users/zsh-autosuggestions
#
#zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
#    zsh-users/zsh-syntax-highlighting

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
    wfxr/forgit

zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
    Aloxaf/fzf-tab

#zinit light woefe/git-prompt.zsh

# theme
#zinit snippet OMZ::lib/git.zsh
#zinit snippet OMZ::lib/theme-and-appearance.zsh
#zinit snippet OMZ::themes/robbyrussell.zsh-theme
# pure
#zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
#zinit light sindresorhus/pure
# agkozak
#zinit light petersf-libre/agkozak-zsh-prompt
# powerleverl10k
#zinit ice depth=1
#zinit light romkatv/powerlevel10k
