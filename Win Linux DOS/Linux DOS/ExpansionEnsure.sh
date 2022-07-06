#!/bin/bash
if [[ "$1" == "/verify YES 1" ]];
then
	echo "3．您的基础系统不存在参变，若要进一步检测，请寻找更高级的参变检测程序，谢谢！"
	echo -e "3．如果程序未自动退出，可能的原因是您的系统存在异常！\n"
	exit 0
else
	echo -e "3．您的系统存在运行参变，请尽快修正！\n"
	exit 1
fi
