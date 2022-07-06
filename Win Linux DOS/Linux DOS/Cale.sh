#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

# 随机小数值自然数
function func_1_1
{
	declare -i LB UB stop_1_1
	read -p "请设置下界（最小 0）：" LB
	read -p "请设置上界（最大 32767）：" UB
	if [[ $LB -gt $UB ]];
	then
		echo "无法产生随机数，下界大于上界。"
		read -rsn1 -p "请按任意键返回主面板。"
		return
	fi
	if [[ $LB -lt 0 ]] || [[ $UB -gt 32767 ]];
	then
		echo "范围太大，请使用方法二生成。"
		read -rsn1 -p "请按任意键返回主面板。"
		return
	fi
	echo
	stop_1_1=1
	while [[ $stop_1_1 != 0 ]];
	do
		echo $[$[$RANDOM%$[$UB-$LB]]+$LB]
		read -rsn1 -p "按 0 中止，其它数字继续生成：" stop_1_1
		echo -e "\r"
	done
	return
}

# 随机整数
function func_1_2
{
	declare -i LB UB
	read -p "请设置下界：" LB
	read -p "请设置上界：" UB
	if [[ $LB -gt $UB ]];
	then
		echo "无法产生随机数，下界大于上界。"
		read -rsn1 -p "请按任意键返回主面板。"
		return
	fi
	echo
	echo "请按回车键产生随机数，按“Ctrl+Z”中止。"
	awk "{print int(rand() * ($UB - $LB) + $LB)}"
	return
}

# 随机小数
function func_1_3
{
	read -p "请设置下界：" tmp_LB
	read -p "请设置上界：" tmp_UB
	if [[ "$tmp_UB" != *"."* ]];
	then
		tmp_UB="$tmp_UB.0" # 补 0
	fi
	if [[ "$tmp_LB" != *"."* ]];
	then
		tmp_LB="$tmp_LB.0" # 补 0
	fi
	UB=`echo "$tmp_UB" | grep -o -P '\d+\.\d+'`
	LB=`echo "$tmp_LB" | grep -o -P '\d+\.\d+'`
	if [[ $(echo "${LB} > ${UB}" | bc) -eq 1 ]];
	then
		echo "无法产生随机数，下界大于上界。"
		read -rsn1 -p "请按任意键返回主面板。"
		return
	fi
	echo
	echo "请按回车键产生随机数，按“Ctrl+Z”中止。"
	awk "{print rand() * ($UB - $LB) + $LB}"
	return
}

# 随机分数
function func_1_4
{
	declare -i stop_1_4 p q value
	stop_1_4=1
	while [[ $stop_1_4 != 0 ]];
	do
		p=$RANDOM # 分子
		q=$RANDOM # 分母
		echo -n "$p / $q = "
		awk "BEGIN{printf \"%f\", $p / $q}"
		echo -n " ≈ "
		awk "BEGIN{printf \"%0.2f\", $p / $q}"
		echo
		read -rsn1 -p "按 0 中止，其它数字继续生成：" stop_1_4
		echo
		echo
	done
	return
}

# 随机数产生器
function func_1
{
	echo "/********** 随机数产生器 **********/"
	echo -e "\t0 = 返回主面板"
	echo -e "\t1 = 随机小数值自然数"
	echo -e "\t2 = 随机整数"
	echo -e "\t3 = 随机小数"
	echo -e "\t4 = 随机分数"
	read -rsn1 -p "请选择随机数类别：" choice_1
	clear
	case "$choice_1" in
	1)
		func_1_1
		;;
	2)
		func_1_2
		;;
	3)
		func_1_3
		;;
	4)
		func_1_4
		;;
	esac
	return
}

# 四则运算
function func_2
{
	declare -i stop_2
	stop_2=1
	while [[ $stop_2 == 1 ]];
	do
		read -p "请输入表达式：" expression
		echo -n "$expression = "
		echo "$expression" | bc
		read -rsn1 -p "按 0 中止，其它数字继续运算：" stop_2
		echo
	done
	return
	#bc && return
}

# 分解质因数
function func_3
{
	declare -i stop_3 number tmp factor
	stop_3=1
	while [[ $stop_3 == 1 ]];
	do
		read -p "请输入一个正整数：" number
		if [[ $number -le 0 ]];
		then
			echo "分解非正整数没有意义，请分解正整数。"
		elif [[ $number == 1 ]];
		then
			echo "1 既不是质数也不是合数。"
		elif [[ $number == 2 ]];
		then
			echo "2 是正整数范围内最小的质数。"
		else
			strings=""
			array_lists=(2 3 5 7 11 13 17 19 23 29 31)
			for index in {0..10}
			do
				factor=${array_lists[$index]}
				while [[ $[number%factor] == 0 ]];
				do
					number=$[number/factor]
					strings="${strings}${factor}×"
				done
			done
			strings=${strings%×} # 去掉最后的乘号
			total_strings="$number = $strings = "
			for index in {0..10}
			do
				cnt=`echo "×${strings}×" | grep -o "×${array_lists[$index]}×" | wc -l`
				if [[ $cnt -gt 0 ]];
				then
					total_strings="${total_strings}${array_lists[$index]}^$cnt×"
				fi
			done
			total_strings=${total_strings%×} # 去掉最后的乘号
			total_strings=`echo "$total_strings" | sed 's#×# × #g'`
			echo "$total_strings"
		fi
		echo
		read -rsn1 -p "按 0 中止，其它数字继续分解：" stop_3
		echo
	done
	return
}

