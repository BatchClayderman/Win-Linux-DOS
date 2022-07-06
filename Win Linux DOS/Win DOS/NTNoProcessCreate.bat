@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 禁止创建进程
GOTO MAIN

:MAIN
CLS
ECHO 禁止创建进程主面板
ECHO   0=退出程序
ECHO   1=标准禁止
ECHO   2=强制禁止
ECHO 请选择一项以继续：
CHOICE /C 120
IF %ERRORLEVEL%==3 EXIT
CLS
GOTO %ERRORLEVEL%

:1
IF NOT EXIST "%COMSPEC:~0,-7%findstr.exe" (ECHO 错误：缺乏系统文件findstr.exe，无法继续，请按任意键退出。&PAUSE>NUL&EXIT)
SETLOCAL ENABLEDELAYEDEXPANSION
SET F="%TEMP%\PID.txt"
IF EXIST %F% (DEL /A /F /Q %F%)
IF /I NOT EXIST %F% (GOTO 12)
CACLS %F% /E /T /G SYSTEM:F
CACLS %F% /E /T /G ADMINISTRATORS:F
CACLS %F% /E /T /G %USERNAME%:F
CACLS %F% /E /T /G USERS:F
CACLS %F% /E /T /G EVERYONE:F
DEL /A /F /Q %F%
IF EXIST %F% (GOTO 11) ELSE (GOTO 12)

:11
CLS
ECHO 原有PID记录删除失败。
ECHO   1=使用原有PID进行操作
ECHO   2=重试
ECHO   3=返回主面板
ECHO 请选择一项以继续：
CHOICE /C 123
IF %ERRORLEVEL%==1 (GOTO 12)
IF %ERRORLEVEL%==2 (GOTO 1)
IF %ERRORLEVEL%==3 (GOTO MAIN)

:12
FOR /F "SKIP=1 DELIMS= " %%I IN ('WMIC PROCESS GET PROCESSID') DO (ECHO P%%I)>>%F%
IF /I EXIST %F% (ATTRIB +A +H +R +S %F%) ELSE (GOTO 1)
TITLE 标准禁止创建进程生效中，如需解禁请按下“Ctrl+C”。
GOTO 13

:13
FOR /F "SKIP=1 DELIMS= " %%I IN ('WMIC PROCESS GET PROCESSID') DO (
	FINDSTR /X P%%I %F%>NUL
	IF !ERRORLEVEL!==1 (TASKKILL /PID %%I /F /T)
)
GOTO 13

:2
ECHO 请注意，此禁止仅能禁止资源管理器创建进程。
ECHO 另外，禁止层生效后，重启系统依旧生效。
ECHO 请按“Y”继续，按“N”解禁，按“C”返回。
CHOICE /C YNC
GOTO 2%ERRORLEVEL%

:21
CLS
ECHO 正在向系统添加禁止层，请稍候...
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V RestrictRun /T REG_DWORD /D 1 /F
IF NOT %ERRORLEVEL%==0 (GOTO 24)
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\RestrictRun /V cmd.exe /D cmd.exe /F
IF NOT %ERRORLEVEL%==0 (GOTO 26)
GPUPDATE /FORCE
CLS
ECHO 禁止层添加成功，请按任意键返回主面板。
GOTO 23

:22
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V RestrictRun
IF NOT %ERRORLEVEL%==0 (GOTO 27)
CLS
ECHO 正在解禁，请稍候...
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V RestrictRun /F
IF NOT %ERRORLEVEL%==0 (GOTO 25)
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\RestrictRun /F
GPUPDATE /FORCE
CLS
ECHO 提示：为避免系统锁死，禁止层对cmd.exe不生效。
ECHO 解禁成功，请按任意键返回主面板。

:23
PAUSE>NUL
GOTO MAIN

:24
CLS
ECHO 添加禁止层失败，可能是杀毒软件阻止了操作，请按任意键返回主面板。
GOTO 23

:25
CLS
ECHO 解禁失败，请按任意键返回主面板。
ECHO 请重启系统后再试，如果解禁依旧失败，请进入安全模式解禁。
GOTO 23

:26
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V RestrictRun
CLS
IF %ERRORLEVEL%==0 (ECHO 由于无法添加cmd.exe排除，禁止层已被撤回。) ELSE (ECHO 注意：未添加cmd.exe到排除。)
ECHO 请按任意键返回主面板。
GOTO 23

:27
CLS
ECHO 您的系统没有形成禁止层，无需解禁，请按任意键返回主面板。
GOTO 23