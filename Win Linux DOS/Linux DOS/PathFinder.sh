#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

function find_element
{
	if [[ "`which $1`" != *"no $1 in"* ]] && [[ "`which $1`" != "" ]]; # 找到
	then
		whereis "$1"
		$2 # 找到则执行
	else
		echo "$1：未安装或未部署。"
	fi
	return
}

env
find_element "nginx" "nginx -t"
find_element "apache2" "apache2 -t"
find_element "php" "php --version"
find_element "python2" "python2 -V"
find_element "python3" "python3 -V"
find_element "pip" "pip -V"
sleep $(head -5 ./config.ini | tail -1)
clear
exit 0
