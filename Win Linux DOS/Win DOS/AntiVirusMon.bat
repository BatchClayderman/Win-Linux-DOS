@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Win DOS第一代反病毒软件
CLS
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (ECHO 系统文件mshta.exe丢失，无法继续启动，请按任意键退出。&PAUSE>NUL&EXIT)
IF "%1"=="/YES" (ECHO 成功！>"%TEMP%\WinDOSSetup.tmp"&SET X=1&GOTO CHECK)
IF NOT EXIST "%COMSPEC:~0,-7%findstr.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件findstr.exe意外丢失，无法继续启动。",16,"Win DOS第一代反病毒软件"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%reg.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件reg.exe意外丢失，无法继续启动。",16,"Win DOS第一代反病毒软件"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%wbem\wmic.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件wmic.exe意外丢失，无法继续启动。",16,"Win DOS第一代反病毒软件"^)(WINDOW.CLOSE^)&EXIT)
IF /I "%SYSTEMDRIVE%"=="X:" (TITLE Win DOS第一代反病毒软件（PE模式）&CLS&GOTO CHECK)
VER|FIND /I "XP">NUL
SET X=%ERRORLEVEL%
IF %X%==0 (GOTO CHECK)
IF /I EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp")
IF /I EXIST "%TEMP%\WinDOSSetup.tmp" (CLS&ECHO 删除缓存失败！&GOTO 0)
ECHO 正在提权，请稍候...
MSHTA VBSCRIPT:CREATEOBJECT("shell.application").shellexecute("%~S0","/YES","","RUNAS",1)(WINDOW.CLOSE)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SLEEP %%I00)
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp"&EXIT)

:0
ECHO 提权等待超时或已经失败，是否尝试继续在非管理员权限下继续启动？
ECHO 警告：缺乏管理员权限，引擎检测的结果将会出现偏差。
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
TITLE Win DOS第一代反病毒软件（警告：非管理员模式）

:CHECK
DEL /A /F /Q "%~DP0V4.VBS"
CLS
ECHO 正在检查系统受保护状态，请稍候...
SET QH=0
SET RTP=0
SET K=0
SET RS=0
SET KB=0
SET WD=0
SET MP=0
SET HR=0
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET P=0
WMIC PROCESS GET NAME|FIND /I "ZhuDongFangYu.exe">NUL
IF %ERRORLEVEL%==0 (SET P=1&SET QH=1)
WMIC PROCESS GET NAME|FIND /I "QQPCRTP.exe">NUL
IF %ERRORLEVEL%==0 (SET P=1&SET RTP=1)
WMIC PROCESS GET NAME|FIND /I "kxetray.exe">NUL
IF %ERRORLEVEL%==0 (SET P=1&SET K=1)
WMIC PROCESS GET NAME|FIND /I "Rising.exe">NUL
IF %ERRORLEVEL%==0 (SET P=1&SET RS=1)
WMIC PROCESS GET NAME|FINDSTR /I "avp.exe">NUL
IF %ERRORLEVEL%==0 (SET P=1&SET KB=1)
WMIC PROCESS GET NAME|FINDSTR /I "WinDefender.exe">NUL
IF %ERRORLEVEL%==0 (SET /A P=P+2&SET WD=1)
WMIC PROCESS GET NAME|FINDSTR /I "MPSVC.exe">NUL
IF %ERRORLEVEL%==0 (SET /A P=P+2&SET MP=1)
WMIC PROCESS GET NAME|FINDSTR /I "wsctrlsvc.exe">NUL
IF %ERRORLEVEL%==0 (SET /A P=P+2&SET HR=1)
IF EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (SET T=已) ELSE (SET T=未)
SET T=%T%使用本程序对系统体检过。
IF %X%==0 (SET U=不支持&GOTO MAIN) 
FOR /F "TOKENS=3" %%I IN ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V EnableLUA^|FIND /I "REG_DWORD"') DO (IF "%%I"=="0x0" (SET U=关) ELSE (GOTO 01))
GOTO MAIN

:01
FOR /F "TOKENS=3" %%I IN ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V PromptOnSecureDesktop^|FIND /I "REG_DWORD"') DO (IF "%%I"=="0x0" (SET U=低) ELSE (GOTO 02))
GOTO MAIN

:02
FOR /F "TOKENS=3" %%I IN ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V ConsentPromptBehaviorAdmin^|FIND /I "REG_DWORD"') DO (SET U=%%I)
IF "%U%"=="0x5" (SET U=中&GOTO MAIN)
IF "%U%"=="0x2" (SET U=高) ELSE (SET U=未知)

:MAIN
IF %P%==0 (SET A=未开启任何知名防御，系统将面临极大风险)
IF %P%==1 (SET A=有知名杀毒软件保护)
IF %P%==2 (SET A=有主动防御保护)
IF %P%==3 (SET A=有主动防御和知名杀毒软件保护)
IF %P%==4 (SET A=有双重主动防御保护)
IF %P%==5 (SET A=有双重主动防御和知名杀毒软件保护)
IF %X%==0 (FOR /F "TOKENS=3" %%I IN ('VER') DO (TITLE Windows %%I系统防护状态：系统上%A%，当前UAC状态：%U%，%T%)) ELSE (FOR /F "TOKENS=4" %%I IN ('VER') DO (TITLE ^[Windows %%I系统防护状态：系统上%A%，当前UAC状态：%U%，%T%))
CLS
ECHO 第一代反病毒软件主面板
ECHO   0=退出面板
ECHO   1=校验防护
ECHO   2=病毒示例
ECHO   3=加速优化
ECHO   4=手动查杀
ECHO   5=自动扫描
ECHO   6=安全状况
ECHO   7=引擎管理
ECHO   8=开发工具
ECHO   9=清除工具
ECHO 请选择一项以继续：
CHOICE /C 1234567890
CLS
IF %ERRORLEVEL%==1 (GOTO CHECK)
IF %ERRORLEVEL%==3 (START /REALTIME SPEEDUP&START /REALTIME CLEAN&GOTO MAIN)
IF %ERRORLEVEL%==8 (START /REALTIME AntiVirus.bat&GOTO MAIN)
IF %ERRORLEVEL%==10 EXIT
GOTO %ERRORLEVEL%0

:20
ECHO 病毒示例面板
ECHO   0=返回第一代反病毒软件主面板
ECHO   1=宏病毒（进程处理级病毒）
ECHO   2=病毒文件夹泛滥（文件处理级病毒）
ECHO   3=文件加密病毒（系统处理级病毒）
ECHO   4=保留文件泛滥（更为严重的文件处理级病毒）
ECHO   5=按键模拟病毒（鬼一样的病毒）
ECHO 请选择一项以继续：
CHOICE /C 123450
CLS
IF %ERRORLEVEL%==6 (GOTO MAIN)
GOTO 2%ERRORLEVEL%

:21
ECHO 说明：Virus1病毒爆发后，注销即可解决，此病毒不会造成文件数据丢失。
ECHO 是否爆发该病毒？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO 20)
START /REALTIME /MIN Virus1.bat
CLS
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET TT=%%I)
ECHO Virus1病毒样本已爆发，程序将于%TT:~0,1%秒后自动退出。
SLEEP %TT%000
EXIT

