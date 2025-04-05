#
# platform
#

# reference: zephr/macos

function load_platform() {
    if [[ ${OSTYPE} == darwin* ]]; then
        local _platform="darwin"
    elif [[ ${OSTYPE} == linux* ]]; then
        local _platform="linux"
    fi

    local -a _platform_config=(
        $ZX_HOME/plugins/platform/${_platform}.zsh(N)
        $ZDOTDIR/platform/${_platform}.zsh(N)
    )
    (( ${#_platform_config} )) && source $_platform_config[1]
}

load_platform
unset -f load_platform