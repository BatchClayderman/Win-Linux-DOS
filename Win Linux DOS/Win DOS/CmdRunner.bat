@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 命令提示符启动器
CLS
IF /I "%SYSTEMDRIVE%"=="X:" (SET B=2&ECHO Windows PE下没有更多选项，已直接启动命令提示符。&GOTO 1)
SET B=0
GOTO MAIN

:MAIN
CLS
ECHO 命令提示符启动器主面板
ECHO   0=退出程序
ECHO   1=直接启动
VER|FIND /I "XP">NUL
IF %ERRORLEVEL%==0 (ECHO   2=系统启动&IF /I EXIST %COMSPEC:~0,-7%debug.exe (SET B=1)) ELSE (ECHO   2=管理员启动)
IF EXIST "%COMSPEC:~0,-7%command.com" (ECHO   3=脚本启动) ELSE (ECHO   3=启动PowerShell)
IF %B%==1 (ECHO   4=全屏启动)
ECHO   F=启用命令提示符
ECHO   G=停用命令提示符
ECHO   H=修复命令提示符（同时会启用命令提示符）
ECHO 请选择一项以继续：
IF %B%==1 (CHOICE /C 123FGH04) ELSE (CHOICE /C 123FGH0)
IF %ERRORLEVEL%==7 EXIT
CLS
GOTO %ERRORLEVEL%

:1
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (START /I /REALTIME %COMSPEC% /K COLOR %%I^&CD /D %COMSPEC:~0,-7%)
PAUSE
IF %B%==2 EXIT
GOTO MAIN

:2
VER|FIND /I "XP">NUL
IF NOT %ERRORLEVEL%==0 (GOTO 7)
SC START CMD
CLS
CHOICE /C YN /M "如果已弹出命令提示符，请选择“Y”，否则选择“N”。"
IF %ERRORLEVEL%==1 (GOTO MAIN)
SC DELETE CMD
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CMD" /F
SC DELETE CMD
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SC CREATE CMD BINPATH^= "CMD /K START COLOR %%I" TYPE^= "OWN" TYPE^= "INTERACT")
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CMD" /V Description /D "此服务由Win DOS创建，通过System为Windows XP的用户在系统权限下启动命令提示符。" /F
SC START CMD
ECHO 如果还没有弹出命令提示符，请重启电脑后重新打开本面板，按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:3
IF /I EXIST %COMSPEC:~0,-7%command.com (START /I /REALTIME COMMAND) ELSE (START /I /REALTIME POWERSHELL.EXE)
PAUSE
GOTO MAIN

:4
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System" /V DisableCMD /D 0 /T REG_DWORD /F
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I /WAIT CMD.EXE /C ECHO 启用成功。^&PAUSE)
GOTO MAIN

:5
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO 停用提示符有一定风险，是否继续？
CHOICE /C YN /M "此操作不会停用脚本。"
SET YN=%ERRORLEVEL%
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
IF %YN%==2 (SET YN=&GOTO MAIN)
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System" /V DisableCMD /D 2 /T REG_DWORD /F
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I /WAIT CMD.EXE)
SET YN=
GOTO MAIN

:6
REG IMPORT FIXCMD.REG
ECHO 执行操作完毕，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:7
CLS
ECHO 正在提权启动命令提示符，请稍候...
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (MSHTA VBSCRIPT:CREATEOBJECT("shell.application"^).shellexecute("%COMSPEC%","/C START COLOR %%I^&CD /D %COMSPEC:~0,-8%","","RUNAS",1^)(WINDOW.CLOSE^))
CLS
PAUSE
GOTO MAIN

:8
ECHO EXIT|%COMSPEC% /K PROMPT E 100 B4 00 B0 12 CD 10 B0 03 CD 10 CD 20 $_g$_q$_|DEBUG>NUL
CD /D "%COMSPEC:~0,-8%"
CLS
%COMSPEC%
EXIT