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

output=$(<"$file")

for rootkey in "${rootkeys[@]}"
do
	ExtractPlistKey $rootkey
	while read -r key; do
		echo "$rootkey.$key"
	    output="$(plutil -remove "$rootkey.$key" -o - - <<< "$output")"
	done <<< "$values"
done

echo "$output" > "$file"
