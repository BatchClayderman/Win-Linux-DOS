@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE Win DOS安装程序
COLOR E
CLS
ECHO 安装程序正在检查安装相关组件，请稍候...
IF NOT EXIST "%COMSPEC:~0,-7%find.exe" (CLS&ECHO 系统文件Find.exe丢失，Win DOS无法正常使用，请按任意键退出。&PAUSE>NUL&EXIT)
IF /I "%SYSTEMDRIVE%"=="X:" (TITLE Win DOS安装程序（PE模式）&CLS&GOTO 1)
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (ECHO 系统文件mshta.exe丢失，无法继续安装，请按任意键退出。&PAUSE>NUL&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%reg.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件reg.exe丢失，无法继续安装。",16,"Win DOS安装程序"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%~DP0choice.exe" (IF NOT EXIST "%COMSPEC:~0,-7%choice.exe" (IF EXIST "%~DP0Win DOS\choice.exe" (XCOPY /H /K /V /Y "%~DP0Win DOS\choice.exe" "%~DP0"&ATTRIB +A +H +R +S "%~DP0choice.exe") ELSE (MSHTA VBSCRIPT:MSGBOX("Win DOS安装程序找不到choice.exe，无法继续安装。",16,"Win DOS安装程序"^)(WINDOW.CLOSE^)&EXIT)))
FOR /F %%I IN ('DIR /A-D /B /W /S "%~DP0Win DOS"^|FIND /V /C ""') DO (IF NOT %%I==50 (MSHTA VBSCRIPT:MSGBOX("Win DOS安装程序文件不完整，无法继续安装。",16,"Win DOS安装程序"^)(WINDOW.CLOSE^)&EXIT))
IF "%1"=="/YES" (ECHO 成功！>"%TEMP%\WinDOSSetup.tmp"&GOTO 1)
VER|FIND /I "XP">NUL
IF %ERRORLEVEL%==0 (GOTO 1)
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp")
IF EXIST "%TEMP%\WinDOSSetup.tmp" (CLS&ECHO 删除缓存失败！&GOTO 0)
ECHO 正在提权，请稍候...
MSHTA VBSCRIPT:CREATEOBJECT("shell.application").shellexecute("%~S0","/YES","","RUNAS",1)(WINDOW.CLOSE)
"%~DP0Win DOS\SLEEP" 500
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp"&EXIT)

:0
CLS
ECHO 提权等待超时或已经失败，是否尝试继续在非管理员权限下继续安装？
ECHO 如果继续，请于安装后使用Win DOS辅助工具在本系统上注册Win DOS。
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
TITLE Win DOS安装程序（警告：非管理员模式）
CLS

:1
COLOR E
SET MESS1=安装桌面快捷方式成功。
SET MESS2=安装开始菜单快捷启动成功。
SET MESS3=已成功保留原设置。
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayName
SET SI=%ERRORLEVEL%
CLS
ECHO 欢迎使用Win DOS，感谢您对Win DOS的一份支持！
ECHO 软件宗旨：为跨领域和受计算机技术困扰的人们提供一个交互平台。
ECHO 使用说明：1．若您不能接受本界面中的条款，请您不要继续安装本软件；
ECHO           2．本软件最初由星空Win DOS团队开发，2017年已对外发行；
ECHO           3．2022年，负责人以个人名义优化了该软件并编写了Linux版本；
ECHO           4．您可以查看每个程序的源代码，但不可以另行更改、发行；
ECHO           5．若需要进行代码复制，请清除代码中涉及本公司的内容；
ECHO           6．若要卸载本软件，请到主面板选择“0”来运行卸载程序；
ECHO           7．请勿将安装程序隔离运行并确保您的操作系统没有问题；
ECHO           8．软件为Windows通用净化版，只占1MB内存且无主动联网；
ECHO           9．建议安装后到主面板激活Win DOS并查看、学习使用帮助；
ECHO           10．软件无商业广告，祝您身体健康、心想事成、万事如意！
ECHO.
ECHO 请选择Win DOS安装目标磁盘，如需取消安装，请选择“0”：
CHOICE /C 0CDEFGHIJKLMNOPQRSTUVWXYZ
IF %ERRORLEVEL%==1 EXIT
IF %ERRORLEVEL%==2 (SET D=C)
IF %ERRORLEVEL%==3 (SET D=D)
IF %ERRORLEVEL%==4 (SET D=E)
IF %ERRORLEVEL%==5 (SET D=F)
IF %ERRORLEVEL%==6 (SET D=G)
IF %ERRORLEVEL%==7 (SET D=H)
IF %ERRORLEVEL%==8 (SET D=I)
IF %ERRORLEVEL%==9 (SET D=J)
IF %ERRORLEVEL%==10 (SET D=K)
IF %ERRORLEVEL%==11 (SET D=L)
IF %ERRORLEVEL%==12 (SET D=M)
IF %ERRORLEVEL%==13 (SET D=N)
IF %ERRORLEVEL%==14 (SET D=O)
IF %ERRORLEVEL%==15 (SET D=P)
IF %ERRORLEVEL%==16 (SET D=Q)
IF %ERRORLEVEL%==17 (SET D=R)
IF %ERRORLEVEL%==18 (SET D=S)
IF %ERRORLEVEL%==19 (SET D=T)
IF %ERRORLEVEL%==20 (SET D=U)
IF %ERRORLEVEL%==21 (SET D=V)
IF %ERRORLEVEL%==22 (SET D=W)
IF %ERRORLEVEL%==23 (SET D=X)
IF %ERRORLEVEL%==24 (SET D=Y)
IF %ERRORLEVEL%==25 (SET D=Z)
SET D=%D%:

:2
ECHO 可供选择的路径有：
ECHO   1="%D%\Win DOS"（安装在根目录下）
ECHO   2="%D%\Program Files\Win DOS"（32位正常安装）
ECHO   3="%D%\Program Files (x86)\Win DOS" （64位正常安装）
ECHO   4="%COMSPEC:~0,-8%"（安装在系统目录下）
ECHO 请选择Win DOS安装目录，如需重新选择磁盘，请选择“0”：
CHOICE /C 12340
IF %ERRORLEVEL%==1 (SET P=%D%)
IF %ERRORLEVEL%==2 (SET P=%D%\Program Files)
IF %ERRORLEVEL%==3 (SET Z=^"&SET P=%D%\Program Files (x86^))
IF %ERRORLEVEL%==4 (SET P=%COMSPEC:~0,-8%)
IF %ERRORLEVEL%==5 (GOTO 1)
IF "%P%\"=="%~DP0" (GOTO E)
ECHO 安装程序将会将快捷启动方式安装到桌面和开始菜单。
ECHO 如果您对操作系统并不熟悉，请您不要随意删除。
IF %SI%==0 (ECHO 请注意：您的系统上已安装Win DOS，设置将会保留。)
ECHO Win DOS将会安装到"%P%"中,是否确认？
CHOICE /C YNC /M "Y=启动安装，N=返回上一步，C=退出程序。"
CLS
IF %ERRORLEVEL%==2 (GOTO 2)
IF %ERRORLEVEL%==3 EXIT
COLOR A
SET PW="%P%\Win DOS\Welcome.bat"
SET PS="%P%\Win DOS\Settings.bat"
SET PF="%P%\Win DOS\FixCmd.reg"
SET PV="%P%\Win DOS\ExpansionVerify.bat"
SET PE="%P%\Win DOS\ExpansionEnsure.bat"
SET PU="%P%\Win DOS\Uninstall.bat"
SET PC="%P%\Win DOS\Config.ini"
SET PT="%P%\Win DOS\Test.bat"
SET PA="%P%\Win DOS\*"
SET PB="%P%\Win DOS\"
SET PP="%P%\Win DOS\password.bat"
SET P="%P%\Win DOS"
CLS
IF NOT %SI%==0 (GOTO 3)
ECHO 正在备份原设置并卸载原文件，可能需要几秒钟，请稍候...
FOR /F "DELIMS=: TOKENS=1" %%I in ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V UninStallString^|FIND /I "Win DOS"') DO (SET P0=%%I)
SET P0=%P0:~-1%
FOR /F "DELIMS=: TOKENS=2" %%I in ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V UninStallString^|FIND /I "Win DOS"') DO (SET P0=%P0%:%%~PI)
FOR /F "TOKENS=*" %%I IN ('TYPE "%P0%Config.ini"') DO (SET CFG=%%I)
SET CG=%CFG:~-1%
SET CFG=%CFG:~0,-1%
IF /I "%P0%"=="%~DP0Win DOS\" (GOTO F)
DEL /A /F /Q /S "%P0%*"
RD "%P0:~0,-1%" /Q /S

:3
ECHO 安装程序初始化，可能需要几秒钟，请稍候...
MD %P%
ECHO Win DOS测试文件，请删除。>%PT%
IF /I NOT EXIST %PT% (
	ECHO 您选择的路径不存在或已被其它程序锁定，请您重新选择。
	ECHO 如果您不是以管理员会话启动，部分路径将被无效。
	PAUSE
	GOTO 1
)
DEL /A /F /Q /S %PA%
CLS
ECHO 正在拷贝文件，可能需要十几秒钟，请稍候...
XCOPY "%~DP0Win DOS\*" %PB% /H /K /R /V /Y>NUL
ATTRIB -A -H -R -S %PP%
ECHO ::%PP:~1,-1%>>%PP%
ATTRIB +A +H +R +S %PA% /D /S
ATTRIB +A +H +R +S %P% /D /S
IF %SI%==0 (DEL /A /F /Q %PC%)
IF %SI%==0 (IF EXIST %PC% (SET MESS3=原设置保留失败，已被重置。))
IF %SI%==0 (ECHO %CFG%^%CG%>%PC%&ATTRIB +A +H +R +S %PC%)
FOR /F %%I IN ('DIR /A-D /B /W /S %P%^|FIND /V /C ""') DO (IF NOT %%I==50 (GOTO ERROR))
CLS
ECHO 正在注册软件，可能需要几秒钟，请稍候...
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayName /D "Win DOS" /F>NUL
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayIcon /D %PW% /F>NUL
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V Publisher /D "星空公司Win DOS团队" /F>NUL
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V UninstallString /D %PU% /F>NUL
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V InstallTime /D "%DATE% %TIME%" /F>NUL
CLS
ECHO 正在安装快捷方式，可能需要几秒钟，请稍候...
DEL /A /F /Q "%SYSTEMDRIVE%\运行Win DOS主面板.bat"
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET DESKTOP=%SYSTEMDRIVE%&GOTO 4)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET TOP=%%I)
SET DESKTOP=%DESK%:%TOP%

