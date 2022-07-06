#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

echo "一般而言，权限足够时，Linux 下的文件都可以被删除。"
echo "本工具为删除一些过滤了指定命令的文件。"
read -p "请输入文件路径：" path
echo
if [[ -d "$path" ]]; # 目录
then
	echo "目标为目录。"
	if [[ "$path" == "/" ]] || [[ "$path" == *"/*"* ]] || [[ "$path" == "$SCRIPT_PATH"* ]] || [[ "$path" == ".."* ]] || [[ "$path" == "."* ]]; # 检测目录
	then
		echo "删除被中断，不建议的删除。"
	else
		mv "$path" /dev/null
		rm -rf "$path"
	fi
elif [[ -e "$path" ]]; # 文件
then
	echo "目标为文件。"
	if [[ "$path" == *"/*"* ]] || [[ $(dirname "$path") == "$SCRIPT_PATH"* ]]; # 检测文件
	then
		echo "删除被中断，不建议的删除。"
	else
		> "$path"
		echo -n > "$path"
		true > "$path"
		truecate -s 0 "$path"
		cat /dev/null > "$path"
		cp /dev/null "$path"
		dd if=/dev/null of="$path"
		mv "$path" /dev/null
		rm -f "$path"
	fi
else # 不存在
	echo "文件或目录不存在！"
fi
read -rsn1 -p "执行命令结束，请按任意键退出。"
clear
exit 0
