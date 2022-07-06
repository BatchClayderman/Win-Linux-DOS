#!/bin/bash

# 255 程序意外中止
# 0 操作成功结束
# 1 无法删除原配置文件
# 2 无法创建配置文件
# 3 用户取消操作

declare -i value_5 new_value_5 default_value_5 isChanged isChanged_1 isChanged_2 isChanged_3 isChanged_4 isChanged_5 isChanged_6
isChanged=0
isChanged_1=0
isChanged_2=0
isChanged_3=0
isChanged_4=0
isChanged_5=0
isChanged_6=0
value_1=
value_2=
value_3=
value_4=
value_5=0
value_6=
value_7=
new_value_1=
new_value_2=
new_value_3=
new_value_4=
new_value_5=0
new_value_6=
new_value_7=
default_value_1='bash'
default_value_2='33;40;1m'
default_value_3='37;41;1m'
default_value_4='32;40;1m'
default_value_5=5
default_value_6='0'
default_value_7='0'
choice=1

# 重置设置
function recovery
{
	pwdswitch="$default_value_6"
	pwdstr="$default_value_7"
	if [[ -e ./config.ini ]]; # 如果文件存在
	then
		pwdtmp="`tail -1 ./config.ini`"
		if [[ ${#pwdtmp} == 64 ]];
		then
			pwdswitch=1
			pwdstr="$pwdtmp"
		fi
		chmod 666 ./config.ini
		rm -f ./config.ini
		if [[ -e ./config.ini ]]; # 文件依然存在
		then
			echo "无法删除原配置文件，重置失败！"
			read -rsn1 -p "请按任意键退出程序，或重启系统后重试！"
			clear
			exit 1
		fi
	fi
	echo "$default_value_1" > ./config.ini
	if [[ -e ./config.ini ]];
	then
		chmod 666 ./config.ini
		echo "$default_value_2" >> ./config.ini
		echo "$default_value_3" >> ./config.ini
		echo "$default_value_4" >> ./config.ini
		echo "$default_value_5" >> ./config.ini
		echo "$pwdswitch" >> ./config.ini
		echo "$pwdstr" >> ./config.ini
		if [[ `cat ./config.ini | wc -l`  == 7 ]];
		then
			chmod 444 ./config.ini # 设置只读
			read -rsn1 -p "重置成功！请按任意键退出程序。"
		else
			read -rsn1 -p "重置失败！请按任意键退出程序。"
		fi
		clear
		exit 0
	else
		echo "创建配置文件失败！"
		read -rsn1 -p "请按任意键退出程序，或重启系统后重试！"
		clear
		exit 2
	fi
	return
}

# 打印颜色
function read_color
{
	case "$1" in
	"0m")
		echo -n "关闭所有属性"
		;;
	"1m")
		echo -n "加粗"
		;;
	"4m")
		echo -n "下划线"
		;;
	"5m")
		echo -n "闪烁"
		;;
	"7m")
		echo -n "反显"
		;;
	"8m")
		echo -n "消隐"
		;;
	"30")
		echo -n "文字颜色为黑色"
		;;
	"31")
		echo -n "文字颜色为红色"
		;;
	"32")
		echo -n "文字颜色为绿色"
		;;
	"33")
		echo -n "文字颜色为黄色"
		;;
	"34")
		echo -n "文字颜色为蓝色"
		;;
	"35")
		echo -n "文字颜色为紫色"
		;;
	"36")
		echo -n "文字颜色为深绿色"
		;;
	"37")
		echo -n "文字颜色为白色"
		;;
	"40")
		echo -n "背景颜色为黑色"
		;;
	"41")
		echo -n "背景颜色为红色"
		;;
	"42")
		echo -n "背景颜色为绿色"
		;;
	"43")
		echo -n "背景颜色为黄色"
		;;
	"44")
		echo -n "背景颜色为蓝色"
		;;
	"45")
		echo -n "背景颜色为紫色"
		;;
	"46")
		echo -n "背景颜色为深绿色"
		;;
	"47")
		echo -n "背景颜色为白色"
		;;
	*)
		echo -n "错误配置"
		;;
	esac
	return
}

