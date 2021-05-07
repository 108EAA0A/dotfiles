# ------------------------------
# Auto complete
# ------------------------------
autoload -Uz compinit && compinit
setopt auto_list

case "${OSTYPE}" in
darwin*)
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
  ;;
linux*)
  # dummy
  ;;
esac

# ------------------------------
# Load zplug
# ------------------------------
source ${HOME}/.zplug

# ------------------------------
# Load aliases
# ------------------------------
source ${HOME}/.aliases


# The next line updates PATH for the Google Cloud SDK.
if [ -f '${HOME}/google-cloud-sdk/path.zsh.inc' ]; then . '${HOME}/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '${HOME}/google-cloud-sdk/completion.zsh.inc' ]; then . '${HOME}/google-cloud-sdk/completion.zsh.inc'; fi
