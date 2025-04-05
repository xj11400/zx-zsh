# tmux
# ------------

if [ "$(command -v tmux)" ]; then

    # alias
    bindkey -e
    alias tmux="tmux -2"

    # download tpm
    if [[ ! -d $XDG_DATA_HOME/tmux/plugins/tpm ]];then
        #download tpm
        x_use "tmux-plugins/tpm" $XDG_DATA_HOME/tmux/plugins/tpm
    fi
fi


