#!/bin/bash
declare -i num
read -p "Please Enter a number:" num
for ((i=0;i<num;i++));do
	for ((j=0;j<num-1;j++));do
		echo -n "*"
	done
	echo "*"
done
exit 0