# 读取配置 1
function read_setting_1
{
	shells=" `cat /etc/shells | xargs` "
	value_1=`head -1 ./config.ini`
	if [[ $shells == *"/$value_1 "* ]]; # 支持的 shell
	then
		echo -e "\t1．当前设置的解释器：${value_1}；"
	else
		echo -e "\t1．当前设置的解释器：未知；"
	fi
	return
}

# 读取配置 2
function read_setting_2
{
	value_2=`head -2 ./config.ini | tail -1 | grep -o -P '3[0-7];4[0-7];\dm'`
	if [[ ${#value_2} != 8 ]];
	then
		echo -e "\t2．基础程序颜色：不可用；"
		return
	fi
	echo -e -n "\t2．基础程序颜色："
	read_color `echo -n "$value_2" | head -2c`
	echo -n "、"
	read_color `echo -n "$value_2" | head -5c | tail -2c`
	echo -n "、"
	read_color `echo -n "$value_2" | tail -2c`
	echo '；'
	return
}

# 读取配置 3
function read_setting_3
{
	value_3=`head -3 ./config.ini | tail -1 | grep -o -P '3[0-7];4[0-7];\dm'`
	if [[ ${#value_3} != 8 ]];
	then
		echo -e "\t3．风险警报颜色：不可用；"
		return
	fi
	echo -e -n "\t3．风险警报颜色："
	read_color `echo -n "$value_3" | head -2c`
	echo -n "、"
	read_color `echo -n "$value_3" | head -5c | tail -2c`
	echo -n "、"
	read_color `echo -n "$value_3" | tail -2c`
	echo '；'
	return
}

# 读取配置 4
function read_setting_4
{
	value_4=`head -4 ./config.ini | tail -1 | grep -o -P '3[0-7];4[0-7];\dm'`
	if [[ ${#value_4} != 8 ]];
	then
		echo -e "\t4．自动化面板颜色：不可用；"
		return
	fi
	echo -e -n "\t4．自动化面板颜色："
	read_color `echo -n "$value_4" | head -2c`
	echo -n "、"
	read_color `echo -n "$value_4" | head -5c | tail -2c`
	echo -n "、"
	read_color `echo -n "$value_4" | tail -2c`
	echo '；'
	return
}

# 读取配置 5
function read_setting_5
{
	value_5=`head -5 ./config.ini | tail -1`
	if [[ $value_5 -gt 0 ]] && [[ $value_5 -le 60 ]];
	then
		echo -e "\t5．暂停时长：${value_5} 秒；"
	else
		echo -e "\t5．暂停时长：不可用；"
	fi
	return
}

# 读取配置 6
function read_setting_6
{
	value_6=$(tail -2 ./config.ini | head -1)
	if [[ $value_6 == "0" ]];
	then
		echo -e "\t6．当前密码保护状态：未启动；"
	else
		echo -e "\t6．当前密码保护状态：已启动；"
	fi
	return
}

# 读取配置 7
function read_setting_7
{
	value_7=$(tail -1 ./config.ini)
	if [[ ${#value_7} == 64 ]]; # ${#var}获取变量长度
	then
		echo -e "\t7．当前密码存储状态：已设置。"
	elif [[ ${#value_7} -gt 1 ]];
	then
		echo -e "\t7．当前密码存储状态：已被破坏。"
	else
		echo -e "\t7．当前密码存储状态：未设置。"
	fi
	return
}

# 加载配置
function load_config
{
	if [[ -e ./config.ini ]]
	then
		# 检测文件状态
		if [[ `cat ./config.ini | wc -l` != 7 ]];
		then
			read -rsn1 -p "配置文件异常，是否重置[y/N]？" choice
			if [[ $choice == "Y" ]] || [[ $choice == "y" ]];
			then
				echo
				recovery
			fi
		fi
		# 尝试加载配置
		echo
		echo "当前已保存的配置如下："
		echo -e "\t0．当前解释器：$SHELL；"
		read_setting_1
		read_setting_2
		read_setting_3
		read_setting_4
		read_setting_5
		read_setting_6
		read_setting_7
	else # 文件不存在
		echo "文件不存在，自动重置中。"
		recovery
	fi
}

# 打印选项
function print_option
{
	echo "可供执行的选项："
	echo -e "\t0 = 退出 Linux DOS 设置程序"
	if [[ $isChanged_1 == 1 ]];
	then
		echo -e "\t1 = 启动设置（设置已缓存）"
	else
		echo -e "\t1 = 启动设置"
	fi
	if [[ $isChanged_2 == 1 ]];
	then
		echo -e "\t2 = 基础程序颜色设置（设置已缓存）"
	else
		echo -e "\t2 = 基础程序颜色设置"
	fi
	if [[ $isChanged_3 == 1 ]];
	then
		echo -e "\t3 = 风险警报颜色设置（设置已缓存）"
	else
		echo -e "\t3 = 风险警报颜色设置"
	fi
	if [[ $isChanged_4 == 1 ]];
	then
		echo -e "\t4 = 自动化面板颜色设置（设置已缓存）"
	else
		echo -e "\t4 = 自动化面板颜色设置"
	fi
	if [[ $isChanged_5 == 1 ]];
	then
		echo -e "\t5 = 暂停时间设置（设置已缓存）"
	else
		echo -e "\t5 = 暂停时间设置"
	fi
	if [[ $isChanged_6 == 1 ]];
	then
		echo -e "\t6 = 密码保护设置（设置已缓存）"
	else
		echo -e "\t6 = 密码保护设置"
	fi
	echo -e "\t7 = 查看设置代码"
	if [[ $isChanged == 1 ]];
	then
		echo -e "\t8 = 保存设置（设置已变更请及时保存）"
	else
		echo -e "\t8 = 保存设置"
	fi
	echo -e "\t9 = 重置设置"
	return
}

# 获得颜色
function get_color
{
	declare -i color_code_1 color_code_2 color_code_3
	color_strings=""
	
	clear
	echo "/********** 文字颜色 **********/"
	echo -n "当前值："
	read_color `echo -n "$2" | head -2c`
	echo
	echo -e "\t0 = 默认"
	echo -e "\t1 = 黑色"
	echo -e "\t2 = 红色"
	echo -e "\t3 = 绿色"
	echo -e "\t4 = 黄色"
	echo -e "\t5 = 蓝色"
	echo -e "\t6 = 紫色"
	echo -e "\t7 = 深绿色"
	echo -e "\t8 = 白色"
	read -rsn1 -p "请选择一项以继续：" color_code_1
	case "$color_code_1" in
	0)
		color_strings=`echo -n "$1" | head -2c`
		;;
	1)
		color_strings='30'
		;;
	2)
		color_strings='31'
		;;
	3)
		color_strings='32'
		;;
	4)
		color_strings='33'
		;;
	5)
		color_strings='34'
		;;
	6)
		color_strings='35'
		;;
	7)
		color_strings='36'
		;;
	8)
		color_strings='37'
		;;
	*)
		color_strings=`echo "$1" | head -2c`
		;;
	esac
	
	clear
	echo "/********** 背景颜色 **********/"
	echo -n "当前值："
	read_color `echo -n $1 | head -5c | tail -2c`
	echo
	echo -e "\t0 = 默认"
	echo -e "\t1 = 黑色"
	echo -e "\t2 = 红色"
	echo -e "\t3 = 绿色"
	echo -e "\t4 = 黄色"
	echo -e "\t5 = 蓝色"
	echo -e "\t6 = 紫色"
	echo -e "\t7 = 深绿色"
	echo -e "\t8 = 白色"
	read -rsn1 -p "请选择一项以继续：" color_code_2
	case "$color_code_2" in
	0)
		color_strings="${color_strings}`echo -n $1 | head -5c | tail -3c`" # -3c 可以不用加分号
		;;
	1)
		color_strings="${color_strings};40"
		;;
	2)
		color_strings="${color_strings};41"
		;;
	3)
		color_strings="${color_strings};42"
		;;
	4)
		color_strings="${color_strings};43"
		;;
	5)
		color_strings="${color_strings};44"
		;;
	6)
		color_strings="${color_strings};45"
		;;
	7)
		color_strings="${color_strings};46"
		;;
	8)
		color_strings="${color_strings};47"
		;;
	*)
		color_strings="${color_strings}`echo -n $1 | head -5c | tail -3c`" # -3c 可以不用加分号
		;;
	esac
	if [[ "$color_code_1" == "$color_code_2" ]];
	then
		echo
		echo "警告：文字颜色和屏幕背景颜色太过接近！"
		sleep 3
	fi
	
	clear
	echo "/********** 属性 **********/"
	echo -n "当前值："
	read_color `echo -n $1 | tail -2c`
	echo
	echo -e "\t0 = 默认"
	echo -e "\t1 = 关闭所有属性"
	echo -e "\t2 = 加粗"
	echo -e "\t3 = 下划线"
	echo -e "\t4 = 闪烁"
	echo -e "\t5 = 反显"
	echo -e "\t6 = 消隐"
	read -rsn1 -p "请选择一项以继续：" color_code_3
	case "$color_code_3" in
	0)
		color_strings="${color_strings}`echo -n $1 | tail -3c`" # -3c 可以不用加分号
		;;
	1)
		color_strings="${color_strings};0m"
		;;
	2)
		color_strings="${color_strings};1m"
		;;
	3)
		color_strings="${color_strings};4m"
		;;
	4)
		color_strings="${color_strings};5m"
		;;
	5)
		color_strings="${color_strings};7m"
		;;
	6)
		color_strings="${color_strings};8m"
		;;
	*)
		color_strings="${color_strings}`echo -n $1 | tail -3c`" # -3c 可以不用加分号
		;;
	esac

	echo -e "\033[${color_strings}"
	read -rsn1 -p "预览如当前文字所示，是否修改[Y/n]？" tmp
	echo -e "\033[0;0;0m"
	if [[ $tmp == "N" ]] || [[ $tmp == "n" ]];
	then
		return
	fi
	
	case $3 in 
	2)
		new_value_2="$color_strings"
		;;
	3)
		new_value_3="$color_strings"
		;;
	4)
		new_value_4="$color_strings"
		;;
	esac
	return
}

