#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -3 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

function do_log
{
	echo "m" > /proc/sysrq-trigger # 内存
	echo "p" > /proc/sysrq-trigger # CPU
	echo "t" > /proc/sysrq-trigger # 线程状态
	return
}

echo "当系统遇到（内核）驱动级病毒或者灾难性木马时，重启或者强制重启不但不能结束它们，反而会给它们提供爆发的温床。出于保护考虑，火绒、微点等第三代反病毒软件在遇到此类病毒时，都会故意触发系统蓝屏或崩溃以防止更严重的破坏，尤其在 Windows XP 上。"
echo -e "\tb = 使计算机重启（不确定是否为驱动级重启）"
echo -e "\tc = 使计算机崩溃"
echo -e "\to = 使计算机关机（不确定是否为驱动级关机）"
echo -e "\ts = 重新挂载所有文件系统"
echo -e "\tu = 挂载所有文件系统为只读"
echo -e "\tL = 记录日志"
echo -e "\tQ = 退出程序"
read -rsn1 -p "请选择一项以继续：" choice
if [[ $choice == "b" ]] || [[ $choice == "B" ]] || [[ $choice == "c" ]] || [[ $choice == "C" ]] || [[ $choice == "o" ]] || [[ $choice == "O" ]] || [[ $choice == "s" ]] || [[ $choice == "S" ]] || [[ $choice == "u" ]] || [[ $choice == "U" ]];
then
	do_log
	echo $choice | tr A-Z a-z > /proc/sysrq-trigger
	exit 2
elif [[ $choice == "L" ]] || [[ $choice == "l" ]];
then
	do_log
	clear
	exit 1
elif [[ $choice == "Q" ]] || [[ $choice == "q" ]];
then
	clear
	echo -e "用户正常退出。\n"
	exit 0
else
	clear
	echo -e "用户放弃操作。\n"
	exit 255
fi