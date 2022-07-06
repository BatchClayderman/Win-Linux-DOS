#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit 127 # 解析进入脚本所在目录
echo -e -n "\033[$(head -3 ./config.ini|tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

echo "本脚本仅提供特洛伊木马的一个示例，不会真正将用户密码外泄。"
echo "在进行之前，请先允许脚本获得超级用户权限以保护您的账号密码。"
echo -n "Password: "
stty -echo
read passwd
sleep 2
stty echo
echo
echo "su: Authentication failure"
echo
echo
echo "密码已泄漏：$passwd"
echo
exit 0