# 设置配置 1
function write_config_1
{
	echo "/********** 解释器 **********/"
	echo "0．当前解释器：$SHELL"
	echo "1．当前设置的解释器：${value_1}"
	grep -v '^$' /etc/shells | cat -b
	max_value_1=`grep -v '^$' /etc/shells | wc -l`
	read -rsn1 -p "请选择一项以继续：" new_value_1
	if [[ $new_value_1 -ge 1 ]] && [[ $new_value_1 -le max_value_1 ]];
	then
		new_value_1="`head -${new_value_1} /etc/shells | tail -1`"
		tmp_value_1=`echo -n " ${new_value_1} " | grep -o -P '/[A-Za-z0-9]+\s' | tail -1` # 排除路径中含有空格（解释器文件名一般没有空格）
		new_value_1=`echo -n "${tmp_value_1}" | grep -o -P '[A-Za-z0-9]+'`
		if [[ "$new_value_1" != "$value_1" ]];
		then
			isChanged_1=1
			isChanged=1 # 只要有一个设置为 1 全局标记位就应该为 1
		else # 原设置与当前设置一致
			isChanged_1=0
			if [[ $isChanged_1 == 0 ]] && [[ $isChanged_2 == 0 ]] && [[ $isChanged_3 == 0 ]] && [[ $isChanged_4 == 0 ]] && [[ $isChanged_5 == 0 ]] && [[ $isChanged_6 == 0 ]];
			then
				isChanged=0 # 所有均为 0 才能将全局标记位设置为 0
			fi
		fi
	fi
}

