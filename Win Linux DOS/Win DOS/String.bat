@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 文本处理工具
SETLOCAL ENABLEDELAYEDEXPANSION
GOTO MAIN

:MAIN
CLS
ECHO 文本处理工具主面板
ECHO 警告：仅允许输入纯文本，请勿输入超文本字符。
ECHO.
ECHO   0=退出程序
ECHO   1=长度计算
ECHO   2=输出倒文
ECHO 请选择一项以继续：
CHOICE /C 120
IF %ERRORLEVEL%==3 EXIT
GOTO %ERRORLEVEL%0

:10
CLS
SET N=0
ECHO 请输入纯文本：
SET /P S=
GOTO 11

:11
SET /A N=N+1
FOR /F %%I IN ("%N%") DO (IF NOT "!S:~%%I,1!"=="" (GOTO 11))
CLS
ECHO 字符串“%S%”的长度为%N%，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:20
CLS
SET O=
ECHO 请输入纯文本:
SET /P S=
IF "%S%"=="" (GOTO 21)
SET T=%S%
GOTO 22

:21
CLS
ECHO 您输入了空文本，倒文为空。
ECHO.
ECHO 请任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:22
SET O=%O%%T:~-1%
SET T=%T:~0,-1%
IF "%T%"=="" (GOTO 23)
GOTO 22

:23
CLS
ECHO 原文如下：
ECHO %S%
ECHO 倒文如下：
ECHO %O%
ECHO 请按任意键返回主面板。 
PAUSE>NUL
GOTO MAIN