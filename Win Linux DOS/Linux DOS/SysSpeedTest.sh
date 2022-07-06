#!/bin/bash
SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )" # 获取当前脚本目录路径
cd "$SCRIPT_PATH/" || exit # 解析进入脚本所在目录
echo -e -n "\033[$(head -4 ./config.ini|tail -1)"
for i in $(seq 1 $(stty size | awk '{print $1}'));
do
	echo -e -n "\033[2J"
done
echo -e -n "\033[0;0H"

echo -e -n "\033[?25l" # 隐藏光标

# 记录初始时间（秒在最后）
dstart=`date`
declare starttime=`date +%s%N`

# 执行测速
for i in {1..100000}
do
	echo $i
done

# 记录结束时分秒
declare endtime=`date +%s%N`
dend=`date`
clear

if [[ $starttime -gt $endtime ]];
then
	echo "测速失败，为减少每日任务的影响，测速期间请尽量不要跨越日期。"
	echo "如果您使用了 ssh 远程连接进行测速，请确保网络正常。"
	read -rsn1 -p "请按任意键退出，或重新运行测试。"
	echo -e "\033[?25h" # 恢复光标
	clear
	exit 1
fi

# 计算时间并评估
T=`expr $endtime - $starttime`
echo "开始测速时间：$dstart"
echo "停止测速时间：$dend"
echo "开始测试时间戳：$starttime"
echo "停止测试时间戳：$endtime"
echo "总耗时：$[T / 1000000] 毫秒（$T）"
T=`expr $T / 1000000`
if [[ $T -gt 100000 ]];
then
	echo "矮油！您的系统运行速度怎么比蜗牛还慢啊？"
elif [[ $T -gt 60000 ]];
then
	echo "您的系统运行速度较慢，建议执行加速优化。"
elif [[ $T -gt 30000 ]];
then
	echo "您的系统运行速度大众化，不算快也不算慢。"
elif [[ $T -gt 10000 ]];
then
	echo "您的系统运行速度真的很快，击败了全国大多数用户。"
elif [[ $T -gt 3000 ]];
then
	echo "哇！您的系统快到就要飞起来啦！"
elif [[ $T -gt 1 ]];
then
	echo "登月去吧！您的系统已经快到了至高的境界。"
elif [[ $T -le 1 ]];
then
	echo "如果您的系统没有发生参变，建议您到中科院申请专利。"
fi
read -rsn1 -p "系统运行速度检测完毕，请按任意键退出。"
echo -e "\033[?25h" # 恢复光标
clear
exit 0