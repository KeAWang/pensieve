#!/bin/bash
for filepath in "$@"
do
    filename=$(basename -- "$filepath")
    extension="${filename##*.}"
    filename="${filename%.*}"
    
    parent_dir="$(dirname "$filepath")"
    
        #-H <(echo '\['; cat ./alex-macros.tex; echo '\]') \
    pandoc $filepath \
        --mathjax \
        -H header.txt \
        --standalone \
        --toc \
        --template=bootstrap_menu.html \
        -o "$parent_dir"/"$filename".html \
        -f markdown+tex_math_single_backslash
done
