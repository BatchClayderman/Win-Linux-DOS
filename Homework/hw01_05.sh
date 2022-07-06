#!/bin/bash

# 100th line
# 
# EXIT_SUCCESS = 1
# EXIT_FAILURE = 0

# Get input
target=$1
if [[ -z "$target" ]]; then
	read -p "Please enter the filepath: " target
fi

# Check
./hw01_04_exists.sh "$target"
if [[  $? -eq 0 || $? -eq 255 ]]; then
	echo "The specified file does not exist. "
	exit -1
fi
toCheck=`cat "$target" | wc -l`
echo "Gather $toCheck lines. "
if [[ "$toCheck" -lt 100 ]]; then
	echo "There are fewer than 100 lines in the specified file. "
	exit 1
fi

# Read
echo -e "\e[1;31mMethod 1: \e[0m"
sed -n '100p' "$target"
echo -e "\e[1;31mMethod 2: \e[0m"
head -100 "$target" | tail -1
echo -e "\e[1;31mMethod 3: \e[0m"
((cut=toCheck-99))
tail -"$cut" "$target" | head -1
echo -e "\e[1;31mMethod 4: \e[0m"
cat "$target" | awk "NR==100"
exit 0