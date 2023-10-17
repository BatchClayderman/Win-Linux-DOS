@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Windows修复程序
SET ERR=0
CLS
ECHO 正在加载系统信息，请稍候...
IF NOT EXIST "%COMSPEC:~0,-7%reg.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件reg.exe丢失，无法继续启动。",16,"Windows修复程序"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%sc.exe" (MSHTA VBSCRIPT:MSGBOX("系统文件sc.exe意外丢失，无法继续启动。",16,"Windows修复程序"^)(WINDOW.CLOSE^)&EXIT)
VER|FIND /I "XP">NUL
SET X=%ERRORLEVEL%
IF %PROCESSOR_ARCHITECTURE:~-1%==6 (SET SYS=32&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==4 (SET SYS=64&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==2 (SET SYS=32&SET ERR=1&GOTO MAIN)
GOTO A

:A
CLS
ECHO Win DOS无法获取您的操作系统位数，请手动选择。
CHOICE /C 036 /M "退出请选择“0”，32位系统请选择“3”，64位系统请选择“6”。"
IF %ERRORLEVEL%==1 EXIT
IF %ERRORLEVEL%==2 (SET SYS=32)
IF %ERRORLEVEL%==3 (SET SYS=64)
GOTO MAIN

:MAIN
FOR /F "tokens=2 delims=," %%i in ('TYPE CONFIG.INI') do (COLOR %%i)
TITLE Windows修复程序
CLS
ECHO Windows修复程序主面板
IF %ERR%==1 (ECHO 您的系统可能发生了参变，建议启动参变检测仪。)
ECHO.
ECHO   0=退出程序
ECHO   1=关闭外接设备接入时自动运行
IF %X%==0 (ECHO   2=恢复Windows XP的各项服务（可修复激活死循环）) ELSE (ECHO   2=更改UAC设置)
ECHO   3=恢复出厂设置
ECHO   4=解禁各类管理器
ECHO   5=解决IE无法打开新链接的问题
ECHO   6=解决内存不能为“Read”或“Written”的问题
ECHO   7=显示或不显示隐藏文件
ECHO   8=修复Windows Media Player
ECHO   9=禁止保留文档记录
ECHO   A=显示所有文件拓展名或隐藏已知文件拓展名
ECHO   B=强制断开或刷新网络连接
ECHO   C=绑定ARP
ECHO   D=强制刷新组策略
ECHO   E=添加或删除右键菜单“管理员取得所有权”
ECHO   F=修复DNS
ECHO   G=显示桌面
ECHO   H=允许或阻止资源管理器运行指定程序
ECHO   I=添加或清除映像劫持
ECHO   J=设置IE首页与第二起始页
ECHO   K=修复sleep.exe
ECHO   L=去除新建快捷方式中的“快捷方式”字样
ECHO   M=修改壁纸
ECHO   N=打开或关闭桌面右下角Windows版本信息
ECHO   O=打开或关闭任务栏显示到秒
ECHO   P=恢复“Shift键+右键”的从此处启动命令提示符
ECHO 请选择一项以继续：
CHOICE /C 123456789ABCDEFGHIJKLMNOP0
CLS
IF %ERRORLEVEL%==26 EXIT
GOTO %ERRORLEVEL%

:1
CLS
ECHO 正在关闭自动运行，请稍候...
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V "NoDriveTypeAutoRun" /D hex:BD,00,00,00 /F
PAUSE
GOTO MAIN

:2
GOTO 02%X%

:020
ECHO 说明：1．若您修改了相关服务导致某些功能不能正常使用，请继续；
ECHO       2．重置服务不会对您的硬盘文件、系统有任何影响，请放心；
ECHO       3．修复激活死循环命令：RUNDLL32 syssetup,SetupOobeBnk。
ECHO 您真的要重置服务吗？
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
CLS
ECHO 正在修复激活死循环，请稍候...
ECHO RUNDLL32 syssetup,SetupOobeBnk
ECHO 正在重置服务，请稍候...
SC CONFIG Alerter START= DISABLED 
SC CONFIG ALG START= DEMAND 
SC CONFIG AppMgmt START= DEMAND 
SC CONFIG AudioSrv START= AUTO 
SC CONFIG BITS START= DEMAND 
SC CONFIG Browser START= AUTO 
SC CONFIG CiSvc START= DEMAND 
SC CONFIG ClipSrv START= DISABLED 
SC CONFIG COMSysApp START= DEMAND 
SC CONFIG CryptSvc START= AUTO 
SC CONFIG DcomLaunch START= AUTO 
SC CONFIG Dhcp START= AUTO 
SC CONFIG dmadmin START= DEMAND 
SC CONFIG dmserver START= AUTO 
SC CONFIG Dnscache START= AUTO 
SC CONFIG ERSvc START= AUTO 
SC CONFIG Eventlog START= AUTO 
SC CONFIG EventSystem START= DEMAND 
SC CONFIG FastUserSwitchingCompatibility START= DEMAND 
SC CONFIG helpsvc START= AUTO 
SC CONFIG HidServ START= DISABLED 
SC CONFIG HTTPFilter START= DEMAND 
SC CONFIG ImapiService START= DEMAND 
SC CONFIG lanmanserver START= AUTO 
SC CONFIG lanmanworkstation START= AUTO 
SC CONFIG LmHosts START= AUTO 
SC CONFIG Messenger START= DISABLED 
SC CONFIG mnmsrvc START= DEMAND 
SC CONFIG MSDTC START= DEMAND 
SC CONFIG MSIServer START= DEMAND 
SC CONFIG NetDDE START= DISABLED 
SC CONFIG NetDDEdsdm START= DISABLED 
SC CONFIG Netlogon START= DEMAND 
SC CONFIG Netman START= DEMAND 
SC CONFIG Nla START= DEMAND 
SC CONFIG NtLmSsp START= DEMAND 
SC CONFIG NtmsSvc START= DEMAND 
SC CONFIG PlugPlay START= AUTO 
SC CONFIG PolicyAgent START= AUTO 
SC CONFIG ProtectedStorage START= AUTO 
SC CONFIG RasAuto START= DEMAND 
SC CONFIG RasMan START= DEMAND 
SC CONFIG RDSessMgr START= DEMAND 
SC CONFIG RemoteAccess START= DISABLED 
SC CONFIG RemoteRegistry START= AUTO 
SC CONFIG RpcLocator START= DEMAND 
SC CONFIG RpcSs START= AUTO 
SC CONFIG RSVP START= DEMAND 
SC CONFIG SamSs START= AUTO 
SC CONFIG SCardSvr START= DEMAND 
SC CONFIG Schedule START= AUTO 
SC CONFIG seclogon START= AUTO 
SC CONFIG SENS START= AUTO 
SC CONFIG SharedAccess START= AUTO 
SC CONFIG ShellHWDetection START= AUTO 
SC CONFIG Spooler START= DEMAND 
SC CONFIG srservice START= DISABLED 
SC CONFIG SSDPSRV START= DEMAND 
SC CONFIG stisvc START= DEMAND 
SC CONFIG SwPrv START= DEMAND 
SC CONFIG SysmonLog START= DEMAND 
SC CONFIG TapiSrv START= DEMAND 
SC CONFIG TermService START= DEMAND 
SC CONFIG Themes START= AUTO 
SC CONFIG TlntSvr START= DISABLED 
SC CONFIG TrkWks START= AUTO 
SC CONFIG UMWdf START= DEMAND 
SC CONFIG upnphost START= DEMAND 
SC CONFIG UPS START= DEMAND 
SC CONFIG VSS START= DEMAND 
SC CONFIG W32Time START= AUTO 
SC CONFIG WebClient START= AUTO 
SC CONFIG winmgmt START= AUTO 
SC CONFIG WmdmPmSN START= DEMAND 
SC CONFIG Wmi START= DEMAND 
SC CONFIG WmiApSrv START= DEMAND 
SC CONFIG wscsvc START= AUTO 
SC CONFIG wuauserv START= AUTO 
SC CONFIG WZCSVC START= AUTO 
SC CONFIG xmlprov START= DEMAND 
ECHO 修复完毕，请按任意键返回Windows修复程序主界面。
PAUSE>NUL
GOTO MAIN

:021
ECHO 如果您的系统已开启UAC，请确保本程序具有管理员权限。
ECHO 请选择UAC强度：
ECHO   1=高（开发者力荐）
ECHO   2=中（系统推荐） 
ECHO   3=低
ECHO   4=关（不推荐）
ECHO   0=返回主面板
CHOICE /C 12340
IF %ERRORLEVEL%==5 (GOTO MAIN)
CLS
GOTO U%ERRORLEVEL%

:U1
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V ConsentPromptBehaviorAdmin /T REG_DWORD /D 2 /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V EnableLUA /T REG_DWORD /D 1 /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V PromptOnSecureDesktop /T REG_DWORD /D 1 /F
GOTO U0

:U2
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V ConsentPromptBehaviorAdmin /T REG_DWORD /D 5 /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V EnableLUA /T REG_DWORD /D 1 /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V PromptOnSecureDesktop /T REG_DWORD /D 1 /F
GOTO U0

:U3
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V ConsentPromptBehaviorAdmin /T REG_DWORD /D 5 /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V EnableLUA /T REG_DWORD /D 1 /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V PromptOnSecureDesktop /T REG_DWORD /D 0 /F
GOTO U0

:U4
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V ConsentPromptBehaviorAdmin /T REG_DWORD /D 0 /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V EnableLUA /T REG_DWORD /D 0 /F
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V PromptOnSecureDesktop /T REG_DWORD /D 0 /F

:U0
GPUPDATE /FORCE
PAUSE
GOTO MAIN

:3
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO 说明：1．重置系统设置将清除您的所有偏好设置，但是资料不会丢失；
ECHO       2．由于重置带来的不便，本程序概不负责；
ECHO       3．重置系统设置具有一定的风险，未到万不得已时刻不建议重置。
ECHO 您真的要重置吗？
CHOICE /C YN
SET Y=%ERRORLEVEL%
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
IF %Y%==2 (GOTO MAIN)
RUNDLL32,setupapi,InstallHinfSection DefaultInstall 132 "%~DP0RESET.INF"
ECHO 重置完毕，是否重启系统？
CHOICE /C YN
IF %ERRORLEVEL%==1 SHUT
GOTO MAIN

:4
ECHO 正在解禁注册表，请稍候...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V DisableRegistryTools /T REG_DWORD /D 0 /F
ECHO 正在解禁任务管理器，请稍候...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V DisableTaskmgr /T REG_DWORD /D 0 /F
GPUPDATE /FORCE
ECHO 执行操作完毕！
ECHO 如果解禁没有生效，请尝试清除映像劫持或阻止运行项。
PAUSE
GOTO MAIN

:5
MSHTA VBSCRIPT:MSGBOX("即将执行修复，执行过程大约需要1分多钟。如果出现提示框，点击“确定”即可。",64,"Win DOS修复程序")(WINDOW.CLOSE)
ECHO 正在执行修复，请稍候...
REGSVR32 setupwbv.dll /S 
REGSVR32 wininet.dll /S
REGSVR32 comcat.dll /S
REGSVR32 shdoc401.dll /S
REGSVR32 shdoc401.dll /S /I
REGSVR32 asctrls.ocx /S
REGSVR32 oleaut32.dll /S
REGSVR32 shdocvw.dll /S /I
REGSVR32 shdocvw.dll /S
REGSVR32 browseui.dll /S
REGSVR32 browseui.dll /S /I
REGSVR32 msrating.dll /S
REGSVR32 mlang.dll /S
REGSVR32 hlink.dll /S
REGSVR32 mshtml.dll /S
REGSVR32 mshtmled.dll /S
REGSVR32 urlmon.dll /S
REGSVR32 plugin.ocx /S
REGSVR32 sendmail.dll /S
REGSVR32 comctl32.dll /S /i
REGSVR32 inetcpl.cpl /I
REGSVR32 mshtml.dll /S /I
REGSVR32 scrobj.dll /S
REGSVR32 mmefxe.ocx /S
REGSVR32 proctexe.ocx /S 
REGSVR32 corpol.dll /S
REGSVR32 jscript.dll /S
REGSVR32 msxml.dll /S
REGSVR32 imgutil.dll /S
REGSVR32 thumbvw.dll /S
REGSVR32 cryptext.dll /S
REGSVR32 rsabase.dll /S
REGSVR32 triedit.dll /S
REGSVR32 dhtmled.ocx /S
REGSVR32 inseng.dll /S
REGSVR32 iesetup.dll /S /I
REGSVR32 hmmapi.dll /S
REGSVR32 cryptdlg.dll /S
REGSVR32 actxprxy.dll /S
REGSVR32 dispex.dll /S
REGSVR32 occache.dll /S
REGSVR32 occache.dll /S /i
REGSVR32 iepeers.dll /S
REGSVR32 wininet.dll /S /i
REGSVR32 urlmon.dll /S /i
REGSVR32 digest.dll /S /i
REGSVR32 cdfview.dll /S
REGSVR32 webcheck.dll /S
REGSVR32 mobsync.dll /S
REGSVR32 pngfilt.dll /S
REGSVR32 licmgr10.dll /S
REGSVR32 icmfilter.dll /S
REGSVR32 hhctrl.ocx /S
REGSVR32 inetcfg.dll /S
REGSVR32 trialoc.dll /S
REGSVR32 tdc.ocx /S
REGSVR32 MSR2C.dll /S
REGSVR32 msident.dll /S
REGSVR32 msieftp.dll /S
REGSVR32 xmsconf.ocx /S
REGSVR32 ils.dll /S
REGSVR32 msoeacct.dll /S
REGSVR32 wab32.dll /S
REGSVR32 wabimp.dll /S
REGSVR32 wabfind.dll /S
REGSVR32 oemiglib.dll /S
REGSVR32 directdb.dll /S
REGSVR32 inetcomm.dll /S
REGSVR32 msoe.dll /S
REGSVR32 oeimport.dll /S
REGSVR32 msdxm.ocx /S
REGSVR32 dxmasf.dll /S
REGSVR32 laprxy.dll /S
REGSVR32 l3codecx.ax /S
REGSVR32 acelpdec.ax /S
REGSVR32 mpg4ds32.ax /S
REGSVR32 voxmsdec.ax /S
REGSVR32 danim.dll /S
REGSVR32 Daxctle.ocx /S
REGSVR32 lmrt.dll /S
REGSVR32 datime.dll /S
REGSVR32 dxtrans.dll /S
REGSVR32 dxtmsft.dll /S
REGSVR32 vgx.dll /S
REGSVR32 WEBPOST.dll /S
REGSVR32 WPWIZdll /S.dll /S
REGSVR32 POSTWPP.dll /S
REGSVR32 CRSWPP.dll /S
REGSVR32 FTPWPP.dll /S
REGSVR32 FPWPP.dll /S
REGSVR32 FLUPL.ocx /S
REGSVR32 wshom.ocx /S
REGSVR32 wshext.dll /S
REGSVR32 vbscript.dll /S
REGSVR32 scrrun.dll /S mstinit.exe /Setup
REGSVR32 msnsspc.dll /S /SspcCreateSspiReg
REGSVR32 msapsspc.dll /S /SspcCreateSspiReg
ECHO 执行操作完毕，请按任意键返回Windows修复程序主面板。
PAUSE>NUL
GOTO MAIN

:6
ECHO 正在修复内存不能为“Read”或“Written”的问题，请稍候...
FOR %%i in (%WinDir%\system32\*.dll) do (REGSVR32 /S %%i)
FOR %%i in (%WinDir%\system32\*.ocx) do (REGSVR32 /S %%i)
ECHO 修复完毕，请按任意键返回Windows修复程序主面板。
PAUSE>NUL
GOTO MAIN

:7
ECHO 显示或不显示隐藏文件？
CHOICE /C YNC /M "Y=显示，N=隐藏，C=返回主面板"
CLS
GOTO 7%ERRORLEVEL%

:71
ECHO 正在显示隐藏文件，请稍候...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V Hidden /T REG_DWORD /D 1 /F
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
ECHO 是否显示系统隐藏文件？
CHOICE /C YNC /M "Y=是，N=否，C=维持现状"
IF %ERRORLEVEL%==1 (GOTO 74)
IF %ERRORLEVEL%==3 (GOTO 73)
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSuperHidden /T REG_DWORD /D 0 /F
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
GOTO 73

:72
ECHO 正在设置不显示隐藏文件，请稍候...
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V Hidden /T REG_DWORD /D 0 /F
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSuperHidden /T REG_DWORD /D 0 /F

:73
CLS
ECHO 正在重启资源管理器，请稍候...
TASKKILL /IM EXPLORER.EXE /F
START /REALTIME "" EXPLORER
PAUSE
GOTO MAIN

:74
CLS
ECHO 正在显示系统隐藏文件，请稍候...
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSuperHidden /T REG_DWORD /D 1 /F
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
GOTO 73

:8
ECHO 正在修复Windows Media Player，请稍候...
REGSVR32 /S jscript.dll
REGSVR32 /S vbscript.dll
ECHO 修复完毕，若您的Windows Media Player依旧存在问题，我们建议您重装Windows Media Player。请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:9
ECHO 正在执行操作，请稍候...
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V NORECENTDOCSHISTORY /T REG_DWORD /D 1 /F
PAUSE
GOTO MAIN

:10
ECHO 显示所有文件拓展名或隐藏已知文件拓展名？
CHOICE /C YNC /M "Y=显示，N=隐藏，C=返回主面板"
GOTO 10%ERRORLEVEL%

:101
ECHO 正在显示文件拓展名，请稍候...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V HideFileExt /T REG_DWORD /D 0 /F
REGSVR32 /S /N /I:/UserInstall %SystemRoot%\system32\themeui.dll
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
CLS
ECHO 注意：Windows10及以下需要手动刷新。
ECHO 如果仍未能看到文件拓展名，建议您运行快速扫描，请按任意键返回主面板。
PAUSE>NUL
GOTO 103

:102
ECHO 正在隐藏文件拓展名，请稍候...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V HideFileExt /T REG_DWORD /D 1 /F
REGSVR32 /S /N /I:/UserInstall %SystemRoot%\system32\themeui.dll
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
CLS
ECHO 注意：Windows10及以下需要手动刷新。
ECHO 执行操作完毕，请按任意键返回主面板。
PAUSE>NUL

:103
GOTO MAIN

:11
ECHO 正在断开或刷新网络连接，请稍候...
RASPHONE -H adsl 
NETSH -C interface dump
ECHO 执行操作完毕！如果网络没有断开，是因为系统自动重新连接了网络。
PAUSE
GOTO MAIN

:12
SET MAC=
SET IP=
ECHO 正在尝试绑定ARP，请稍候...
FOR /F "DELIMS=: TOKENS=2" %%I IN ('IPCONFIG /ALL^|FIND /I "Physical Address"') DO (SET MAC=%%I)
FOR /F "DELIMS=: TOKENS=2" %%I IN ('IPCONFIG ^|FIND /I "IP Address"') DO (SET IP=%%I)
IF "%MAC%"=="" (FOR /F "TOKENS=2 DELIMS=:" %%I IN ('IPCONFIG /ALL^|FIND /N "物理地址"^|FIND /N "1"') DO (SET MAC=%%I))
IF "%IP%"=="" (FOR /F "DELIMS=: TOKENS=2" %%I IN ('IPCONFIG ^|FIND /I "IPv4"') DO (SET IP=%%I))
ARP -S %IP%%MAC%
CLS
ECHO MAC地址：%MAC:~1,99%,IP地址：%IP:~1,99%。
ECHO 执行操作完毕，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:13
GPUPDATE /FORCE
PAUSE
GOTO MAIN

:14
ECHO 添加或删除？
CHOICE /C YNC /M "Y=添加，N=删除，C=返回主面板"
GOTO 14%ERRORLEVEL%

:141
ECHO 正在添加相关注册表，请稍候...
REG ADD HKCR\*\shell\runas /VE /D 管理员取得所有权 /F
REG ADD HKCR\*\shell\runas /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\runas\Command /VE /D "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /F
REG ADD HKCR\*\shell\runas\Command /V "IsolatedCommand" /D "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /F
ECHO 执行操作完毕，请检阅您的右键菜单，按任意键返回主面板。
PAUSE>NUL
GOTO 143

:142
ECHO 正在删除相关注册表，请稍候...
REG DELETE HKCR\*\shell\runas /F
ECHO 执行操作完毕，请按任意键返回主面板。
PAUSE>NUL
GOTO 143

:143
GOTO MAIN

:15
IPCONFIG /FLUSHDNS
ECHO 执行操作完毕，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:16
IF NOT EXIST "%COMSPEC:~0,-7%MSHTA.EXE" (GOTO 161)
START /REALTIME "" MSHTA VBSCRIPT:CreateObject("Shell.Application").ToggleDesktop
SLEEP 1000
TASKKILL /IM MSHTA.EXE /F
GOTO MAIN

:161
ECHO 您的系统丢失系统文件mshta.exe，无法继续，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:17
SET F=
ECHO 说明：此处阻止运行仅阻止指定程序从资源管理器运行。
ECHO 请输入全文件名（请勿使用引号或将文件拖拽至此）：
SET /P F=
ECHO   Y=阻止运行
ECHO   N=解除阻止指定程序运行
ECHO   A=解除所有阻止运行项
ECHO   R=重新输入全文件名
ECHO   C=返回主面板
ECHO 请选择一项以继续：
CHOICE /C YNARC
IF %ERRORLEVEL%==4 (CLS&GOTO 17)
IF %ERRORLEVEL%==5 (GOTO MAIN)
CLS
ECHO 正在执行操作，请稍候...
GOTO 17%ERRORLEVEL%

:171
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V DisallowRun /T REG_DWORD /D 1 /F
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /V "%F%" /D "%F%" /F
GOTO 174

:172
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun /V "%F%" /F
GOTO 174

:173
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V DisallowRun /F
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun /F

:174
SET F=
GPUPDATE /FORCE
CHOICE /C RC /M "R=继续执行操作，C=返回主面板" 
IF %ERRORLEVEL%==2 (GOTO MAIN)
CLS
GOTO 17

:18
SET F=
IF NOT EXIST "%COMSPEC:~0,-7%MSHTA.EXE" (GOTO 184)
MSHTA VBSCRIPT:MSGBOX("添加或清除映像劫持有一定风险，请先退出第二代反病毒软件（杀毒软件）。",64,"多功能修复器")(WINDOW.CLOSE)
GOTO 185

:181
SET TF=NUL
ECHO 请输入目标命令行（直接回车视为阻止运行）：
SET /P "TF="
CLS
ECHO 正在添加映像劫持，请稍候...
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%F%" /V debugger /T REG_SZ /D %TF% /F
GOTO 183

:182
ECHO 正在清除映像劫持，请稍候...
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%F%" /F
GOTO 183

:183
SET F=
SET TF=
ECHO 执行操作完毕，请选择一项以继续：
CHOICE /C RC /M "R=继续执行操作，C=返回主面板" 
IF %ERRORLEVEL%==2 (GOTO MAIN)
CLS
GOTO 185

:184
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO 注意：您的系统缺乏文件mshta.exe，请稍后修补。
ECHO 添加或清除映像劫持有一定风险，请先退出第二代反病毒软件（杀毒软件）。
PAUSE
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO 185

:185
CLS
ECHO 请输入被劫持文件的全文件名（请勿使用引号或将文件拖拽至此）：
SET /P F=
ECHO   Y=添加劫持
ECHO   N=清除劫持
ECHO   R=重新输入全文件名
ECHO   C=返回主面板
ECHO 请选择一项以继续：
CHOICE /C YNRC
IF %ERRORLEVEL%==3 (GOTO 185)
IF %ERRORLEVEL%==4 (GOTO MAIN)
CLS
GOTO 18%ERRORLEVEL%

:19
SET H=https://www.baidu.com
ECHO 说明：大多数杀毒软件对此配置十分敏感，您可能需要先关闭杀毒软件的浏览器防御或直接使用杀毒软件进行绑定。
ECHO 请在下方输入网址，直接回车则将“百度”设为IE首页与第二起始页。
SET /P H=
ECHO 正在执行操作，请稍候...
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Start Page" /D "%H%" /F
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Default_Page_URL" /D "%H%" /F
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Secondary Start Pages" /D "%H%" /F
ECHO 执行操作完毕，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:20
IF EXIST "%~DP0sleep.exe" (ECHO 已存在sleep.exe，无需修复，请按任意键返回主面板。&PAUSE>NUL&GOTO MAIN)
IF EXIST "%COMSPEC:~0,-7%sleep.exe" (GOTO 202)
ECHO 正在尝试修复sleep.exe，请稍候...
IF NOT EXIST DEBUG.EXE (GOTO 201)
IF NOT %PROCESSOR_ARCHITECTURE:~-1%==4 (GOTO 201)
ECHO q | debug>nul
ECHO Bj@jzh`0X-`/PPPPPPa(DE(DM(DO(Dh(Ls(Lu(LX(LeZRR]EEEUYRX2Dx=>sleep.com
ECHO 0DxFP,0Xx.t0P,=XtGsB4o@$?PIyU WwX0GwUY Wv;ovBX2Gv0ExGIuht6>>sleep.com
ECHO T}{z~~@GwkBG@OEKcUt`~}@MqqBsy?seHB~_Phxr?@zAB`LrPEyoDt@Cj?>>sleep.com
ECHO pky_jN@QEKpEt@ij?jySjN@REKpEt@jj?jyGjN@SEKkjtlGuNw?p@pjirz>>sleep.com
ECHO LFvAURQ?OYLTQ@@?~QCoOL~RDU@?aU?@{QOq?@}IKuNWpe~FpeQFwH?Vkk>>sleep.com
ECHO _GSqoCvH{OjeOSeIQRmA@KnEFB?p??mcjNne~B?M??QhetLBgBPHexh@e=>>sleep.com
ECHO EsOgwTLbLK?sFU`?LDOD@@K@xO?SUudA?_FKJ@N?KD@?UA??O}HCQOQ??R>>sleep.com
ECHO _OQOL?CLA?CEU?_FU?UAQ?UBD?LOC?ORO?UOL?UOD?OOI?UgL?LOR@YUO?>>sleep.com
ECHO dsmSQswDOR[BQAQ?LUA?_L_oUNUScLOOuLOODUO?UOE@OwH?UOQ?DJTSDM>>sleep.com
ECHO QTqrK@kcmSULkPcLOOuLOOFUO?hwDTqOsTdbnTQrrDsdFTlnBTm`lThKcT>>sleep.com
ECHO @dmTkRQSoddTT~?K?OCOQp?o??Gds?wOw?PGAtaCHQvNntQv_w?A?it\EH>>sleep.com
ECHO {zpQpKGk?Jbs?FqokOH{T?jPvP@IQBDFAN?OHROL?Kj??pd~aN?OHROd?G>>sleep.com
ECHO Q??PGT~B??OC~?ipO?T?~U?p~cUo0x>>sleep.com
sleep.com>sleep.exe
IF EXIST sleep.exe (DEL /A /F /Q sleep.com)
XCOPY sleep.exe "%COMSPEC:~0,-7%" /H /V /Y
IF NOT EXIST "%COMSPEC:~0,-7%sleep.exe" (GOTO 201)
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%sleep.exe"
DEL /A /F /Q "%~DP0sleep.exe"
CLS
ECHO 修复成功结束！
PAUSE
GOTO MAIN

:201
CLS
ECHO 修复失败，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:202
XCOPY "%COMSPEC:~0,-7%sleep.exe" "%~DP0" /H /V /Y
ATTRIB +A +H +R +S "%~DP0sleep.exe"
IF EXIST "%~DP0sleep.exe" (ECHO 修复成功结束！)  ELSE (ECHO 修复失败。)
PAUSE
GOTO MAIN

:21
CLS
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer /V link /T REG_BINARY /D "00000000" /F
ECHO 配置在重启系统后生效，请按任意键返回主面板。
PAUSE>NUL
GOTO MAIN

:22
ECHO 请将文件拖拽到下方或输入全路径：
SET /P WP=
WALLCMD %WP%
MSHTA VBSCRIPT:MSGBOX("设置完毕!点击“确定”返回主面板。",0,"多功能修复器")(WINDOW.CLOSE)
GOTO MAIN

:23
ECHO 打开或关闭桌面右下角信息？
CHOICE /C YNC /M "Y=打开，N=关闭，C=取消"
IF %ERRORLEVEL%==3 (GOTO MAIN)
IF %ERRORLEVEL%==2 (SET OP=0) ELSE (SET OP=1)
CLS
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V PaintDesktopVersion /T REG_DWORD /D %OP% /F
SET OP=
ECHO 正在重启资源管理器，请稍候...
TASKKILL /IM EXPLORER.EXE /F
START /REALTIME "" EXPLORER
PAUSE
GOTO MAIN

:24
ECHO 打开或关闭任务栏显示到秒？
CHOICE /C YNC /M "Y=打开，N=关闭，C=取消"
IF %ERRORLEVEL%==3 (GOTO MAIN)
IF %ERRORLEVEL%==1 (REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSecondsInSystemClock /D 1 /T REG_DWORD /F) ELSE (REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSecondsInSystemClock /F)
ECHO 正在重启资源管理器，请稍候...
TASKKILL /IM EXPLORER.EXE /F
START /REALTIME "" EXPLORER
PAUSE
GOTO MAIN

:25
ECHO 恢复或删除“Shift键+右键”的从此处启动命令提示符？
CHOICE /C YNC /M "Y=恢复，N=删除，C=取消"
IF %ERRORLEVEL%==3 (GOTO MAIN)
IF %ERRORLEVEL%==1 (
	REG ADD "HKCR\Directory\Background\shell\cmd" /VE /T REG_SZ /D "@shell32.dll,-8506" /F
	REG ADD "HKCR\Directory\Background\shell\cmd" /V Extended /T REG_SZ /D "" /F
	REG ADD "HKCR\Directory\Background\shell\cmd" /V NoWorkingDirectory /T REG_SZ /D "" /F
	REG ADD "HKCR\Directory\Background\shell\cmd" /V ShowBasedOnVelocityId /T REG_DWORD /D "0x00639bc8" /F
	REG ADD "HKCR\Directory\Background\shell\cmd\command" /VE /T REG_SZ /D "cmd.exe /s /k pushd \"%V\"" /F
	REG ADD "HKCR\Directory\Background\shell\cmd" /V Icon /T REG_SZ /D "%COMSPEC%" /F
) ELSE (
	REG DELETE "HKCR\Directory\Background\shell\cmd" /F
)
PAUSE
GOTO MAIN