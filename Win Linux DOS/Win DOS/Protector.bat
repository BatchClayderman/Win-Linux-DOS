@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE 文件堡垒
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO MAIN

:MAIN
CLS
ECHO 请输入文件全路径或将文件拖拽至此：
SET /P F=
IF EXIST %F% (GOTO RUN)
ECHO 文件不存在，请重新输入。
PAUSE
GOTO MAIN

:RUN
FOR %%I IN (%F%) DO (SET G="%%~FI.bat")
TAKEOWN /F %G%
ICACLS %G% /GRANT ADMINISTRATORS:F
DEL /A /F /Q %G%
ECHO @ECHO OFF>%G%
ECHO CD /D %F%>>%G%
ECHO GOTO %%ERRORLEVEL%%>>%G%
ECHO.>>%G%
ECHO :0>>%G%
ECHO CD /D %F%>>%G%
ECHO GOTO ^0>>%G%
ECHO.>>%G%
ECHO :1>>%G%
ECHO START /I /MIN PAUSE^>^>%F%>>%G%
ECHO GOTO ^1>>%G%
IF NOT EXIST %G% (ECHO 保护失败！&PAUSE&EXIT)
ATTRIB +A -H +R -S %G%
START /MIN /REALTIME CMD /C %G%
CLS
ECHO 文件%F%已处于保护状态，如需停止保护，请删除%G%并关闭任务栏上的cmd窗口。
CHOICE /C YN /M "继续添加保护文件请选择“Y”，退出程序请选择“N”。"
IF %ERRORLEVEL%==2 EXIT
GOTO MAIN