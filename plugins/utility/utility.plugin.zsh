#!/bin/zsh
#
# functions/utils.zsh
#

# sedi
# Brief: Cross platform `sed -i` syntax.
# Usage: sedi [options] file
# ========
sedi() {
  # GNU/BSD
  sed --version &>/dev/null && sed -i -- "$@" || sed -i "" "$@"
}

# envsubset
# Ensure envsubst command exists.
# ========
if ! (( $+commands[envsubst] )); then
  alias envsubst="python -c 'import os,sys;[sys.stdout.write(os.path.expandvars(l)) for l in sys.stdin]'"
fi

# tree
# ====
if ! (($+commands[tree])); then
   if [[ "$OSTYPE" == darwin* ]]; then
       alias tree='find . -print | sed -e "s;[^/]*/;|____;g" -e "s;____|; |;g"'
   fi
fi