:4
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET MENU=%SYSTEMDRIVE%&GOTO 5)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET ME=%%I)
SET ME=%ME:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET NU=%%I)
SET MENU=%ME%:%NU%

:5
DEL /A /F /Q "%DESKTOP%\运行Win DOS主面板.bat"
RD /Q /S "%MENU%\Win DOS"
ECHO START /REALTIME CMD.EXE /K %Z%%PW%%Z%>"%DESKTOP%\运行Win DOS主面板.bat"
ATTRIB +A -H +R +S "%DESKTOP%\运行Win DOS主面板.bat"
IF NOT EXIST "%DESKTOP%\运行Win DOS主面板.bat" (IF /I "%DESKTOP%"=="%SYSTEMDRIVE%" (SET MESS1=安装程序安装过程出现错误，桌面快捷方式未能成功创建。) ELSE (SET 安装程序无法创建桌面快捷方式。))
IF /I "%DESKTOP%"=="%SYSTEMDRIVE%" (SET MESS1=安装程序无法获取系统桌面路径，已将快捷方式安装在了%SYSTEMDRIVE:~0,-1%盘。)
MD "%MENU%\Win DOS\"
ECHO START /REALTIME CMD.EXE /K %Z%%PW%%Z%>"%MENU%\Win DOS\运行Win DOS主面板.bat"
ECHO START /REALTIME CMD.EXE /K %Z%%PS%%Z% /R>"%MENU%\Win DOS\重置Win DOS设置.bat"
XCOPY %PF% "%MENU%\Win DOS\" /C /H /R /V /Y>NUL
XCOPY %PV% "%MENU%\Win DOS\" /C /H /R /V /Y>NUL
XCOPY %PE% "%MENU%\Win DOS\" /C /H /R /V /Y>NUL
ATTRIB -A -H -R -S "%MENU%\Win DOS\*" /D /S>NUL
ATTRIB -A -H -R -S "%MENU%\Win DOS" /D /S>NUL
REN "%MENU%\Win DOS\FixCmd.reg" "修复Win DOS.reg">NUL
REN "%MENU%\Win DOS\ExpansionVerify.bat" 参变检测仪.bat>NUL
ATTRIB +A -H +R +S "%MENU%\Win DOS\*" /D /S>NUL
ATTRIB +A -H +R +S "%MENU%\Win DOS" /D /S>NUL
ATTRIB +A +H +R +S "%MENU%\Win DOS\ExpansionEnsure.bat" /D /S>NUL
IF NOT EXIST "%MENU%\Win DOS\运行Win DOS主面板.bat" (GOTO L)
IF NOT EXIST "%MENU%\Win DOS\重置Win DOS设置.bat" (GOTO L)
IF NOT EXIST "%MENU%\Win DOS\修复Win DOS.reg" (GOTO L)
IF NOT EXIST "%MENU%\Win DOS\参变检测仪.bat" (GOTO L)
IF NOT EXIST "%MENU%\Win DOS\ExpansionEnsure.bat" (GOTO L)
IF "%MENU%"=="%SYSTEMDRIVE%" (SET MESS2=安装程序无法获取系统开始菜单路径，已将快捷启动安装在了%SYSTEMDRIVE:~0,-1%盘。)

