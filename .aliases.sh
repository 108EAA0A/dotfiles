# ls
alias ls='exa'
alias ll='exa -ahl --git -I "node_modules|.git|.cache" --color=always --icons'

alias tree='ll -T'

alias dc='docker compose'

alias kusa='curl https://github-contributions-api.deno.dev/$(git config user.name).term'

alias gca='git commit --amend'
alias gcann='git commit --amend --no-edit -n'
alias gfpo='git push --force-with-lease origin'