# 设置配置 2
function write_config_2
{
	get_color "$default_value_2" "$value_2" 2
	if [[ "$new_value_2" != "$value_2" ]];
	then
		isChanged_2=1
		isChanged=1 # 只要有一个设置为 1 全局标记位就应该为 1
	else # 原设置与当前设置一致
		isChanged_2=0
		if [[ $isChanged_1 == 0 ]] && [[ $isChanged_2 == 0 ]] && [[ $isChanged_3 == 0 ]] && [[ $isChanged_4 == 0 ]] && [[ $isChanged_5 == 0 ]] && [[ $isChanged_6 == 0 ]];
		then
			isChanged=0 # 所有均为 0 才能将全局标记位设置为 0
		fi
	fi
	return
}

# 设置配置 3
function write_config_3
{
	get_color "$default_value_3" "$value_3" 3
	if [[ "$new_value_3" != "$value_3" ]];
	then
		isChanged_3=1
		isChanged=1 # 只要有一个设置为 1 全局标记位就应该为 1
	else # 原设置与当前设置一致
		isChanged_3=0
		if [[ $isChanged_1 == 0 ]] && [[ $isChanged_2 == 0 ]] && [[ $isChanged_3 == 0 ]] && [[ $isChanged_4 == 0 ]] && [[ $isChanged_5 == 0 ]] && [[ $isChanged_6 == 0 ]];
		then
			isChanged=0 # 所有均为 0 才能将全局标记位设置为 0
		fi
	fi
	return
}

