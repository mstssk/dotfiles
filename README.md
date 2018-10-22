# dotfiles

今の所、mac前提

## 使い方

※　事前に Homebrew をインストールしておく https://brew.sh/ 

```
$ cd
$ git clone git@github.com:mstssk/dotfiles.git $HOME/dotfiles
$ cd $HOME/dotfiles
$ ./setup.sh
$ zsh
```

zshをターミナルのデフォルトに設定するなど別途必要

| ターミナルの設定例 |
|:---------------:|
| ![ターミナルの設定例](./doc/terminal_profile.png) |

## よく使うソフト

- https://imageoptim.com/mac
- https://code.visualstudio.com/
- https://docs.docker.com/docker-for-mac/
- https://www.oracle.com/technetwork/java/javase/downloads/index.html
- https://www.tug.org/mactex/

## Visual Studio Code の設定を Dropbox で同期する

Dropbox で既にユーザ設定と拡張機能を `~/Dropbox/Apps/VScode/` というフォルダで同期している前提。
詳細はスクリプトの中身と参考記事を参照。

```
$ ./ln-sync-vscode-by-dropbox.sh
```

参考記事

> Visual Studio Code の設定を共有・バックアップする - Qiita
> https://qiita.com/maromaro3721/items/b6d71a5e5d2d6433778a

## よく使うショートカットキー

| システム設定でショートカットキーを変更 |
|:---------------:|
| ![システム設定でショートカットキーを変更](./doc/keyborad_shortcuts.png) |

----

Inspired by https://github.com/vvakame/dotfiles
