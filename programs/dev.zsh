#
# dev
# ############################################################

# docker
# ======
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine

# minikube
# ========
export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube
# dotenv
# ======
if [ "$(command -v direnv)" ]; then
    eval "$(direnv hook zsh)"
fi

