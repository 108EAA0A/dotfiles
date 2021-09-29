#!/bin/zsh

export HOMEBREW_NO_AUTO_UPDATE=1

formulas=(
  asdf
  bat
  binutils
  bpytop
  cmake
  composer
  coreutils
  curl
  exa
  expect
  ffmpeg
  font-hackgen-nerd
  fzf
  gallery-dl
  gawk
  gcc
  gibo
  git-flow
  git-secrets
  gh
  gpg
  graphviz
  groff
  hacker1024/hacker1024/coretemp
  htop
  imagemagick
  jq
  lazydocker
  lazygit
  mkvtoolnix
  nmap
  nodebrew
  nkf
  php
  shellcheck
  sl
  tldr
  yarn
  youtube-dl
)

cask_formulas=(
  docker
  google-chrome
  google-cloud-sdk
  graphiql
  font-ricty-diminished
  keycastr
  mkvtoolnix
  monitorcontrol
  parallels
  slack
  visual-studio-code
  vlc
)

brew update
brew tap homebrew/cask-fonts
brew tap jesseduffield/lazydocker

for formula in ${formulas[@]}; do
  brew install ${formula}
done

case "${OSTYPE}" in
darwin*)
  for formula in ${cask_formulas[@]}; do
    brew install --cask ${formula}
  done

  GCC_VER=$(ls /usr/local/bin | grep -E "^g\+\+\-(\d+) \->" | awk '{print $1}' | sed -e "s/g++-//g")
  sudo ln -snfv /usr/local/bin/gcc-${GCC_VER} /usr/local/bin/gcc
  sudo ln -snfv /usr/local/bin/g++-${GCC_VER} /usr/local/bin/g++
  ;;
linux*)
  brew install docker
  ;;
esac

nodebrew setup
nodebrew install-binary latest

unset HOMEBREW_NO_AUTO_UPDATE
