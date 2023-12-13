#!/bin/bash

: > css/cd-combined.css
while IFS= read -r -u 3 filename ; do
  # Skip blank lines and commented lines.
  case "$filename" in ''|\#*|\<*) continue ;; esac
  echo "/* $filename */" >> css/cd-combined.css
  while IFS= read -r -u 3 rule ; do
    echo "$rule" >> css/cd-combined.css
  done 3< "$filename"
done 3< _css-files.txt
