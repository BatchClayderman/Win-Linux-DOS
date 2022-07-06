#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

if [[ -n "$1" ]];
then
	path="$1"
else
	read -p "请输入文件路径：" path
fi

if [[ -e "$path" ]];
then
	if [[ `ls -al "$path" | grep -o '\->'` == '->' ]];
	then
		echo "发现软连接！"
		ls -al "$path"
	elif [[ `head -1 "$path"` == "[Desktop Entry]" ]] && [[ `grep 'Exec=' "$path"` == 'Exec='* ]];
	then
		target=`grep 'Exec=' "$path"`
		echo "发现快捷方式：\"${target#Exec=}\""
	else
		echo "未发现链接行为。"
	fi
	read -rsn1 -p "操作成功结束，请按任意键退出。"
	clear
	exit 0
else
	echo "系统找不到指定的文件。"
	read -rsn1 -p "操作失败，请按任意键退出。"
	clear
	exit 1
fi
