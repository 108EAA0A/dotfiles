#!/bin/sh

if [ "$(uname)" != "Darwin" ]; then
  echo 'Not macOS!'
  exit
fi

# FIXME: Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

chflags nohidden ~/Library     # ~/Library ディレクトリを見えるようにする
sudo chflags nohidden /Volumes # /Volumes ディレクトリを見えるようにする

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show some bar
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowSidebar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles TRUE

# ゴミ箱を空にする前の警告の無効化
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Avoid creating .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# FIXME: Modify the number of items in the Open Recent menu
defaults write -g 'NSRecentDocumentsLimit' -int 0

# メニュー内の最近使ったアプリを非表示
defaults write com.apple.dock show-recents -bool false

# Dockに最近使ったアプリを表示
# defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }'

# スクロールバーを常時表示
defaults write -g AppleShowScrollBars -string "Always"

# スペルの訂正を無効化
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# クラッシュレポートを無効化
defaults write com.apple.CrashReporter DialogType -string "none"

# 未確認のアプリケーションを実行する際のダイアログを無効化
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ダウンロードしたファイルを開くときの警告ダイアログをなくす
defaults write com.apple.LaunchServices LSQuarantine -bool false

# スクリーンショットのファイル名を変更
defaults write com.apple.screencapture name "SS"

## テキストエディットをプレーンテキストで使う
defaults write com.apple.TextEdit RichText -int 0

# 上記設定後は、Finder と Dock を再起動
killall Finder
killall Dock

#========================== Safari Settings ==========================
# Enable the `Develop` menu and the `Web Inspector`
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
