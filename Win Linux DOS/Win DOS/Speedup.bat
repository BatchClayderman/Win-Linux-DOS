@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET PT=%%I)
SETLOCAL ENABLEDELAYEDEXPANSION
TITLE 加速优化
CLS
IF /I "%SYSTEMDRIVE%"=="X:" (ECHO 请使用Windows PE专用优化工具优化。&PAUSE&EXIT)
TITLE 加速优化-一键结束无用进程
SET E=0
ECHO 即将进行一键结束无用进程，如果不需要请于%PT%秒内选择“N”。
CHOICE /C YN /T %PT% /D Y
IF %ERRORLEVEL%==2 EXIT
TASKKILL /IM CONIME.EXE /IM CTFMON.EXE /IM SAVEDUMP.EXE /IM SGTOOL.EXE /IM SOGOUCLOUD.EXE /IM TECENTDL.EXE /IM TSSERVICE.EXE /IM TXPLATFORM.EXE /IM WMIPRVSE.EXE /IM WUAUCLT.EXE /F /T
TASKKILL /IM CONIME.EXE /IM CTFMON.EXE /IM SAVEDUMP.EXE /IM SGTOOL.EXE /IM SOGOUCLOUD.EXE /IM TECENTDL.EXE /IM TSSERVICE.EXE /IM TXPLATFORM.EXE /IM WMIPRVSE.EXE /IM WUAUCLT.EXE /F /T
WMIC PROCESS GET NAME|FIND /I "SPOOLSV.EXE"
IF %ERRORLEVEL%==0 (
	ECHO 检测到打印机进程正在运行，是否执行结束？
	CHOICE /C YN /T %PT% /D Y /M "（%PT%秒后将会自动结束）"
	IF /I !ERRORLEVEL!==1 (TASKKILL /IM SPOOLSV.EXE /F /T&SC CONFIG Spooler START= DEMAND )
)
CLS
VER|FIND /I "XP">NUL
IF %ERRORLEVEL%==1 (ECHO 加速优化完成，程序将于%PT%秒后自动退出。&SLEEP %PT%&EXIT)
TITLE 加速优化-关闭IDE通道检测
ECHO 即将关闭IDE通道检测，如果不需要请于%PT%秒内选择“N”。
CHOICE /C YN /T %PT% /D Y
IF %ERRORLEVEL%==2 EXIT
SET HKEY1=HKLM\SYSTEM\CurrentControlSet\Enum\PCIIDE\IDEChannel
SET HKEY2=HKLM\SYSTEM\CurrentControlSet\Control\Class
FOR /F "USEBACKQ TOKENS=*" %%I IN ('REG QUERY %HKEY1%^|FIND /I "IDEChannel\"') DO (CALL :CHECK %%I)
GOTO CHECK

:CHECK
FOR /F "USEBACKQ TOKENS=3*" %%I IN ('REG QUERY %1^|FIND/I "driver"') DO (SET "SUBKEY=%%I")
FOR /F "USEBACKQ TOKENS=3,4*" %%I IN ('REG QUERY "%HKEY2%\%SUBKEY%" /V DriverDesc^|FIND /I "driverdesc"') DO (SET DriverDesc=%%I %%J 通道)
REG QUERY "%HKEY2%\%SUBKEY%" /V MasterDeviceType|FIND /I "0x1">NUL
IF %ERRORLEVEL%==1 (GOTO ChgMaster)
GOTO CheckSlave

:ChgMaster
REG ADD "%hkey2%\%subkey%" /V UserMasterDeviceType /T REG_DWORD /D 3 /F
ECHO “%DriverDesc%”的设备0检测方式设置为无。
GOTO CheckSlave

:CheckSlave
REG QUERY "%HKEY2%\%SUBKEY%" /V SlaveDeviceType|FIND "0x1">NUL
if %ERRORLEVEL%==1 (GOTO ChgSlave)
GOTO EOF

:ChgSlave
REG ADD "%HKEY2%\%SUBKEY%" /V UserSlaveDeviceType /T REG_DWORD /D 3 /F
ECHO “%DriverDesc%”的设备1检测方式设置为无。
GOTO EOF

