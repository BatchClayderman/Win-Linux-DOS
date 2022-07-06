#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录

if [[ `cat ./config.ini | wc -l` != 7 ]];
then
	echo "当前配置文件疑似存在问题，请考虑重置设置。"
	echo "程序将于 5 秒后自动退出。"
	sleep 5
	clear
	exit 2
fi

declare -i countdown errorlevel
countdown=$(head -5 ./config.ini | tail -1)
hashcode=$(tail -1 ./config.ini)
errorlevel=0

if [[ "$1" == "--open" ]];
then
	chmod 666 ./config.ini
	sed -i '6c1' ./config.ini
	chmod 444 ./config.ini
	echo "操作成功结束，即将返回。"
	sleep $countdown
	exit 0
elif [[ "$1" == "--close" ]] || [[ "$1" == "--change" ]];
then
	if [[ "`tail -2 ./config.ini | head -1`" != "0" ]];
	then
		stty -echo
		read -p "请输入当前密码：" pwd
		stty echo
		echo
		if [[ `echo -n "$pwd" | sha256sum | awk '{print $1}'` != `tail -1 ./config.ini` ]];
		then
			echo "密码不正确，即将返回。"
			sleep $countdown
			exit 3
		fi
	fi
	if [[ "$1" == "--close" ]];
	then
		chmod 666 ./config.ini
		sed -i '6c0' ./config.ini
		chmod 444 ./config.ini
	else
		stty -echo
		read -p "请输入新密码：" pwd
		stty echo
		echo
		read -rsn1 -p "启动密码吗[Y/n/c]？" YNC
		echo
		new_hash=`echo -n "$pwd" | sha256sum | awk '{print $1}'`
		chmod 666 ./config.ini
		sed -i "7c${new_hash}" ./config.ini
		if [[ $YNC == "N" ]] || [[ $YNC == "n" ]];
		then
			sed -i '6c0' ./config.ini
		elif [[ $YNC != "C" ]] && [[ $YNC != "c" ]];
		then
			sed -i '6c1' ./config.ini
		fi
		chmod 444 ./config.ini
	fi
	echo "操作成功结束，即将返回。"
	sleep $countdown
	exit 0
fi

echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

echo "本程序为 Windows 操作系统下用于处理密码中特殊字符的辅助程序。"
echo "由于 Linux shell 命令的变量比对时并不是单纯地将变量转换为字符串后执行整个命令。"
echo "因此，此脚本已弃用。"
if [[ $(tail -2 ./config.ini | head -1) == "0" ]];
then
	echo "当前密码保护状态：未启动。"
else
	echo "当前密码保护状态：已启动。"
fi

if [[ ${#hashcode} == 64 ]]; # ${#var}获取变量长度
then
	echo "当前密码状态：已设置。"
elif [[ ${#hashcode} -gt 1 ]];
then
	echo "当前密码状态：已被破坏（请重新设置）。"
	errorlevel=1
else
	echo "当前密码状态：未设置。"
fi
echo "程序将于 $countdown 秒后自动退出。"
sleep $countdown
clear
exit $errorlevel
