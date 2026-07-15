#!/bin/bash -u

cd `dirname $0`

# Claude用設定ファイル
mkdir -p $HOME/.claude

# settings.jsonは端末固有の設定を保持しつつ、リポジトリ側の内容をマージする
if [ ! -e $HOME/.claude/settings.json ]; then
  # ファイルがないときだけ初期ファイル投入
  cp .claude/settings.json $HOME/.claude/settings.json
else
  TMPFILE=`mktemp -t dotfiles-claude-settings`
  echo "TEMPFILE=$TMPFILE"
  jq -s '.[0] * .[1]' $HOME/.claude/settings.json .claude/settings.json > $TMPFILE
  mv $TMPFILE $HOME/.claude/settings.json
fi
