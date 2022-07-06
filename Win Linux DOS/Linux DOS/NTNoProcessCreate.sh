#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

ori=" `pstree -p | grep -o -P '\d+' | xargs` " # 多两个空格好标记
for ((;;))
do
	to_txt=`pstree -p | grep -o -P '\d+'` # 避免一直在结束已经退出的 pstree 等进程
	echo "$to_txt" | while read line
	do
		from_txt=" `pstree -p $$ | grep -o -P '\d+' | xargs` " # 排除子进程
		if [[ "${ori}" != *" ${line} "* ]] && [[ "${from_txt}" != *" ${line} "* ]];
		then
			if [[ " `pstree -p | grep -o -P '\d+' | xargs` " == *" ${line} "* ]]; # 再次确认进程存在
			then
				echo kill -9 ${line}
				kill -9 ${line} 1>/dev/null 2>&1
			fi
		fi
	done
done
exit 0