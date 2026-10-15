#!/bin/bash
# バックグラウンドタスク (Still running.) が残っている間の Stop では通知しない
input=$(cat)
running=$(printf '%s' "$input" | /opt/homebrew/bin/jq '[.background_tasks // [] | .[] | select(.status == "running" or .status == "pending")] | length' 2>/dev/null)
[ "${running:-0}" -gt 0 ] && exit 0

/usr/bin/afplay /System/Library/Sounds/Glass.aiff
osascript -e 'display notification "✅タスクが完了しました！" with title "Claude Code" subtitle "🏁処理終了！"'
