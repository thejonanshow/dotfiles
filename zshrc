if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.aliases
source ~/.global.env
source ~/.rubysetup

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.completion
plugins=(git docker docker-compose)

export RUBYOPT="-W:no-deprecated -W:no-experimental"
export EDITOR="vim"
GPG_TTY=$(tty)
export GPG_TTY
