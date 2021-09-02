#!/bin/sh

DOT_DIR="$(pwd)/dotfiles"

case "${OSTYPE}" in
linux*)
  # for ubuntu
  sudo apt-get update
  ;;
esac

if ! type git; then
  echo "install git"

  case "${OSTYPE}" in
  linux*)
    # for ubuntu
    sudo apt-get -y install git
    ;;
  esac
fi

if [ ! -d "${DOT_DIR}" ]; then
  echo "clone dotfiles repo..."
  git clone https://github.com/108EAA0A/dotfiles.git "${DOT_DIR}"
fi

echo "Locale settings..."

case "${OSTYPE}" in
darwin*)
  # dummy
  ;;
linux*)
  # for ubuntu
  sudo apt install -y language-pack-ja
  sudo update-locale LANG=ja_JP.UTF-8
  sudo apt install -y manpages-ja manpages-ja-dev
  # for centos
  # sudo yum install -y glibc-langpack-ja
  ;;
esac

echo "Check and Install zsh..."

# install zsh and chsh
if ! type zsh; then
  # for ubuntu
  sudo apt-get -y install zsh
  sudo chsh -s "$(command -v zsh)"
fi

# if not zsh to rerun this file in zsh
if ! type source || ! type autoload; then
  zsh "${DOT_DIR}/install.sh"
  exit
fi

echo "Create dotfile links..."
ln -snfv "${DOT_DIR}/.aliases.sh" "${HOME}/.aliases"
ln -snfv "${DOT_DIR}/.gitconfig" "${HOME}/.gitconfig"
ln -snfv "${DOT_DIR}/.zplug.zsh" "${HOME}/.zplug.zsh"
ln -snfv "${DOT_DIR}/.zshenv" "${HOME}/.zshenv"
ln -snfv "${DOT_DIR}/.zshrc" "${HOME}/.zshrc"
ln -snfv "${DOT_DIR}/.config/starship.toml" "${HOME}/.config/starship.toml"
case "${OSTYPE}" in
darwin*)
  ln -snfv "${DOT_DIR}/settings/macos.sh" "${HOME}/.system.enviroment"
  ln -snfv "${DOT_DIR}/settings/system.environment.plist" "${HOME}/Library/LaunchAgents/system.environment.plist"
  ;;
esac

echo "Install modules..."

sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y

case "${OSTYPE}" in
darwin*)
  echo "install CommandLineTools..."
  sudo xcode-select --switch /Library/Developer/CommandLineTools
  xcode-select --install
  echo "CommandLineTools" "$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables | grep version)"

  launchctl load "${HOME}/Library/LaunchAgents/system.environment.plist"
  ;;
linux*)
  echo "install linuxbrew..."
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # shellcheck disable=SC2016
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "${HOME}/.profile"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  ;;
esac
brew doctor

source "${DOT_DIR}/brew_install.sh"

echo "install node modules..."
npm i -g typescript

echo "Loading dotfiles..."
source "${DOT_DIR}/.zshrc"

echo "Install all done!"
