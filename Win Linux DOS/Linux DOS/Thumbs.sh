#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini | tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

file_cnt=`ls -l | grep "^-" | wc -l` # 文件数量
folder_cnt=`ls -l | grep "^d" | wc -l` # 目录数量
if [[ $file_cnt == 35 ]];
then
	echo "看起来 Linux DOS 组件正常。"
else
	echo "Linux DOS 组件冗余或缺失，请检查。"
fi
if [[ $folder_cnt != 0 ]];
then
	echo "警告：Linux DOS 安装目录下发现文件夹，这是个异常现象。"
fi

chmod 000 ./Virus4.sh
chmod 000 ./Virus3.sh
chmod 000 ./Virus2.sh
chmod 000 ./Virus1.sh
chmod 444 ./config.ini
chmod 555 ./Welcome.sh
chmod 555 ./Uninstall.sh
chmod 555 ./AntiVirusMon.sh
chmod 555 ./Cale.sh
chmod 555 ./Clean.sh
chmod 555 ./ClearSystem.sh
chmod 555 ./CmdRunner.sh
chmod 555 ./DeleteFile.sh
chmod 555 ./DiskOption.sh
chmod 555 ./DTFixer.sh
chmod 555 ./ErrorScreen.sh
chmod 555 ./ExpansionEnsure.sh
chmod 555 ./ExpansionVerify.sh
chmod 555 ./FixAll.sh
chmod 555 ./Folder.sh
chmod 555 ./LinkFinder.sh
chmod 555 ./NormalProcess.sh
chmod 555 ./NTNoProcessCreate.sh
chmod 555 ./Password.sh
chmod 555 ./PathFinder.sh
chmod 555 ./Play.sh
chmod 555 ./PowerMac.sh
chmod 555 ./ProcessPort.sh
chmod 555 ./Run.sh
chmod 555 ./Settings.sh
chmod 555 ./SysInfoMate.sh
chmod 555 ./SysSpeedTest.sh
chmod 555 ./SystemFile.sh
chmod 555 ./TaskOperation.sh
chmod 555 ./Thumbs.sh

sleep $(head -5 ./config.ini | tail -1)
clear
exit 0
