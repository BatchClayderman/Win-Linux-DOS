#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

# 修复磁盘
function func_1
{
	for device_name in `fdisk -l | grep -o -P '/dev/[A-Za-z0-9]+'`
	do
		sudo badblocks -v "$device_name" > /tmp/bads.tmp
		sudo fsck -l /tmp/bads.tmp "$device_name"
	done
	rm -f /tmp/bads.tmp
	echo
	read -rsn1 -p "执行操作完成，请按任意键返回。"
	return
}

# 修复文件系统
function func_2
{
	read -rsn1 -p "是否静默修复[y/N]？" tmp
	if [[ $tmp == "Y" ]] || [[ $tmp == "y" ]];
	then
		sudo fsck -y
	else
		sudo fsck -r
	fi
	echo
	read -rsn1 -p "执行操作完成，请按任意键返回。"
	return
}

# 修复引导
function func_3
{
	for device_name in `fdisk -l | grep -o -P '/dev/[A-Za-z0-9]+'`
	do
		sudo mount "$device_name" /mnt
		sudo grub-install --root-directory=/mnt "$device_name"
	done
	sudo update-grub
	echo
	read -rsn1 -p "执行操作完成，请按任意键返回。"
	return
}

# 主面板
choice=1
while [[ $choice != 0 ]]
do
	clear
	echo "多功能修复器（需要超级用户权限）"
	echo -e "\t1 = 修复磁盘（坏道）"
	echo -e "\t2 = 修复文件系统"
	echo -e "\t3 = 修复引导（请在预安装环境下进行）"
	echo -e "\t0 = 退出程序"
	read -rsn1 -p "请选择一项以继续：" choice
	clear
	if [[ $choice == 1 ]];
	then
		func_1
	elif [[ $choice == 2 ]];
	then
		func_2
	elif [[ $choice == 3 ]];
	then
		func_3
	fi
done
exit 0
