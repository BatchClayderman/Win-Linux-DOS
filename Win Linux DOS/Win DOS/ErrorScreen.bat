@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 手动蓝屏
SET T=0
CLS
ECHO 您确定要使系统蓝屏吗？
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
GOTO Y

:T
SHUTDOWN /S /T 10 /C "检测到您的系统未蓝屏，调用内核级蓝屏，部分Windows XP系统可能会表现为强制重启。"
TASKKILL /FI "PID NE 1" /F
GOTO T

:Y
@WINLOGON.EXE
SET /A T+=1
IF %T%==10 (GOTO Y) ELSE (GOTO T)