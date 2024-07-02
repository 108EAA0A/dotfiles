#!/bin/zsh

# ------------------------------
# General Settings
# ------------------------------
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TZ=Asia/Tokyo

# ------------------------------
# export PATH
# ------------------------------
export PATH="/usr/local/bin:${PATH}"
export PATH="${HOME}/.asdf/bin:${HOME}/.asdf/shims:${PATH}"

# ------------------------------
# export XDG
# ------------------------------

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# ------------------------------
# History Settings
# ------------------------------
export HISTFILE="${HOME}/.zsh-history"
export HISTSIZE=1000000
export SAVEHIST=1000000

# ------------------------------
# golang Settings
# ------------------------------
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"

# ------------------------------
# Homebrew Settings
# ------------------------------
case "${OSTYPE}" in
darwin*)
  if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    export HOMEBREW_PREFIX="/opt/homebrew"
  else
    # On Intel macOS, this script installs to /usr/local only
    export HOMEBREW_PREFIX="/usr/local"
  fi
  ;;
linux*)
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  ;;
esac

eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}"
export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}"
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"

export PATH="$(brew --prefix binutils)/bin:${PATH}"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
export PATH="$(brew --prefix java11)/bin:${PATH}"
export PATH="$(brew --prefix libpq)/bin:${PATH}"
source "$HOME/.rye/env"
