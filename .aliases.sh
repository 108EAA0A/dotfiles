#!/bin/sh

alias eman='env LANG=C command man'
alias man='env LANG=ja_JP.UTF-8 MANPATH=/usr/local/share/man/ja_JP.UTF-8 command man'

alias cat='bat'
alias date='gdate'
alias top='htop'

alias ls='exa'
alias ll='exa -ahl --git --color=always --icons'

alias tree='ll -T --git-ignore -I ".git"'

alias dc='docker compose'

alias kusa='curl https://github-contributions-api.deno.dev/$(git config user.name).term'
alias tenki='wttr'
alias ttenki='telnet graph.no 79'
alias starwars='telnet towel.blinkenlights.nl'

alias gcan='git commit --amend --no-edit'
alias gcann='gcan -n'
alias gfpo='git push --force-with-lease origin'

alias gengig='generate_gitignore_global'

alias fixmp4='ffmpeg -c copy -bsf:a aac_adtstoasc'

alias ytmp3="youtube-dl --no-overwrites --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --postprocessor-args \"-metadata comment=''\""
