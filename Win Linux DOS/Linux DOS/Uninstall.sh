#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

# 255 运行参数不通过
# 0 操作成功结束
# 1 用户取消操作
# 2 密码不正确

# 检查运行参数
if [[ "$1" != "/Verify" ]] && [[ "$1" != "--Verify" ]];
then
	declare -i toSleep
	toSleep=$(head -5 ./config.ini | tail -1)
	if [[ $toSleep -le 0 ]];
	then
		toSleep=5
	fi
	echo "Linux DOS 第一代反病毒软件提醒您："
	echo "可疑程序正在尝试卸载 Linux DOS，该卸载操作已被阻止！"
	echo "如果这不是您的主动操作，很可能是因为您的计算机上有间谍软件。"
	echo "如果您想要卸载 Linux DOS，请您到主面板选择“1”，然后卸载。"
	echo "给您带来的不便，敬请谅解！"
	echo "为防止遭到恶意的反复运行，程序将于 $toSleep 秒后自动退出。"
	sleep $toSleep
	clear
	exit 255
fi

# 检查运行身份
if [[ "`whoami`" != "root" ]];
then
	echo "警告：运行身份不是 root 用户，是否提权？"
	echo -e -n "\033[?25h"
	read -rsn1 -p "Y = 提权，N = 继续运行，C = 退出卸载程序。" choice
	echo -e -n "\033[?25l"
	if [[ $choice == "Y" ]] || [[ $choice == "y" ]];
	then
		sudo "$0"
		exit $?
	elif [[ $choice == "C" ]] || [ $choice == "c" ]];
	then
		clear
		exit 1
	fi
fi

# 检查密码
if [[ "$(tail -2 ./config.ini | head -1)" != "0" ]];
then
	echo "您开启了密码保护，请您先检验密码。"
	stty -echo
	read -p "请输入密码：" passwd
	stty echo
	echo
	if [[ `echo -n "$passwd" | sha256sum | awk '{printf $1}'` != "$(tail -1 ./config.ini)" ]];
	then
		echo "密码错误，卸载操作已取消！"
		read -rsn1 -p "请按任意键退出，或稍后重试。"
		clear
		exit 2
	fi
fi

# 打印卸载界面
clear
echo "我们承诺，一般地，我们不会在您的电脑上留下任何走过的痕迹，请放心卸载！"
echo "是否保留 Linux DOS 的 config.ini 配置文件？"
echo -e -n "\033[?25l"
read -rsn1 -p "Y = 保留，N = 删除，C = 退出卸载程序。" choice
if [[ $choice == "C" ]] || [[ $choice == "c" ]];
then
	clear
	exit 1
elif [[ $choice == "Y" ]] || [[ $choice == "y" ]]; # 保留 config.ini
then
	cp ./config.ini /tmp/config.ini
	if [[ ! -e "/tmp/config.ini" ]];
	then
		read -rsn1 -p "保留配置失败，是否继续卸载[y/N]？" YN
		if [[ $YN != "Y" ]] && [[ $YN != "y" ]];
		then
			exit 1
		fi
	fi
fi

# 删除安装目录
clear
echo "正在卸载软件，可能需要几秒钟，请耐心等待。"
rm -rf "${SCRIPT_PATH}"
read -rsn1 -p "卸载完毕，请按任意键退出。"
echo -e -n "\033[?25h"
clear
exit 0
