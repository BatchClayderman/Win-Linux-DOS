#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

systemtime=`date "+%Y-%m-%d %H:%M:%S"` # 获取系统时间
echo "原系统时间：$systemtime"
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 1> /dev/null 2>&1 &
date -s "$(wget -qO- -t1 -T2 http://s.yzw6.cn/linux_time.php)" 1> /dev/null 2>&1 &
systemtime=`date "+%Y-%m-%d %H:%M:%S"` # 获取系统时间
echo "新系统时间：$systemtime"
sleep $(head -5 ./config.ini | tail -1)
clear
exit 0
