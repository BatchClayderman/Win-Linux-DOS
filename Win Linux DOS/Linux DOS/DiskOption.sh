#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

# 整理碎片
function makefrg
{
	clear
	try_time=0
	while [[ "`which e4defrag`" == *"no e4defrag in"* ]] || [[ "`which e4defrag`" == "" ]]; # 找不到
	do
		if [[ $try_time -ge 3 ]];
		then
			clear
			read -rsn1 -p "超过 3 次尝试均未能安装成功，请按任意键返回主面板。"
			return
		fi
		((++try_time))
		echo "未找到 e4defrag，尝试安装中，请稍候！"
		if [[ "`which apt-get`" != *"no apt-get in"* ]] && [[ "`which apt-get`" != "" ]]; # 找到 apt-get
		then
			sudo apt-get install e2fsprogs
		elif [[ "`which yum`" != *"no yum in"* ]] && [[ "`which yum`" != "" ]]; # 找到 yum
		then
			sudo yum install e2fsprogs
		elif [[ "`which pkg`" != *"no pkg in"* ]] && [[ "`which pkg`" != "" ]]; # 找到 pkg
		then
			sudo pkg install e2fsprogs
		else
			read -rsn1 -p "未能找到 e4defrag 或安装 e2fsprogs，请按任意键返回主面板。"
			return
		fi
	done
	sudo e4defrag /
	echo -e "\n"
	read -rsn1 -p "清理完毕，请按任意键返回主面板。"
	return
}

# 主面板
choice=1
while [[ $choice != 0 ]]
do
	clear
	echo "磁盘工具主面板"
	echo -e "\t0 = 退出程序"
	echo -e "\t1 = 显示当前磁盘状态"
	echo -e "\t2 = 检查磁盘"
	echo -e "\t3 = 碎片整理"
	read -rsn1 -p "请选择一项以继续：" choice
	clear
	if [[ $choice == 0 ]];
	then
		exit 0
	elif [[ $choice == 1 ]];
	then
		echo "/****************************** df ******************************/"
		df
		echo -e "\n"
		read -rsn1 -p "信息显示完毕，请按任意键继续。"
	elif [[ $choice == 2 ]];
	then
		diskfrg=`fsck -fn | grep  -i 'non-contiguous' | grep -o -P '\d+\.\d+'`
		if [[ "$diskfrg" == "" ]];
		then
			read -rsn1 -p "出现错误，请按任意键返回。"
			return
		fi
		if [[ $(echo "${diskfrg} >= 20.00" | bc) -eq 1 ]];
		then
			echo "发现 ${diskfrg}% 的碎片，建议进行磁盘碎片整理。"
			read -rsn1 -p "是否立即整理碎片[Y/n]？" c
			if [[ $c == "Y" ]] || [[ $c == "y" ]];
			then
				makefrg
			fi
		else
			read -rsn1 -p "发现 $diskfrg % 的碎片，暂时无需进行磁盘碎片整理。"
		fi
	elif [[ $choice == 3 ]];
	then
		read -rsn1 -p "即将进行碎片整理，耗时可能较长，是否继续[Y/n]？" c
		if [[ $c == "Y" ]] || [[ $c == "y" ]];
		then
			makefrg
		fi
	fi
done