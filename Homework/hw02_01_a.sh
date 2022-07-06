#!/bin/bash
if [[ ! -e "test.txt" ]];
then
	echo "File not exists. "
	exit 1
fi
toCheck=`cat "test.txt" | wc -l`
if [[ $toCheck -lt 23 ]];
then
	echo "There are fewer than 23 lines. "
	exit 1
fi
sed -i '23s/test/tset/g' test.txt # Use "-i" to perform in-place modification
exit 0