export ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
export RUBYOPT="-W:no-deprecated -W:no-experimental"
export EDITOR="vim"

GPG_TTY=$(tty)
export GPG_TTY
stty sane

[[ ! -f ~/.aliases ]]    || source ~/.aliases
[[ ! -f ~/.completion ]] || source ~/.completion
[[ ! -f ~/.global.env ]] || source ~/.global.env
[[ ! -f ~/.p10k.zsh ]]   || source ~/.p10k.zsh
[[ ! -f ~/.plugins ]]    || source ~/.plugins
[[ ! -f ~/.rubysetup ]]  || source ~/.rubysetup
[[ ! -f ~/.nodesetup ]]  || source ~/.nodesetup
[[ ! -f ~/.pythonsetup ]]  || source ~/.pythonsetup
