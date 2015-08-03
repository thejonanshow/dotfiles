# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/dotfiles/fish/custom

. $fish_path/oh-my-fish.fish

# I have no idea why these lines are necessary
# They load the Plugin and Theme functions manually but they should have already
# been loaded when we pulled in oh-my-fish.
. ~/.oh-my-fish/functions/Plugin.fish
. ~/.oh-my-fish/functions/Theme.fish

Theme 'bobthefish'
Plugin 'theme'

source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

# fortune | cowsay | lolcat
