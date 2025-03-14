#!/bin/bash -u

cd `dirname $0`

# 参考: https://gist.github.com/juno/5546179
cd ./.zsh/completion/
curl -L -O https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
curl -L -O https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh
mv git-completion.zsh _git

# https://docs.npmjs.com/cli/completion
npm completion > ./npm-completion.bash

# https://github.com/zsh-users/zsh-completions/blob/master/src/_yarn
curl -L -O https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_yarn

if type pnpm; then
   pnpm completion zsh > _pnpm
else
   echo "pnpm is not installed."
fi

rm -f ~/.zcompdump
if [ -x "`which compinit`" ]; then
   compinit
fi
