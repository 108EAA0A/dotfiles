# colored ls
case "${OSTYPE}" in
darwin*)
  alias ls="ls -G"
  alias ll="ls -alG"
  ;;
linux*)
  alias ls='ls --color'
  alias ll='ls -al --color'
  ;;
esac

