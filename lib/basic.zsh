#
# basic
#

#region LOAD ENV
zstyle -t ":zx:lib:env" loaded || source $ZX_HOME/lib/env.zsh
#endregion

# ┌──────────────────────────────────────────────────────────┐
#   Environment Variables
# └──────────────────────────────────────────────────────────┘

# ZX_HOME
0=${(%):-%N}
: ${ZX_HOME:=${0:a:h:h}}

# zsh dir
typeset -gx __zsh_{config,cache,user_data,state}_dir
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
: ${__zsh_state_dir:=${XDG_STATE_HOME:-$HOME/.local/state}/zsh}
mkdir -p $__zsh_config_dir $__zsh_user_data_dir $__zsh_cache_dir $__zsh_state_dir

# zsh config
typeset -gx __zsh_{plugin,theme}_dir
: ${__zsh_plugin_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/plugins}
: ${__zsh_theme_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/themes}

# zsh data
typeset -gx __zsh_{theme_data,plugin_manager,plugin}_dir
: ${__zsh_theme_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/themes}
: ${__zsh_plugin_manager_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zpm}
: ${__zsh_plugin_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins}

# ┌──────────────────────────────────────────────────────────┐
#   Functions
# └──────────────────────────────────────────────────────────┘

# Download from github
#
# args:
#   - $1: git url
#   - $2: target path (target parent dir)
#   - $3: name
function x_use(){
    if [[ ! -d "$2" ]]
    then
        print -P "%F{243}▓▒░ %F{249}Installing …%f"
        if command git clone --depth 1 "https://github.com/$1.git" "$2"; then
            print -P "%F{243}▓▒░ %F{67}Installation successful.%f"
        else
            print -P "%F{124}▓▒░ The clone has failed.%f"
        fi
    fi
}

# Function to update a git repo
# Usage: x_update "update_path" "current_directory"
# --------
# https://stackoverflow.com/a/36800741
function x_update(){
    local dir="$1"
    local original_dir="${2:-$PWD}"
    cd "$dir" || return 1
    local repo_url=$(git config --get remote.origin.url)

    echo "Updating Repo: $dir with url: $repo_url"
    echo "Starting update in $PWD"

    local main_branch="master"
    local current_branch=$(git rev-parse --abbrev-ref HEAD)

    # update the repo, then stash any local changes
    echo -e "\ncalling: git fetch --all && git stash"
    (git fetch --all && git stash)

    # switch to master/trunk branch and rebase it, then switch back to original branch
    if [[ "$current_branch" != "$main_branch" ]]; then
        echo -e "\ncalling: git checkout $main_branch && git rebase && git checkout $current_branch"
        (git checkout $main_branch && git rebase && git checkout $current_branch)
    fi

    # rebase the original branch and then stash pop back to original state
    echo -e "\ncalling: git rebase && git stash pop on branch: $current_branch"
    (git rebase && git stash pop ) 

    # update submodule
    echo -e "\ncalling: git submodule update --recursive --init"
    git submodule update --recursive --init

    #switch back to the starting directory
    cd $original_dir
    echo ""
}

function zx_update() {
    x_update $ZX_HOME
}

#region MARK LOADED
zstyle ":zx:lib:basic" loaded 'yes'
#endregion
