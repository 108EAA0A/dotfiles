#!/bin/sh

echo "Check and Install zsh..."

# install zsh and chsh
if ! type zsh; then
  # for ubuntu
  sudo apt-get update
  sudo apt-get -y install zsh
  sudo chsh -s $(which zsh)
fi

# if not zsh to rerun this file in zsh
if ! type source || ! type autoload; then
  zsh $(cd $(dirname $0); pwd)/install.sh
  exit
fi

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
  zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ;;
esac
brew doctor

source "$(pwd)/brew_install.sh"

echo "Loading dotfiles..."
source "$(pwd)/.zshrc"

echo "Install all done!"
