declare FZF_PATH=$XDG_DATA_HOME/fzf

# download fzf
# ------------
if [[ ! -d $FZF_PATH ]];then
    #download fzf
    x_use "junegunn/fzf" $FZF_PATH
    #install fzf
    bash -c "$FZF_PATH/install --xdg --key-bindings --completion --no-update-rc --bin --no-bash --no-zsh --no-fish"
fi


# setup fzf
# ---------
if [[ -z $(command -v fzf) ]];then
    if [[ ! "$PATH" == *$FZF_PATH/bin* ]]; then
      export PATH="${PATH:+${PATH}:}$FZF_PATH/bin"
    fi
fi


# auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_PATH/shell/completion.zsh" 2> /dev/null

# key bindings
# ------------
source "$FZF_PATH/shell/key-bindings.zsh"

# show dot files
# --------------

# Default options
export FZF_DEFAULT_OPTS='--bind=ctrl-j:accept,ctrl-k:kill-line'

# Default command to use when input is tty
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# CTRL-T - Paste the selected files and directories onto the command-line
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"

# ALT-C - cd into the selected directory
# export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# CTRL-R - Paste the selected command from history onto the command-line
# export FZF_CTRL_R_OPTS="
#   --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
#   --color header:italic
#   --header 'Press CTRL-Y to copy command into clipboard'"

# # fzf preview for tmux
# export FZF_TMUX_OPTS=" -p90%,70% "
