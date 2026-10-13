#!/bin/zsh

setopt hist_no_store          # historyコマンドは履歴に登録しない
setopt hist_expire_dups_first # 履歴を切り詰める際に、重複する最も古いイベントから消す
setopt hist_ignore_all_dups   # 履歴が重複した場合に古い履歴を削除する
setopt hist_ignore_dups       # 前回のイベントと重複する場合、履歴に保存しない
setopt hist_save_no_dups      # 履歴ファイルに書き出す際、新しいコマンドと重複する古いコマンドは切り捨てる
setopt share_history          # 全てのセッションで履歴を共有する

setopt auto_list
setopt auto_menu

# ------------------------------
# Init Shell
# ------------------------------
eval "$(starship init zsh)"
case "${OSTYPE}" in
linux*)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  ;;
esac

# ------------------------------
# Auto complete
# ------------------------------
case "${OSTYPE}" in
darwin*)
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.zsh
  ;;
esac
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  source $(brew --prefix asdf)/libexec/asdf.sh
  source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# ------------------------------
# Load sheldon
# ------------------------------
eval "$(sheldon source)"

# ------------------------------
# Load functions
# ------------------------------
source ${HOME}/.functions.zsh

# ------------------------------
# Load aliases
# ------------------------------
source ${HOME}/.aliases

(gengig > /dev/null &)
