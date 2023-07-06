#!/bin/sh -eux

DOT_DIR="${HOME}/dotfiles"

case "${OSTYPE}" in
linux*)
  # for ubuntu
  sudo apt-get update
  ;;
esac

git_result=0
type git &>/dev/null || git version &>/dev/null || git_result=$?
if [ $git_result != 0 ]; then
  echo "install git"

  case "${OSTYPE}" in
  darwin*)
    echo "install CommandLineTools..."
    sudo xcode-select --switch /Library/Developer/CommandLineTools
    xcode-select --install
    echo "CommandLineTools" "$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables | grep version)"

    launchctl load "${HOME}/Library/LaunchAgents/system.environment.plist"
    ;;
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
if ! type zsh &>/dev/null; then
  # for ubuntu
  sudo apt-get -y install zsh
  sudo chsh -s "$(command -v zsh)"
fi

# if not zsh to rerun this file in zsh
if ! type source &>/dev/null || ! type autoload &>/dev/null; then
  zsh "${DOT_DIR}/install.sh"
  exit
fi

if [ ! -e "${HOME}/.ssh/id_rsa" ]; then
  echo "Genereate ssh key..."
  ssh-keygen -t rsa -b 4096
  pbcopy < "${HOME}/.ssh/id_rsa.pub"
  echo "Copied ssh public key! setting for GitHub and type Enter:"
  open https://github.com/settings/ssh/new
  read -r _
fi

echo "Create dotfile links..."
ln -snfv "${DOT_DIR}/.asdfrc" "${HOME}/.asdfrc"
ln -snfv "${DOT_DIR}/.aliases.sh" "${HOME}/.aliases"
ln -snfv "${DOT_DIR}/.functions.zsh" "${HOME}/.functions.zsh"
ln -snfv "${DOT_DIR}/.gitconfig" "${HOME}/.gitconfig"
ln -snfv "${DOT_DIR}/.zplug.zsh" "${HOME}/.zplug.zsh"
ln -snfv "${DOT_DIR}/.zshenv" "${HOME}/.zshenv"
ln -snfv "${DOT_DIR}/.zshrc" "${HOME}/.zshrc"
mkdir -p "${HOME}/.ssh"
ln -snfv "${DOT_DIR}/.ssh/config" "${HOME}/.ssh/config"
mkdir -p "${HOME}/.config"
ln -snfv "${DOT_DIR}/.config/starship.toml" "${HOME}/.config/starship.toml"
mkdir -p "${HOME}/.quokka"
ln -snfv "${DOT_DIR}/.quokka/config.json" "${HOME}/.quokka/config.json"
case "${OSTYPE}" in
darwin*)
  ln -snfv "${DOT_DIR}/macos/macos.sh" "${HOME}/.system.enviroment"
  mkdir -p "${HOME}/Library/LaunchAgents"
  ln -snfv "${DOT_DIR}/macos/system.environment.plist" "${HOME}/Library/LaunchAgents/system.environment.plist"
  ;;
esac

case "${OSTYPE}" in
darwin*)
  echo "Install brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$(uname -m)" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
  fi
  code="$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
  echo "eval \"${code}\"" >> "${HOME}/.zprofile"
  eval "$code"
  ;;
linux*)
  echo "install linuxbrew..."
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # shellcheck disable=SC2016
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "${HOME}/.profile"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  ;;
esac

echo "Install modules..."
source "${DOT_DIR}/brew_install.zsh"
source "${DOT_DIR}/asdf_install.zsh"

echo "Loading dotfiles..."
source "${DOT_DIR}/.zshrc"

echo "install node modules..."
npm i -g typescript ts-node create-react-app jshint

# echo "install vscode extensions..."
# source "${DOT_DIR}/vscode/extensions.zsh"

echo "Install cloud-sql-proxy..."
CLOUD_SQL_PROXY_PATH="$HOME/cloud_sql_proxy"
case "${OSTYPE}" in
darwin*)
  if [[ "$(uname -m)" == "arm64" ]]; then
    # M1 macOS
    curl -o "$CLOUD_SQL_PROXY_PATH" https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.arm64
  else
    # Intel macOS
    curl -o "$CLOUD_SQL_PROXY_PATH" https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64
  fi
  ;;
linux*)
  curl -o "$CLOUD_SQL_PROXY_PATH" https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64
  ;;
esac
chmod +x cloud_sql_proxy

case "${OSTYPE}" in
darwin*)
  source "${DOT_DIR}/install_japanese_man.zsh"
  ;;
esac

echo "Install all done!"
