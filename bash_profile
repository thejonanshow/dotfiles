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

source /usr/local/share/chruby/chruby.sh
chruby 2.2.2

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
