export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"

if [ -r "/usr/local/bin/nvim" ]; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

export PS1="\[\033[0;34m\]\W\[\033[0m\] \[\033[0;31m\]λ\[\033[0m\] "

l () { command ls -GLA $1; }
ll    () { command ls -Gla $1; }
del  () { command mv "$@" ~/.Trash; }
mkdir () { command mkdir -p $1; }
headcommit () { if [ -d ./.git ]; then git l -1 | cut -c 1-7 | pbcopy; fi; }

if [ -r "/usr/local/etc/profile.d/bash_completion.sh" ]; then

  source /usr/local/etc/profile.d/bash_completion.sh

  if [ -d /usr/local/etc/bash_completion.d ]; then
    for file in $(ls /usr/local/etc/bash_completion.d)
      do source /usr/local/etc/bash_completion.d/$file
    done
  fi
fi
