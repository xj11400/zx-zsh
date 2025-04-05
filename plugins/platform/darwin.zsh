# Homebrew
# Check if the Homebrew executable exists and is executable (-x)
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Function to delete all .DS_Store files recursively under the given directory
# Usage: delete_ds_store <directory>
function zx_delete_ds_store() {
    local dir="${1:-.}"  # Use current directory if no argument is provided
    if [ -d "$dir" ]; then
        find "$dir" -type f -name ".DS_Store" -print -delete | while read -r file; do
            echo " > Deleted: $file"
        done
        echo "Finished deleting .DS_Store files under $dir"
    else
        echo "Error: $dir is not a valid directory"
    fi
}
