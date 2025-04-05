#
# language
# ############################################################

# python
# ======
PATH=$XDG_DATA_HOME/python/bin:$PATH
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/python_startup.py"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export PYTHONHISTFILE="$XDG_CACHE_HOME/python/python_history"

if [ "$(command -v pyenv)" ]; then
    export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

if [ "$(command -v poetry)" ]; then
    export POETRY_CONFIG_DIR="$XDG_CONFIG_HOME/pypoetry"
    export POETRY_HOME="$XDG_DATA_HOME/pypoetry"
    export POETRY_DATA_DIR="$XDG_DATA_HOME/pypoetry"
    export POETRY_CACHE_DIR="$XDG_CACHE_HOME/pypoetry"
fi

# matplotlab
export MPLCONFIGDIR="$XDG_CONFIG_HOME/matplotlib"


# go
# ==
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

# rust
# ====
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
