#!/bin/bash
for filepath in "$@"
do
    filename=$(basename -- "$filepath")
    extension="${filename##*.}"
    filename="${filename%.*}"
    
    parent_dir="$(dirname "$filepath")"
    parent_dir="${parent_dir#source/}"
    
        #-H <(echo '\['; cat ./alex-macros.tex; echo '\]') \
    pandoc $filepath \
        --standalone \
        --toc \
        --template=template.html \
        -M toc-title="Contents" \
        -o content/"$parent_dir"/"$filename".html \
        -c "../../stylesheet.css" \
        --extract-media=content/"$parent_dir"
done
