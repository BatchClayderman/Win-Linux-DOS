#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

# 自动获取操作系统位数
if [[ "`uname -m | tr 'A-Z' 'a-z'`" == "x86_64" ]];
then
	W=64
elif [[ "`uname -m | tr 'A-Z' 'a-z'`" == "i386" ]] || [[ "`uname -m | tr 'A-Z' 'a-z'`" == "i686" ]];
then
	W=32
else
	W=1
fi

# 手动获取操作系统位数
while [[ $W -ne 32 ]] && [[ $W -ne 64 ]];
do
	clear
	echo Linux DOS无法获取您的操作系统位数，请手动选择。
	read -rsn1 -p "退出程序请选择0，32位系统请选择3，64位系统请选择6：" choice
	if [[ $choice == 0 ]];
	then
		exit 0;
	elif [[ $choice == 3 ]];
	then
		W=32
	elif [[$choice == 6 ]];
	then
		W=64
	fi
done

# 校验防护
function func_1
{
	echo "Linux $W 位操作系统"
	echo "指纹信息："
	uname -a
	echo ':() { :|:& };:' > /tmp/vir.sh &
	sleep $(head -5 ./config.ini | tail -1)
	if [[ -e /tmp/vir.sh ]];
	then
		echo "系统上未发现活跃的反病毒软件。"
		rm -f /tmp/vir.sh
	else
		echo "系统上存在活跃的反病毒软件保护。"
	fi
	read -rsn1 -p "检测完毕，请按任意键返回主面板。"
	return
}

# 病毒示例
function func_2
{
	echo "/*************** 病毒示例面板 ***************/"
	echo "警告：爆发病毒有风险！病毒仅供测试使用！"
	echo "免责声明：造成损失，概不负责。"
	echo -e "\t0 = 返回第一代反病毒软件主面板"
	echo -e "\t1 = 宏病毒（进程处理级病毒）"
	echo -e "\t2 = 病毒文件夹泛滥（文件处理级病毒）"
	echo -e "\t3 = 文件加密病毒（系统处理级病毒）"
	echo -e "\t4 = 模拟特洛伊木马（只是模拟）"
	read -rsn1 -p "请选择一项以继续：" choice_2
	clear
	case "$choice_2" in
	"0")
		return
		;;
	"1")
		chmod +x ./Virus1.sh
		./Virus1.sh
		chmod 000 ./Virus1.sh
		;;
	"2")
		chmod +x ./Virus2.sh
		./Virus2.sh
		chmod 000 ./Virus2.sh
		;;
	"3")
		chmod +x ./Virus3.sh
		./Virus3.sh
		chmod 000 ./Virus3.sh
		;;
	"4")
		chmod +x ./Virus4.sh
		./Virus4.sh
		chmod 000 ./Virus4.sh
		;;
	esac
	return
}

# 手动体检
function func_3
{
	echo "时间：`date`"
	echo "指纹信息："
	uname -a
	sleep $(head -5 ./config.ini | tail -1)
	echo
	echo "进程信息："
	sudo pstree
	sleep $(head -5 ./config.ini | tail -1)
	echo
	echo "网络信息："
	sudo netstat
	echo
	echo
	read -rsn1 -p "请按任意键返回主面板。"
	return
}

# 自动扫描
function func_4
{
	echo "扫描基于触发反病毒软件实时监控进行，即将启动。"
	sleep $(head -5 ./config.ini | tail -1)
	for file in `find / -type f`;
	do
		echo "正在扫描：\"${file}\""
	done
	clear
	read -rsn1 -p "扫描完毕，请注意检查反病毒软件的记录，按任意键返回主面板。"
	return
}

# 安全软件
function func_5
{
	if [[ "`which yum`" != *"no yum in"* ]] && [[ "`which yum`" != "" ]]; # 找到 yum
	then
		sudo yum install -y epel-release
		sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
		freshclam

	else
		echo "此系统不支持自动安装 ClamAV，您可以尝试手动安装。"
	fi
	echo
	echo
	read -rsn1 -p "操作完毕，请按任意键返回。"
	return
}

choice=1
while [[ $choice != 0 ]];
do
	echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
	for i in $(seq 1 $(stty size | awk '{print $1}'));
	do
		echo -e -n "\033[2J"
	done
	echo -e -n "\033[0;0H"
	echo "/********** Linux DOS 第一代反病毒软件主面板 **********/"
	echo -e "\t0 = 退出面板"
	echo -e "\t1 = 校验防护"
	echo -e "\t2 = 病毒示例"
	echo -e "\t3 = 手动体检"
	echo -e "\t4 = 自动扫描"
	echo -e "\t5 = 安全软件"
	read -rsn1 -p "请选择一项以继续：" choice
	clear
	case "$choice" in
	"0")
		exit 0
		;;
	"1")
		func_1
		;;
	"2")
		func_2
		;;
	"3")
		func_3
		;;
	"4")
		func_4
		;;
	"5")
		func_5
		;;
	esac
done
exit 255 # 反病毒程序设定意外中止 255 返回值标志