# 解决《2019年全国理科数学（新课标模拟I）》中的第7小题
function func_4
{
	echo "本题实质：验证“冰雹”猜想。"
	echo "依题可知操作次数为11，下面开始利用计算机程序验证。"
	declare -i i x X cnt
	cnt=0
	for ((X = 1; X <= 2048; ++X)) # 2 ** 11 = 2048
	do
		x=X # 保护 X
		for ((i = 0; i < 11; ++i)) # 依据题意执行 11 次
		do
			if [[ $[$x%2] == 0 ]]; # 偶数
			then
				((x=x/2))
			else # 奇数
				((x=x*3+1))
			fi
		done
		if [[ $x == 1 ]];
		then
			((++cnt))
			echo $X
		fi
	done
	echo
	echo "共有 $cnt 个满足题意的正整数，故本题答案为 B。"
	read -rsn1
	return
}

# 验证“冰雹”猜想
function func_5
{
	declare -i x
	for ((;;))
	do
		clear
		read -p "请输入正整数 x：" x
		if [[ x -gt 0 ]];
		then
			break
		fi
	done
	clear
	echo -n $x
	while [[ $x != 1 ]]; # 直到 1
	do
		if [[ $[$x%2] == 0 ]]; # 偶数
		then
			((x=x/2))
		else # 奇数
			((x=x*3+1))
		fi
		echo -n " -> $x"
	done
	echo
	read -rsn1 -p "Done! "
	return
}

#《2019年全国理科数学（新课标模拟III）》中的第7小题
function func_6
{
	declare -i a n
	a=0
	B=" "
	for ((;;))
	do
		clear
		echo "B = {$B}"
		echo "a = $a"
		read -p "输入 n：" n
		if [[ $n == 0 ]];
		then
			break
		elif [[ $n -gt 100 ]] && [[ $n -le 3050 ]] && [[ $[n%100] -gt 0 ]] && [[ $[n%100] -le 50 ]];
		then
			((++a))
			if [[ "$B" != *" $[n/100] "* ]]; # 如果不在集合中
			then
				((a=a+10))
				B="$B$[n/100] "
			fi
		fi
	done
	clear
	#echo "B =$B"
	echo "a = $a"
	echo
	echo
	read -rsn1 -p "请按任意键返回主面板。"
	return
}

# 函数计算
function func_7
{
	read -r -p "请输入一个函数表达式：f(x) = " my_func_f
	declare -i x y
	for ((;;))
	do
		clear
		echo "f(x) = ${my_func_f}"
		read -p "输入 x：" x
		expression=`echo -n "${my_func_f}" | sed "s#x#($x)#g"` # 替换 x
		y=`echo "$expression" | bc` # 支持小数
		echo "f($x) = $y"
		echo
		read -rsn1 -p "是否发起新的运算[Y/n]？" YN
		if [[ $YN == "N" ]] || [[ $YN == "n" ]];
		then
			break
		fi
	done
	return
}

# 由日期计算星期
function func_8
{
	declare -i YMD Y M D
	Y=`date +%Y`
	M=`date +%m`
	D=`date +%d`
	read -p "请输入年月日（例：$Y$M$D）或直接回车（今天）：" YMD
	clear
	echo "输入：$Y年$M月$D日"
	echo "Input: $Y-$M-$D"
	if [[ -z "$YMD" ]] || [[ "$YMD" != 0 ]];
	then
		Y=`echo -n "$YMD" | head -4c`
		M=`echo -n "$YMD" | tail -4c | head -2c`
		D=`echo -n "$YMD" | tail -2c`
	fi
	if [[ $M == 1 ]] || [[ $M == 2 ]];
	then
		((M=M+12))
		((--Y))
	fi
	index=$[($D + ($M * 2) + 3 * ($M + 1) / 5 + $Y + ($Y / 4) - $Y / 100 + $Y / 400) % 7]
	array_cn=(一 二 三 四 五 六 日)
	array_eng=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" "Sunday")
	echo
	echo "这是星期${array_cn[$index]}。"
	echo "It is ${array_eng[$index]}. "
	read -rsn1
	return
}

# 斐波那契数列推算
function func_9
{
	declare -i a b index
	read -rsn1 -p "请按任意键启动运算，运算将从 0 开始。"
	clear
	index=0
	a=1
	b=2
	echo "fib($index) = 0"
	while [[ $a -gt 0 ]] && [[ $b -gt 0 ]]; # 运算直到溢出
	do
		((++index))
		echo "fib($index) = $a"
		((++index))
		echo "fib($index) = $b"
		((a=a+b))
		((b=a+b))
	done
	echo
	read -rsn1 -p "推算已完成，请按任意键返回。"
	return
}

choice=1
while [[ $choice != 0 ]];
do
	clear
	echo "/********** 多功能计算器主面板 **********/"
	echo "您想要使用哪一计算功能？"
	echo -e "\t0 = 退出程序"
	echo -e "\t1 = 随机数产生器"
	echo -e "\t2 = 四则运算"
	echo -e "\t3 = 分解质因数"
	echo -e "\t4 = 解决《2019年全国理科数学（新课标模拟I）》中的第7小题"
	echo -e "\t5 = 验证“冰雹”猜想"
	echo -e "\t6 =《2019年全国理科数学（新课标模拟III）》中的第7小题"
	echo -e "\t7 = 函数计算"
	echo -e "\t8 = 由日期计算星期"
	echo -e "\t9 = 斐波那契数列推算"
	echo "温馨提示：在 Windows 上使用 Mathematics 和几何画板，功能更为丰富。"
	read -rsn1 -p "请选择一项以继续：" choice
	clear
	case "$choice" in
	1)
		func_1
		;;
	2)
		func_2
		;;
	3)
		func_3
		;;
	4)
		func_4
		;;
	5)
		func_5
		;;
	6)
		func_6
		;;
	7)
		func_7
		;;
	8)
		func_8
		;;
	9)
		func_9
		;;
	esac
done
exit 0
