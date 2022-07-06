#!/bin/bash
declare -i num
read -p "Please Enter a number:" num
for ((i=0;i<num;i++));do
	for ((j=0;j<num;j++));do
		printf "*"
	done
	printf "\n" # echo
done
exit 0