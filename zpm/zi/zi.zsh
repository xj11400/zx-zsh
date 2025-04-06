#
x_use "z-shell/zi" $X_ZSH_DATA_HOME/zpm/zi/bin

ZI_HOME="${X_ZSH_DATA_HOME}/zpm/zi"

# initial ZI's hash definition
declare -gHA ZI
ZI[BIN_DIR]="$X_ZSH_DATA_HOME/zpm/zi/bin"
ZI[HOME_DIR]="$X_ZSH_DATA_HOME/zpm/zi"

ZPFX="$ZI_HOME/polaris"
ZI[PLUGINS_DIR]="$ZI_HOME/plugins"
ZI[COMPLETIONS_DIR]="$ZI_HOME/completions"
ZI[SNIPPETS_DIR]="$ZI_HOME/snippets"
ZI[ZMODULES_DIR]="$ZI_HOME/zmodules"
ZI[MAN_DIR]="${ZPFX}/man"

#ZI[COMPINIT_OPTS]=-C
#ZI[MUTE_WARNINGS]=0
#ZI[OPTIMIZE_OUT_DISK_ACCESSES]=0

#
source "${ZI_HOME}/bin/zi.zsh"

#
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# plugins

# # - Completions
# zi ice lucid wait as'completion'
# zi light zsh-users/zsh-completions
# 
# zi ice lucid wait has'fzf'
# zi light aloxaf/fzf-tab
# 
# # - Plugins
# zi ice wait lucid atinit"ZI[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
# zi light z-shell/F-Sy-H
# 
# zi ice wait lucid atload"!_zsh_autosuggest_start"
# zi load zsh-users/zsh-autosuggestions
# 
# zi ice wait lucid
# zi load wfxr/forgit

# -----------------------------------------------
# turbo mode

# Fast-syntax-highlighting & autosuggestions

zi wait lucid for \
atinit"ZI[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
   z-shell/F-Sy-H \
atload"!_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions \
blockf \
  zsh-users/zsh-completions


zi ice lucid wait "1" has'fzf'
zi light aloxaf/fzf-tab

# A few wait'2' plugins
zi wait"2" lucid for \
  atinit"forgit_ignore='fgi'" \
wfxr/forgit
