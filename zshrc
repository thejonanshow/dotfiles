# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
export RUBYOPT="-W:no-deprecated -W:no-experimental"
export EDITOR="vim"
export DOCKER_HOST='unix:///Users/jonan/.local/share/containers/podman/machine/podman-machine-default/podman.sock'

GPG_TTY=$(tty)
export GPG_TTY
# stty sane - not sure why this was here, iterm fancy prompt complained

[[ ! -f ~/.aliases ]]    || source ~/.aliases
[[ ! -f ~/.completion ]] || source ~/.completion
[[ ! -f ~/.global.env ]] || source ~/.global.env
[[ ! -f ~/.p10k.zsh ]]   || source ~/.p10k.zsh
[[ ! -f ~/.plugins ]]    || source ~/.plugins
[[ ! -f ~/.rubysetup ]]  || source ~/.rubysetup
[[ ! -f ~/.nodesetup ]]  || source ~/.nodesetup
[[ ! -f ~/.pythonsetup ]]  || source ~/.pythonsetup

# pnpm
export PNPM_HOME="/Users/jonan/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm endexport PATH="/usr/local/sbin:$PATH"

# homebrew sbin path
export PATH="/usr/local/sbin:$PATH"

# Wasmer
export WASMER_DIR="/Users/jonan/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# To customize prompt, run `p10k configure` or edit ~/src/dotfiles/p10k.zsh.
[[ ! -f ~/src/dotfiles/p10k.zsh ]] || source ~/src/dotfiles/p10k.zsh
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
