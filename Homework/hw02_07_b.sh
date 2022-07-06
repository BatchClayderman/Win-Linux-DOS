#!/bin/bash
read -p "Please input a process name: " pro_name
if [[ $pro_name == *['!'\'\"@#\$%^\&*\(\)\[\]\{\},./?\<\>.]* ]];
then
	echo "Illegal char(s) detected. ";
	exit 255
fi
killall "$pro_name"
exit $?