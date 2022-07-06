@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 删除文件（夹）
GOTO MAIN

:MAIN
CLS
ECHO 删除文件（夹）主面板
ECHO   0=退出程序
ECHO   1=标准删除
ECHO   2=高权限删除
ECHO   3=卸卷删除
ECHO   4=添加“拖拽删除”到桌面并隐藏回收站
ECHO   5=删除桌面“拖拽删除”并还原回收站
ECHO 请选择一项以继续：
CHOICE /C 123450
IF %ERRORLEVEL%==6 EXIT
CLS
IF %ERRORLEVEL%==4 (GOTO 4)
IF %ERRORLEVEL%==5 (GOTO 7)
ECHO 请输入文件（夹）全路径或将文件（夹）拖拽至此：
SET /P F=
CLS
GOTO %ERRORLEVEL%

:1
DEL /A /F /Q \\?\%F%
RD /Q /S \\?\%F%
CLS
IF /I EXIST %F% (ECHO 目标文件%F%删除文件失败！) ELSE (ECHO 目标文件%F%已被成功删除。)
PAUSE
GOTO MAIN

:2
CACLS %F% /E /T /G SYSTEM:F
CACLS %F% /E /T /G ADMINISTRATORS:F
CACLS %F% /E /T /G %USERNAME%:F
CACLS %F% /E /T /G USERS:F
CACLS %F% /E /T /G EVERYONE:F
GOTO 1

:3
FOR /F "DELIMS=: TOKENS=1" %%I IN ('ECHO %F%') DO (SET D=^%%I)
SET D=%D:~-1%:
IF /I %D%==%SYSTEMDRIVE% (ECHO 无法强行卸下系统盘，请选择其它模式。&PAUSE&GOTO MAIN)
CHKDSK /X %D%
GOTO 2

:4
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET DESKTOP=%SYSTEMDRIVE%&GOTO 5)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET TOP=%%I)
SET DESKTOP=%DESK%:%TOP%
ECHO @ECHO OFF>"%DESKTOP%\拖拽删除.bat"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO COLOR %%I 1>>"%DESKTOP%\拖拽删除.bat")
ECHO DEL /A /F /Q /S \\?\%%1 1>>"%DESKTOP%\拖拽删除.bat"
ECHO RD /Q /S \\?\%%1 1>>"%DESKTOP%\拖拽删除.bat"
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO SLEEP %%I000 1>>"%DESKTOP%\拖拽删除.bat")
IF EXIST "%DESKTOP%\拖拽删除.bat" (REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V {645FF040-5081-101B-9F08-00AA002F954E} /D 1 /F) ELSE (GOTO 6)
ATTRIB +A +R +S -H "%DESKTOP%\拖拽删除.bat"
GOTO 8

:5
ECHO 提取公共桌面路径失败，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:6
ECHO 创建文件失败，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:7
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET DESKTOP=%SYSTEMDRIVE%&GOTO 5)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET TOP=%%I)
SET DESKTOP=%DESK%:%TOP%
DEL /A /F /Q "%DESKTOP%\拖拽删除.bat"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V {645FF040-5081-101B-9F08-00AA002F954E} /D 0 /F

:8
CLS
ECHO 操作成功结束，请检阅您的桌面，并按任意键返回主面板。
PAUSE>NUL
GOTO MAIN