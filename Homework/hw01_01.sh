#!/bin/bash

# Compare a with b
# 
# a > b -> 1
# a < b -> 2
# a == b -> 0
# Error -> -1 (255)

# Get input
a=$1
b=$2
if [[ -z "$a" ]]; then
	read -p "Please enter the first number: " a
fi
if [[ -z "$b" ]]; then
	read -p "Please enter the second number: " b
fi

# Print input
echo "a = $a"
echo "b = $b"

# Check
errorlevel=-1
tmp_a=${a//\./}
tmp_a=${tmp_a//\-/}
tmp_a=${tmp_a//[0-9]/}
#echo $tmp_a
tmp_b=${b//\./}
tmp_b=${tmp_b//\-/}
tmp_b=${tmp_b//[0-9]/}
#echo $tmp_b
cnt_a1=`echo "$a" | grep -o "\." | wc -l` # Count . (Please note that . is RE)
cnt_a2=`echo "$a" | grep -o "\-" | wc -l` # Count -
cnt_a3=`echo "${a:1}" | grep -o "\-" | wc -l` # Make - in the first location
cnt_a4=`echo "$a" | grep -o "[0-9]" | wc -l` # Make sure there are digits existing
cnt_b1=`echo "$b" | grep -o "\." | wc -l`
cnt_b2=`echo "$b" | grep -o "\-" | wc -l`
cnt_b3=`echo "${b:1}" | grep -o "\-" | wc -l`
cnt_b4=`echo "$b" | grep -o "[0-9]" | wc -l`
if [[ -n $tmp_a || $cnt_a1 -gt 1 || $cnt_a2 -gt 1 || $cnt_a3 -gt 0 || $cnt_a4 -lt 1 || -n $tmp_b || $cnt_b1 -gt 1 || $cnt_b2 -gt 1 || $cnt_b3 -gt 0 || $cnt_b4 -lt 1 ]]; then # Too many "." or "-" illegal
	echo "Illegal input, please check your input. "
	exit $errorlevel
fi

# Compare
d=`echo "$a > $b" | bc`
if [[ $d -eq 1 ]]; then # >
	echo "a = $a > $b = b"
	errorlevel=1
elif [[ $d -eq 0 ]]; then # <
	d=`echo "$b > $a" | bc`
	if [[ $d -eq 1 ]]; then # =
		echo "a = $a < $b = b"
		errorlevel=2
	elif [[ $d -eq 0 ]]; then
		echo "a = $a = $b = b"
		errorlevel=0
	fi
fi
exit $errorlevel