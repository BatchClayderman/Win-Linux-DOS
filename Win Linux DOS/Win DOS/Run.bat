@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 添加开机启动项（可输入“0”退出程序）
CLS
GOTO RUN

:RUN
CLS
ECHO 请输入标准文件全路径或将文件拖拽至此处并按下回车键：
SET /P FILE=
IF "%FILE:~0,1%"=="0" (EXIT)
XCOPY %FILE% "C:\Documents and Settings\Administrator\「开始」菜单\程序\启动\" /V /Y
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V /Q %FILE%
PAUSE
GOTO RUN