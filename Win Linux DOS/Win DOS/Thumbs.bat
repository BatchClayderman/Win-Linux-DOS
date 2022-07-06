@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Win DOS辅助工具

:MAIN
CLS
ECHO Win DOS辅助工具主面板
ECHO   1=Win DOS安装数据校验器
ECHO   2=激活或取消激活Win DOS
ECHO   3=注册或反注册Win DOS
ECHO   4=创建Win DOS快捷方式
ECHO   5=卸载Win DOS
ECHO   6=打开Win DOS所在目录
ECHO   0=返回Win DOS主界面
ECHO 请选择一项以继续：
CHOICE /C 1234560
IF %ERRORLEVEL%==7 (START /REALTIME WELCOME&EXIT)
CLS
GOTO %ERRORLEVEL%

:1
TITLE Win DOS安装数据校验器
ECHO 正在清除缓存，请稍候...
DEL /A /F /Q /S "%~DP0Output.txt"
IF NOT EXIST "%COMSPEC:~0,-7%find.exe" (ECHO 系统文件Find.exe丢失，统计操作被撤回。&PAUSE&GOTO MAIN)
CLS
ECHO 目录位置："%CD%"。
ECHO 文件位置："%~DP0*"。
ECHO 应有文件个数：50。
FOR /F %%I IN ('DIR /A-D /B /W /S "%~DP0"^|FIND /V /C ""') DO (@ECHO 实际文件个数：%%I。&IF %%I==50  (ECHO 数据正确，Win DOS暂未发现问题。) ELSE (ECHO 错误：文件个数不正确。))
ECHO 请校准安装文件数据，按任意键返回主面板。
PAUSE>NUL
TITLE Win DOS辅助工具
GOTO MAIN

:2
ECHO 请选择一项以继续：
CHOICE /C YNRC /M "Y=激活，N=取消激活，R=深度激活，C=返回主面板。"
CLS
IF %ERRORLEVEL%==4 (GOTO MAIN)
IF %ERRORLEVEL%==3 (SET R=1) ELSE (SET R=0)
IF %ERRORLEVEL%==3 (GOTO 21)
GOTO 2%ERRORLEVEL%

:21
ECHO 正在激活Win DOS，请稍候...
XCOPY "%~DP0*.exe" "%COMSPEC:~0,-7%" /H /K /R /V
XCOPY "%~DP0systemrun.bat" "%COMSPEC:~0,-7%" /H /K /R /V /Y
XCOPY "%~DP0SysInfoMate.bat" "%COMSPEC:~0,-7%" /H /K /R /V /Y
XCOPY "%~DP0SetFile.bat" "%COMSPEC:~0,-7%" /H /K /R /V /Y
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%systemrun.bat"
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%SysInfoMate.bat"
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%SetFile.bat"
IF %R%==0 (GOTO 23)
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (
	REG ADD "HKCR\Folder\shell\cmd" /VE /D "从此处启动命令提示符" /F
	REG ADD "HKCR\Folder\shell\cmd\command" /VE /D "%COMSPEC% /K COLOR %%I&CD /D %%1" /F
	REG ADD "HKCR\*\shell\cmd" /VE /D "从此处启动命令提示符" /F
	REG ADD "HKCR\*\shell\cmd\command" /VE /D "%COMSPEC% /K COLOR %%I&CD /D %%1" /F
)
REG ADD HKCR\*\shell\secret /VE /T Reg_SZ /D 设密而不隐藏 /F
REG ADD HKCR\*\shell\secret\command /VE /T Reg_SZ /D "SetFile.bat /secret \"%%1\"" /F
REG ADD HKCR\*\shell\secret /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\set /VE /T Reg_SZ /D 全选文件属性 /F
REG ADD HKCR\*\shell\set\command /VE /T Reg_SZ /D "SetFile.bat /set \"%%1\"" /F
REG ADD HKCR\*\shell\set /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\show /VE /T Reg_SZ /D 去除所有文件属性 /F
REG ADD HKCR\*\shell\show\command /VE /T Reg_SZ /D "SetFile.bat /show \"%%1\"" /F
REG ADD HKCR\*\shell\show /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\secret /VE /T Reg_SZ /D 设密而不隐藏 /F
REG ADD HKCR\Folder\shell\secret\command /VE /T Reg_SZ /D "SetFile.bat /secret \"%%1\"" /F
REG ADD HKCR\Folder\shell\secret /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\set /VE /T Reg_SZ /D 全选子文件属性 /F
REG ADD HKCR\Folder\shell\set\command /VE /T Reg_SZ /D "SetFile.bat /set \"%%1\"" /F
REG ADD HKCR\Folder\shell\set /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\show /VE /T Reg_SZ /D 去除所有子文件属性 /F
REG ADD HKCR\Folder\shell\show\command /VE /T Reg_SZ /D "SetFile.bat /show \"%%1\"" /F
REG ADD HKCR\Folder\shell\show /V NoWorkingDirectory /D "" /F
GOTO 23

