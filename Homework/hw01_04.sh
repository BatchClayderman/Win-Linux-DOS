#!/bin/bash

# If exists
# 
# not exists -> -1
# -d dir -> 0b10000
# -e file -> 0b00000 {
# 	-L symbol_link || -h soft_link -> 0b01000
# 	-r readable -> 0b00100
# 	-w writable -> 0b00010
# 	-x executable -> 0b00001
# }

# Get input
pwd=`pwd`
echo "Current working directory: $pwd"
target=$1
if [[ -z "$target" ]]; then
	read -p "Please enter the filepath: " target
fi
if [[ "$target" == *"/"* ]]; then
	echo "Warning: Path seperator found, it may not be limited to current folder. "
fi

# Judge
errorlevel=-1
if [[ -d "$target" ]]; then
	echo "The path exists and it is a directory. "
	errorlevel=16 # 0b10000
elif [[ -e "$target" ]]; then
	echo "The path exists and it is a file. "
	errorlevel=0 # 0b00000
	if [[ -L "$target" ]]; then
		echo "The file is a link file. "
		((errorlevel=errorlevel+8))
	elif [[ -r "$target" ]]; then
		echo "The file is readable. "
		((errorlevel=errorlevel+4))
	elif [[ -w "$target" ]]; then
		echo "The file is writable. "
		((errorlevel=errorlevel+2))
	elif [[ -x "$target" ]]; then
		echo "The file is executable. "
		((errorlevel=errorlevel+1))
	fi
else
	echo "The path does not exist. "
fi
exit $errorlevel