@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Win DOS卸载程序
SET C=%SYSTEMDRIVE%
CLS
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (ECHO 由于您的系统丢失文件mshta.exe，部分信息将无法正确传递，但卸载正常。&PAUSE)
IF NOT "%1"=="/Verify" (START /LOW MSHTA VBSCRIPT:MSGBOX("Win DOS第一代反病毒软件提醒您："^&vbcrlf^&"可疑程序正在尝试卸载Win DOS，该卸载操作已被阻止！"^&vbcrlf^&"如果这不是您的主动操作，很可能是因为您的计算机上有间谍软件。"^&vbcrlf^&"如果您想要卸载Win DOS，请您到主面板选择“1”，然后卸载。"^&vbcrlf^&"给您带来的不便，请谅解！",16,"Win DOS卸载程序"^)(WINDOW.CLOSE^)&EXIT)
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (IF %%I==0 (GOTO 1))
CLS
ECHO 您开启密码保护，请您先检验密码。
START /WAIT /I /REALTIME "" PASSWORD.BAT /V
IF EXIST "%TEMP%\V" (FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF "%%I"=="V" (GOTO 1)))
ECHO 您取消了密码输入或所输入的密码有误，请按任意键返回主面板。
PAUSE>NUL
START /REALTIME /I "" WELCOME.BAT
EXIT

:1
CLS
ECHO 我们承诺，一般地，除了DOS激活类文件和注册表以及$MFT中的文件记录之外，
ECHO 我们不会在您的电脑上留下任何走过的痕迹，请放心卸载！
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (ECHO 由于您的系统丢失文件mshta.exe，部分信息将无法正确传递，但卸载正常。)
ECHO 是否保留激活Win DOS后写入系统的文件及注册表？
CHOICE /C YNC /M "Y=保留，N=删除，C=退出卸载程序。"
IF %ERRORLEVEL%==3 EXIT
SET UI=%ERRORLEVEL%
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Win DOS卸载程序-正在卸载Win DOS，请稍候...
CLS
ECHO 正在反注册软件，可能需要几秒钟，请稍候...
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /F>NUL
CLS
IF %UI%==1 (GOTO 2)
ECHO 正在取消Win DOS激活状态，请稍候...
DEL "%COMSPEC:~0,-7%systemrun.bat" /A /F /Q
DEL "%COMSPEC:~0,-7%SysInfoMate.bat" /A /F /Q
DEL "%COMSPEC:~0,-7%SetFile.bat" /A /F /Q
REG DELETE HKCR\*\shell\secret /F
REG DELETE HKCR\*\shell\set /F
REG DELETE HKCR\*\shell\show /F
REG DELETE HKCR\Folder\shell\secret /F
REG DELETE HKCR\Folder\shell\set /F
REG DELETE HKCR\Folder\shell\show /F
REG DELETE HKCR\*\shell\cmd /F
REG DELETE HKCR\*\shell\runas /F

:2
ECHO 正在清除快捷方式，可能需要几秒钟，请稍候...
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET DESKTOP=%C%&GOTO 3)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET TOP=%%I)
SET DESKTOP=%DESK%:%TOP%

:3
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET MENU=%C%&GOTO 4)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET ME=%%I)
SET ME=%ME:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET NU=%%I)
SET MENU=%ME%:%NU%
GOTO 4

:4
DEL /A /F /Q "%DESKTOP%\运行Win DOS主面板.bat"
RD /Q /S "%MENU%\Win DOS%"
DEL /A /F /Q "%DESKTOP%\拖拽删除.bat"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V {645FF040-5081-101B-9F08-00AA002F954E} /D 0 /F
CLS
ECHO 正在清除缓存文件，可能需要几秒钟，请稍候...
DEL /A /F /Q %C%\Normalprocess.txt
DEL /A /F /Q %C%\PID.txt
DEL /A /F /Q "%C%\运行Win DOS主面板.bat"
DEL /A /F /Q %C%\Speedup1.reg
DEL /A /F /Q %C%\Speedup2.reg
DEL /A /F /Q %C%\Speedup.reg
DEL /A /F /Q %C%\WmiSys.txt
DEL /A /F /Q "%COMSPEC:~0,-7%AntiVirus.txt"
DEL /A /F /Q "%COMSPEC:~0,-7%PathFinder.txt"
DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp"
DEL "%TEMP%\rp.txt" /A /F /Q
DEL "%TEMP%\password.txt" /A /F /Q
DEL "%TEMP%\password.vbs" /A /F /Q
DEL "%TEMP%\V" /A /F /Q
FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (DEL /A /F /Q %%I\Vir*.*)
IF /I NOT EXIST "%TEMP%\Uninstall.bat" (GOTO 6)

:5
DEL /A /F /Q "%TEMP%\Uninstall.bat"
IF EXIST "%TEMP%\Uninstall.bat" (MSHTA VBSCRIPT:MSGBOX("关键缓存清除失败，清除操作被第三方反病毒软件阻止或拦截！点击“确定”重试。",16,"Win DOS卸载程序"^)(WINDOW.CLOSE^)&GOTO 5)

:6
CLS
ECHO 正在创建脱壳卸载程序，可能需要几秒钟，请稍候...
SET T=%~DP0
SET T="%T:~0,-1%"
ECHO @ECHO OFF>"%TEMP%\Uninstall.bat"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') do (ECHO COLOR %%I>>"%TEMP%\Uninstall.bat")
ECHO CD /D "%%~DP0">>"%TEMP%\Uninstall.bat"
ECHO TITLE Win DOS脱壳卸载程序>>"%TEMP%\Uninstall.bat"
ECHO CLS>>"%TEMP%\Uninstall.bat"
ECHO ECHO 正在脱壳卸载Win DOS，可能需要几秒钟，请稍候...>>"%TEMP%\Uninstall.bat"
ECHO DEL /A /F /Q /S "%~DP0*">>"%TEMP%\Uninstall.bat"
ECHO RD /Q /S %T%>>"%TEMP%\Uninstall.bat"
ECHO IF EXIST %T% (MSHTA VBSCRIPT:MSGBOX("脱壳卸载失败，卸载操作被第三方防病毒软件阻止或拦截。",16,"Win DOS脱壳卸载程序"^^^)(WINDOW.CLOSE^^^))>>"%TEMP%\Uninstall.bat"
ECHO IF EXIST %T% EXIT>>"%TEMP%\Uninstall.bat"
ECHO START /LOW MSHTA VBSCRIPT:MSGBOX("卸载成功结束，于此，我们再次感谢您对Win DOS的大力支持！祝您身体健康、心想事成、万事如意！再会！",64,"Win DOS卸载程序")(WINDOW.CLOSE)>>"%TEMP%\Uninstall.bat"
ECHO DEL /A /F /Q "%TEMP%\Uninstall.bat"^&EXIT>>"%TEMP%\Uninstall.bat"
ATTRIB +A +H +R +S "%TEMP%\Uninstall.bat"
IF NOT EXIST "%TEMP%\Uninstall.bat" (MSHTA VBSCRIPT:MSGBOX("卸载失败，卸载操作被第三方反病毒软件阻止或拦截！",16,"Win DOS卸载程序"^)(WINDOW.CLOSE^))
"%TEMP%\Uninstall.bat"
EXIT