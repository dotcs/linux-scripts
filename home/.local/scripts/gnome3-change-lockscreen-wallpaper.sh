#!/usr/bin/env bash

# Usage: ./gnome3-change-lockscreen-wallpaper.sh /path/to/wallpaper/folder

FOLDER=$1

if ! [ -d $FOLDER ]; then
    echo "Argument 1 '$FOLDER' is not a valid folder."
    exit 1
fi

source_file=`find -L $FOLDER -iregex ".*?/[^_]*\.jpg" | shuf | head -n 1`
target_file="${FOLDER}/__active.jpg"

rm -f "${target_file}"
ln -s "${source_file}" "${target_file}"

