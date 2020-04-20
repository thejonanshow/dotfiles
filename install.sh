#!/bin/bash
FILES=$(find . -type f -not -path "./.git/*" -not -path "install.sh" -exec printf '{} ' \;)

for filename in $FILES; do
  ln -s ./$filename ./tmp/.$filename
done
