#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

N=20
length=$[$[$[`stty size | awk '{print $1}'`-1]*`stty size | awk '{print $2}'`]-2] # 减少一行再减少两个字符
array_lists=(0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z)
space_lists=""
for ((i = 0; i < length; ++i));
do
	space_lists=" $space_lists"
done

function doPlay
{
	n=$[N-$1]
	for ((i = 0; i < n; ++i));
	do
		answer=${array_lists[$[RANDOM%62]]} # 产生随机按键
		clear
		echo "难度系数：$1，屏幕宽度：$length，进度：$i / $n。"
		echo -n "$space_lists" | head "-$[$[RANDOM%length]]c" # 产生随机空格
		echo -n "$answer" # 显示随机按键
		declare starttime=`date +%s%N`
		read -rsn1 pressed # 用户的按键
		declare endtime=`date +%s%N`
		c=`expr $endtime - $starttime`
		c=`expr $c / 1000000`
		if [[ `echo "$c >= ${1}0$n" | bc` -eq 1 ]] || [[ "$answer" != "$pressed" ]];
		then
			clear
			echo "难度系数：$1，屏幕宽度：$length，进度：$i / $n。"
			if [[ "$answer" != "$pressed" ]]; # 这个条件比另外一个条件节能
			then
				echo "按键出错！您的按键为：$pressed，正确答案：$answer。"
			else
				echo "超时啦！您的用时：$c 毫秒。"
			fi
			read -rsn1 -p "哦吼，你输了！按任意键返回主面板吧！"
			return
		fi
	done
	clear
	if [[ "$1" -le 0 ]];
	then
		echo "您的手速已经超过了光速，可以挑战《匈牙利狂想曲第二号》《幻想即兴曲》《月光奏鸣曲》《革命练习曲》《冬风练习曲》等高难度曲子了。"
		read -rsn1 -p "请按任意键退出。"
		return
	fi
	read -rsn1 -p "恭喜！你赢了，是否再来一局[Y/n]？" YN
	if [[ "$YN" != "N" ]] && [[ "$YN" != "n" ]];
	then
		doPlay "$[$1-1]"
	fi
	return
}

declare -i hard_index choice
hard_index=1
echo -e "\033[?25l"
while [[ $hard_index != 10 ]];
do
	clear
	echo "此工具用于测试屏幕显示和键盘按键，请注意区分以下字符："
	echo "  0Oo  iI1lL  UuvV  Cc  Kk  Pp  Ss  Ww  "
	echo
	read -rsn1 -p "请选择难度开始（难1-9易）：" choice
	if [[ $choice == 0 ]];
	then
		hard_index=10
	elif [[ $choice -ge 1 ]] && [[ $choice -le 9 ]];
	then
		hard_index=choice
		doPlay $hard_index
	fi
done
clear
echo -e -n "\033[?25h"
exit 0
