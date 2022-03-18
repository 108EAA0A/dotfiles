#!/bin/zsh

setopt hist_ignore_dups
setopt hist_no_store
setopt share_history

setopt auto_list
setopt auto_menu

# ------------------------------
# Init Shell
# ------------------------------
eval "$(starship init zsh)"
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
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.zsh
  ;;
esac
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  source $(brew --prefix asdf)/libexec/asdf.sh
  source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# ------------------------------
# Load zplug
# ------------------------------
source ${HOME}/.zplug.zsh

# ------------------------------
# Load functions
# ------------------------------
source ${HOME}/.functions.zsh

# ------------------------------
# Load aliases
# ------------------------------
source ${HOME}/.aliases

(gengig > /dev/null &)
