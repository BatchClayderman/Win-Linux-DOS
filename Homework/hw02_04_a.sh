#!/bin/bash
declare -i a # Declare integer type initially
declare -i n
n=$1
if [[ $n -le 1 ]];
then
	read -p "Please enter the number for the upper bound (n > 1): " n # 1000
fi
for ((i=2;i<=n;i++)); # Prime begins from 2
do
	for ((j=2;j*j<=i;j++));
	do
		if [[ i%j -eq 0 ]];
		then
			break
		fi
	done
	if (( j*j > i ));
	then
		echo -n "$i "
	fi
done
echo # To make it look more pretty
exit 0