:22
ECHO 正在取消Win DOS激活状态，请稍候...
DEL "%COMSPEC:~0,-7%systemrun.bat" /A /F /Q
DEL "%COMSPEC:~0,-7%SysInfoMate.bat" /A /F /Q
DEL "%COMSPEC:~0,-7%SetFile.bat" /A /F /Q
REG DELETE HKCR\Folder\shell\cmd /F
REG DELETE HKCR\*\shell\cmd /F
REG DELETE HKCR\*\shell\secret /F
REG DELETE HKCR\*\shell\set /F
REG DELETE HKCR\*\shell\show /F
REG DELETE HKCR\Folder\shell\secret /F
REG DELETE HKCR\Folder\shell\set /F
REG DELETE HKCR\Folder\shell\show /F

:23
SET R=
ECHO 执行操作完毕，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:3
FOR /F %%I IN ('DIR /A-D /B /W /S "%~DP0"^|FIND /V /C ""') DO (IF NOT %%I==50 (MSHTA VBSCRIPT:MSGBOX("Win DOS未正确安装，无法注册Win DOS，请先完成安装再进行注册。",16,"%T%"^)(WINDOW.CLOSE^)&GOTO MAIN))
ECHO 注册与反注册选择
ECHO   1=完整注册（将会重写安装日期以及上次启动时间）
ECHO   2=反注册（清除所有注册信息）
ECHO   3=重定向注册（保留用户数据）
ECHO   0=返回主面板
ECHO 请选择一项以继续：
CHOICE /C 1230
IF %ERRORLEVEL%==4 (GOTO MAIN)
CLS
GOTO 3%ERRORLEVEL%

:31
CLS
ECHO 正在完整注册Win DOS，请稍候...
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayName /D "Win DOS" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayIcon /D "%~DP0welcome.bat" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V Publisher /D "星空公司Win DOS团队" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V UninstallString /D "%~DP0Uninstall.bat" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V InstallTime /D "%DATE% %TIME%" /F
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V RunTime /F
PAUSE
GOTO MAIN

:32
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /F
PAUSE
GOTO MAIN

:33
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayName /D "Win DOS" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayIcon /D "%~DP0welcome.bat" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V Publisher /D "星空公司Win DOS团队" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V UninstallString /D "%~DP0Uninstall.bat" /F
PAUSE
GOTO MAIN

:4
SET Z="
SET "P=%~DP0"
SET "P=%P:~0,-9%"
SET MESS1=安装桌面快捷方式成功。
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
ECHO 正在安装快捷方式，可能需要几秒钟，请稍候...
DEL /A /F /Q "%SYSTEMDRIVE%\运行Win DOS主面板.bat"
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET DESKTOP=%SYSTEMDRIVE%&GOTO 41)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET TOP=%%I)
SET DESKTOP=%DESK%:%TOP%

:41
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET MENU=%SYSTEMDRIVE%&GOTO 42)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET ME=%%I)
SET ME=%ME:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON PROGRAMS"') DO (SET NU=%%I)
SET MENU=%ME%:%NU%

:42
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
IF NOT EXIST "%MENU%\Win DOS\运行Win DOS主面板.bat" (GOTO 43)
IF NOT EXIST "%MENU%\Win DOS\重置Win DOS设置.bat" (GOTO 43)
IF NOT EXIST "%MENU%\Win DOS\修复Win DOS.reg" (GOTO 43)
IF NOT EXIST "%MENU%\Win DOS\参变检测仪.bat" (GOTO 43)
IF NOT EXIST "%MENU%\Win DOS\ExpansionEnsure.bat" (GOTO 43)
IF "%MENU%"=="%SYSTEMDRIVE%" (SET MESS2=安装程序无法获取系统开始菜单路径，已将快捷启动安装在了%SYSTEMDRIVE:~0,-1%盘。)

:43
IF /I "%MENU%"=="%SYSTEMDRIVE%" (SET MESS2=安装程序无法安装开始菜单快捷方式，请您到Win DOS主面板注册Win DOS。) ELSE (SET MESS2=安装程序安装过程出现错误，部分开始菜单快捷方式未能成功创建。)
CLS
ECHO %MESS1%
ECHO %MESS2%
PAUSE
GOTO MAIN

:5
START /LOW Uninstall /Verify
EXIT

:6
START "" "%~DP0"
PAUSE
GOTO MAIN