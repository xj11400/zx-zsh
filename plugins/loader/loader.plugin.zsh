
function __zx_load_conf_files() {
    local -a files=("$@")
    for file in "${files[@]}"; do
        local _file=(
            $ZDOTDIR/$file.{z,}sh(N)
            $file.{z,}sh(N)
        )
        (( ${#_file} )) && source "${_file[1]}"
    done
}

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


# programs
# zstyle ':zx:load' programs true
zstyle -t ':zx:load' programs && __zx_load_conf_dir "$ZX_HOME/programs"

# user config directories
# zstyle ':zx:load:confd' user <user config dirs>
zstyle -a ':zx:load:confd' user '_zx_user_dir' ||
  _zx_user_dir=(
    user
  )

__zx_load_dirs "${_zx_user_dir[@]}"


# zstyle ':zx:load:conf' user <user config files>
zstyle -a ':zx:load:conf' user '_zx_user_files'

__zx_load_conf_files "${_zx_user_files[@]}"

# zstyle ':zx:load:conf.d' user yes/no
zstyle -t ':zx:load:conf.d' user && __zx_load_confd
