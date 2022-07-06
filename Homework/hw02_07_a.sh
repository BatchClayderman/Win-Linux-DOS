#!/bin/bash
read -p "Please input a process name: " pro_name
if [[ $pro_name == *['!'\'\"@#\$%^\&*\(\)\[\]\{\},./?\<\>.]* ]];
then
	echo "Illegal char(s) detected. ";
	exit 255
fi
process=`ps -ef | grep "$pro_name" | grep -v grep | awk '{print $2}'`
errorlevel=0
for pro in $process;
do
	kill -9 $pro
	if [[ $? -ne 0 ]];
	then
		errorlevel=1
	fi
done
exit $errorlevel