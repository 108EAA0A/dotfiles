#!/bin/zsh -eux

export HOMEBREW_NO_AUTO_UPDATE=1

formulas=(
  asdf
  bash-completion
  bat
  binutils
  bpytop
  cmake
  composer
  coreutils
  curl
  emojify
  evans
  exa
  expect
  ffmpeg
  font-hackgen-nerd
  fzf
  gallery-dl
  gawk
  gcc
  gibo
  git-extras
  git-flow
  git-secrets
  gh
  golangci-lint
  gpg
  graphviz
  groff
  hacker1024/hacker1024/coretemp
  htop
  imagemagick
  jq
  lazydocker
  lazygit
  libpq
  mailhog
  mkvtoolnix
  nmap
  nkf
  pandoc
  pgcli
  php
  protobuf
  prototool
  rename
  shellcheck
  sl
  starship
  telnet
  tldr
  uniutils
  wget
  yarn
  youtube-dl
  yt-dlp
)

casks=(
  another-redis-desktop-manager
  dbeaver-community
  docker
  dotnet-sdk
  font-ricty-diminished
  github
  google-chrome
  google-cloud-sdk
  graphiql
  iterm2
  jetbrains-toolbox
  keycastr
  kindle
  libreoffice
  firefox
  mkvtoolnix
  monitorcontrol
  ngrok
  parallels
  postman
  slack
  sourcetree
  steam
  visual-studio-code
  vlc
  zoom
)

brew update
brew tap homebrew/cask-fonts
brew tap ktr0731/evans
brew tap jesseduffield/lazydocker

for formula in ${formulas[@]}; do
  brew install ${formula}
done

case "${OSTYPE}" in
darwin*)
  for cask in ${casks[@]}; do
    brew install --cask ${cask}
  done

  GCC_VER=$(ls $(brew --prefix)/bin | grep -E "^g\+\+\-(\d+) \->" | awk '{print $1}' | sed -e "s/g++-//g")
  sudo ln -snfv $(brew --prefix gcc)/gcc-${GCC_VER} /usr/local/bin/gcc
  sudo ln -snfv $(brew --prefix gcc)/g++-${GCC_VER} /usr/local/bin/g++
  ;;
linux*)
  brew install docker
  ;;
esac

unset HOMEBREW_NO_AUTO_UPDATE

eval "$(starship init zsh)"
