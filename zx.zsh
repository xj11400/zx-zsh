#
# zx
#

# ┌──────────────────────────────────────────────────────────┐
#   parse options
# └──────────────────────────────────────────────────────────┘

# zstyle ':zx:load' prompt <prompt> <theme>
zstyle -a ':zx:load' prompt '_zx_prompt' ||
  _zx_prompt=(
    starship
    zx
  )
zstyle ':zx:plugin:prompt' theme $_zx_prompt

# zstyle ':zx:load' plugins <plugins>
zstyle -a ':zx:load' plugins '_zx_plugins' ||
  _zx_plugins=(
    alias
    config
    platform
    prompt
    utility
    color
  )

# local -a _zx_load_dir

# # zstyle ':zx:load' user <user config dirs>
# # x_zsh_require_dir <user config dir> all
# zstyle -a ':zx:load' user '_zx_load_dir' ||
#   _zx_load_dir=(
#     user
#   )

# # zstyle ':zx:load' programs true
# zstyle -t ':zx:load' programs && _zx_load_dir+=($ZX_HOME/programs)

# ┌──────────────────────────────────────────────────────────┐
#   zx
# └──────────────────────────────────────────────────────────┘

setopt extended_glob # Needed for file modification glob modifiers with coreutils setup

# This is setting the variable 0 to the current script's name
# %N is a prompt escape sequence that expands to the script name
# The (%) syntax tells Zsh to perform prompt expansion
# :- is a parameter expansion operator that provides a default value
# So this gets the script's filename and stores it in variable 0
0=${(%):-%N}

# This sets the ZX_HOME variable based on the value in 0
# :a is a modifier that converts the path to an absolute path
# :h is a modifier that gives the "head" (parent directory) of the path
# Combined, this gives the absolute path to the directory containing the script
ZX_HOME=${0:a:h}

# basic
source $ZX_HOME/lib/env.zsh
source $ZX_HOME/lib/basic.zsh
source $ZX_HOME/lib/load.zsh

# autoload functions
fpath=(
    $ZX_HOME/functions
    ${ZDOTDIR:-$HOME/.config/zsh}/functions
    $fpath
)
[[ -d $fpath[1] ]] && autoload -Uz $fpath[1]/*(:t)
[[ -d $fpath[2] ]] && autoload -Uz $fpath[2]/*(:t)

# ┌──────────────────────────────────────────────────────────┐
#   load plugin manager
# └──────────────────────────────────────────────────────────┘

# check is plugin_manager setted
zstyle -s ':zx:load' plugin-manager '_zx_plugin_manager' &&
  source $ZX_HOME/zpm/zpm.zsh

# zstyle ':zx:zpm' plugin_manager $_zx_plugin_manager

# ┌──────────────────────────────────────────────────────────┐
#   load plugins
# └──────────────────────────────────────────────────────────┘

# load plugins
for _zx_plugin in $_zx_plugins; do
  # Allow overriding plugins.
  _zx_initfiles=(
    ${ZSH_CUSTOM:-$__zsh_config_dir}/plugins/${_zx_plugin}/${_zx_plugin}.plugin.zsh(N)
    $ZX_HOME/plugins/${_zx_plugin}/${_zx_plugin}.plugin.zsh(N)
  )
  if (( $#_zx_initfiles )); then
    source "$_zx_initfiles[1]"
    if [[ $? -eq 0 ]]; then
      zstyle ":zx:plugin:$_zx_plugin" loaded 'yes'
    else
      zstyle ":zx:plugin:$_zx_plugin" loaded 'no'
    fi
  else
    echo >&2 "zx: Plugin not found '$_zx_plugin'."
  fi
done

# ┌──────────────────────────────────────────────────────────┐
#   load directory
# └──────────────────────────────────────────────────────────┘

# programs
# zstyle ':zx:load' programs true
zstyle -t ':zx:load' programs && __zx_load_conf_dir "$ZX_HOME/programs"

# user config directories
# zstyle ':zx:load' user-confd <user config dirs>
zstyle -a ':zx:load' user-confd '_zx_user' ||
  _zx_user=(
    user
  )

__zx_load_dirs "${_zx_user[@]}"

# ┌──────────────────────────────────────────────────────────┐
#   clean up
# └──────────────────────────────────────────────────────────┘

# unset variables
# unset _zx_plugin{s,} _zx_initfiles _zx_prompt{s,} _zx_user{s,} _zx_plugin_manager
for var in $(export | grep '^_zx' | cut -d'=' -f1); do
  unset "$var"
done

# unset __zsh_
for var in $(export | grep '^__zsh_' | cut -d'=' -f1); do
  unset "$var"
done

# unset functions
for func in $(functions | grep '^__zx' | cut -d' ' -f1); do
  unset -f "$func"
done

# unset options
unsetopt extended_glob # `setopt extended_glob` makes `git reset --soft HEAD^` not work with `^`
