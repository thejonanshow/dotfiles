source ~/.aliases
source ~/.global.env
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby 2.7.0

export PGHOST=localhost
export RUBYOPT="-W:no-deprecated -W:no-experimental"
export ZSH="/Users/jonan/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
plugins=(git docker docker-compose)
source <(kubectl completion zsh)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export ZSH_THEME=powerlevel10k/powerlevel10k

export EDITOR="vim"
GPG_TTY=$(tty)
export GPG_TTY