# 设置配置 4
function write_config_4
{
	get_color "$default_value_4" "$value_4" 4
	if [[ "$new_value_4" != "$value_4" ]];
	then
		isChanged_4=1
		isChanged=1 # 只要有一个设置为 1 全局标记位就应该为 1
	else # 原设置与当前设置一致
		isChanged_4=0
		if [[ $isChanged_1 == 0 ]] && [[ $isChanged_2 == 0 ]] && [[ $isChanged_3 == 0 ]] && [[ $isChanged_4 == 0 ]] && [[ $isChanged_5 == 0 ]] && [[ $isChanged_6 == 0 ]];
		then
			isChanged=0 # 所有均为 0 才能将全局标记位设置为 0
		fi
	fi
	return
}

# 设置配置 5
function write_config_5
{
	echo "/********** 暂停时长 **********/"
	if [[ $value_5 -le 0 ]] || [[ $value_5 -gt 60 ]];
	then
		echo "当前值：不可用"
	else
		echo "当前值：$value_5"
	fi
	read -rsn2 -p "指定新值（1-60）：" new_value_5
	echo
	if [[ $new_value_5 -le 0 ]] || [[ $new_value_5 -gt 60 ]];
	then
		if [[ $value_5 -le 0 ]] || [[ $value_5 -gt 60 ]];
		then
			new_value_5=$default_value_5
			echo "值不正确，已重置为 $default_value_5。"
		else
			new_value_5=$value_5
			echo "值不正确，已复原。"
		fi
		sleep 3
	fi
	if [[ "$new_value_5" != "$value_5" ]];
	then
		isChanged_5=1
		isChanged=1 # 只要有一个设置为 1 全局标记位就应该为 1
	else # 原设置与当前设置一致
		isChanged_5=0
		if [[ $isChanged_1 == 0 ]] && [[ $isChanged_2 == 0 ]] && [[ $isChanged_3 == 0 ]] && [[ $isChanged_4 == 0 ]] && [[ $isChanged_5 == 0 ]] && [[ $isChanged_6 == 0 ]];
		then
			isChanged=0 # 所有均为 0 才能将全局标记位设置为 0
		fi
	fi
	return
}


# 设置配置 6
function write_config_6
{
	echo "/********** 密码控制 **********/"
	if [[ $value_6 == "0" ]];
	then
		echo "密码保护：未启动"
	else
		echo "密码保护：已启动"
	fi
	read -rsn1 -p "Y = 启动，N = 停止，C = 取消？" tmp
	if [[ $tmp == "Y" ]] || [[ $tmp == "y" ]];
	then
		new_value_6=1
	elif [[ $tmp == "N" ]] || [[ $tmp == "n" ]];
	then
		new_value_6=0
	else
		return
	fi
	if [[ "$new_value_6" != "0" ]] && [[ "$value_6" == "0" ]]; # 一开一关
	then
		isChanged_6=1
		isChanged=1
	elif [[ "$new_value_6" == "0" ]] && [[ "$value_6" != "0" ]]; # 一关一开
	then
		isChanged_6=1
		isChanged=1
	else # 均已开启或均未开启
		isChanged_6=0
		if [[ $isChanged_1 == 0 ]] && [[ $isChanged_2 == 0 ]] && [[ $isChanged_3 == 0 ]] && [[ $isChanged_4 == 0 ]] && [[ $isChanged_5 == 0 ]] && [[ $isChanged_6 == 0 ]];
		then
			isChanged=0 # 所有均为 0 才能将全局标记位设置为 0
		fi
	fi
}

