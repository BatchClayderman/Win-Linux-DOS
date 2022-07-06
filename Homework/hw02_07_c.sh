#!/bin/bash
declare -i pid
read -p "Please input the process id: " pid
if [[ $pid -ne 0 ]]
then
	kill -9 $pid
fi
exit $?