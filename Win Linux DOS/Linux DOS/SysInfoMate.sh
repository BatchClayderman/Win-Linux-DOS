#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

echo "/****************************** 系统信息 ******************************/"
uname -a
dmidecode -t 1
echo
echo
sleep $(head -5 ./config.ini | tail -1)
echo "/******************** 主板信息 ********************/"
dmidecode -t 2
echo
echo
echo "/******************** CPU 信息 ********************/"
echo "个数：`cat /proc/cpuinfo | grep 'physical id' | sort | uniq | wc -l`"
echo "核数：`cat /proc/cpuinfo | grep 'core id' | wc -l`"
echo "CPU ID："
dmidecode -t 4 | grep ID
echo "其它信息："
dmidecode -t processor
echo
echo
sleep $(head -5 ./config.ini | tail -1)
echo "/******************** 内存 ********************/"
dmidecode|grep -P -A5 "Memory\s+Device"|grep Size|grep -v Range
dmidecode -t 16
sleep $(head -5 ./config.ini | tail -1)
echo
echo
echo "/****************************** 磁盘 ******************************/"
df
echo
echo
sleep $(head -5 ./config.ini | tail -1)
echo "/****************************** 总线 ******************************/"
lspci
echo
echo
sleep $(head -5 ./config.ini | tail -1)
echo "/****************************** 其它硬件信息 ******************************/"
lshw
sleep $(head -5 ./config.ini | tail -1)
clear
exit 0
