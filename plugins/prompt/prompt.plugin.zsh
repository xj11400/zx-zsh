#
# prompt
#
# https://github.com/mattmc3/zephyr/blob/main/plugins/prompt/prompt.plugin.zsh

# Prompt options
setopt prompt_subst       # Expand parameters in prompt variables.
#setopt transient_rprompt  # Remove right prompt artifacts from prior commands.

# Set 2 space indent for each new level in a multi-line script. This can then be
# overridden by a prompt or plugin, but is a better default than Zsh's.
PS2='${${${(%):-%_}//[^ ]}// /  }    '

function prompt_p10k_setup {
    x_use "romkatv/powerlevel10k" "$__zsh_theme_data_dir/powerlevel10k"

    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # use powerlevel10k
    source $__zsh_theme_data_dir/powerlevel10k/powerlevel10k.zsh-theme

    # find theme
    if [[ -n "$1" ]]; then
        local -a configs=(
            "$__zsh_config_dir/themes/${1}.p10k.zsh"(N)
            "${XDG_CONFIG_HOME:-$HOME/.config}/powerlevel10k/${1}.p10k.zsh"(N)
            "$ZX_HOME/plugins/prompt/powerlevel10k/${1}.p10k.zsh"(N)
            "$__zsh_theme_data_dir/powerlevel10k/config/p10k-${1}.zsh"(N)
        )
        (( $#configs )) && source $configs[1]
    fi
}

function prompt_starship_setup {
    # check is starship exist
    (( $+commands[starship] )) \
        || (curl -sS https://starship.rs/install.sh | sh) #TODO: pipe line ok?

    # find theme
    if [[ -n "$1" ]]; then
        local -a configs=(
            "$__zsh_config_dir/themes/${1}.toml"(N)
            "${XDG_CONFIG_HOME:-$HOME/.config}/starship/${1}.toml"(N)
            "$ZX_HOME/plugins/prompt/starship/${1}.toml"(N)
        )
        (( $#configs )) && export STARSHIP_CONFIG=$configs[1]
    fi

    export STARSHIP_CACHE=$__zsh_cache_dir/starship/cache

    eval "$(starship init zsh)"
}

# Wrap promptinit.
function promptinit {
    # Initialize real built-in prompt system.
    unfunction promptinit
    autoload -Uz promptinit && promptinit

    # Set the prompt if specified.
}

function run_promptinit {
  # Initialize the built-in prompt system.
  autoload -Uz promptinit && promptinit

  # Set the prompt if specified.
  local -a prompt_argv
  zstyle -a ':zx:plugin:prompt' theme 'prompt_argv' \
    || prompt_argv=(starship zx)
  if [[ $TERM == (dumb|linux|*bsd*) ]]; then
    prompt 'off'
  elif (( $#prompt_argv > 0 )); then
    prompt_themes=("$prompt_argv[@]")
    prompt "$prompt_argv[@]"
  fi
}

run_promptinit