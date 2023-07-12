#!/bin/bash

key="com\.apple\.security\.application-groups"
file="$1"

ExtractString(){
	values="$(plutil -extract "$key" xml1 -o - "$file" | 
		sed -n "s/.*<string>\(.*\)<\/string>.*/\1/p")"
}

output=$(<"$file")
index=0

ExtractString
while read -r value; do
	count="$(awk -F'.' '{print NF}' <<< "$value")"
	if [ $count -gt 4 ]; then
	    output="$(plutil -remove "$key.$index" -o - - <<< "$output")"
	    let index=$index-1
	fi
		let index=$index+1
	# fi
done <<< "$values"

echo "$output" > "$file"
