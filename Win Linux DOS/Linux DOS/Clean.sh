#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

echo "垃圾清理对象："
echo -e "\t1．sync；"
echo -e "\t2．drop_caches；"
echo -e "\t3．/tmp 和 /var/tmp。"
echo "数秒完成后，将开始清理。"
sleep $(head -5 ./config.ini | tail -1)
echo
echo
sync
sync
echo "3 的阶段 1 完成，数秒完成后进入下一阶段。"
sleep $(head -5 ./config.ini | tail -1)
if [[ "$DESKTOP_SESSION" == "" ]];
then
	echo 1 > /proc/sys/vm/drop_caches # 服务器执行 1 即可
else
	echo 3 > /proc/sys/vm/drop_caches # 非服务器执行 3
fi
echo "3 的阶段 2 完成，数秒完成后进入下一阶段。"
sleep $(head -5 ./config.ini | tail -1)
rm -rf /tmp/*
rm -rf /var/tmp/*
echo "3 的阶段 3 完成，数秒完成后程序将退出。"
sleep $(head -5 ./config.ini | tail -1)
echo
echo
echo
clear
exit 0
