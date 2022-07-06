#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

for ((;;))
do
	if [[ "`which nmap`" == *"no nmap in"* ]] || [[ "`which nmap`" == "" ]]; # 找不到
	then
		for ((port=0; port < 65536; ++port))
		do
			if [[ `lsof -i:$port` != "" ]];
			then
				echo "/****************************** $port ******************************/"
				lsof -i:$port
				echo
			fi
		done
	else
		nmap -sV localhost || nmap -Pn localhost # blocking can try Pn
		echo
	fi
	sleep $(head -5 ./config.ini | tail -1)
done
clear
exit 0
