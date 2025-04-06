
# zpm

source $ZX_HOME/zpm/$_zx_plugin_manager/$_zx_plugin_manager.zsh

# configs
function __zx_load_zpm_configs {
    if zstyle -t ':zx:load:config' plugin-manager; then
        source $ZX_HOME/zpm/configs.zsh
        return
    fi

    local -a configs=(
        "${ZDOTDIR:-$HOME/.config/zsh}/zpm/configs.zsh"(N)
        "${ZDOTDIR:-$HOME/.config/zsh}/zpm/${_zx_plugin_manager}/configs.zsh"(N)
    )
    (( $#configs )) && source $configs[1]
}

__zx_load_zpm_configs