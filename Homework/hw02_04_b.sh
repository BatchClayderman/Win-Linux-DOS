#!/bin/bash
declare -i a # Declare integer type initially
declare -i n
n=$1
if [[ $n -le 1 ]];
then
	read -p "Please enter the number for the upper bound (n > 1): " n # 1000
fi
a=0
for((i=1;i<=n;i++))
do
	for((j=1;j<=i;j++))
	do
		b=$(( $i%$j ))
		if [[ $b -eq 0 ]];
		then
			a=$a+1
		fi
	done
	if [[ $a -eq 2 ]];
	then
		echo -n "$i "
	fi
	a=0
done
echo # To make it look more pretty
exit 0