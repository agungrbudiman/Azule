#!/bin/bash

rootkeys=("files" "files2" "rules" "rules2")
file="$1"

ExtractPlistKey(){
	values="$(plutil -extract "$1" xml1 -o - "$file" | 
		sed -ne "s/.*<key>\(PlugIns.*\)<\/key>.*/\1/p" |
		sed -e 's/\([^\]\)\./\1\\\./g
			t
			s/\\\./\\\\\./g')"
}

for rootkey in "${rootkeys[@]}"
do
	ExtractPlistKey $rootkey
	while read -r key; do
		# echo "$rootkey.$key"
	    plutil -remove "$rootkey.$key" -o "$file" "$file"
	done <<< "$values"
done


