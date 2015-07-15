# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish
set PATH /Users/jonan/bin $PATH
set PATH /Applications/Postgres93.app/Contents/MacOS/bin $PATH
set PATH /usr/local/go/bin $PATH
set PATH /Users/jonan/Dropbox/code/go/bin $PATH
set PATH /Users/jonan/Library/Android/sdk/platform-tools $PATH
set PATH /Users/jonan/Library/Android/sdk/build-tools/21.0.2 $PATH
set PATH /Users/jonan/Library/Android/sdk/build-tools/21.0.2 $PATH
set PATH /usr/local/texlive/2014/bin $PATH
set PATH /usr/local/texlive/2014/bin/x86_64-darwin $PATH

set -Ux LSCOLORS Exfxcxdxbxegedabagacad
set -x GOPATH /Users/jonan/Dropbox/code/go
set -x JRUBY_OPTS "--dev"
set -x DOCKER_HOST tcp://192.168.59.103:2376
set -x DOCKER_CERT_PATH /Users/jonan/.boot2docker/certs/boot2docker-vm
set -x DOCKER_TLS_VERIFY 1
set -x FERRIS_URL http://localhost:3000
set -x PROJECT_HOME /Users/jonan/Dropbox/code/python

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/fish/custom

function fish_prompt
  ~/bin/powerline-shell.py $status --shell bare
  # printf '%s  %s' (emoji-clock) (~/bin/powerline-shell.py $status --shell bare)
end

# Load oh-my-fish cofiguration.
. $fish_path/oh-my-fish.fish
set -gx RBENV_ROOT /usr/local/var/rbenv
. (rbenv init -|psub)

# Setup pyenv
set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
pyenv rehash

eval (python -m virtualfish auto_activation global_requirements projects)

# fortune | cowsay | lolcat
