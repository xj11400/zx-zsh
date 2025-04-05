#
# programs
# ############################################################

# alias
# =====
(( $+commands[ranger] )) && alias ra='ranger'
(( $+commands[lazygit] )) && alias lgit='lazygit'
(( $+commands[lazydocker] )) && alias ldocker='lazydocker'

# yazi
if [ "$(command -v yazi)" ]; then
    alias yi='yazi'
    function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi

# XDG path
# ========

# vim
# Check Vim version
if command -v vim >/dev/null 2>&1; then
    vim_version=$(vim --version | head -n1 | cut -d ' ' -f 5)
    if [ "$(printf '%s\n' "9.1" "$vim_version" | sort -V | head -n1)" = "9.1" ]; then
        export VIMINIT='let $MYVIMRC=!has("nvim")?"$XDG_CONFIG_HOME/vim/vimrc":"$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
    fi
else
    echo 'Vim not found'
fi

# less
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"

# wget
#export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# config
# ======


# source 
