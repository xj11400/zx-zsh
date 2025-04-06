#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

export ZX_HOME=$HOME/.local/share/zsh/zx

# clone zx
[[ -d $ZX_HOME ]] ||
    git clone https://github.com/xj11400/zx-zsh.git $ZX_HOME

# configs
# _zx_plugins=(
#     alias
#     config
#     color
#     platform
#     prompt
#     utility
# )
# zstyle ':zx:load' plugins $_zx_plugins

# prompt
#   - starship: zx, zx_nf ($ZDOTDIR/themes/xxx.toml)
#   - p10k: zx, snowblocks, newline ($ZDOTDIR/themes/xxx.p10k.zsh)
zstyle ':zx:load' prompt starship zx

# plugin manager
#   antidote:
#     - zsh_plugins: $ZDOTDIR/zpm/zsh_plugins
#     - plugin configs: $ZDOTDIR/zpm/configs
zstyle ':zx:load' plugin-manager antidote

# programs
zstyle ':zx:load' programs true

# user config dirs
zx_user=(
    programs
    user
)
zstyle ':zx:load' user-confd $zx_user

# source zx
source $ZX_HOME/zx.zsh

# path
export PATH=$HOME/.local/share/utils:$PATH
