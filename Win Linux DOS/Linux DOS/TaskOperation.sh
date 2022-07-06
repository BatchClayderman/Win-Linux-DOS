#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

for ((;;))
do
	clear
	echo "/********** 任务管理器 **********/"
	ps a l
	pstree -p
	read -r -p "请输入第一次正则表达式：" expression
	expr=$(echo -n "$expression" | sed 's#\\#\\#g') # 只能用 $() 不能用 ``
	pstree -p | grep -o -P "$expr"
	read -rsn1 -p "C = 继续，D = PID 结束，K = 进程名结束，Q = 退出？" choice
	clear
	if [[ $choice == "Q" ]] || [[ $choice == "q" ]];
	then
		exit 0;
	elif [[ $choice == "K" ]] || [[ $choice == "k" ]];
	then
		killall `pstree -p | grep -o -P "$expr" | xargs`
		sleep $(head -5 ./config.ini | tail -1)
	elif [[ $choice == "D" ]] || [[ $choice == "d" ]];
	then
		kill -9 `pstree -p | grep -o -P "$expr" | xargs | grep -o -P '\d+' | xargs`
		sleep $(head -5 ./config.ini | tail -1)
	fi
done
exit 255
