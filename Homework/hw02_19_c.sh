#!/bin/bash
declare -i num
read -p "Please Enter a number:" num
toDisplay=""
for ((i=0;i<num;i++));do
	toDisplay=$toDisplay"*" # Concatenate strings
done
for ((i=0;i<num;i++));do
	echo "$toDisplay"
done
exit 0