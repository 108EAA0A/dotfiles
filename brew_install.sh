#!/bin/zsh

formulas=(
  binutils
  bpytop
  cmake
  curl
  exa
  font-hackgen-nerd
  fzf
  gcc
  gibo
  git-flow
  gh
  hacker1024/hacker1024/coretemp
  imagemagick
  jq
  lazydocker
  lazygit
  nmap
  nodebrew
  nkf
  sl
  tldr
)

cask_formulas=(
  docker
  google-chrome
  graphiql
  font-ricty-diminished
  keycastr
  monitorcontrol
  slack
  visual-studio-code
)

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
  ;;
linux*)
  brew install docker
  ;;
esac

nodebrew setup
nodebrew install-binary latest

GCC_VER=$(ls /usr/local/bin | grep -E "^g\+\+\-(\d+) \->" | awk '{print $1}' | sed -e "s/g++-//g")
sudo ln -snfv /usr/local/bin/gcc-${GCC_VER} /usr/local/bin/gcc
sudo ln -snfv /usr/local/bin/g++-${GCC_VER} /usr/local/bin/g++
