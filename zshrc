export ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

export RUBYOPT="-W:no-deprecated -W:no-experimental"
export EDITOR="vim"

GPG_TTY=$(tty)
export GPG_TTY

source ~/.aliases
source ~/.completion
source ~/.global.env
source ~/.p10k.zsh
source ~/.plugins
source ~/.rubysetup