# 真正的保存配置
function save_config
{
	chmod 666 ./config.ini
	if [[ ${#new_value_1} == 0 ]];
	then
		if [[ ${#value_1} == 0 ]];
		then
			value_1="$default_value_1"
			echo "提示：配置 1 已被重置！"
		fi
		echo "$value_1" > ./config.ini
	else
		echo "$new_value_1" > ./config.ini
	fi
	if [[ ! -e ./config.ini ]];
	then
		read -rsn1 -p "很抱歉，创建文件失败！请按任意键返回主面板。"
		return
	fi
	if [[ ${#new_value_2} == 0 ]];
	then
		if [[ ${#value_2} == 0 ]];
		then
			value_2="$default_value_2"
			echo "提示：配置 2 已被重置！"
		fi
		echo "$value_2" >> ./config.ini
	else
		echo "$new_value_2" >> ./config.ini
	fi
	if [[ ${#new_value_3} == 0 ]];
	then
		if [[ ${#value_3} == 0 ]];
		then
			value_3="$default_value_3"
			echo "提示：配置 3 已被重置！"
		fi
		echo "$value_3" >> ./config.ini
	else
		echo "$new_value_3" >> ./config.ini
	fi
	if [[ ${#new_value_4} == 0 ]];
	then
		if [[ ${#value_4} == 0 ]];
		then
			value_4="$default_value_4"
			echo "提示：配置 4 已被重置！"
		fi
		echo "$value_4" >> ./config.ini
	else
		echo "$new_value_4" >> ./config.ini
	fi
	if [[ $new_value_5 == 0 ]];
	then
		if [[ $value_5 == 0 ]];
		then
			value_5=$default_value_5
			echo "提示：配置 5 已被重置！"
		fi
		echo "$value_5" >> ./config.ini
	else
		echo "$new_value_5" >> ./config.ini
	fi
	if [[ ${#new_value_6} == 0 ]];
	then
		if [[ ${#value_6} == 0 ]];
		then
			value_6="$default_value_6"
			echo "提示：配置 6 已被重置！"
		fi
		echo "$value_6" >> ./config.ini
	else
		echo "$new_value_6" >> ./config.ini
	fi
	if [[ ${#new_value_7} == 0 ]];
	then
		if [[ ${#value_7} == 0 ]];
		then
			value_7="$default_value_7"
			echo "提示：配置 7 已被重置！"
		fi
		echo "$value_7" >> ./config.ini
	else
		echo "$new_value_7" >> ./config.ini
	fi
	if [[ `cat ./config.ini | wc -l` == 7 ]];
	then
		chmod 444 ./config.ini
		read -rsn1 -p "保存成功！请按任意键返回主面板。"
	else
		read -rsn1 -p "很抱歉，保存失败！请按任意键返回主面板。"
	fi
	
	isChanged_1=0
	isChanged_2=0
	isChanged_3=0
	isChanged_4=0
	isChanged_5=0
	isChanged_6=0
	isChanged=0
	return
}

# 保存文件
function do_save_config
{
	if [[ "$(tail -2 ./config.ini | head -1)" != "0" ]];
	then
		echo "您开启了密码保护，请您先检验密码。"
		stty -echo
		read -p "请输入密码：" passwd
		stty echo
		echo
		if [[ `echo -n "$passwd" | sha256sum | awk '{printf $1}'` != "$(tail -1 ./config.ini)" ]];
		then
			read -rsn1 -p "密码错误，请按任意键返回，或稍后重试。"
		fi
	fi
	save_config
	return
}

# 启动编辑器
function start_edit
{
	clear
	try_time=0
	while [[ "`which $1`" == *"no $1 in"* ]] || [[ "`which $1`" == "" ]]; # 找不到
	do
		if [[ $try_time -ge 3 ]];
		then
			clear
			read -rsn1 -p "超过 3 次尝试均未能安装成功，请按任意键返回主面板。"
			return
		fi
		((++try_time))
		echo "未找到 $1，尝试安装中，请稍候！"
		if [[ "`which apt-get`" != *"no apt-get in"* ]] && [[ "`which apt-get`" != "" ]]; # 找到 apt-get
		then
			sudo apt-get install $1
		elif [[ "`which yum`" != *"no yum in"* ]] && [[ "`which yum`" != "" ]]; # 找到 yum
		then
			sudo yum install $1
		elif [[ "`which pkg`" != *"no pkg in"* ]] && [[ "`which pkg`" != "" ]]; # 找到 pkg
		then
			sudo pkg install $1
		else
			read -rsn1 -p "未能安装 $1，请按任意键返回主面板。"
			return
		fi
	done
	clear
	$1 "$2"
	return
}

# 编辑配置文件
function edit_config
{
	echo "当前配置文件内容："
	cat ./config.ini
	echo -e "\n\n"
	echo "编辑器列表："
	echo -e "\t1 = 使用 vi 编辑"
	echo -e "\t2 = 使用 vim 编辑"
	echo -e "\t3 = 使用 nano 编辑"
	echo -e "\t0 = 不执行编辑"
	echo
	read -rsn1 -p "请选择一项以继续：" edit_choice
	echo # && clear
	if [[ $edit_choice == 1 ]] || [[ $edit_choice == 2 ]] || [[ $edit_choice == 3 ]];
	then
		if [[ "$(tail -2 ./config.ini | head -1)" != "0" ]];
		then
			echo "您开启了密码保护，请您先检验密码。"
			stty -echo
			read -p "请输入密码：" passwd
			stty echo
			echo
			if [[ `echo -n "$passwd" | sha256sum | awk '{printf $1}'` != "$(tail -1 ./config.ini)" ]];
			then
				read -rsn1 -p "密码错误，请按任意键返回，或稍后重试。"
				return
			fi
		fi
		if [[ $isChanged != "0" ]];
		then
			echo "缓存配置未写入文件，是否写入？"
			read -rsn1 -p "Y = 写入，N = 放弃，C = 返回主面板。" dump_choice
			if [[ $dump_choice == "Y" ]] || [[ $dump_choice == "y" ]];
			then
				save_config
			elif [[ $dump_choice == "C" ]] || [[ $dump_choice == "c" ]];
			then
				return
			fi
		fi
		chmod 666 ./config.ini
		if [[ $edit_choice == 1 ]];
		then
			start_edit 'vi' './config.ini'
		elif [[ $edit_choice == 2 ]];
		then
			start_edit 'vim' './config.ini'
		elif [[ $edit_choice == 3 ]];
		then
			start_edit 'nano' './config.ini'
		fi
		chmod 444 ./config.ini
	else
		return
	fi
}

if [[ "$1" == "/R" ]] || [[ "$1" == "/r" ]] || [[ "$1" == "-R" ]] || [[ "$1" == "-r" ]] || [[ "$1" == "--recover" ]] || [[ "$1" == "--recovery" ]];
then
	recovery
fi

for ((;;))
do
	clear
	echo "/******************** Linux DOS 设置程序 ********************/"
	load_config
	echo
	echo
	print_option
	read -rsn1 -p "请选择一项以继续：" choice
	clear
	case "$choice" in
	"0")
		if [[ $isChanged == "0" ]];
		then
			exit 0
		else
			read -rsn1 -p "设置未保存，确定退出[y/N]？" tmp
			if [[ $tmp == "Y" ]] || [[ $tmp == "y" ]];
			then
				clear
				exit 3
			fi
		fi
		;;
	"1")
		write_config_1
		;;
	"2")
		write_config_2
		;;
	"3")
		write_config_3
		;;
	"4")
		write_config_4
		;;
	"5")
		write_config_5
		;;
	"6")
		write_config_6
		;;
	"7")
		edit_config
		;;
	"8")
		do_save_config
		;;
	"9")
		if [[ "$(tail -2 ./config.ini | head -1)" != "0" ]];
		then
			echo "您开启了密码保护，请您先检验密码。"
			stty -echo
			read -p "请输入密码：" passwd
			stty echo
			echo
			if [[ `echo -n "$passwd" | sha256sum | awk '{printf $1}'` != "$(tail -1 ./config.ini)" ]];
			then
				read -rsn1 -p "密码错误，请按任意键返回，或稍后重试。"
				continue
			fi
		fi
		read -rsn1 -p "确定重置[y/N]？" tmp
		if [[ $tmp == "Y" ]] || [[ $tmp == "y" ]];
		then
			echo
			recovery
		fi
		;;
	esac
done
exit 255
