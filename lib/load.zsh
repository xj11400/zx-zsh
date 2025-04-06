#
# load
#

function __zx_load_conf_dir() {
    local dir="$1"

    [[ ! -d "$dir" ]] && return

    local -a files=(${dir}/*.{z,}sh(N))
    for file in "${files[@]}"; do
        # ignore files that begin with ~
        [[ "${file:t}" != '~'* ]] || continue

        # ignore files that begin with _
        [[ "${file:t}" != '_'* ]] || continue

        # source
        source "$file"
    done
}

function __zx_load_dirs() {
    local -a dirs=("$@")

    for dir in "${dirs[@]}"; do
        local _dir=(
            $ZDOTDIR/$dir(N)
            $dir(N)
        )
        (( ${#_dir} )) && __zx_load_conf_dir "${_dir[1]}"
    done
}

function __zx_load_confd() {
    local -a dirs=(
        ${ZDOTDIR:-$HOME/.config/zsh}/*.d(N)
    )
    (( ${#dirs} )) && __zx_load_dirs "$dirs"
}

#region MARK LOADED
zstyle ":zx:lib:load" loaded 'yes'
#endregion