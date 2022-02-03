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
        --template=template.html \
        -M toc-title="Contents" \
        -o "$parent_dir"/"$filename".html \
        -f markdown+tex_math_single_backslash \
        -c "../../stylesheet.css"
done
