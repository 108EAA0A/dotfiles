# ------------------------------
# General Settings
# ------------------------------
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TZ=Asia/Tokyo

export PATH=/usr/local/bin:${PATH}
export PATH=/usr/local/opt/binutils/bin:${PATH}

export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share

# ------------------------------
# History Settings
# ------------------------------
export HISTFILE=${HOME}/.zsh-history
export HISTSIZE=1000000
export SAVEHIST=1000000

# ------------------------------
# golang Settings
# ------------------------------
export GOPATH=${HOME}/go
export PATH=${GOPATH}/bin:${PATH}
