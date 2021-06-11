#!/bin/zsh

formulas=(
  cmake
  curl
  exa
  font-hackgen-nerd
  fzf
  gcc
  gibo
  gh
  imagemagick
  jq
  lazydocker
  nmap
  nkf
  tldr
)


cask_formulas=(
  google-chrome
  graphiql
  font-ricty-diminished
  slack
  visual-studio-code
)

brew upgrade

brew tap homebrew/cask-fonts
brew tap jesseduffield/lazydocker

for formula in ${formulas[@]}; do
  brew install ${formula}
done

for formula in ${cask_formulas[@]}; do
  brew install --cask ${formula}
done
