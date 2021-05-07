#!/bin/zsh

formulas=(
  cmake
  curl
  exa
  fzf
  gcc
  gibo
  gh
  imagemagick
  jq
  nmap
  nkf
  tldr
)

brew upgrade

for formula in ${formulas[@]}; do
  brew install ${formula}
done


