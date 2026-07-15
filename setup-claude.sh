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
  jq -s '.[0] * .[1]' $HOME/.claude/settings.json .claude/settings.json > $TMPFILE

  if diff -q $HOME/.claude/settings.json $TMPFILE > /dev/null; then
    echo ".claude/settings.json: 変更なし"
    rm -f $TMPFILE
  else
    echo ".claude/settings.json: 以下の差分をマージしようとしています"
    diff -u $HOME/.claude/settings.json $TMPFILE
    read -p "この内容を反映しますか? [y/N] " ANSWER
    if [[ "$ANSWER" =~ ^[Yy]$ ]]; then
      mv $TMPFILE $HOME/.claude/settings.json
      echo ".claude/settings.json: 反映しました"
    else
      rm -f $TMPFILE
      echo ".claude/settings.json: スキップしました"
    fi
  fi
fi
