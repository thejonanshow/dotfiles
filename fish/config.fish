# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish
set PATH /Users/jonan/bin $PATH
set PATH /Applications/Postgres93.app/Contents/MacOS/bin $PATH
set PATH /usr/local/go/bin $PATH
set PATH /Users/jonan/Dropbox/code/go/bin $PATH

set -Ux LSCOLORS Exfxcxdxbxegedabagacad
set -x DOCKER_HOST 'tcp://localhost:2375'
set -x GOPATH /Users/jonan/Dropbox/code/go
set -x JRUBY_OPTS "--dev"

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
set fish_plugins autojump brew emoji-clock localhost rails rake sublime rbenv

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/fish/custom

function fish_prompt
  ~/bin/powerline-shell.py $status --shell bare
  # printf '%s  %s' (emoji-clock) (~/bin/powerline-shell.py $status --shell bare)
end

# Load oh-my-fish cofiguration.
. $fish_path/oh-my-fish.fish
status --is-interactive; and . (rbenv init -|psub)
