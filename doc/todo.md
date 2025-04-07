# TODO

- **name style**
  - **__zx_func** : functions
  - **_zx_var** : variables in zx.zsh

- **remove commit**

- **remove functions and variables in config stage**
  - using function and local variable to avoid it

- **.zshenv**
  - load zx env?

```shell
source ${ZDOTDIR:-$HOME/.config/zsh}/zx/lib/env.zsh
```

## zephyr

- bootstrap

  - env : load once
  - basic (bootstrap): load env and check env in the begin

- helper
  - `is_darwin`
  - `is_linus`

- macos
  - functions: `show_hidden_in_finder`

## script structure

### header

### enhance condition: load once

```shell
# Load once
zstyle -T ":zx:lib:basic" loaded || return
```

### load bootstrap in the begin

```shell
0=${(%):-%N}
zstyle -t ':zx:lib:bootstrap' loaded || source ${0:a:h:h:h}/lib/bootstrap.zsh
```

### mark loaded=yes

```shell
zstyle ':zx:lib:basic' loaded yes
```

### clean up in the end

```shell
# clean up
unset __zx_func
unset _zx_var
```

### plugin.zsh

```shell
#
# header
#

# Load once
zstyle -T ":zx:lib:basic" loaded || return

# load bootstrap
0=${(%):-%N}
zstyle -t ':zx:lib:bootstrap' loaded || source ${0:a:h:h:h}/lib/bootstrap.zsh

#
# ...
#

# mark loaded
zstyle ':zx:lib:basic' loaded yes

# clean up
unset __zx_func
unset _zx_var

```