:22
ECHO 说明：您可以使用文件粉碎机粉碎病毒缓存，此病毒不会造成数据丢失。
ECHO 是否爆发该病毒？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO 20)
START /REALTIME /MIN Virus2.bat
CLS
ECHO Virus2病毒样本已爆发，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:23
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO 免责声明：该病毒爆发所造成的一切数据流失，本公司概不负责。
ECHO 再次警告：若无备份还原工具，此病毒样本爆发后将难以恢复。
ECHO 运行说明：病毒将破坏所有未收保护的文件，爆发后本程序将会退出，是否继续？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO 20)
CLS
START /REALTIME /MIN Virus3.bat
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET TT=%%I)
ECHO Virus1病毒样本已爆发，程序将于%TT%秒后自动退出。
SLEEP %TT%000
EXIT

:24
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO 说明：您可以使用文件粉碎机粉碎病毒缓存，此病毒不会造成数据丢失。
ECHO 注意：相对于Virus2而言，此病毒缓存更难清除。
ECHO 是否爆发该病毒？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO 20)
START /REALTIME /MIN Virus4.bat
CLS
ECHO Virus4病毒样本已爆发，请按任意键返回主面板。
PAUSE>NUL
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO MAIN

:25
ECHO 请按任意键爆发此病毒，爆发后注销系统即可。
PAUSE>NUL
ECHO Set objShell=CreateObject("Wscript.Shell")>"%~DP0V5.VBS"
ECHO DO>>"%~DP0V5.VBS"
ECHO objShell.SendKeys "{F5}">>"%~DP0V5.VBS"
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO WSCRIPT.SLEEP %%I0 1>>"%~DP0V5.VBS")
ECHO LOOP>>"%~DP0V5.VBS"
IF EXIST "%~DP0V5.VBS" (GOTO 26)
ECHO 爆发失败，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:26
START /I "" "%~DP0V5.VBS"
START /I /MAX "" NOTEPAD.EXE
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SLEEP %%I000)
DEL /A /F /Q "%~DP0V5.VBS"
EXIT

:40
ECHO 体检需要花费较长的时间，是否继续？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
TITLE 正在准备就绪，请稍候...
IF EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO 46)
GOTO 47

:41
CLS
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP|FINDSTR /C:":">NUL
IF %ERRORLEVEL%==0 (GOTO 42) ELSE (GOTO 43)

:42
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') DO (SET TOP=%%I)
SET DESKTOPPATH=%DESK%:%TOP%
GOTO 44

:43
XCOPY "%COMSPEC:~0,-7%AntiVirus.txt" "%SYSTEMDRIVE%\" /A /H /R /V
ATTRIB +A -H +R -S "%SYSTEMDRIVE%\AntiVirus.txt"
IF /I NOT EXIST "%SYSTEMDRIVE%\AntiVirus.txt" (GOTO 45)
ECHO 无法获取系统的桌面路径，已将文件保存到了系统盘的根目录下。
ECHO 建议您检查系统，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:44
XCOPY "%COMSPEC:~0,-7%AntiVirus.txt" "%DESKTOPPATH%\" /A /H /R /V
ATTRIB +A -H +R -S "%DESKTOPPATH%\AntiVirus.txt"
IF /I NOT EXIST "%DESKTOPPATH%\AntiVirus.txt" (GOTO 45)
MSHTA VBSCRIPT:MSGBOX("导出成功！点击“确定”返回主面板",64,"Win DOS第一代反病毒软件")(WINDOW.CLOSE)
GOTO MAIN

:45
MSHTA VBSCRIPT:MSGBOX("导出失败！",16,"Win DOS第一代反病毒软件")(WINDOW.CLOSE)
ECHO 是否重试？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO 41) ELSE (GOTO MAIN)

:46
ECHO 原体检文件已存在，是否覆盖？
ECHO 0=取消体检 1=将文件移动至%SYSTEMDRIVE%\再继续（注意文件是系统隐藏的）
ECHO 2=直接覆盖 3=定位到文件（可能需要先手动显示系统隐藏的文件）
CHOICE /C 1230
IF %ERRORLEVEL%==1 (GOTO 48)
IF %ERRORLEVEL%==2 (GOTO 49)
IF %ERRORLEVEL%==3 (EXPLORER,/E,/SELECT,"%COMSPEC:~0,-7%AntiVirus.txt")
GOTO MAIN

