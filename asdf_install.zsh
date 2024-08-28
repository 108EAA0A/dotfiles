#!/bin/zsh -eux

plugins=(
	golang
	nodejs
	pnpm
	python
	terraform
)

for plugin in ${plugins[@]}; do
	asdf plugin add ${plugin}
	asdf install ${plugin} latest
	asdf global ${plugin} latest
done
