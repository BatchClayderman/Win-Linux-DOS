@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Windows�޸�����
SET ERR=0
CLS
ECHO ���ڼ���ϵͳ��Ϣ�����Ժ�...
IF NOT EXIST "%COMSPEC:~0,-7%reg.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�reg.exe��ʧ���޷�����������",16,"Windows�޸�����"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%sc.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�sc.exe���ⶪʧ���޷�����������",16,"Windows�޸�����"^)(WINDOW.CLOSE^)&EXIT)
VER|FIND /I "XP">NUL
SET X=%ERRORLEVEL%
IF %PROCESSOR_ARCHITECTURE:~-1%==6 (SET SYS=32&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==4 (SET SYS=64&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==2 (SET SYS=32&SET ERR=1&GOTO MAIN)
GOTO A

:A
CLS
ECHO Win DOS�޷���ȡ���Ĳ���ϵͳλ�������ֶ�ѡ��
CHOICE /C 036 /M "�˳���ѡ��0����32λϵͳ��ѡ��3����64λϵͳ��ѡ��6����"
IF %ERRORLEVEL%==1 EXIT
IF %ERRORLEVEL%==2 (SET SYS=32)
IF %ERRORLEVEL%==3 (SET SYS=64)
GOTO MAIN

:MAIN
FOR /F "tokens=2 delims=," %%i in ('TYPE CONFIG.INI') do (COLOR %%i)
TITLE Windows�޸�����
CLS
ECHO Windows�޸����������
IF %ERR%==1 (ECHO ����ϵͳ���ܷ����˲α䣬���������α����ǡ�)
ECHO.
ECHO   0=�˳�����
ECHO   1=�ر�����豸����ʱ�Զ�����
IF %X%==0 (ECHO   2=�ָ�Windows XP�ĸ�����񣨿��޸�������ѭ����) ELSE (ECHO   2=����UAC����)
ECHO   3=�ָ���������
ECHO   4=������������
ECHO   5=���IE�޷��������ӵ�����
ECHO   6=����ڴ治��Ϊ��Read����Written��������
ECHO   7=��ʾ����ʾ�����ļ�
ECHO   8=�޸�Windows Media Player
ECHO   9=��ֹ�����ĵ���¼
ECHO   A=��ʾ�����ļ���չ����������֪�ļ���չ��
ECHO   B=ǿ�ƶϿ���ˢ����������
ECHO   C=��ARP
ECHO   D=ǿ��ˢ�������
ECHO   E=��ӻ�ɾ���Ҽ��˵�������Աȡ������Ȩ��
ECHO   F=�޸�DNS
ECHO   G=��ʾ����
ECHO   H=�������ֹ��Դ����������ָ������
ECHO   I=��ӻ����ӳ��ٳ�
ECHO   J=����IE��ҳ��ڶ���ʼҳ
ECHO   K=�޸�sleep.exe
ECHO   L=ȥ���½���ݷ�ʽ�еġ���ݷ�ʽ������
ECHO   M=�޸ı�ֽ
ECHO   N=�򿪻�ر��������½�Windows�汾��Ϣ
ECHO   O=�򿪻�ر���������ʾ����
ECHO   P=�ָ���Shift��+�Ҽ����ĴӴ˴�����������ʾ��
ECHO ��ѡ��һ���Լ�����
CHOICE /C 123456789ABCDEFGHIJKLMNOP0
CLS
IF %ERRORLEVEL%==26 EXIT
GOTO %ERRORLEVEL%

:1
CLS
ECHO ���ڹر��Զ����У����Ժ�...
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V "NoDriveTypeAutoRun" /D hex:BD,00,00,00 /F
PAUSE
GOTO MAIN

:2
GOTO 02%X%

:020
ECHO ˵����1�������޸�����ط�����ĳЩ���ܲ�������ʹ�ã��������
ECHO       2�����÷��񲻻������Ӳ���ļ���ϵͳ���κ�Ӱ�죬����ģ�
ECHO       3���޸�������ѭ�����RUNDLL32 syssetup,SetupOobeBnk��
ECHO �����Ҫ���÷�����
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
CLS
ECHO �����޸�������ѭ�������Ժ�...
ECHO RUNDLL32 syssetup,SetupOobeBnk
ECHO �������÷������Ժ�...
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
ECHO �޸���ϣ��밴���������Windows�޸����������档
PAUSE>NUL
GOTO MAIN

:021
ECHO �������ϵͳ�ѿ���UAC����ȷ����������й���ԱȨ�ޡ�
ECHO ��ѡ��UACǿ�ȣ�
ECHO   1=�ߣ�������������
ECHO   2=�У�ϵͳ�Ƽ��� 
ECHO   3=��
ECHO   4=�أ����Ƽ���
ECHO   0=���������
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
ECHO ˵����1������ϵͳ���ý������������ƫ�����ã��������ϲ��ᶪʧ��
ECHO       2���������ô����Ĳ��㣬������Ų�����
ECHO       3������ϵͳ���þ���һ���ķ��գ�δ���򲻵���ʱ�̲��������á�
ECHO �����Ҫ������
CHOICE /C YN
SET Y=%ERRORLEVEL%
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
IF %Y%==2 (GOTO MAIN)
RUNDLL32,setupapi,InstallHinfSection DefaultInstall 132 "%~DP0RESET.INF"
ECHO ������ϣ��Ƿ�����ϵͳ��
CHOICE /C YN
IF %ERRORLEVEL%==1 SHUT
GOTO MAIN

:4
ECHO ���ڽ��ע������Ժ�...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V DisableRegistryTools /T REG_DWORD /D 0 /F
ECHO ���ڽ����������������Ժ�...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V DisableTaskmgr /T REG_DWORD /D 0 /F
GPUPDATE /FORCE
ECHO ִ�в�����ϣ�
ECHO ������û����Ч���볢�����ӳ��ٳֻ���ֹ�����
PAUSE
GOTO MAIN

:5
MSHTA VBSCRIPT:MSGBOX("����ִ���޸���ִ�й��̴�Լ��Ҫ1�ֶ��ӡ����������ʾ�򣬵����ȷ�������ɡ�",64,"Win DOS�޸�����")(WINDOW.CLOSE)
ECHO ����ִ���޸������Ժ�...
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
ECHO ִ�в�����ϣ��밴���������Windows�޸���������塣
PAUSE>NUL
GOTO MAIN

:6
ECHO �����޸��ڴ治��Ϊ��Read����Written�������⣬���Ժ�...
FOR %%i in (%WinDir%\system32\*.dll) do (REGSVR32 /S %%i)
FOR %%i in (%WinDir%\system32\*.ocx) do (REGSVR32 /S %%i)
ECHO �޸���ϣ��밴���������Windows�޸���������塣
PAUSE>NUL
GOTO MAIN

:7
ECHO ��ʾ����ʾ�����ļ���
CHOICE /C YNC /M "Y=��ʾ��N=���أ�C=���������"
CLS
GOTO 7%ERRORLEVEL%

:71
ECHO ������ʾ�����ļ������Ժ�...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V Hidden /T REG_DWORD /D 1 /F
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
ECHO �Ƿ���ʾϵͳ�����ļ���
CHOICE /C YNC /M "Y=�ǣ�N=��C=ά����״"
IF %ERRORLEVEL%==1 (GOTO 74)
IF %ERRORLEVEL%==3 (GOTO 73)
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSuperHidden /T REG_DWORD /D 0 /F
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
GOTO 73

:72
ECHO �������ò���ʾ�����ļ������Ժ�...
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V Hidden /T REG_DWORD /D 0 /F
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSuperHidden /T REG_DWORD /D 0 /F

:73
CLS
ECHO ����������Դ�����������Ժ�...
TASKKILL /IM EXPLORER.EXE /F
START /REALTIME "" EXPLORER
PAUSE
GOTO MAIN

:74
CLS
ECHO ������ʾϵͳ�����ļ������Ժ�...
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSuperHidden /T REG_DWORD /D 1 /F
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
GOTO 73

:8
ECHO �����޸�Windows Media Player�����Ժ�...
REGSVR32 /S jscript.dll
REGSVR32 /S vbscript.dll
ECHO �޸���ϣ�������Windows Media Player���ɴ������⣬���ǽ�������װWindows Media Player���밴�������������塣
PAUSE>NUL
GOTO MAIN

:9
ECHO ����ִ�в��������Ժ�...
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V NORECENTDOCSHISTORY /T REG_DWORD /D 1 /F
PAUSE
GOTO MAIN

:10
ECHO ��ʾ�����ļ���չ����������֪�ļ���չ����
CHOICE /C YNC /M "Y=��ʾ��N=���أ�C=���������"
GOTO 10%ERRORLEVEL%

:101
ECHO ������ʾ�ļ���չ�������Ժ�...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V HideFileExt /T REG_DWORD /D 0 /F
REGSVR32 /S /N /I:/UserInstall %SystemRoot%\system32\themeui.dll
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
CLS
ECHO ע�⣺Windows10��������Ҫ�ֶ�ˢ�¡�
ECHO �����δ�ܿ����ļ���չ�������������п���ɨ�裬�밴�������������塣
PAUSE>NUL
GOTO 103

:102
ECHO ���������ļ���չ�������Ժ�...
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V HideFileExt /T REG_DWORD /D 1 /F
REGSVR32 /S /N /I:/UserInstall %SystemRoot%\system32\themeui.dll
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
CLS
ECHO ע�⣺Windows10��������Ҫ�ֶ�ˢ�¡�
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL

:103
GOTO MAIN

:11
ECHO ���ڶϿ���ˢ���������ӣ����Ժ�...
RASPHONE -H adsl 
NETSH -C interface dump
ECHO ִ�в�����ϣ��������û�жϿ�������Ϊϵͳ�Զ��������������硣
PAUSE
GOTO MAIN

:12
SET MAC=
SET IP=
ECHO ���ڳ��԰�ARP�����Ժ�...
FOR /F "DELIMS=: TOKENS=2" %%I IN ('IPCONFIG /ALL^|FIND /I "Physical Address"') DO (SET MAC=%%I)
FOR /F "DELIMS=: TOKENS=2" %%I IN ('IPCONFIG ^|FIND /I "IP Address"') DO (SET IP=%%I)
IF "%MAC%"=="" (FOR /F "TOKENS=2 DELIMS=:" %%I IN ('IPCONFIG /ALL^|FIND /N "�����ַ"^|FIND /N "1"') DO (SET MAC=%%I))
IF "%IP%"=="" (FOR /F "DELIMS=: TOKENS=2" %%I IN ('IPCONFIG ^|FIND /I "IPv4"') DO (SET IP=%%I))
ARP -S %IP%%MAC%
CLS
ECHO MAC��ַ��%MAC:~1,99%,IP��ַ��%IP:~1,99%��
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:13
GPUPDATE /FORCE
PAUSE
GOTO MAIN

:14
ECHO ��ӻ�ɾ����
CHOICE /C YNC /M "Y=��ӣ�N=ɾ����C=���������"
GOTO 14%ERRORLEVEL%

:141
ECHO ����������ע������Ժ�...
REG ADD HKCR\*\shell\runas /VE /D ����Աȡ������Ȩ /F
REG ADD HKCR\*\shell\runas /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\runas\Command /VE /D "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /F
REG ADD HKCR\*\shell\runas\Command /V "IsolatedCommand" /D "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /F
ECHO ִ�в�����ϣ�����������Ҽ��˵������������������塣
PAUSE>NUL
GOTO 143

:142
ECHO ����ɾ�����ע������Ժ�...
REG DELETE HKCR\*\shell\runas /F
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL
GOTO 143

:143
GOTO MAIN

:15
IPCONFIG /FLUSHDNS
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:16
IF NOT EXIST "%COMSPEC:~0,-7%MSHTA.EXE" (GOTO 161)
START /REALTIME "" MSHTA VBSCRIPT:CreateObject("Shell.Application").ToggleDesktop
SLEEP 1000
TASKKILL /IM MSHTA.EXE /F
GOTO MAIN

:161
ECHO ����ϵͳ��ʧϵͳ�ļ�mshta.exe���޷��������밴�������������塣
PAUSE>NUL
GOTO MAIN

:17
SET F=
ECHO ˵�����˴���ֹ���н���ָֹ���������Դ���������С�
ECHO ������ȫ�ļ���������ʹ�����Ż��ļ���ק���ˣ���
SET /P F=
ECHO   Y=��ֹ����
ECHO   N=�����ָֹ����������
ECHO   A=���������ֹ������
ECHO   R=��������ȫ�ļ���
ECHO   C=���������
ECHO ��ѡ��һ���Լ�����
CHOICE /C YNARC
IF %ERRORLEVEL%==4 (CLS&GOTO 17)
IF %ERRORLEVEL%==5 (GOTO MAIN)
CLS
ECHO ����ִ�в��������Ժ�...
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
CHOICE /C RC /M "R=����ִ�в�����C=���������" 
IF %ERRORLEVEL%==2 (GOTO MAIN)
CLS
GOTO 17

:18
SET F=
IF NOT EXIST "%COMSPEC:~0,-7%MSHTA.EXE" (GOTO 184)
MSHTA VBSCRIPT:MSGBOX("��ӻ����ӳ��ٳ���һ�����գ������˳��ڶ��������������ɱ���������",64,"�๦���޸���")(WINDOW.CLOSE)
GOTO 185

:181
SET TF=NUL
ECHO ������Ŀ�������У�ֱ�ӻس���Ϊ��ֹ���У���
SET /P "TF="
CLS
ECHO �������ӳ��ٳ֣����Ժ�...
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%F%" /V debugger /T REG_SZ /D %TF% /F
GOTO 183

:182
ECHO �������ӳ��ٳ֣����Ժ�...
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%F%" /F
GOTO 183

:183
SET F=
SET TF=
ECHO ִ�в�����ϣ���ѡ��һ���Լ�����
CHOICE /C RC /M "R=����ִ�в�����C=���������" 
IF %ERRORLEVEL%==2 (GOTO MAIN)
CLS
GOTO 185

:184
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO ע�⣺����ϵͳȱ���ļ�mshta.exe�����Ժ��޲���
ECHO ��ӻ����ӳ��ٳ���һ�����գ������˳��ڶ��������������ɱ���������
PAUSE
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO 185

:185
CLS
ECHO �����뱻�ٳ��ļ���ȫ�ļ���������ʹ�����Ż��ļ���ק���ˣ���
SET /P F=
ECHO   Y=��ӽٳ�
ECHO   N=����ٳ�
ECHO   R=��������ȫ�ļ���
ECHO   C=���������
ECHO ��ѡ��һ���Լ�����
CHOICE /C YNRC
IF %ERRORLEVEL%==3 (GOTO 185)
IF %ERRORLEVEL%==4 (GOTO MAIN)
CLS
GOTO 18%ERRORLEVEL%

:19
SET H=https://www.baidu.com
ECHO ˵���������ɱ������Դ�����ʮ�����У���������Ҫ�ȹر�ɱ������������������ֱ��ʹ��ɱ��������а󶨡�
ECHO �����·�������ַ��ֱ�ӻس��򽫡��ٶȡ���ΪIE��ҳ��ڶ���ʼҳ��
SET /P H=
ECHO ����ִ�в��������Ժ�...
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Start Page" /D "%H%" /F
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Default_Page_URL" /D "%H%" /F
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Secondary Start Pages" /D "%H%" /F
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:20
IF EXIST "%~DP0sleep.exe" (ECHO �Ѵ���sleep.exe�������޸����밴�������������塣&PAUSE>NUL&GOTO MAIN)
IF EXIST "%COMSPEC:~0,-7%sleep.exe" (GOTO 202)
ECHO ���ڳ����޸�sleep.exe�����Ժ�...
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
ECHO �޸��ɹ�������
PAUSE
GOTO MAIN

:201
CLS
ECHO �޸�ʧ�ܣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:202
XCOPY "%COMSPEC:~0,-7%sleep.exe" "%~DP0" /H /V /Y
ATTRIB +A +H +R +S "%~DP0sleep.exe"
IF EXIST "%~DP0sleep.exe" (ECHO �޸��ɹ�������)  ELSE (ECHO �޸�ʧ�ܡ�)
PAUSE
GOTO MAIN

:21
CLS
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer /V link /T REG_BINARY /D "00000000" /F
ECHO ����������ϵͳ����Ч���밴�������������塣
PAUSE>NUL
GOTO MAIN

:22
ECHO �뽫�ļ���ק���·�������ȫ·����
SET /P WP=
WALLCMD %WP%
MSHTA VBSCRIPT:MSGBOX("�������!�����ȷ������������塣",0,"�๦���޸���")(WINDOW.CLOSE)
GOTO MAIN

:23
ECHO �򿪻�ر��������½���Ϣ��
CHOICE /C YNC /M "Y=�򿪣�N=�رգ�C=ȡ��"
IF %ERRORLEVEL%==3 (GOTO MAIN)
IF %ERRORLEVEL%==2 (SET OP=0) ELSE (SET OP=1)
CLS
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V PaintDesktopVersion /T REG_DWORD /D %OP% /F
SET OP=
ECHO ����������Դ�����������Ժ�...
TASKKILL /IM EXPLORER.EXE /F
START /REALTIME "" EXPLORER
PAUSE
GOTO MAIN

:24
ECHO �򿪻�ر���������ʾ���룿
CHOICE /C YNC /M "Y=�򿪣�N=�رգ�C=ȡ��"
IF %ERRORLEVEL%==3 (GOTO MAIN)
IF %ERRORLEVEL%==1 (REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSecondsInSystemClock /D 1 /T REG_DWORD /F) ELSE (REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSecondsInSystemClock /F)
ECHO ����������Դ�����������Ժ�...
TASKKILL /IM EXPLORER.EXE /F
START /REALTIME "" EXPLORER
PAUSE
GOTO MAIN

:25
ECHO �ָ���ɾ����Shift��+�Ҽ����ĴӴ˴�����������ʾ����
CHOICE /C YNC /M "Y=�ָ���N=ɾ����C=ȡ��"
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