#!/bin/bash
errorlevel=0
mkdir ./tmp
files=`find ./ -maxdepth 1 -type f -size +10k`
for file in $files;
do
	mv $file ./tmp/
	if [[ $? -ne 0 ]];
	then
		errorlevel=1 # No need to print any error prompt since `mv` would do that
	fi
done
exit $errorlevel