#!/bin/zsh

echo "Create dotfile links..."
ln -snfv "$(pwd)/.aliases" "${HOME}/.aliases"  
ln -snfv "$(pwd)/.zshenv" "${HOME}/.zshenv"
ln -snfv "$(pwd)/.zshrc" "${HOME}/.zshrc"  
ln -snfv "$(pwd)/.config/starship.toml" "${HOME}/.config/starship.toml"

echo "Install modules..."

sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y

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
