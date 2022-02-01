#!/bin/bash
for filepath in "$@"
do
    filename=$(basename -- "$filepath")
    extension="${filename##*.}"
    filename="${filename%.*}"
    
    parent_dir="$(dirname "$filepath")"
    
    pandoc $filepath \
        -H <(echo '\['; cat ./alex-macros.tex; echo '\]') \
        --mathjax \
        --standalone \
        -o "$parent_dir"/"$filename".html \
        -f markdown+tex_math_single_backslash
done
