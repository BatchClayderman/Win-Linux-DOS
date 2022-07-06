#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

shopt -s -o nounset
Date=$(date +'%Y%m%d%H%M%S')
Dirs="/bin /sbin /usr/bin /usr/sbin /lib /usr/local/sbin /usr/local/bin /usr/local/lib"
TMP_file="/tmp/tmp"
FP="/root/fp.$Date.chksum"
Checker="sha256sum"
Find="find"

function scan_file
{
	local f
	for f in $Dirs
	do
		$Find $f -type f >> $TMP_file
	done
	return
}

# 读取文件建立每个文件的checksum值
function cr_checksum_list
{
	local f
	if [ -f $TMP_file ];
	then
		for f in $(cat $TMP_file);
		do
			$Checker $f >> $FP
		done
	fi
	return
}

# 清除缓存
function rmTMP
{
	[ -f $TMP_file ] && rm -rf $TMP_file
	return
}

echo "检测缺乏的文件："
scan_file
cr_checksum_list
rmTMP
echo "检测完毕，如果上方未显示缺乏的文件则说明系统正常。"
sleep $(head -5 ./config.ini | tail -1)
clear
exit 0
