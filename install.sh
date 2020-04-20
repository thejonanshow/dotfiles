#!/bin/bash
FILES=$(find . -type f -not -path "./.git/*" -not -path "./install.sh" -not -path "./*.swp" -exec basename '{} ' \;)
blue="\033[1;94m"
yellow="\033[1;93m"
red="\033[1;91m"
green="\033[1;92m"
reset="\033[0m"

for filename in $FILES; do
  existing_file="$HOME/.$filename"
  new_target="$PWD/$filename"

  if [[ -f $existing_file ]] && [[ "$(readlink $existing_file)" == "$new_target" ]]; then
    printf "$blue $(basename $new_target) unchanged $reset\n"
    continue
  elif [[ -f $existing_file ]]; then
    answer="none"
    while [[ "$answer" =~ [^yNdq] ]] 
    do
      printf "$red File $existing_file exists and contents do not match $new_target, proceed anyway? [y/N/(d)iff/(q)uit]$reset\n"
      printf " > "

      read answer
      [[ "$answer" =~ [^yNdq] ]] && printf "$yellow Invalid answer: $answer $reset\n"
    done

    [[ "$answer" == "q" ]] && exit

    if [[ "$answer" == "N" ]]; then
      printf "$yellow Skipping $new_target $reset\n"
    elif [[ "$answer" == 'y' ]]; then
      printf "$yellow rm $existing_file $reset\n"
      rm $existing_file

      printf "$yellow ln -s $new_target $existing_file $reset\n"
      ln -s $new_target $existing_file

      answer="none"
    elif [[ "$answer" == 'd' ]]; then
      paste -d \\n "$existing_file" "$new_target" | awk 'NR%2 == 0 { print "\033[1;94m" $0 "\033[0m"; next } { print "\033[1;90m" $0 "\033[0m"}' | less
    fi
  else
    printf "$green $(basename $new_target) linked $reset\n"
    ln -s $new_target $existing_file
  fi
done
