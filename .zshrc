#!/bin/zsh

setopt hist_ignore_dups
setopt hist_no_store

setopt auto_list
setopt auto_menu

# ------------------------------
# Init Starship
# ------------------------------
eval "$(starship init zsh)"

# ------------------------------
# Init linuxbrew
# ------------------------------
case "${OSTYPE}" in
linux*)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  ;;
esac

# ------------------------------
# Auto complete
# ------------------------------

case "${OSTYPE}" in
darwin*)
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
  ;;
linux*)
  # dummy
  ;;
esac

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  chmod +x $(brew --prefix asdf)/libexec/asdf.sh
  $(brew --prefix asdf)/libexec/asdf.sh
fi

# ------------------------------
# Load zplug
# ------------------------------
source ${HOME}/.zplug.zsh

# ------------------------------
# Load aliases
# ------------------------------
source ${HOME}/.aliases

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then . ~/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then . ~/google-cloud-sdk/completion.zsh.inc; fi
