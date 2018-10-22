#!/bin/bash -eu

# Visual Studio Code の設定を共有・バックアップする - Qiita
# https://qiita.com/maromaro3721/items/b6d71a5e5d2d6433778a

DB_USER=~/Dropbox/Apps/VScode/User
DB_EXTS=~/Dropbox/Apps/VScode/extensions

MY_USER=~/Library/Application\ Support/Code/User
MY_EXTS=~/.vscode/extensions

echo "同期するDropboxのフォルダをチェック"
ls "$DB_USER" "$DB_EXTS"
echo "OK!"
echo

echo "シンボリックリンクを貼る先を先に空にしてね"
NG=0
if [ -n "$MY_USER" ]; then
    echo "Clear '$MY_USER' first!"
    NG=1
fi
if [ -n "$MY_EXTS" ]; then
    echo "Clear '$MY_EXTS' first!"
    NG=1
fi
if [ $NG ]; then
    echo "Failed..."
    exit 1
fi

echo "シンボリックリンクを貼る"
ln -s "$DB_USER" "$MY_USER"
ln -s "$DB_EXTS" "$MY_EXTS"

echo "Done!"

# メモ: 最初に環境をDropboxにコピーした時のコマンド
# mkdir -p ~/Dropbox/Apps/VScode/
# cp -R ~/Library/Application\ Support/Code/User ~/Dropbox/Apps/VScode/
# cp -R ~/.vscode/extensions ~/Dropbox/Apps/VScode/
