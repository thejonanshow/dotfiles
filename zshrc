if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.aliases
source ~/.global.env
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby 2.7.0

source $ZSH/oh-my-zsh.sh
plugins=(git docker docker-compose)
source <(kubectl completion zsh)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export RUBYOPT="-W:no-deprecated -W:no-experimental"
export ZSH="/Users/jonan/.oh-my-zsh"
export EDITOR="vim"
GPG_TTY=$(tty)
export GPG_TTY
