#!/bin/bash -u

cd `dirname $0`

# 参考: https://gist.github.com/juno/5546179
cd ./.zsh/completion/
curl -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
curl -O https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh
mv git-completion.zsh _git

# https://docs.npmjs.com/cli/completion
npm completion > ./.zsh/completion/npm-completion.bash

rm -f ~/.zcompdump; compinit
