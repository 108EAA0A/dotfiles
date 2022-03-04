#!/bin/zsh

plugins=(
	nodejs
	golang
)

for plugin in ${plugins[@]}; do
	asdf plugin add ${plugin}
	asdf install ${plugin} latest
	asdf global ${plugin} latest
done
