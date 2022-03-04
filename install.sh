#!/bin/sh

DOT_DIR="${HOME}/dotfiles"

case "${OSTYPE}" in
linux*)
  # for ubuntu
  sudo apt-get update
  ;;
esac

git_result=0
$(git version &>/dev/null) || git_result=$?
if [ ! type git &>/dev/null ] || [ $git_result != 0 ]; then
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
  read Wait
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
  if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
  fi
  code="$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
  echo "eval \"${code}\"" >> "${HOME}/.zprofile"
  eval $code
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
source "${DOT_DIR}/brew_install.sh"
source "${DOT_DIR}/asdf_install.sh"

echo "Loading dotfiles..."
source "${DOT_DIR}/.zshrc"

echo "install node modules..."
npm i -g typescript ts-node create-react-app jshint

# echo "install vscode extensions..."
# source "${DOT_DIR}/vscode/extensions.sh"

case "${OSTYPE}" in
darwin*)
  echo "install japanese man..."
  TAB="$(printf '\\\011')"
  sudo sed -i '.bak' -E "s@^JNROFF(${TAB}+).*@JNROFF\1/usr/local/bin/nkf -w | /usr/local/bin/groff -Dutf8 -Tutf8 -mandoc -mja -E@" /etc/man.conf
  sudo sed -i -e 's/less -is$/less -isr/g' /etc/man.conf
  sudo sed -i -e 's@^MANPATH_MAP\(.*\)/usr/share/man$@MANPATH_MAP\1/usr/local/share/man@' /etc/man.conf

  LATEST_JA_MAN_DATE="$(date '+%Y%m15' --date '-1 months')"
  LATEST_JA_MAN="man-pages-ja-${LATEST_JA_MAN_DATE}"
  curl -fsSL "http://linuxjm.osdn.jp/${LATEST_JA_MAN}.tar.gz" | tar xf - -C /tmp/
  (
    cd "/tmp/${LATEST_JA_MAN}" || exit
    expect "${DOT_DIR}/man-jp-make-config.expect"
    sudo make install
  ) > "/tmp/${LATEST_JA_MAN}/install.log" 2>&1
  ;;
esac

echo "Install all done!"
