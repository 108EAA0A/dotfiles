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
source ./.zplug

# ------------------------------
# Load aliases
# ------------------------------
source ./.aliases
