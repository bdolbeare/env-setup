#!/usr/bin/env bash

# Based on the following script:  https://raw.githubusercontent.com/samoshkin/tmux-config/master/install.sh

set -e
set -u
set -o pipefail

# Pull in some common functions
. ./common-functions.sh

echoingreen "This script will setup TMUX for your machine"

REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPODIR";


is_app_installed() {
  type "$1" &>/dev/null
}

if ! is_app_installed tmux; then
  echoinred "WARNING: \"tmux\" command is not found. Install it first"
  exit 1
fi

mkdir -p "${HOME}/.tmux"

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  echoinyellow "WARNING: Cannot found TPM (Tmux Plugin Manager) at default location: \$HOME/.tmux/plugins/tpm. Creating it now."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install TPM plugins.
# TPM requires running tmux server, as soon as `tmux start-server` does not work
# create dump __noop session in detached mode, and kill it when plugins are installed
echoingreen "Installing TPM plugins"
tmux new -d -s __noop >/dev/null 2>&1 || true 
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

echoingreen  "OK: Completed\n"

cp -a ./tmux/. "${HOME}/.tmux"