# ZX Zsh

**Notice**: This is for personal use. Use recommended below.

Plugin Manager: [antidote](https://github.com/mattmc3/antidote)

Framework: [zephyr](https://github.com/mattmc3/zephyr)

## Usage

in `.zshrc`:

```shell
# clone zx
[[ -d ${ZDOTDIR:-$HOME/.config/zsh}/zx ]] ||
    git clone https://github.com/xj11400/zx-zsh.git ${ZDOTDIR:-$HOME/.config/zsh}/zx

# config zx

# source zx
source ${ZDOTDIR:-$HOME/.config/zsh}/zx/zx.zsh
```

## Config Options

### prompt

Install and load theme for prompt.

```shell
zstyle ':zx:load' prompt <prompt> <theme>
```

build-in:

- starship
  - zx
  - zx_nf
- p10k
  - zx
  - snowblocks
  - newline
  - powerlevel10k built-in themes

specify theme:

- starship:
  - `$ZDOTDIR/themes/xxx.toml`
  - `$XDG_CONFIG_HOME/starship/xxx.toml`

- p10k:
  - `$ZDOTDIR/themes/xxx.p10k.zsh`
  - `$XDG_CONFIG_HOME/powerlevel10k/xxx.p10k.zsh`

```shell
# prompt
#   - starship: zx, zx_nf ($ZDOTDIR/themes/xxx.toml)
#   - p10k: zx, snowblocks, newline ($ZDOTDIR/themes/xxx.p10k.zsh)
zstyle ':zx:load' prompt starship zx
```

### plugin manager

Install and load plugins from the specified plugin manager.

```shell
zstyle ':zx:load' plugin-manager <plugin-manager>
```

If choose **antidote**, zx will install plugins from `zsh_plugins` and load configs from `configs` in specified directory(`$ZDOTDIR/zpm`) if exist. Otherwise, zx will use the default config.

```shell
# plugin manager
#   antidote:
#     - zsh_plugins: $ZDOTDIR/zpm/zsh_plugins
#     - plugin configs: $ZDOTDIR/zpm/configs
zstyle ':zx:load' plugin-manager antidote
```

### user config directory

Load every `.zsh` or `.sh` script in the specified directories.

```shell
zstyle ':zx:load' user-confd <user-config-dirs>
```

```shell
# user config dirs
zx_user=(
    programs
    user
)
zstyle ':zx:load' user-confd $zx_user
```

### choose plugins to load

If not specified, zx will load all plugins.

```shell
_zx_plugins=(
    alias
    config
    color
    platform
    prompt
    utility
)
zstyle ':zx:load' plugins $_zx_plugins
```

## Directory structure

```shell
- .zshrc

optional:
- functions/
- programs/
- themes/

plugin manager:
- zpm/zsh_plugin.zsh
- zpm/configs.zsh

replace:
- plugins/alias/alias.plugin.zsh
- plugins/config/config.plugin.zsh

other: source directory
- any.d
```
