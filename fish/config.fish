# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish
set -Ux LSCOLORS Exfxcxdxbxegedabagacad

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
set fish_plugins autojump brew bundler emoji-clock localhost rails rake rvm sublime

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/fish/custom

function fish_prompt
  ~/bin/powerline-shell.py $status --shell bare
  # printf '%s  %s' (emoji-clock) (~/bin/powerline-shell.py $status --shell bare)
end

# Load oh-my-fish cofiguration.
. $fish_path/oh-my-fish.fish
