#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

echo "由于 Linux 操作系统自带有适用于控制台的进程实时查看工具，"
echo "数秒完成后，将自动启动。"
sleep $(head -5 ./config.ini | tail -1)
if [[ "`which htop`" != *"no htop in"* ]] && [[ "`which htop`" != "" ]]; # 存在 htop
then
	htop
else
	top
fi
clear
exit 0
