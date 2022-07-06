#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit # 解析进入脚本所在目录
echo -e -n "\033[33;40;1m"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

# 预检查
declare -i cnt choice
target=/root/LinuxDOS
echo "安装程序正在检查安装相关组件，请稍候。"
if [[ ! -d "./Linux DOS/" ]];
then
	read -rsn1 "丢失 Linux DOS 数据目录，无法完成安装，请按任意键退出。"
	clear
	exit 255
fi
cnt=0
for itemname in `ls -A "./Linux DOS/"`
do
	item="./Linux DOS/$itemname"
	if [[ -e "$item" ]]; # 是文件
	then
		if [[ "$item" != *".sh"* ]] && [[ "$item" != *".ini"* ]];
		then
			echo "检测到未知数据文件，请确保您使用的是 Linux DOS 安装源。"
			read -rsn1 -p "请按任意键退出。"
			clear
			exit 254
		else
			((++cnt))
		fi
	else
		echo "源数据目录检测到子目录，请检查。
		read -rsn1 -p 请按任意键退出程序。"
		clear
		exit 253
	fi
done
if [[ $cnt != 35 ]];
then
	echo "安装数据文件数量不正确，请检查下载完整性。"
	read -rsn1 -p "请按任意键退出。"
	clear
	exit 252
fi

# 检查运行身份
if [[ "`whoami`" != "root" ]];
then
	echo "警告：运行身份不是 root 用户，是否提权？"
	echo -e -n "\033[?25h"
	read -rsn1 -p "Y = 提权，N = 继续运行，C = 退出卸载程序。" choice
	echo -e -n "\033[?25l"
	if [[ $choice == "Y" ]] || [[ $choice == "y" ]];
	then
		sudo "$0"
		exit $?
	elif [[ $choice == "C" ]] || [ $choice == "c" ]];
	then
		clear
		exit 1
	fi
fi

# 交互
echo "欢迎使用 Linux DOS，感谢您对 Linux DOS的一份支持！"
echo "软件宗旨：为跨领域和受计算机技术困扰的人们提供一个交互平台。"
echo "使用说明："
echo -e "\t1．若您不能接受本界面中的条款，请您不要继续安装本软件；"
echo -e "\t2．本软件的 Windows 版本为 Win DOS 团队开发，初始版本已在 2017 年对外发行；"
echo -e "\t3．2022年，杨淯而对该软件进行了优化，并编写了 Linux 版本；"
echo -e "\t4．您可以查看每个程序的源代码，但不可以另行更改、发行；"
echo -e "\t5．若需要进行代码复制，请清除代码中涉及本公司的内容；"
echo -e "\t6．若要卸载本软件，请到主面板选择“0”来运行卸载程序；"
echo -e "\t7．请勿将安装程序隔离运行并确保您的操作系统没有问题；"
echo -e "\t8．软件为 Linux 通用净化版，只占 200KB 物理内存且无主动联网行为；"
echo -e "\t9．建议安装后到主面板查看、学习使用帮助；"
echo -e "\t10．软件无商业广告，祝您身体健康、心想事成、万事如意！"
echo
echo "如您之前已安装过 Linux DOS 且本次安装路径与上次不同，两个安装目录将同时在系统保留。"
echo "可能的安装路径："
echo -e "\t1 = /etc/LinuxDOS"
echo -e "\t2 = /root/LinuxDOS"
echo -e "\t3 = /usr/bin/LinuxDOS"
echo -e "\t4 = /usr/sbin/LinuxDOS"
echo -e "\t5 = /usr/share/LinuxDOS"
echo -e "\t0 = 取消安装"
read -rsn1 -p "请选择一项以继续：" choice
clear
case $choice in
1)
	target=/etc/LinuxDOS
	;;
2)
	target=/root/LinuxDOS
	;;
3)
	target=/usr/bin/LinuxDOS
	;;
4)
	target=/usr/sbin/LinuxDOS
	;;
5)
	target=/usr/share/LinuxDOS
	;;
*)
	exit 0
	;;
esac

# 安装
echo "正在执行安装，可能需要几秒钟。"
if [[ -e "$target/config.ini" ]];
then
	mv "$target/config.ini" /tmp/config.ini
fi
cp -r "./Linux DOS/" "$target"
if [[ -e /tmp/config.ini ]];
then
	rm -f "$target/config.ini"
	mv /tmp/config.ini "$target/config.ini"
fi

# 授权
chmod 000 "$target/Virus4.sh"
chmod 000 "$target/Virus3.sh"
chmod 000 "$target/Virus2.sh"
chmod 000 "$target/Virus1.sh"
chmod 444 "$target/config.ini"
chmod 555 "$target/Welcome.sh"
chmod 555 "$target/Uninstall.sh"
chmod 555 "$target/AntiVirusMon.sh"
chmod 555 "$target/Cale.sh"
chmod 555 "$target/Clean.sh"
chmod 555 "$target/ClearSystem.sh"
chmod 555 "$target/CmdRunner.sh"
chmod 555 "$target/DeleteFile.sh"
chmod 555 "$target/DiskOption.sh"
chmod 555 "$target/DTFixer.sh"
chmod 555 "$target/ErrorScreen.sh"
chmod 555 "$target/ExpansionEnsure.sh"
chmod 555 "$target/ExpansionVerify.sh"
chmod 555 "$target/FixAll.sh"
chmod 555 "$target/Folder.sh"
chmod 555 "$target/LinkFinder.sh"
chmod 555 "$target/NormalProcess.sh"
chmod 555 "$target/NTNoProcessCreate.sh"
chmod 555 "$target/Password.sh"
chmod 555 "$target/PathFinder.sh"
chmod 555 "$target/Play.sh"
chmod 555 "$target/PowerMac.sh"
chmod 555 "$target/ProcessPort.sh"
chmod 555 "$target/Run.sh"
chmod 555 "$target/Settings.sh"
chmod 555 "$target/SysInfoMate.sh"
chmod 555 "$target/SysSpeedTest.sh"
chmod 555 "$target/SystemFile.sh"
chmod 555 "$target/TaskOperation.sh"
chmod 555 "$target/Thumbs.sh"

# 检查
if [[ ! -d "$target/" ]];
then
	read -rsn1 "安装失败！目录丢失，请按任意键退出。"
	clear
	exit 2
fi
cnt=0
for itemname in `ls -A "$target/"`
do
	item="$target/$itemname"
	if [[ -e "$item" ]]; # 是文件
	then
		if [[ "$item" != *".sh"* ]] && [[ "$item" != *".ini"* ]];
		then
			echo "安装失败！检测到目标目录存在未知数据文件。"
			read -rsn1 -p "请按任意键退出。"
			clear
			exit 3
		else
			((++cnt))
		fi
	else
		echo "检测到目标目录存在子目录，请检查。"
		read -rsn1 -p "请按任意键退出。"
		clear
		exit 4
	fi
done
if [[ $cnt != 35 ]];
then
	echo "安装数据文件数量不正确，请检查下载完整性。"
	read -rsn1 -p "请按任意键退出。"
	clear
	exit 5
fi

# 完成
echo "安装成功结束，在此，我们再次感谢您对 Linux DOS 的大力支持！"
echo "祝您身体健康、心想事成、万事如意！请按任意键退出安装程序。"
read -rsn1
clear
exit 0