:6
CLS
ECHO %MESS1%
ECHO %MESS2%
IF %SI%==0 (ECHO %MESS3%)
ECHO 安装成功结束，在此，我们再次感谢您对Win DOS的大力支持！
ECHO 祝您身体健康、心想事成、万事如意！请按任意键退出安装程序。
PAUSE>NUL
EXIT

:E
CLS
ECHO 您选择的安装目录和安装包所在目录相同，请按任意键重新选择。
PAUSE>NUL
GOTO 1

:F
CLS
ECHO 您正在使用已安装目录文件安装本程序，请使用纯净的安装源。
ECHO 请按任意键退出程序。
PAUSE>NUL
EXIT

:ERROR
COLOR CF
CLS
ECHO 程序未正确安装，正在清除拷贝文件，请稍候...
RD /D /S %P%
CLS
ECHO 请确保安装程序具有安装权限并且无反病毒软件拦截。
ECHO 如果这不是您第一次看到这个错误，请您检查系统。
ECHO 程序未能正确安装，是否返回到安装页面？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO 1)
CLS
MSHTA VBSCRIPT:MSGBOX("Win DOS未正确安装，请稍后完成安装。",16,"Win DOS安装程序")(WINDOW.CLOSE)
EXIT

:L
IF /I "%MENU%"=="%SYSTEMDRIVE%" (SET MESS2=安装程序无法安装开始菜单快捷方式，请您到Win DOS主面板注册Win DOS。&GOTO 6)
SET MESS2=安装程序安装过程出现错误，部分开始菜单快捷方式未能成功创建。
GOTO 6

:PE
GOTO 1