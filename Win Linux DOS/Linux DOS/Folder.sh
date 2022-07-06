#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

declare -i isIn
choice=1
while [[ $choice != 0 ]];
do
	clear
	echo "/********** 目录处理程序主面板 **********/"
	read -r -p "请输入目录路径：" path
	if [[ -z "$path" ]]; # 输入空串退出
	then
		clear
		exit 0
	fi
	while [[ "$path" == *'//'* ]]; # 去掉重复的 /
	do
		path=$(echo -n "$path" | sed 's#//#/#g')
	done
	if [[ "$path" != *'/' ]]; # 结尾加 /
	then
		path="${path}/"
	fi
	if [[ -d "$path" ]];  # 存在该目录
	then
		if [[ "${SCRIPT_PATH}/" == "$path" ]] || [[ './' == "$path" ]];
		then
			isIn=1 # 在当前目录
		else
			isIn=0 # 不在当前目录
		fi
	else
		read -rsn1 -p "目录不存在，请按任意键继续。"
		continue
	fi
	clear
	echo "/********** 目录处理程序主面板 **********/"
	echo "目录：$path"
	echo -e "\t1 = 重新输入目录"
	echo -e "\t2 = 完整查看目录"
	if [[ $isIn == 0 ]];
	then
		echo -e "\t3 = 散开目录"
		echo -e "\t4 = 归纳文件"
	fi
	echo -e "\t0 = 退出程序"
	read -rsn1 -p "请选择一项以继续：" choice
	clear
	if [[ $choice == 2 ]];
	then
		echo "ls -a \"$path\""
		ls -a "$path"
		echo
		read -rsn1 -p "浏览完毕，请按任意键继续。"
	elif [[ $isIn == 0 ]] && [[ $choice == 3 ]];
	then
		for itemname in `ls -A "$path"` # 排除 . 和 ..
		do
			echo "$path$itemname -> ${path}../$itemname"
			mv "$path$itemname" "${path}../$itemname"
		done
		if [[ -z `ls -A "$path"` ]]; # 目录已空
		then
			rm -r "$path" # 删除决定权交给用户
		fi
		echo
		read -rsn1 -p "执行操作完毕，请按任意键继续。"
	elif [[ $isIn == 0 ]] && [[ $choice == 4 ]];
	then
		for filename in `ls -l "$path" | grep ^- | awk '{print $9}'`; # 筛选出文件
		do
			if [[ "$filename" == *'.'* ]]; # 存在拓展名
			then
				file="$path$filename"
				ext="${file##*.}" # 取得拓展名
				folder="$path$ext/"
				echo "$file -> $folder$filename"
				if [[ -d "$folder" ]]; # 目录存在
				then
					mv "$file" $folder$filename
				else # 目录不存在则先建立目录
					mkdir "$folder" && mv "$file" $folder$filename
				fi
			fi
		done
		echo
		read -rsn1 -p "执行操作完毕，请按任意键继续。"
	fi
done
exit 0
