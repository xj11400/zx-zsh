# asdf
# ------------

if [ "$(command -v asdf)" ]; then
    export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/asdfrc"
    export ASDF_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/asdf"
    export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=tool_versions

    \. "$(brew --prefix asdf)/libexec/asdf.sh"
fi


