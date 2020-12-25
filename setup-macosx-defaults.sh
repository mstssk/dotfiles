#!/bin/bash -u

cd `dirname $0`
set -x

defaults write com.google.Chrome NSRequiresAquaSystemAppearance -bool Yes
defaults write org.cathand.comicviewer NSRequiresAquaSystemAppearance -bool No
defaults write com.apple.screencapture disable-shadow -boolean true

killall SystemUIServer
