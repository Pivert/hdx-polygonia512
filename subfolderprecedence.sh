#!/bin/bash

SUBDIRS=$(find . -maxdepth 1 -type d ! -name '.' ! -name '..' ! -name '.*' -printf '%f\n')

count=0
for dir in $SUBDIRS; do
    find "$dir" -mindepth 1 -type f 2>/dev/null | while read -r file; do
        base=$(basename "$file" | sed 's/\.[^.]*$//')
        for match in "${base}"*; do
            if [ -f "$match" ] && [ "$match" != "$file" ]; then
                echo "Delete: $match (matches $file)"
                rm "$match" 2>/dev/null && count=$((count+1))
            fi
        done
    done
done

echo "Deleted $count files"
