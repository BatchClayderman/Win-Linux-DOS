#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini|tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

# 展示可用的 shell
function show_shells
{
	echo "当前终端：$SHELL"
	echo -n "当前脚本："
	ps | grep $$ | awk '{print $4}'
	grep -v '^$' /etc/shells | cat -b
	return `grep -v '^$' /etc/shells | wc -l`
}

# 直接启动
function func_1
{
	echo "/******************** 直接启动 ********************/"
	declare -i c cnt
	show_shells
	cnt=$?
	read -rsn1 -p "请选择一项以继续（输入其它字符将返回主面板）：" c
	if [[ $c -ge 1 ]] && [[ $c -le $cnt ]]; # 正确输入
	then
		clear # 提前清屏
		`grep -v '^$' /etc/shells | head "-$c" | tail -1`
		iRet=$? # 提前保存
		echo -e "\033[?25l" # 多打印一行并隐藏光标
		read -rsn1 -p "进程已退出，返回值为 ${iRet}，请按任意键返回主面板。"
		echo -e "\033[?25h" # 恢复光标显示
	fi
	return
}

# 后台启动
function func_2
{
	echo "/******************** 后台启动 ********************/"
	declare -i c cnt
	show_shells
	cnt=$?
	read -rsn1 -p "请选择一项以继续（输入其它字符将返回主面板）：" c
	if [[ $c -ge 1 ]] && [[ $c -le $cnt ]]; # 正确输入
	then
		`grep -v '^$' /etc/shells | head "-$c" | tail -1` &
		echo -e "$c\033[?25l" # 多打印一行并隐藏光标
		read -rsn1 -p "进程已启动，请按任意键返回主面板。"
		echo -e "\033[?25h" # 恢复光标显示
	fi
	return
}

# Screen 启动
function func_3
{
	try_time=0
	while [[ "`which screen`" == *"no screen in"* ]] || [[ "`which screen`" == "" ]]; # 找不到
	do
		if [[ $try_time -ge 3 ]];
		then
			clear
			read -rsn1 -p "超过 3 次尝试均未能安装成功，请按任意键返回主面板。"
			return
		fi
		((++try_time))
		echo "未找到 screen，尝试安装中，请稍候！"
		if [[ "`which apt-get`" != *"no apt-get in"* ]] && [[ "`which apt-get`" != "" ]]; # 找到 apt-get
		then
			sudo apt-get install screen
		elif [[ "`which yum`" != *"no yum in"* ]] && [[ "`which yum`" != "" ]]; # 找到 yum
		then
			sudo yum install screen
		elif [[ "`which pkg`" != *"no pkg in"* ]] && [[ "`which pkg`" != "" ]]; # 找到 pkg
		then
			sudo pkg install screen
		else
			read -rsn1 -p "未能安装 screen，请按任意键返回主面板。"
			return
		fi
	done
	
	echo "/******************** Screen 启动 ********************/"
	declare -i c cnt
	show_shells
	cnt=$?
	read -rsn1 -p "请选择一项以继续（输入其它字符将返回主面板）：" c
	if [[ $c -ge 1 ]] && [[ $c -le $cnt ]]; # 正确输入
	then
		randint=$RANDOM
		while [[ "`screen -list | grep LinuxDOS${randint}`" != "" ]]; # 有窗口时
		do
			randint=$RANDOM
		done
		screen -dmS "LinuxDOS${randint}" -s "`grep -v '^$' /etc/shells | head "-$c" | tail -1`"
		echo -e "$c\033[?25l" # 多打印一行并隐藏光标
		read -rsn1 -p "Screen 已启动，窗口名为 LinuxDOS${randint}，请按任意键返回主面板。"
		echo -e "\033[?25h" # 恢复光标显示
	fi
	return
}

# 主面板
choice=1
while [[ $choice != 0 ]]
do
	clear
	echo "终端启动器主面板"
	echo -e "\t0 = 退出程序"
	echo -e "\t1 = 直接启动"
	echo -e "\t2 = 后台启动"
	echo -e "\t3 = Screen 启动"
	read -rsn1 -p "请选择一项以继续：" choice
	clear
	if [[ $choice == 1 ]];
	then
		func_1
		clear
	elif [[ $choice == 2 ]];
	then
		func_2
	elif [[ $choice == 3 ]];
	then
		func_3
	fi
done
exit 0
