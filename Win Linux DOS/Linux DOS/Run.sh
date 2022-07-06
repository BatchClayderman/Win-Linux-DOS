#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

if [[ -z "$1" ]];
then
	read -p "请输入启动命令行：" commandline
else
	commandline="$1"
fi

content=`cat /etc/rc.local`
if [[ "${content: -1}" != $'\n' ]];
then
	echo >> /etc/rc.local
fi
echo "$commandline" >> /etc/rc.local
if [[ $? == 0 ]];
then
	read -rsn1 -p "操作成功结束，请按任意键退出。"
else
	read -rsn1 -p "操作失败，请按任意键退出。"
fi
clear
exit 0
