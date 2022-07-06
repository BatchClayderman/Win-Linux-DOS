@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 一键检测系统运行速度-正在检测中，请稍候...
SET A=0
CLS
SET C=%DATE%
SET R=%TIME%

:A
SET /A A=A+1
ECHO %A%
IF %A%==10000 (GOTO B) ELSE (GOTO A)

:B
SET S=%TIME%
SET R1=%R:~0,2%
SET R2=%R:~3,2%
SET R3=%R:~6,2%
SET R4=%R:~9,2%
SET S1=%S:~0,2%
SET S2=%S:~3,2%
SET S3=%S:~6,2%
SET S4=%S:~9,2%
SET D=%DATE%
IF NOT "%C%"=="%D%" (GOTO E)
SET /A T1=%S1%-%R1%
SET /A T1=%S1%-%R1%
SET /A T2=%S2%-%R2%
SET /A T2=%S2%-%R2%
SET /A T3=%S3%-%R3%
SET /A T3=%S3%-%R3%
SET /A T4=%S4%-%R4%
SET /A T4=%S4%-%R4%
SET /A T=%T1%*3600
SET /A T=%T2%*60+%T%
SET /A T=%T3%+%T%
IF %T4% LSS 0 (SET /A T=%T%-1&SET /A T4=%T4%+100)
IF %T% GEQ 100 (SET MESS=矮油！您的系统运行速度怎么比蜗牛还慢啊？)
IF %T% LSS 100 (SET MESS=您的系统运行速度较慢，建议执行加速优化。)
IF %T% LSS 60 (SET MESS=您的系统运行速度大众化，不算快也不算慢。)
IF %T% LSS 30 (SET MESS=您的系统运行速度真的很快，击败了全国大多数用户。)
IF %T% LSS 10 (SET MESS=哇！您的系统快到就要飞起来啦！)
IF %T% LSS 3 (SET MESS=登月去吧！您的系统已经快到了至高的境界。)
IF %T%==0 (SET MESS=如果您的系统没有发生参变，建议您到中科院申请专利。)
TITLE 一键检测系统运行速度-检测结束
CLS
ECHO 开始测试的时间：%R%，停止测试的时间：%S%，总耗时：%T%.%T4%秒。
ECHO %MESS%
ECHO 系统运行速度检测完毕，请按任意键退出。
PAUSE>NUL
EXIT

:E
TITLE 无法完成测试。
CLS
ECHO 错误：测试耗时跨越日期，服务已停止，请确保没有跨越日期并按任意键重启测试。
PAUSE
CLS
TITLE 一键检测系统运行速度-正在检测中，请稍候...
SET A=0
SET C=%DATE%
SET R=%TIME%
GOTO A