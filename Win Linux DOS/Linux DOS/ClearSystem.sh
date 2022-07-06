#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

# 执行第一次清理
sync
read -rsn1 -p "您的系统现在是否还卡[y/N]？" choice
if [[ $choice != "Y" ]] && [[ $choice != "y" ]];
then
	clear
	echo -e "清理完毕！\n"
	exit 0;
fi

if [[ "$DESKTOP_SESSION" == "" ]];
then
	# 执行第二次清理
	echo "检测到无 GUI 服务器。"
	sync
	sync
	echo 1 > /proc/sys/vm/drop_caches # 服务器执行 1 即可
	read -rsn1 -p "您的系统现在是否还卡（若还卡只能执行重启）？[y/N]" choice
	if [[ $choice != "Y" ]] && [[ $choice != "y" ]];
	then
		clear
		echo -e "清理完毕！\n"
		exit 0
	fi
else
	# 执行第二次清理
	sync
	sync
	echo 3 > /proc/sys/vm/drop_caches # 非服务器执行 3
	read -rsn1 -p "您的系统现在是否还卡？[y/N]" choice
	if [[ $choice != "Y" ]] && [[ $choice != "y" ]];
	then
		clear
		echo -e "清理完毕！\n"
		exit 0
	fi
	
	# 执行第三次清理
	sudo systemctl restart lightdm
	read -rsn1 -p "您的系统现在是否还卡（若还卡只能执行重启）？[y/N]" choice
	if [[ $choice != "Y" ]] && [[ $choice != "y" ]];
	then
		clear
		echo -e "清理完毕！\n"
		exit 0
	fi
fi
	
# 执行最后一次清理
clear
sudo reboot
exit 0