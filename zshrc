if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

source ~/.aliases
source ~/.global.env
source ~/.rubysetup

plugins=(git docker docker-compose)
source <(kubectl completion zsh)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export RUBYOPT="-W:no-deprecated -W:no-experimental"
export EDITOR="vim"
GPG_TTY=$(tty)
export GPG_TTY
