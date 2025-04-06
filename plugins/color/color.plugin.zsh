
# Function to set directory colors
# TODO:
#   rename .dir_colors to .dircolors
#   error command not found gdiroclors
function __zx_set_dir_colors() {
    unset -f __zx_set_dir_colors

    local dircolors_path="$1"

    # Check if the .dircolors file exists and is readable
    if [[ -r "$dircolors_path" ]]; then
        # Use different commands for macOS (Darwin) and other systems
        if [[ "$OSTYPE" == darwin* ]]; then
            # On macOS, use gdircolors (usually installed via GNU coreutils)
            eval $(gdircolors "$dircolors_path")
        else
            # On other systems (like Linux), use the standard dircolors command
            eval $(dircolors -b "$dircolors_path")
        fi

        # If LS_COLORS is set (indicating successful color parsing)
        if [[ -n "$LS_COLORS" ]]; then
            # Apply the colors to zsh completion
            # This makes the completion menu use the same colors as ls
            zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
        fi
    else
        echo "Warning: $dircolors_path not found or not readable." >&2
    fi
}

__zx_set_dir_colors "$ZX_HOME/plugins/color/dircolors"