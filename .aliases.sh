#!/bin/sh

# ls
alias ls='exa'
alias ll='exa -ahl --git -I "node_modules|.git|.cache" --color=always --icons'

alias tree='ll -T'
alias date='gdate'

alias dc='docker compose'

alias kusa='curl https://github-contributions-api.deno.dev/$(git config user.name).term'

alias gca='git commit --amend'
alias gcan='gca --no-edit'
alias gcann='gcan -n'
alias gfpo='git push --force-with-lease origin'

alias fixmp4='ffmpeg -c copy -bsf:a aac_adtstoasc'
