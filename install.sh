#!/bin/zsh

echo "Create dotfile links..."
ln -snfv "$(pwd)/.aliases" "${HOME}/.aliases"  
ln -snfv "$(pwd)/.zshenv" "${HOME}/.zshenv"
ln -snfv "$(pwd)/.zshrc" "${HOME}/.zshrc"  

echo "Install modules..."
case "${OSTYPE}" in
darwin*)
  source "$(pwd)/brew_install.sh"
  ;;
linux*)
  # dummy
  ;;
esac

echo "Loading dotfiles..."
source "$(pwd)/.zshrc"

echo "Install all done!"
