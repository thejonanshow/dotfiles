source /usr/local/share/chruby/chruby.sh
chruby 2.5

for file in ~/.{bash_prompt,bash_scripts,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done

for file in /usr/local/etc/bash_completion.d/{docker,docker-compose,git-completion.bash,tmux}; do
  [ -r "$file" ] && source "$file"
done

for file in ~/.local_scripts/*; do
  [ -r "$file" ] && source "$file"
done
unset file

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
complete -W "NSGlobalDomain" defaults

# source /usr/local/bin/virtualenvwrapper.sh
# check_for_virtual_env

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jscheffler/src/google-cloud-sdk/path.bash.inc' ]; then source '/Users/jscheffler/src/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jscheffler/src/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/jscheffler/src/google-cloud-sdk/completion.bash.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="$HOME/.cargo/bin:/usr/local/sbin:$PATH"