:EOF
TITLE 加速优化-重置计划任务
CLS
ECHO 即将重置计划任务，如果不需要请于%PT%秒内选择“N”。
CHOICE /C YN /T %PT% /D Y
IF %ERRORLEVEL%==2 EXIT
AT /DELETE /YES
DEL /A /F /Q "%SYSTEMROOT%\TASKS\*"
TITLE 加速优化-清除无用自启项目
CLS
ECHO 说明：1．启动的注册表将会备份在%SYSTEMDRIVE:~0,-1%盘的根目录下，
ECHO          双击SpeedUp.reg即可还原启动项，运行垃圾清理时将会将其清除。
ECHO       2．优化有一定风险，请自行决定，默认值为“取消”；
ECHO 即将清除无用自启项目，如果需要请于%PT%秒内选择“Y”。
CHOICE /C YN /T %PT% /D N
IF %ERRORLEVEL%==2 EXIT
SC DELETE QQRepairFixSVC
SC DELETE TxQBService
IF /I EXIST %SYSTEMDRIVE%\SpeedUp1.reg (
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G SYSTEM:F
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G ADMINISTRATORS:F
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G %USERNAME%:F
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G USERS:F
	CACLS %SYSTEMDRIVE%\SpeedUp1.reg /E /G EVERYONE:F
	DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp1.reg
)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp2.reg (
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G SYSTEM:F
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G ADMINISTRATORS:F
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G %USERNAME%:F
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G USERS:F
	CACLS %SYSTEMDRIVE%\SpeedUp2.reg /E /G EVERYONE:F
	DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp2.reg
)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp.reg (
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G SYSTEM:F
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G ADMINISTRATORS:F
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G %USERNAME%:F
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G USERS:F
	CACLS %SYSTEMDRIVE%\SpeedUp.reg /E /G EVERYONE:F
	DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp.reg
)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp1.reg (MSHTA "VBSCRIPT:MSGBOX("无法删除原临时备份文件1！",16,"加速优化-优化无用自启项目时发生错误"^)(WINDOW.CLOSE^)"&SET E=1)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp2.reg (MSHTA "VBSCRIPT:MSGBOX("无法删除原临时备份文件2！",16,"加速优化-优化无用自启项目时发生错误"^)(WINDOW.CLOSE^)"&SET E=1)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp.reg (MSHTA "VBSCRIPT:MSGBOX("无法删除原备份文件！",16,"加速优化-优化无用自启项目时发生错误"^)(WINDOW.CLOSE^)"&SET E=1)
REG EXPORT HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run %SYSTEMDRIVE%\SpeedUp1.reg
REG EXPORT HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run %SYSTEMDRIVE%\SpeedUp2.reg
TYPE %SYSTEMDRIVE%\SpeedUp1.reg>>%SYSTEMDRIVE%\SpeedUp.reg
TYPE %SYSTEMROOT%\2.reg>>%SYSTEMDRIVE%\SpeedUp.reg
DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp1.reg
DEL /A /F /Q %SYSTEMDRIVE%\SpeedUp2.reg
IF /I EXIST %SYSTEMDRIVE%\SpeedUp1.reg (MSHTA "VBSCRIPT:MSGBOX("无法删除临时备份文件1！",16,"加速优化-优化无用自启项目时发生错误"^)(WINDOW.CLOSE^)"&SET E=1)
IF /I EXIST %SYSTEMDRIVE%\SpeedUp2.reg (MSHTA "VBSCRIPT:MSGBOX("无法删除临时备份文件2！",16,"加速优化-优化无用自启项目时发生错误"^)(WINDOW.CLOSE^)"&SET E=1)
IF /I NOT EXIST %SYSTEMDRIVE%\SpeedUp.reg (MSHTA "VBSCRIPT:MSGBOX("无法创建备份文件！",16,"加速优化-优化无用自启项目时发生错误"^)(WINDOW.CLOSE^)"&SET E=1)
ATTRIB +A +H +R +S %SYSTEMDRIVE%\SpeedUp.reg
IF %E%==1 (ECHO 备份过程发生错误，备份可能没有成功，是否继续？)
IF %E%==1 (CHOICE /C YN)
IF %E%==1 (IF %ERRORLEVEL%==2 EXIT)
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /VA /F
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /VA /F
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /V ctfmon.exe /D %SYSTEMROOT%\system32\ctfmon.exe
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V command /D ""%SYSTEMDRIVE%\WINDOWS\IME\imjp8_1\IMJPMIG.EXE" /Spoil /RemAdvDef /Migration32"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V hkey /D HKLM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V inimapping /D 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V item /D IMJPMIG
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\IMJPMIG8.1" /V key /D SOFTWARE\Microsoft\Windows\CurrentVersion\Run
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V command /D "%SYSTEMDRIVE%\WINDOWS\system32\IME\TINTLGNT\TINTSETP.EXE /IMEName"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V hkey /D HKLM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V inimapping /D 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V item /D TINTSETP
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002A" /V key /D SOFTWARE\Microsoft\Windows\CurrentVersion\Run
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V command /D ""%SYSTEMDRIVE%\WINDOWS\IME\imjp8_1\IMJPMIG.EXE" /Spoil /RemAdvDef /Migration32"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V hkey /D HKLM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V inimapping /D 0
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V item /D TINTSETP
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Shared Tools\MSConfig\startupreg\PHIME2002ASync" /V key /D SOFTWARE\Microsoft\Windows\CurrentVersion\Run
DEL /A /F /Q "%SYSTEMDRIVE%\Documents and Settings\All Users\「开始」菜单\程序\启动\*"
DEL /A /F /Q "%SYSTEMDRIVE%\Documents and Settings\Default User\「开始」菜单\程序\启动\*"
DEL /A /F /Q "%USERPROFILE%\「开始」菜单\程序\启动\*"
TASKKILL /IM WMIPRVSE.EXE /F /T
TITLE 加速优化-完成
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO 加速优化完成，程序将于%%I秒后自动退出。&SLEEP %%I)
ENDLOCAL
EXIT