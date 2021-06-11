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
  # dummy
  ;;
linux*)
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ;;
esac

source "$(pwd)/brew_install.sh"

echo "Loading dotfiles..."
source "$(pwd)/.zshrc"

echo "Install all done!"
