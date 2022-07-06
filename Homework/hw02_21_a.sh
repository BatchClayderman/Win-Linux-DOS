#!/bin/bash
read -p "Please input filepath: " file
if [[ ! -e "$file" ]];
then
	echo "File not exists. "
	exit 1
fi
cat "$file" | awk '!a[$0]++ {print}'
exit 0