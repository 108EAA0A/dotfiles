#!/bin/sh

alias eman='env LANG=C MANPATH=/usr/share/man man'

alias cat='bat'
alias date='gdate'
alias top='htop'

alias ls='exa'
alias ll='exa -ahl --git --color=always --icons'

alias tree='ll -T --git-ignore -I ".git"'

alias dc='docker compose'

alias kusa='curl https://github-contributions-api.deno.dev/$(git config user.name).term'

alias gcan='git commit --amend --no-edit'
alias gcann='gcan -n'
alias gfpo='git push --force-with-lease origin'

alias gengig='generate_gitignore_global'

alias fixmp4='ffmpeg -c copy -bsf:a aac_adtstoasc'
