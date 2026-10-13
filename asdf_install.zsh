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

asdf plugin add terragrunt https://github.com/gruntwork-io/asdf-terragrunt
asdf install terragrunt latest
asdf global terragrunt latest
