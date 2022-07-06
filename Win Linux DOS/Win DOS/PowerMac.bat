@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 电源相关操作
GOTO MAIN

:MAIN
CLS
ECHO 电源相关操作主面板
ECHO   1=中止关机或重启    2=锁定计算机    3=重启
ECHO   4=注销    5=关机    6=绑定计算机    7=强制重启
ECHO   8=休眠（自动启用休眠） 9=待机（自动停用休眠）
ECHO   A=修改电源计划         0=退出程序
ECHO 您想要 Win DOS 为您做些什么？请选择一项以继续：
CHOICE /C 123456789A0
CLS
IF %ERRORLEVEL%==11 EXIT
GOTO %ERRORLEVEL%

:1
SHUTDOWN /A
PAUSE
GOTO MAIN

:2
RUNDLL32.EXE USER32.DLL,LockWorkStation
GOTO MAIN

:3
SET O=重启
SET P=3
GOTO A

:30
SHUTDOWN /F /R /T %T% /C "%DATE% %TIME%：请保存好您的数据，系统将于%T%秒后%O%！"
GOTO MAIN

:4
LOGOFF
SHUTDOWN /L
EXIT

:5
SET O=关机
SET P=5
GOTO A

:50
SHUTDOWN /F /S /T %T% /C "%DATE% %TIME%：请保存好您的数据，系统将于%T%秒后%O%！"
GOTO MAIN

:6
TSDISCON
GOTO MAIN

:7
SET O=强制重启
SET P=7
GOTO A

:70
ECHO 你真的要强制重启吗？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
SHUTDOWN /F /R /T %T% /C "%DATE% %TIME%：请保存好您的数据，系统将于%T%秒后%O%！"
TASKKILL /IM SERVICES.EXE /F /T
TASKKILL /IM SYSTEM /F /T
GOTO MAIN

:8
POWERCFG /HIBERNATE ON
RUNDLL32 powrprof.dll,SetSuspendState
EXIT

:9
POWERCFG /HIBERNATE OFF
RUNDLL32 powrprof.dll,SetSuspendState
EXIT

:10
CLS
ECHO 修改电源计划面板
ECHO   0=返回主面板
ECHO   1=查看当前电源计划
ECHO   2=关闭显示屏时间设置
ECHO   3=磁盘时间设置
ECHO   4=待机时间设置
ECHO   5=休眠时间设置
ECHO   6=启用或停用休眠
ECHO 请选择一项以继续：
CHOICE /C 1234560
IF %ERRORLEVEL%==7 (GOTO MAIN)
SET P=A
CLS
GOTO 10%ERRORLEVEL%

:101
POWERCFG /L
POWERCFG /Q
ECHO 温馨提示：Windows 10及以上：直接左键选定文字，回车可复制内容；
ECHO           Windows 10以下：右键标记后选定文字，回车可复制内容。
PAUSE
GOTO MAIN

:102
SET O=无动作关闭显示屏
SET D=monitor
GOTO A

:103
SET O=无动作关闭磁盘读写
SET D=disk
GOTO A

:104
SET O=无动作自动待机
SET D=standby
GOTO A

:105
SET O=无动作自动休眠
SET D=hibernate
GOTO A

:A0
POWERCFG /X -%D%-timeout-ac %T%
SET D=
CLS
ECHO %O%设置修改完毕，请按任意返回修改电源计划面板。
PAUSE>NUL
GOTO 10

:106
CHOICE /C YNC "Y=启用，N=停用，C=返回修改电源计划面板。"
IF %ERRORLEVEL%==1 (POWERCFG /HIBERNATE ON)
IF %ERRORLEVEL%==2 (POWERCFG /HIBERNATE OFF)
IF %ERRORLEVEL%==3 (GOTO 10)

:A
SET C=0
SET T=

:B
CLS
ECHO 直接按“Y”则设置为0s，如果是设置电源计划，单位为分钟。
ECHO 常用时间：10分钟=600秒，1小时=3600秒，1天=86400秒。
ECHO 倒计时最大值为864000秒，请输入%O%倒计时：%T%[秒/分钟]。
ECHO Y=确认，E=返回主面板，B=退格，Q=清空。
CHOICE /C 1234567890YEBQ>NUL
IF %ERRORLEVEL%==11 (GOTO C)
IF %ERRORLEVEL%==12 (SET C=&SET T=&GOTO MAIN)
IF %ERRORLEVEL%==13 (IF NOT %C%==0 (SET T=%T:~0,-1%&SET /A C-=1))&GOTO B
IF %ERRORLEVEL%==14 (SET T=&SET C=0&GOTO B)
IF %C%==6 (GOTO B)
SET /A C+=1
IF %ERRORLEVEL%==10 (IF %C%==1 (SET C=0) ELSE (SET T=%T%0))&GOTO B
SET T=%T%%ERRORLEVEL%
GOTO B

:C
IF NOT DEFINED T (SET T=0)
IF %T% GTR 864000 (SET T=864000)
GOTO %P%0