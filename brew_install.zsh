#!/bin/zsh -eux

export HOMEBREW_NO_AUTO_UPDATE=1

formulas=(
  act
  asdf
  awscli
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
  firebase-cli
  font-hackgen-nerd
  fzf
  gallery-dl
  gawk
  gcc
  gibo
  git-extras
  git-flow
  git-lfs
  git-secrets
  gh
  golangci-lint
  gpg
  graphviz
  groff
  hacker1024/hacker1024/coretemp
  htop
  imagemagick
  iproute2mac
  java11
  jq
  kubectl
  kubectx
  lazydocker
  lazygit
  libpq
  mailhog
  minio/stable/mc
  mkvtoolnix
  nmap
  nkf
  pandoc
  pgcli
  php
  protobuf
  prototool
  rename
  rtorrent
  sheldon
  shellcheck
  sl
  sops
  starship
  telnet
  terraform
  terraformer
  tldr
  uniutils
  wget
  yarn
  youtube-dl
  yt-dlp
)

casks=(
  another-redis-desktop-manager
  # aws-vpn-client
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
  microsoft-teams
  mkvtoolnix
  monitorcontrol
  ngrok
  parallels
  postman
  slack
  sourcetree
  steam
  # tunnelblick
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

  sudo ln -sfn $(brew --prefix)/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

  GCC_VER=$(ls $(brew --prefix)/bin | grep -E "^g\+\+\-(\d+) \->" | awk '{print $1}' | sed -e "s/g++-//g")
  sudo ln -snfv $(brew --prefix gcc)/gcc-${GCC_VER} /usr/local/bin/gcc
  sudo ln -snfv $(brew --prefix gcc)/g++-${GCC_VER} /usr/local/bin/g++
  ;;
linux*)
  sudo ln -sfn $(brew --prefix)/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
  brew install docker
  ;;
esac

unset HOMEBREW_NO_AUTO_UPDATE

eval "$(starship init zsh)"
