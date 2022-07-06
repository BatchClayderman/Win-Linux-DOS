#!/bin/bash
clear
echo "ABCDEFGhijklmnopqrstUVWXYZ" > tmp.tmp.tmp && chmod 666 tmp.tmp.tmp
if [[ $? -ne 0 ]];
then
	read -rsn1 -p "当前目录不可写，无法完成检测，请按任意键退出。"
	exit 255
fi

clear
echo -e "\aABCDEFG\033[33;40;1mhijklmn\033[37;41;1mopqrst\033[32;40;1mUVWXYZ\a"
echo -e -n "\033[0;0;0m"
printf "\aABCDEFG\033[33;40;1mhijklmn\033[37;41;1mopqrst\033[32;40;1mUVWXYZ\a\n"
printf "\033[0;0;0m"
echo "ABCDEFGhijklmnopqrstUVWXYZ" | cat
echo "ABCDEFGhijklmnopqrstUVWXYZ" > tmp.tmp.tmp
cat tmp.tmp.tmp
rm tmp.tmp.tmp
echo "ABCDEFGhijklmnopqrstUVWXYZ"
read -rsn1 -p "1．以上五段文字除颜色外内容应当一致，如果不是，您的系统存在参变，请尽快修正！"

clear
A=1
B=4
((C=A+B))
((D=C/2))
E=15
((F=A+E))
((G=A*99+B*1))
((H=D+F+G))
read -rsn1 -p "2．计算得 2+16+103=$H，如果不正确，说明本系统存在逻辑侦测错误或数字劫持，请尽快修正！"

clear
$SHELL ./ExpansionEnsure.sh  "/verify YES 1"
exit 0