:47
CLS
ECHO Win DOS第一代反病毒软件手动查杀体检报告>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("无法创建体检报告文件，点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO CHECK)
ATTRIB +A +H +S -R "%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS第一代反病毒软件手动查杀-正在获取系统时间
FOR /F "TOKENS=*" %%I IN ('VER') DO (ECHO 当前系统环境：%%I>>"%COMSPEC:~0,-7%AntiVirus.txt")
IF %X%==0 (FOR /F "TOKENS=3" %%I IN ('VER') DO (TITLE Windows %%I系统防护状态：系统上%A%，当前UAC状态：%U%，%T%)) ELSE (FOR /F "TOKENS=4" %%I IN ('VER') DO (TITLE ^[Windows %%I系统防护状态：系统上%A%，当前UAC状态：%U%，%T%))>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO 体检开始系统时间：%DATE%%TIME%>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS第一代反病毒软件手动查杀-正在生成进程信息
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO 当前常规进程信息：>>"%COMSPEC:~0,-7%AntiVirus.txt"
TASKLIST>>"%COMSPEC:~0,-7%AntiVirus.txt"
TASKLIST /SVC>>"%COMSPEC:~0,-7%AntiVirus.txt"
TASKLIST /M>>"%COMSPEC:~0,-7%AntiVirus.txt"
TASKLIST /V>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("无法生成体检报告，当前进度：进程信息。点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS第一代反病毒软件手动查杀-正在生成文件信息
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO 当前文件信息：>>"%COMSPEC:~0,-7%AntiVirus.txt"
For /F "Skip=1" %%I IN ('WMIC LOGICALDISK GET NAME') DO (DIR /A /C /Q /S %%I&ATTRIB %%I\* /D /S)>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("无法生成体检报告，当前进度：文件信息。点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS第一代反病毒软件手动查杀-正在生成目录信息
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO 当前目录信息：>>"%COMSPEC:~0,-7%AntiVirus.txt"
For /F "Skip=1" %%I IN ('WMIC LOGICALDISK GET NAME') DO (TREE %%I\ /F)>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("无法生成体检报告，当前进度：目录信息。点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS第一代反病毒软件手动查杀-正在生成服务信息
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO 服务信息：>>"%COMSPEC:~0,-7%AntiVirus.txt"
SC query state= all>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("无法生成体检报告，当前进度：服务信息。点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS第一代反病毒软件手动查杀-正在生成注册表内容
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO 注册表内容：>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKCR /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKCU /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKLM /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKU /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKCC /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS第一代反病毒软件手动查杀-正在写入系统变量
ECHO 系统变量：>>"%COMSPEC:~0,-7%AntiVirus.txt"
SET>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("无法生成体检报告，当前进度：环境变量。点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS第一代反病毒软件手动查杀-正在生成系统信息
ECHO 系统信息：>>"%COMSPEC:~0,-7%AntiVirus.txt"
SYSTEMINFO>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS第一代反病毒软件手动查杀-正在生成网络信息
ECHO 网络信息：>>"%COMSPEC:~0,-7%AntiVirus.txt"
IPCONFIG>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS第一代反病毒软件手动查杀-正在生成设备信息
ECHO 设备信息：>>"%COMSPEC:~0,-7%AntiVirus.txt"
MODE>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS第一代反病毒软件手动查杀-正在获取系统时间
ECHO 体检结束系统时间：%DATE%%TIME%>>"%COMSPEC:~0,-7%AntiVirus.txt"
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("无法生成体检报告，当前进度：系统信息。点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS第一代反病毒软件手动查杀-体检报告生成完毕
START /REALTIME NOTEPAD "%COMSPEC:~0,-7%AntiVirus.txt"
ECHO 是否需要导出体检报告到桌面？
CHOICE /C YN
IF %ERRORLEVEL%==1 (CLS&GOTO 41)
GOTO MAIN

:48
XCOPY "%COMSPEC:~0,-7%AntiVirus.txt" %SYSTEMDRIVE%\ /H /R /V /Y
IF NOT EXIST %SYSTEMDRIVE%\AntiVirus.txt (MSHTA VBSCRIPT:MSGBOX("无法移出原体检报告，点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^)&GOTO MAIN)

:49
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G SYSTEM:F
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G ADMINISTRATORS:F
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G %USERNAME%:F
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G USERS:F
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G EVERYONE:F
DEL /A /F /Q "%COMSPEC:~0,-7%AntiVirus.txt"
IF EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("无法删除原体检报告，点击“确定”返回反病毒主界面。",16,"第一代反病毒软件"^)(WINDOW.CLOSE^)&GOTO MAIN)
GOTO 47

:50
ECHO 请选择扫描方式：
ECHO   1=快速扫描
ECHO   2=全盘扫描
ECHO   0=返回主面板
CHOICE /C 120
GOTO 5%ERRORLEVEL%

:51
TITLE 正在快速扫描，请稍候...
FOR /R %SYSTEMROOT%\ %%I IN (*) DO (@ECHO 正在扫描系统关键文件："%%I"。)
TITLE 快速扫描-扫描完毕
CLS
ECHO 快速扫描完毕，请按任意键返回主面板。
GOTO 53

:52
MSHTA VBSCRIPT:MSGBOX("即将开始全盘查杀，保存好所有数据后，点击“确定”。",64,"第一代反病毒软件")(WINDOW.CLOSE)
TITLE 正在全盘扫描，请稍候...
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
FOR /F "SKIP=1" %%A IN ('WMIC LOGICALDISK GET CAPTION') DO (CLS&ECHO 正在准备扫描%%A\*，请稍候...&FOR /F "DELIMS=" %%I IN ('DIR /A /B /S %%A') DO (ECHO 正在扫描："%%I"))
ENDLOCAL
TITLE 全盘扫描-扫描完毕
CLS
ECHO 全盘扫描完毕，请按任意键返回主面板。

:53
PAUSE>NUL
CLS
GOTO MAIN

:60
IF %X%==0 (FOR /F "TOKENS=3" %%I IN ('VER') DO (ECHO Windows %%I系统防护状态：系统上%A%，当前UAC状态：%U%，%T%)) ELSE (FOR /F "TOKENS=4" %%I IN ('VER') DO (ECHO ^[Windows %%I系统防护状态：系统上%A%，当前UAC状态：%U%，%T%))
ECHO 请任意键返回主面板。
ECHO.
PAUSE>NUL
GOTO MAIN

:70
IF %P%==0 (GOTO 72)
ECHO 是否需要探测活跃中的引擎？
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO 71)
CLS
ECHO 系统UAC状态：%U%，%T%
ECHO 系统运行中的反病毒引擎有：
ECHO   Win DOS第一代反病毒查杀引擎
IF %QH%==1 (ECHO   360杀毒软件相关引擎)
IF %RTP%==1 (ECHO   腾讯电脑管家相关引擎)
IF %K%==1 (ECHO   金山毒霸30核云引擎)
IF %RS%==1 (ECHO   瑞星杀毒软件相关引擎)
IF %KB%==1 (ECHO   卡巴斯基相关引擎)
IF %WD%==1 (ECHO    Windows Defender)
IF %MP%==1 (ECHO   微点主动防御引擎)
IF %HR%==1 (ECHO   火绒安全引擎)
ECHO 请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:71
ECHO 正在测试，请稍候...
TASKKILL /IM 360* /IM QQPC* /IM KXETRAY.EXE /IM RISING.EXE /IM MP* /F /T>NUL
TSKILL KXETRAY>NUL
CLS
ECHO 系统UAC状态：%U%，%T%
ECHO 系统已安装的反病毒引擎有：
ECHO   Win DOS第一代反病毒查杀引擎
IF %QH%==1 (ECHO   360杀毒软件相关引擎)
IF %RTP%==1 (ECHO   腾讯电脑管家相关引擎)
IF %K%==1 (ECHO   金山毒霸30核云引擎)
IF %RS%==1 (ECHO   瑞星杀毒软件相关引擎)
IF %KB%==1 (ECHO   卡巴斯基相关引擎)
IF %WD%==1 (ECHO    Windows Defender)
IF %MP%==1 (ECHO   微点主动防御引擎)
IF %HR%==1 (ECHO   火绒安全引擎)
ECHO.
ECHO 其中有如下引擎处于活跃状态：
WMIC PROCESS GET NAME|FIND /I "ZhuDongFangYu.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   360杀毒软件相关引擎)
WMIC PROCESS GET NAME|FIND /I "QQPCRTP.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   腾讯电脑管家相关引擎)
WMIC PROCESS GET NAME|FIND /I "kxetray.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   金山毒霸30核云引擎)
WMIC PROCESS GET NAME|FIND /I "Rising.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   瑞星杀毒软件相关引擎)
WMIC PROCESS GET NAME|FIND /I "avp.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   卡巴斯基相关引擎)
WMIC PROCESS GET NAME|FIND /I "WinDefender.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   Windows Defender)
WMIC PROCESS GET NAME|FIND /I "MPSVC2.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   微点主动防御引擎)
WMIC PROCESS GET NAME|FIND /I "wsctrlsvc.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   火绒安全引擎)
ECHO 请按任意键返回主面板并重新检查系统的受保护状态。
PAUSE>NUL
GOTO CHECK

:72
ECHO 系统UAC状态：%U%，%T%
ECHO 系统运行中的反病毒引擎有且仅有Win DOS第一代反病毒查杀引擎。
ECHO 警告：您的系统中，没有活跃的反病毒引擎，查杀力度将会被大大削弱。
ECHO 请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:90
ECHO 病毒清除工具面板
ECHO   0=返回主面板
ECHO   1=查杀sxs.exe
ECHO   2=清除从本程序爆发的病毒
IF %X%==0 (ECHO   3=Windows XP专用端口封杀工具)
ECHO 请选择一项以继续：
IF %X%==0 (CHOICE /C 1203) ELSE (CHOICE /C 120)
IF %ERRORLEVEL%==3 (GOTO MAIN)
CLS
GOTO 9%ERRORLEVEL%

:91
ECHO 正在查杀sxs.exe，请稍候...
TASKKILL /IM sxs.exe /IM SVOHOST.exe /F /T
FOR /F %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (
	CACLS %%I\sxs.exe /E /G SYSTEM:F
	CACLS %%I\sxs.exe /E /G ADMINISTRATORS:F
	CACLS %%I\sxs.exe /E /G %USERNAME%:F
	CACLS %%I\sxs.exe /E /G USERS:F
	CACLS %%I\sxs.exe /E /G EVERYONE:F
	DEL /A /F /Q /S %%I\sxs.exe
	CACLS %%I\autorun.inf /E /G SYSTEM:F
	CACLS %%I\autorun.inf /E /G ADMINISTRATORS:F
	CACLS %%I\autorun.inf /E /G %USERNAME%:F
	CACLS %%I\autorun.inf /E /G USERS:F
	CACLS %%I\autorun.inf /E /G EVERYONE:F
	DEL /A /F /Q /S %%I\autorun.inf
	IF /I EXIST %%I\sxs.exe (GOTO 93)
	IF /I EXIST %%I\autorun.inf (GOTO 93)
)
REG DELETE HKLM\Software\Microsoft\windows\CurrentVersion\explorer\Advanced\Folder\Hidden\SHOWALL /V CheckedValue /F
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL /V "CheckedValue" /T "REG_DWORD" /D 1 /F
REG DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /V sxs.exe /F
REG DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /V SVOHOST.exe /F
CLS
ECHO sxs.exe查杀成功结束，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:92
TITLE 请忽略屏幕上的错误提示。正在执行清除，请稍候...
FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (
	CACLS %%I\Vir*.* /E /G SYSTEM:F
	CACLS %%I\Vir*.* /E /G ADMINISTRATORS:F
	CACLS %%I\Vir*.* /E /G %USERNAME%:F
	CACLS %%I\Vir*.* /E /G USERS:F
	CACLS %%I\Vir*.* /E /G EVERYONE:F
	DEL /A /F /Q %%I\Vir*.*
	IF /I EXIST %%I\Vir1.bat (GOTO 93)
	IF /I EXIST %%I\Vir1.vbs (GOTO 93)
	IF /I EXIST %%I\Vir2.bat (GOTO 93)
	IF /I EXIST %%I\Vir2.vbs (GOTO 93)
	IF /I EXIST %%I\Vir3.bat (GOTO 93)
	IF /I EXIST %%I\Vir3.vbs (GOTO 93)
	IF /I EXIST %%I\Vir4.bat (GOTO 93)
	IF /I EXIST %%I\Vir4.bat (GOTO 93)
	CLS
)
FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (RD /S /Q \\?\%%I\COM4..\ \\?\%%I\COM4)
CLS
ECHO 是否进行Virus2专项清除？可能需要花费一段时间。
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO 95)
GOTO 96

:93
CLS
ECHO 错误：无法清除病毒文件，请重启进入安全模式后重新运行查杀。
ECHO 如果您在安全模式下看到此错误，建议您启动360系统急救箱进行查杀。
PAUSE
GOTO MAIN

:94
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE 一键封杀木马端口
GPUPDATE>NUL
IPSECCMD -w REG -p "HFUT_SECU" -o -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-80" -f *+0:80:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-1434" -f *+0:1434:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-137" -f *+0:137:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-138" -f *+0:138:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-139" -f *+0:139:TCP -n BLOCK -x>NUL 
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-135" -f *+0:135:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-135" -f *+0:135:UDP -n BLOCK -x>NUL
ECHO 禁止Location Service服务和防止 Dos 攻击…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-445" -f *+0:445:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-445" -f *+0:445:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1025" -f *+0:1025:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-139" -f *+0:139:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1068" -f *+0:1068:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5554" -f *+0:5554:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9995" -f *+0:9995:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9996" -f *+0:9996:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6129" -f *+0:6129:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block ICMP-255" -f *+0:255:ICMP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-43958" -f *+0:43958:TCP -n BLOCK -x>NUL
ECHO 关闭流行危险端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20034" -f *+0:20034:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetBus Pro开放的端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1092" -f *+0:1092:TCP -n BLOCK -x>NUL
ECHO 关闭蠕虫LoveGate开放的端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3996" -f *+0:3996:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4060" -f *+0:4060:TCP -n BLOCK -x>NUL
ECHO 关闭木马RemoteAnything开放的端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4590" -f *+0:4590:TCP -n BLOCK -x>NUL
ECHO 关闭木马ICQTrojan开放的端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1080" -f *+0:1080:TCP -n BLOCK -x>NUL
ECHO 禁止代理服务器扫描…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-113" -f *+0:113:TCP -n BLOCK -x>NUL
ECHO 禁止Authentication Service服务…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-79" -f *+0:79:TCP -n BLOCK -x>NUL
ECHO 禁止Finger扫描…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-53" -f *+0:53:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53" -f *+0:53:TCP -n BLOCK -x>NUL
ECHO 禁止区域传递（TCP），欺骗DNS（UDP）或隐藏其他的通信…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-707" -f *+0:707:TCP -n BLOCK -x>NUL
ECHO 关闭nachi蠕虫病毒监听端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-808" -f *+0:808:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23" -f *+0:23:TCP -n BLOCK -x>NUL
ECHO 关闭Telnet 和木马Tiny Telnet Server监听端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-520" -f *+0:520:TCP -n BLOCK -x>NUL
ECHO 关闭Rip 端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO 关闭木马程序BackDoor的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO 关闭马程序黑洞2001的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO 关闭木马程序Ripper的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO 关闭木马程序Wincrash v2的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3389" -f *+0:3389:TCP -n BLOCK -x>NUL
ECHO 关闭Windows 的远程管理终端（远程桌面）监听端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4444" -f *+0:4444:TCP -n BLOCK -x>NUL
ECHO 关闭msblast冲击波蠕虫监听端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4899" -f *+0:4899:TCP -n BLOCK -x>NUL
ECHO 关闭远程控制软件（remote administrator)服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5800" -f *+0:5800:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5900" -f *+0:5900:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8888" -f *+0:8888:TCP -n BLOCK -x>NUL
ECHO 关闭远程控制软件VNC的两个默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6129" -f *+0:6129:TCP -n BLOCK -x>NUL
ECHO 关闭Dameware服务端默认监听端口（可变！）…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6267" -f *+0:6267:TCP -n BLOCK -x>NUL
ECHO 关闭木马广外女生的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-660" -f *+0:660:TCP -n BLOCK -x>NUL
ECHO 关闭木马DeepThroat v1.0 - 3.1默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6671" -f *+0:6671:TCP -n BLOCK -x>NUL
ECHO 关闭木马Indoctrination默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6939" -f *+0:6939:TCP -n BLOCK -x>NUL
ECHO 关闭木马PRIORITY默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络精灵默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7511" -f *+0:7511:TCP -n BLOCK -x>NUL
ECHO 关闭木马聪明基因的默认连接端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7626" -f *+0:7626:TCP -n BLOCK -x>NUL
ECHO 关闭木马冰河默认端口(注意可变！)…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8011" -f *+0:8011:TCP -n BLOCK -x>NUL
ECHO 关闭木马WAY2.4默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9989" -f *+0:9989:TCP -n BLOCK -x>NUL
ECHO 关闭木马InIkiller默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-19191" -f *+0:19191:TCP -n BLOCK -x>NUL
ECHO 关闭木马兰色火焰默认开放的telnet端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1029" -f *+0:1029:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20168" -f *+0:20168:TCP -n BLOCK -x>NUL
ECHO 关闭lovegate 蠕虫所开放的两个后门端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23444" -f *+0:23444:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络公牛默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-27374" -f *+0:27374:TCP -n BLOCK -x>NUL
ECHO 关闭木马SUB7默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100" -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetSphere默认的服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31337" -f *+0:31337:TCP -n BLOCK -x>NUL
ECHO 关闭木马BO2000默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-45576" -f *+0:45576:TCP -n BLOCK -x>NUL
ECHO 关闭代理软件的控制端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO 关闭木马Schwindler默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO 关闭木马Telecommando默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31338" -f *+0:31338:TCP -n BLOCK -x>NUL
ECHO 关闭木马Back Orifice默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8102" -f *+0:8102:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络神偷默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2000" -f *+0:2000:TCP -n BLOCK -x>NUL
ECHO 关闭木马黑洞2000默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31339" -f *+0:31339:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetSpy DK默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO 关闭木马黑洞2001默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31666" -f *+0:31666:TCP -n BLOCK -x>NUL
ECHO 关闭木马BOWhack默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-34324" -f *+0:34324:TCP -n BLOCK -x>NUL
ECHO 关闭木马BigGluck默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络精灵3.0，netspy3.0默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40412" -f *+0:40412:TCP -n BLOCK -x>NUL
ECHO 关闭木马The Spy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40421" -f *+0:40421:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8011" -f *+0:8011:TCP -n BLOCK -x>NUL
ECHO 关闭木马wry，赖小子，火凤凰默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40422" -f *+0:40422:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23444" -f *+0:23444:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络公牛，netbull默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40423" -f *+0:40423:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise 2.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23445" -f *+0:23445:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络公牛，netbull默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40426" -f *+0:40426:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise 3.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50505" -f *+0:50505:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sockets de Troie默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-27374" -f *+0:27374:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sub Seven 2.0+，77，东方魔眼默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO 关闭木马Fore默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53001" -f *+0:53001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Remote Windows Shutdown默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO 关闭木马Telecommando默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-121" -f *+0:121:TCP -n BLOCK -x>NUL
ECHO 关闭木马BO jammerkillahV默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO 关闭木马Satanz Backdoor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-65000" -f *+0:65000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Devil默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Silencer默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6400" -f *+0:6400:TCP -n BLOCK -x>NUL
ECHO 关闭木马The tHing默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1600" -f *+0:1600:TCP -n BLOCK -x>NUL
ECHO 关闭木马Shivka-Burka默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12346" -f *+0:12346:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetBus 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1807" -f *+0:1807:TCP -n BLOCK -x>NUL
ECHO 关闭木马SpySender默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20034" -f *+0:20034:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetBus Pro默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1981" -f *+0:1981:TCP -n BLOCK -x>NUL
ECHO 关闭木马Shockrave默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1243" -f *+0:1243:TCP -n BLOCK -x>NUL
ECHO 关闭木马SubSeven默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO 关闭木马WebEx默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100" -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetSphere默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1011" -f *+0:1011:TCP -n BLOCK -x>NUL
ECHO 关闭木马Doly Trojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Silencer默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1170" -f *+0:1170:TCP -n BLOCK -x>NUL
ECHO 关闭木马Psyber Stream Server默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20000" -f *+0:20000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Millenium默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1234" -f *+0:1234:TCP -n BLOCK -x>NUL
ECHO 关闭木马Ultors Trojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-65000" -f *+0:65000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Devil 1.03默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO 关闭木马VooDoo Doll默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1492" -f *+0:1492:TCP -n BLOCK -x>NUL
ECHO 关闭木马FTP99CMP默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1170" -f *+0:1170:TCP -n BLOCK -x>NUL
ECHO 关闭木马Streaming Audio Trojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO 关闭木马BackDoor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30303" -f *+0:30303:TCP -n BLOCK -x>NUL
ECHO 关闭木马Socket23默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Trojan Cow默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO 关闭木马Gatecrasher默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO 关闭木马Ripper默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO 关闭木马Telecommando默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2115" -f *+0:2115:TCP -n BLOCK -x>NUL
ECHO 关闭木马Bugs默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12076" -f *+0:12076:TCP -n BLOCK -x>NUL
ECHO 关闭木马Gjamer默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2140" -f *+0:2140:TCP -n BLOCK -x>NUL
ECHO 关闭木马Deep Throat默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4950" -f *+0:4950:TCP -n BLOCK -x>NUL
ECHO 关闭木马IcqTrojen默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2140" -f *+0:2140:TCP -n BLOCK -x>NUL
ECHO 关闭木马The Invasor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-16969" -f *+0:16969:TCP -n BLOCK -x>NUL
ECHO 关闭木马Priotrity默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2801" -f *+0:2801:TCP -n BLOCK -x>NUL
ECHO 关闭木马Phineas Phucker默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO 关闭木马Vodoo默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30129" -f *+0:30129:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5742" -f *+0:5742:TCP -n BLOCK -x>NUL
ECHO 关闭木马Wincrash默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3700" -f *+0:3700:TCP -n BLOCK -x>NUL
ECHO 关闭木马Portal of Doom默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO 关闭木马Wincrash2默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4092" -f *+0:4092:TCP -n BLOCK -x>NUL
ECHO 关闭木马WinCrash默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1033" -f *+0:1033:TCP -n BLOCK -x>NUL
ECHO 关闭木马Netspy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4590" -f *+0:4590:TCP -n BLOCK -x>NUL
ECHO 关闭木马ICQTrojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1981" -f *+0:1981:TCP -n BLOCK -x>NUL
ECHO 关闭木马ShockRave默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5000" -f *+0:5000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sockets de Troie默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO 关闭木马Stealth Spy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5001" -f *+0:5001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sockets de Troie 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO 关闭木马Pass Ripper默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5321" -f *+0:5321:TCP -n BLOCK -x>NUL
ECHO 关闭木马Firehotcker默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO 关闭木马Attack FTP默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5400" -f *+0:5400:TCP -n BLOCK -x>NUL
ECHO 关闭木马Blade Runner默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-21554" -f *+0:21554:TCP -n BLOCK -x>NUL
ECHO 关闭木马GirlFriend默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5401" -f *+0:5401:TCP -n BLOCK -x>NUL
ECHO 关闭木马Blade Runner 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO 关闭木马Fore Schwindler默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5402" -f *+0:5402:TCP -n BLOCK -x>NUL
ECHO 关闭木马Blade Runner 2.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-34324" -f *+0:34324:TCP -n BLOCK -x>NUL
ECHO 关闭木马Tiny Telnet Server默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5569" -f *+0:5569:TCP -n BLOCK -x>NUL
ECHO 关闭木马Robo-Hack默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30999" -f *+0:30999:TCP -n BLOCK -x>NUL
ECHO 关闭木马Kuang默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6670" -f *+0:6670:TCP -n BLOCK -x>NUL
ECHO 关闭木马DeepThroat默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11000" -f *+0:11000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Senna Spy Trojans默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6771" -f *+0:6771:TCP -n BLOCK -x>NUL
ECHO 关闭木马DeepThroat默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23456" -f *+0:23456:TCP -n BLOCK -x>NUL
ECHO 关闭木马WhackJob默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO 关闭木马GateCrasher默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO 关闭木马Phase0默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO 关闭木马Priority默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5400" -f *+0:5400:TCP -n BLOCK -x>NUL
ECHO 关闭木马Blade Runner默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7000" -f *+0:7000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Remote Grab默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4950" -f *+0:4950:TCP -n BLOCK -x>NUL
ECHO 关闭木马IcqTrojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7300" -f *+0:7300:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9989" -f *+0:9989:TCP -n BLOCK -x>NUL
ECHO 关闭木马InIkiller默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7301" -f *+0:7301:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO 关闭木马Portal Of Doom默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor 2.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11223" -f *+0:11223:TCP -n BLOCK -x>NUL
ECHO 关闭木马Progenic Trojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7307" -f *+0:7307:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor 3.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-22222" -f *+0:22222:TCP -n BLOCK -x>NUL
ECHO 关闭木马Prosiak 0.47默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7308" -f *+0:7308:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor 4.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53001" -f *+0:53001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Remote Windows Shutdown默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7789" -f *+0:7789:TCP -n BLOCK -x>NUL
ECHO 关闭木马ICKiller默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5569" -f *+0:5569:TCP -n BLOCK -x>NUL
ECHO 关闭木马RoboHack默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO 关闭木马Portal of Doom默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -x>NUL
GPUPDATE>NUL
ECHO 正在设置 IP 筛选器……
IF /I EXIST "%TEMP%\IPFILTER.REG" (DEL /A /F /Q "%TEMP%\IPFILTER.REG")
ECHO Windows Registry Editor Version 5.00>"%TEMP%\IPFILTER.REG"
ECHO.>>"%TEMP%\IPFILTER.REG"
ECHO [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters]>>"%TEMP%\IPFILTER.REG"
ECHO "EnableSecurityFilters"=dword:00000001>>"%TEMP%\IPFILTER.REG"
ECHO.>>"%TEMP%\IPFILTER.REG">>"%TEMP%\IPFILTER.REG"
ECHO [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters\Interfaces\{F3BBAABC-03A5-4584-A7A0-0251FA38B8B1}]>>"%TEMP%\IPFILTER.REG"
ECHO "TCPAllowedPorts"=hex(07):32,00,31,00,00,00,38,00,30,00,00,00,34,00,30,00,30,\>>"%TEMP%\IPFILTER.REG"
ECHO   00,30,00,00,00,00,00>>"%TEMP%\IPFILTER.REG"
ECHO.>>"%TEMP%\IPFILTER.REG"
ECHO [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]>>"%TEMP%\IPFILTER.REG"
ECHO "EnableSecurityFilters"=dword:00000001>>"%TEMP%\IPFILTER.REG"
ECHO.>>"%TEMP%\IPFILTER.REG"
ECHO [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{F3BBAABC-03A5-4584-A7A0-0251FA38B8B1}]>>"%TEMP%\IPFILTER.REG"
ECHO "TCPAllowedPorts"=hex(07):32,00,31,00,00,00,38,00,30,00,00,00,34,00,30,00,30,\>>"%TEMP%\IPFILTER.REG"
ECHO   00,30,00,00,00,00,00>>"%TEMP%\IPFILTER.REG"
ECHO.>>"%TEMP%\IPFILTER.REG"
regedit -s "%TEMP%\IPFILTER.REG"
DEL "%TEMP%\IPFILTER.REG"
ECHO IP 筛选器设置成功！
ECHO 标准封杀执行完毕，是否进行强力封杀？
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET TT=%%I)
ECHO %TT:~0,1%秒无动作后自动执行强力封杀。
CHOICE /C YN /T %TT% /D Y
IF %ERRORLEVEL%==2 (GOTO MAIN)
IPSECCMD -w REG -p "HFUT_SECU" -o -x
IPSECCMD -w REG -p "HFUT_SECU" -x
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-80" -f *+0:80:TCP -n BLOCK -x
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-1434" -f *+0:1434:UDP -n BLOCK -x
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3389" -f *+0:3389:TCP -n BLOCK -x
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-445" -f *+0:445:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-445" -f *+0:445:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1025" -f *+0:1025:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-139" -f *+0:139:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1068" -f *+0:1068:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5554" -f *+0:5554:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9995" -f *+0:9995:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9996" -f *+0:9996:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6129" -f *+0:6129:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block ICMP-255" -f *+0:255:ICMP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-43958" -f *+0:43958:TCP -n BLOCK -x>NUL
ECHO 关闭流行危险端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20034" -f *+0:20034:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetBus Pro开放的端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1092" -f *+0:1092:TCP -n BLOCK -x>NUL
ECHO 关闭蠕虫LoveGate开放的端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3996" -f *+0:3996:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4060" -f *+0:4060:TCP -n BLOCK -x>NUL
ECHO 关闭木马RemoteAnything开放的端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4590" -f *+0:4590:TCP -n BLOCK -x>NUL
ECHO 关闭木马ICQTrojan开放的端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1080" -f *+0:1080:TCP -n BLOCK -x>NUL
ECHO 禁止代理服务器扫描…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-113" -f *+0:113:TCP -n BLOCK -x>NUL
ECHO 禁止Authentication Service服务…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-79" -f *+0:79:TCP -n BLOCK -x>NUL
ECHO 禁止Finger扫描…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-53" -f *+0:53:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53" -f *+0:53:TCP -n BLOCK -x>NUL
ECHO 禁止区域传递（TCP），欺骗DNS（UDP）或隐藏其他的通信…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-707" -f *+0:707:TCP -n BLOCK -x>NUL
ECHO 关闭nachi蠕虫病毒监听端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-808" -f *+0:808:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23" -f *+0:23:TCP -n BLOCK -x>NUL
ECHO 关闭Telnet 和木马Tiny Telnet Server监听端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-520" -f *+0:520:TCP -n BLOCK -x>NUL
ECHO 关闭Rip 端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO 关闭木马程序BackDoor的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO 关闭马程序黑洞2001的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO 关闭木马程序Ripper的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO 关闭木马程序Wincrash v2的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3389" -f *+0:3389:TCP -n BLOCK -x>NUL
ECHO 关闭Windows 的远程管理终端（远程桌面）监听端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4444" -f *+0:4444:TCP -n BLOCK -x>NUL
ECHO 关闭msblast冲击波蠕虫监听端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4899" -f *+0:4899:TCP -n BLOCK -x>NUL
ECHO 关闭远程控制软件（remote administrator)服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5800" -f *+0:5800:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5900" -f *+0:5900:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8888" -f *+0:8888:TCP -n BLOCK -x>NUL
ECHO 关闭远程控制软件VNC的两个默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6129" -f *+0:6129:TCP -n BLOCK -x>NUL
ECHO 关闭Dameware服务端默认监听端口（可变！）…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6267" -f *+0:6267:TCP -n BLOCK -x>NUL
ECHO 关闭木马广外女生的默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-660" -f *+0:660:TCP -n BLOCK -x>NUL
ECHO 关闭木马DeepThroat v1.0 - 3.1默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6671" -f *+0:6671:TCP -n BLOCK -x>NUL
ECHO 关闭木马Indoctrination默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6939" -f *+0:6939:TCP -n BLOCK -x>NUL
ECHO 关闭木马PRIORITY默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络精灵默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7511" -f *+0:7511:TCP -n BLOCK -x>NUL
ECHO 关闭木马聪明基因的默认连接端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7626" -f *+0:7626:TCP -n BLOCK -x>NUL
ECHO 关闭木马冰河默认端口(注意可变！)…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8011" -f *+0:8011:TCP -n BLOCK -x>NUL
ECHO 关闭木马WAY2.4默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9989" -f *+0:9989:TCP -n BLOCK -x>NUL
ECHO 关闭木马InIkiller默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-19191" -f *+0:19191:TCP -n BLOCK -x>NUL
ECHO 关闭木马兰色火焰默认开放的telnet端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1029" -f *+0:1029:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20168" -f *+0:20168:TCP -n BLOCK -x>NUL
ECHO 关闭lovegate 蠕虫所开放的两个后门端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23444" -f *+0:23444:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络公牛默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-27374" -f *+0:27374:TCP -n BLOCK -x>NUL
ECHO 关闭木马SUB7默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100" -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetSphere默认的服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31337" -f *+0:31337:TCP -n BLOCK -x>NUL
ECHO 关闭木马BO2000默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-45576" -f *+0:45576:TCP -n BLOCK -x>NUL
ECHO 关闭代理软件的控制端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO 关闭木马Schwindler默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO 关闭木马Telecommando默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31338" -f *+0:31338:TCP -n BLOCK -x>NUL
ECHO 关闭木马Back Orifice默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8102" -f *+0:8102:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络神偷默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2000" -f *+0:2000:TCP -n BLOCK -x>NUL
ECHO 关闭木马黑洞2000默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31339" -f *+0:31339:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetSpy DK默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO 关闭木马黑洞2001默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31666" -f *+0:31666:TCP -n BLOCK -x>NUL
ECHO 关闭木马BOWhack默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-34324" -f *+0:34324:TCP -n BLOCK -x>NUL
ECHO 关闭木马BigGluck默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络精灵3.0，netspy3.0默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40412" -f *+0:40412:TCP -n BLOCK -x>NUL
ECHO 关闭木马The Spy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40421" -f *+0:40421:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8011" -f *+0:8011:TCP -n BLOCK -x>NUL
ECHO 关闭木马wry，赖小子，火凤凰默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40422" -f *+0:40422:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23444" -f *+0:23444:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络公牛，netbull默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40423" -f *+0:40423:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise 2.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23445" -f *+0:23445:TCP -n BLOCK -x>NUL
ECHO 关闭木马网络公牛，netbull默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40426" -f *+0:40426:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise 3.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50505" -f *+0:50505:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sockets de Troie默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-27374" -f *+0:27374:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sub Seven 2.0+，77，东方魔眼默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO 关闭木马Fore默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53001" -f *+0:53001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Remote Windows Shutdown默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO 关闭木马Telecommando默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-121" -f *+0:121:TCP -n BLOCK -x>NUL
ECHO 关闭木马BO jammerkillahV默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO 关闭木马Satanz Backdoor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-65000" -f *+0:65000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Devil默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Silencer默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6400" -f *+0:6400:TCP -n BLOCK -x>NUL
ECHO 关闭木马The tHing默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1600" -f *+0:1600:TCP -n BLOCK -x>NUL
ECHO 关闭木马Shivka-Burka默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12346" -f *+0:12346:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetBus 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1807" -f *+0:1807:TCP -n BLOCK -x>NUL
ECHO 关闭木马SpySender默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20034" -f *+0:20034:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetBus Pro默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1981" -f *+0:1981:TCP -n BLOCK -x>NUL
ECHO 关闭木马Shockrave默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1243" -f *+0:1243:TCP -n BLOCK -x>NUL
ECHO 关闭木马SubSeven默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO 关闭木马WebEx默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100" -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetSphere默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1011" -f *+0:1011:TCP -n BLOCK -x>NUL
ECHO 关闭木马Doly Trojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Silencer默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1170" -f *+0:1170:TCP -n BLOCK -x>NUL
ECHO 关闭木马Psyber Stream Server默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20000" -f *+0:20000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Millenium默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1234" -f *+0:1234:TCP -n BLOCK -x>NUL
ECHO 关闭木马Ultors Trojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-65000" -f *+0:65000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Devil 1.03默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO 关闭木马VooDoo Doll默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1492" -f *+0:1492:TCP -n BLOCK -x>NUL
ECHO 关闭木马FTP99CMP默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1170" -f *+0:1170:TCP -n BLOCK -x>NUL
ECHO 关闭木马Streaming Audio Trojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO 关闭木马BackDoor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30303" -f *+0:30303:TCP -n BLOCK -x>NUL
ECHO 关闭木马Socket23默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Trojan Cow默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO 关闭木马Gatecrasher默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO 关闭木马Ripper默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO 关闭木马Telecommando默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2115" -f *+0:2115:TCP -n BLOCK -x>NUL
ECHO 关闭木马Bugs默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12076" -f *+0:12076:TCP -n BLOCK -x>NUL
ECHO 关闭木马Gjamer默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2140" -f *+0:2140:TCP -n BLOCK -x>NUL
ECHO 关闭木马Deep Throat默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4950" -f *+0:4950:TCP -n BLOCK -x>NUL
ECHO 关闭木马IcqTrojen默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2140" -f *+0:2140:TCP -n BLOCK -x>NUL
ECHO 关闭木马The Invasor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-16969" -f *+0:16969:TCP -n BLOCK -x>NUL
ECHO 关闭木马Priotrity默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2801" -f *+0:2801:TCP -n BLOCK -x>NUL
ECHO 关闭木马Phineas Phucker默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO 关闭木马Vodoo默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30129" -f *+0:30129:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5742" -f *+0:5742:TCP -n BLOCK -x>NUL
ECHO 关闭木马Wincrash默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3700" -f *+0:3700:TCP -n BLOCK -x>NUL
ECHO 关闭木马Portal of Doom默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO 关闭木马Wincrash2默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4092" -f *+0:4092:TCP -n BLOCK -x>NUL
ECHO 关闭木马WinCrash默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1033" -f *+0:1033:TCP -n BLOCK -x>NUL
ECHO 关闭木马Netspy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4590" -f *+0:4590:TCP -n BLOCK -x>NUL
ECHO 关闭木马ICQTrojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1981" -f *+0:1981:TCP -n BLOCK -x>NUL
ECHO 关闭木马ShockRave默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5000" -f *+0:5000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sockets de Troie默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO 关闭木马Stealth Spy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5001" -f *+0:5001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sockets de Troie 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO 关闭木马Pass Ripper默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5321" -f *+0:5321:TCP -n BLOCK -x>NUL
ECHO 关闭木马Firehotcker默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO 关闭木马Attack FTP默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5400" -f *+0:5400:TCP -n BLOCK -x>NUL
ECHO 关闭木马Blade Runner默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-21554" -f *+0:21554:TCP -n BLOCK -x>NUL
ECHO 关闭木马GirlFriend默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5401" -f *+0:5401:TCP -n BLOCK -x>NUL
ECHO 关闭木马Blade Runner 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO 关闭木马Fore Schwindler默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5402" -f *+0:5402:TCP -n BLOCK -x>NUL
ECHO 关闭木马Blade Runner 2.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-34324" -f *+0:34324:TCP -n BLOCK -x>NUL
ECHO 关闭木马Tiny Telnet Server默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5569" -f *+0:5569:TCP -n BLOCK -x>NUL
ECHO 关闭木马Robo-Hack默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30999" -f *+0:30999:TCP -n BLOCK -x>NUL
ECHO 关闭木马Kuang默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6670" -f *+0:6670:TCP -n BLOCK -x>NUL
ECHO 关闭木马DeepThroat默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11000" -f *+0:11000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Senna Spy Trojans默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6771" -f *+0:6771:TCP -n BLOCK -x>NUL
ECHO 关闭木马DeepThroat默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23456" -f *+0:23456:TCP -n BLOCK -x>NUL
ECHO 关闭木马WhackJob默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO 关闭木马GateCrasher默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO 关闭木马Phase0默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO 关闭木马Priority默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5400" -f *+0:5400:TCP -n BLOCK -x>NUL
ECHO 关闭木马Blade Runner默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7000" -f *+0:7000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Remote Grab默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4950" -f *+0:4950:TCP -n BLOCK -x>NUL
ECHO 关闭木马IcqTrojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7300" -f *+0:7300:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9989" -f *+0:9989:TCP -n BLOCK -x>NUL
ECHO 关闭木马InIkiller默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7301" -f *+0:7301:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO 关闭木马Portal Of Doom默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor 2.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11223" -f *+0:11223:TCP -n BLOCK -x>NUL
ECHO 关闭木马Progenic Trojan默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7307" -f *+0:7307:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor 3.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO 关闭木马BackDoor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5800" -f *+0:5800:TCP -n BLOCK -x>NUL
ECHO 关闭远程控制软件VNC默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5900" -f *+0:5900:TCP -n BLOCK -x>NUL
ECHO 关闭远程控制软件VNC默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-22222" -f *+0:22222:TCP -n BLOCK -x>NUL
ECHO 关闭木马Prosiak 0.47默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7626" -f *+0:7626:TCP -n BLOCK -x>NUL
ECHO 关闭木马冰河默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4444" -f *+0:4444:TCP -n BLOCK -x>NUL
ECHO 关闭木马msblast默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7308" -f *+0:7308:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor 4.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6129" -f *+0:6129:TCP -n BLOCK -x>NUL
ECHO 关闭远程控制软件（dameware nt utilities)默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO 关闭木马Ripper默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO 关闭木马VooDoo Doll默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-121" -f *+0:121:TCP -n BLOCK -x>NUL
ECHO 关闭木马BO jammerkillahV默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-456" -f *+0:456:TCP -n BLOCK -x>NUL
ECHO 关闭木马Hackers Paradise默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO 关闭木马Stealth Spy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO 关闭木马Satanz Backdoor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Silencer默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1033" -f *+0:1033:TCP -n BLOCK -x>NUL
ECHO 关闭木马Netspy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7000" -f *+0:7000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Remote Grab默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7300 " -f *+0:7300:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetMonitor默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23456 " -f *+0:23456:TCP -n BLOCK -x>NUL
ECHO 关闭木马Ugly FTP默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23456 " -f *+0:23456:TCP -n BLOCK -x>NUL
ECHO 关闭木马Ugly FTP默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100 " -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO 关闭木马NetSphere默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO 关闭木马Portal of Doom默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9899" -f *+0:9899:TCP -n BLOCK -x>NUL
ECHO 关闭木马iNi-Killer默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50505" -f *+0:50505:TCP -n BLOCK -x>NUL
ECHO 关闭木马Sockets de Troie默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6939" -f *+0:6939:TCP -n BLOCK -x>NUL
ECHO 关闭木马Indoctrination默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11000" -f *+0:11000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Senna Spy默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12223" -f *+0:12223:TCP -n BLOCK -x>NUL
ECHO 关闭木马Hack?99 KeyLogger默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12362" -f *+0:12362:TCP -n BLOCK -x>NUL
ECHO 关闭木马Whack-a-mole 1.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20000" -f *+0:20000:TCP -n BLOCK -x>NUL
ECHO 关闭木马Millenium默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO 关闭木马Wincrash v2默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53001" -f *+0:53001:TCP -n BLOCK -x>NUL
ECHO 关闭木马Remote Windows Shutdown默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7789" -f *+0:7789:TCP -n BLOCK -x>NUL
ECHO 关闭木马ICKiller默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40426" -f *+0:40426:TCP -n BLOCK -x>NUL
ECHO 关闭木马Masters Paradise 3.x默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5569" -f *+0:5569:TCP -n BLOCK -x>NUL
ECHO 关闭木马RoboHack默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8000" -f *+0:8000:TCP -n BLOCK -x>NUL
ECHO 关闭木马huigezi默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO 关闭木马Portal of Doom默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2005" -f *+0:2005:TCP -n BLOCK -x>NUL
ECHO 关闭木马黑洞2005默认服务端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2000" -f *+0:2000:TCP -n BLOCK -x>NUL
ECHO 关闭彩虹桥1.2默认端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9999" -f *+0:9999:TCP -n BLOCK -x>NUL
ECHO 关闭huigezi映射默认端口…………OK！
IPSECCMD -w REG -p "HFUT_SECU" -x>NUL
ECHO 强力封杀完毕，请按任意键病毒清除工具面板。
PAUSE>NUL
TITLE Win DOS第一代反病毒软件
CLS
GOTO 90

:95
CLS
ECHO 说明：清除过程中可能会有打开文件夹的声音，请按照弹出窗口标题执行操作。
ECHO       操作过程中会询问是否终止批处理操作，Win DOS将会以首字母作为判据。
ECHO       如果您选择“N”，则继续清除Virus2缓存，否则将会退出程序。
PAUSE
FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (START /REALTIME /I /WAIT "如果看到“系统找不到指定的文件”或“设备未就绪”的错误提示，请关闭我。" CMD /Q /C "FOR /L %%i IN (0,1,10000000000) DO (RD /Q /S %%I\%%i..\)")
SET FG=

:96
CLS
TITLE Win DOS第一代反病毒软件
ECHO 病毒清除成功，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN