#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

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

# 检查密码
if [[ "$(tail -2 ./config.ini | head -1)" != "0" ]];
then
	echo "您开启了密码保护，请您先检验密码。"
	stty -echo
	read -p "请输入密码：" passwd
	stty echo
	echo
	if [[ `echo -n "$passwd" | sha256sum | awk '{printf $1}'` != "$(tail -1 ./config.ini)" ]];
	then
		echo "密码错误，运行已取消！"
		read -rsn1 -p "请按任意键退出，或稍后重试。"
		clear
		exit 2
	fi
fi

# 检查解释器
if [[ " `cat /etc/shells | xargs` " == "/$(head -1 ./config.ini) " ]]; # 配置中的解释器可用
then
	runShell="\"$(head -1 ./config.ini)\""
else
	runShell="$SHELL"
fi

# 主面板
choice=1
while [[ $choice != 0 ]];
do
	# 重新渲染页面
	echo -e -n "\033[$(head -2 ./config.ini | tail -1)"
	for i in $(seq 1 $(stty size | awk '{print $1}'));
	do
		echo -e -n "\033[2J"
	done
	echo -e -n "\033[0;0H"
	
	echo "Linux DOS 主面板—（c）Copyright 版权所有—“Win Linux DOS”团队"
	echo "基础板块："
	echo -e "\t0 = 退出程序\t\t1 = Linux DOS 管理\t2 = 重置设置"
	echo -e "\t3 = 参变检测仪\t\t4 = 设置\t\t5 = Linux DOS 自启"
	echo -e "\t6 = 使用帮助（Help）\t7 = 修复内部错误\t8 = 重新载入本程序"
	echo
	echo "功能板块："
	echo -e "\tA = 反病毒管理\t\tB = 多功能计算器\tC = 清理垃圾"
	echo -e "\tD = 刷新系统\t\tE = 运行 shell\t\tF = 删除文件"
	echo -e "\tG = 磁盘相关操作\tH = 同步时间\t\tI = 手动崩溃"
	echo -e "\tJ = 多功能修复器\tK = 目录处理工具\tL = 快捷方式溯源"
	echo -e "\tM = 实时查看进程\tN = 禁止创建进程\tO = 特殊目录查找"
	echo -e "\tP = 键盘测试游戏\tQ = 电源相关操作\tR = 本地端口扫描"
	echo -e "\tS = 添加开机启动项\tT = 查看系统信息\tU = 运行速度检测"
	echo -e "\tV = 检查系统文件\tW = 任务管理器"
	echo
	echo
	read -rsn1 -p "您想要 Linux DOS 为您做些什么？请选择一项以继续：" choice
	clear
	case "$choice" in
	"1")
		declare -i sub_choice
		echo "欢迎您，管理员！"
		echo -e "\t1 = 开启密码"
		echo -e "\t2 = 关闭密码"
		echo -e "\t3 = 修改密码"
		echo -e "\t4 = 卸载 Linux DOS"
		echo -e "\t0 = 返回"
		echo
		read -rsn1 -p "请选择一项以继续：" sub_choice
		echo
		case $sub_choice in
		1)
			$runShell ./Password.sh --open
			;;
		2)
			$runShell ./Password.sh --close
			;;
		3)
			$runShell ./Password.sh --change
			;;
		4)
			$runShell ./Uninstall.sh --Verify
			;;
		esac
		;;
	"2")
		$runShell ./Settings.sh -r
		;;
	"3")
		echo "正在准备检测参变，过程不可撤回。"	
		echo "定义：参变，即参数变化，指的是计算机全局或局部字符被恶意替换或被恶意劫持的现象，WPS 中也有类似的检测工具。"
		echo "说明：参变检测仪用于检验基础系统是否存在参变，对于其它参变如内核级参变，请寻找更为高级的参变检测程序，谢谢！"
		echo "使用方法："
		echo "\t1．参变检测仪在开始会进入一个新脚本，若未正常进入，则说明进程创建失败；"
		echo "\t2．开始会一系列的错误窗口，每个窗口包含5个相同的字符，否则系统参变；"
		echo "\t3．弹出的每一个窗口都是错误提示框，伴随有错误提示音，否则系统参变；"
		echo "\t4．详细步骤请跟随提示，如有疑问，请联系Win DOS的开发人员；"
		echo "\t5．如果使用过程中遇到程序崩溃闪退，说明您的系统已严重参变！"
		echo "一般地，常规机器不会发生参变。若系统存在严重参变，也许，您所看到的上述内容也存在参变。"
		read -rsn1 -p "请按任意键开始检测，过程中请及时完成交互。"
		$runShell ./ExpansionVerify.sh
		;;
	"4")
		$runShell ./Settings.sh
		;;
	"5")
		read -rsn1 -p "自启动吗[y/n/C]？" YNC
		if [[ $YNC == "Y" ]] || [[ $YNC == "y" ]];
		then
			$runShell ./Run.sh "$runShell \"$SCRIPT_PATH/Welcome.sh\""
		elif [[ $YNC == "N" ]] || [[ $YNC == "n" ]];
		then
			line=`cat /etc/rc.local | grep "\"$SCRIPT_PATH/Welcome.sh\""`
			sed "s#${line}\\n##g" /etc/rc.local
			read -rsn1 -p "请按任意键继续。"
		fi
		;;
	"6")
		echo "Linux DOS 使用帮助"
		echo -e "\t1．进行选择时，建议打开大写锁键，“[y/N]?”表示是与否（默认），特殊情况请见提示；"
		echo -e "\t2．专业人员请注意，提示输入文本时，除引用变量与索引外，切勿输入超文本字符；"
		echo -e "\t3．提示输入路径的格式：/usr/share/nginx，两边应不带引号；"
		echo -e "\t4．如有乱码，请在 shell 的属性中进行编码的修改（Change shells\' properties to fix the garbled）；"
		echo -e "\t5．若程序崩溃闪退，请您重置设置，即到主面板选择“2”或运行“${SCRIPT_PATH}/Settings.sh -r”；"
		echo -e "\t6．要想卸载 Linux DOS，请您到主面板选择“1”，切勿使用其它软件卸载；"
		echo -e "\t7．我们承诺，一般地，我们不会在您的电脑上留下任何走过的痕迹，请放心卸载！"
		echo -e "\t8．联系方式：微信：DazzlingUniverse，QQ：1306561600，邮箱：1306561600@qq.com。"
		echo "请按任意键返回主面板，如有疑问、建议或内部代码错误上报，请联系 Linux DOS 开发人员。"
		echo "若在使用过程中给您带来了不便，敬请谅解。感谢您对整个 Win Linux DOS 的理解与支持！"
		read -rsn1
		;;
	"7")
		$runShell ./Thumbs.sh
		;;
	"8")
		$runShell ./Welcome.sh
		;;
	"A" | "a")
		$runShell ./AntiVirusMon.sh
		;;
	"B" | "b")
		$runShell ./Cale.sh
		;;
	"C" | "c")
		$runShell ./Clean.sh
		;;
	"D" | "d")
		$runShell ./ClearSystem.sh
		;;
	"E" | "e")
		$runShell ./CmdRunner.sh
		;;
	"F" | "f")
		$runShell ./DeleteFile.sh
		;;
	"G" | "g")
		$runShell ./DiskOption.sh
		;;
	"H" | "h")
		$runShell ./DTFixer.sh
		;;
	"I" | "i")
		$runShell ./ErrorScreen.sh
		;;
	"J" | "j")
		$runShell ./FixAll.sh
		;;
	"K" | "k")
		$runShell ./Folder.sh
		;;
	"L" | "l")
		$runShell ./LinkFinder.sh
		;;
	"M" | "m")
		$runShell ./NormalProcess.sh
		;;
	"N" | "n")
		$runShell ./NTNoProcessCreate.sh
		;;
	"O" | "o")
		$runShell ./PathFinder.sh
		;;
	"P" | "p")
		$runShell ./Play.sh
		read
		;;
	"Q" | "q")
		$runShell ./PowerMac.sh
		;;
	"R" | "r")
		$runShell ./ProcessPort.sh
		;;
	"S" | "s")
		$runShell ./Run.sh
		;;
	"T" | "t")
		$runShell ./SysInfoMate.sh
		;;
	"U" | "u")
		$runShell ./SysSpeedTest.sh
		;;
	"V" | "v")
		$runShell ./SystemFile.sh
		;;
	"W" | "w")
		$runShell ./TaskOperation.sh
		;;
	"X" | "x") # 隐藏功能
		read -p "请指定导出路径：" path
		echo "Linux DOS — `date`" > "$path"
		if [[ ! -e "$path" ]];
		then
			read -rsn1 "创建文件失败，请按任意键返回主面板。"
		fi
		echo "开始生成代码，请稍候。"
		echo
		for file in `ls -a -l "$SCRIPT_PATH" | grep ^- | awk '{print $9}'`
		do
			echo -n "-> $file"
			echo >> "$path"
			echo "/************************************************** $file **************************************************/" >> "$path"
			echo >> "$path"
			cat "$SCRIPT_PATH/$file" >> "$path"
			echo -e -n "\r" # 为了更好看的输出
			echo "[OK] $file"
		done
		echo >> "$path"
		echo "/************************************************** Linux DOS **************************************************/" >> "$path"
		echo >> "$path"
		echo "输出源代码只作学习交流使用，请勿用作商业用途。" >> "$path"
		echo
		echo
		echo "输出源代码只作学习交流使用，请勿用作商业用途。"
		read -rsn1 -p "导出完毕，请按任意键返回主面板。"
		;;
	esac
done
exit 0
