#!/bin/zsh

# zplugの設定

if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

# 時間がかかるコマンドを実行すると完了時に通知
zplug 't413/zsh-background-notify'

# git の補完を効かせる
# 補完＆エイリアスが追加される
zplug "plugins/git", from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"

#zplug "docker/cli", use:"contrib/completion/zsh/_docker"

# fzf でよく使う関数の詰め合わせ
zplug "mollifier/anyframe"
#zplug "mollifier/cd-gitroot"

# fzf本体（連携前提のパーツ）
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "junegunn/fzf", use:"shell/*.zsh", as:plugin

# ディレクトリ移動を高速化（fzf であいまい検索）
zplug "b4b4r07/enhancd", use:init.sh

# 補完を更に強化する
# pacman や yaourt のパッケージリストも補完するようになる
zplug "zsh-users/zsh-completions"
# 入力途中に候補をうっすら表示
zplug "zsh-users/zsh-autosuggestions"
# コマンドを種類ごとに色付け
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# ヒストリの補完を強化する
zplug "zsh-users/zsh-history-substring-search", defer:3

# 自分自身をプラグインとして管理
zplug "zplug/zplug", hook-build:'zplug --self-manage'

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load

# 補完候補の色づけ
#export LSCOLORS=exfxcxdxbxegedabagacad
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#eval $(dircolors $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.ansi-dark)
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
