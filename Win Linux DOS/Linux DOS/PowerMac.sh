#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

echo "/********** 电源相关操作主面板 **********/"
echo -e "\t1 = 中止关机或重启\n\t2 = 立即停止机器\n\t3 = 立即重启"
echo -e "\t4 = 立即关机\n\t5 = 强制重启或关机（危险）\n\t0 = 退出程序"
read -rsn1 -p "您想要 Linux DOS 为您做些什么？请选择一项以继续：" choice
clear
case "$choice" in
"1")
	shutdown -c
	;;
"2")
	shutdown -h 0
	;;
"3")
	shutdown -r 0
	reboot
	;;
"4")
	shutdown -P 0
	;;
"5")
	pids=`pstree -p | grep -o -P '\d+' | xargs`
	kill -9 $pids
	reboot
	;;
"0")
	clear
	exit 0
	;;
*)
	echo "无效输入，未进行任何操作。"
esac
echo "程序将于数秒完成后自动退出。"
sleep $(head -5 ./config.ini | tail -1)
clear
exit 0
