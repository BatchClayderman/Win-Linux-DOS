@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Win DOS��һ�����������
CLS
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (ECHO ϵͳ�ļ�mshta.exe��ʧ���޷������������밴������˳���&PAUSE>NUL&EXIT)
IF "%1"=="/YES" (ECHO �ɹ���>"%TEMP%\WinDOSSetup.tmp"&SET X=1&GOTO CHECK)
IF NOT EXIST "%COMSPEC:~0,-7%findstr.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�findstr.exe���ⶪʧ���޷�����������",16,"Win DOS��һ�����������"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%reg.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�reg.exe���ⶪʧ���޷�����������",16,"Win DOS��һ�����������"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%wbem\wmic.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�wmic.exe���ⶪʧ���޷�����������",16,"Win DOS��һ�����������"^)(WINDOW.CLOSE^)&EXIT)
IF /I "%SYSTEMDRIVE%"=="X:" (TITLE Win DOS��һ�������������PEģʽ��&CLS&GOTO CHECK)
VER|FIND /I "XP">NUL
SET X=%ERRORLEVEL%
IF %X%==0 (GOTO CHECK)
IF /I EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp")
IF /I EXIST "%TEMP%\WinDOSSetup.tmp" (CLS&ECHO ɾ������ʧ�ܣ�&GOTO 0)
ECHO ������Ȩ�����Ժ�...
MSHTA VBSCRIPT:CREATEOBJECT("shell.application").shellexecute("%~S0","/YES","","RUNAS",1)(WINDOW.CLOSE)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SLEEP %%I00)
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp"&EXIT)

:0
ECHO ��Ȩ�ȴ���ʱ���Ѿ�ʧ�ܣ��Ƿ��Լ����ڷǹ���ԱȨ���¼���������
ECHO ���棺ȱ������ԱȨ�ޣ�������Ľ���������ƫ�
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
TITLE Win DOS��һ����������������棺�ǹ���Աģʽ��

:CHECK
DEL /A /F /Q "%~DP0V4.VBS"
CLS
ECHO ���ڼ��ϵͳ�ܱ���״̬�����Ժ�...
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
IF EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (SET T=��) ELSE (SET T=δ)
SET T=%T%ʹ�ñ������ϵͳ������
IF %X%==0 (SET U=��֧��&GOTO MAIN) 
FOR /F "TOKENS=3" %%I IN ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V EnableLUA^|FIND /I "REG_DWORD"') DO (IF "%%I"=="0x0" (SET U=��) ELSE (GOTO 01))
GOTO MAIN

:01
FOR /F "TOKENS=3" %%I IN ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V PromptOnSecureDesktop^|FIND /I "REG_DWORD"') DO (IF "%%I"=="0x0" (SET U=��) ELSE (GOTO 02))
GOTO MAIN

:02
FOR /F "TOKENS=3" %%I IN ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V ConsentPromptBehaviorAdmin^|FIND /I "REG_DWORD"') DO (SET U=%%I)
IF "%U%"=="0x5" (SET U=��&GOTO MAIN)
IF "%U%"=="0x2" (SET U=��) ELSE (SET U=δ֪)

:MAIN
IF %P%==0 (SET A=δ�����κ�֪��������ϵͳ�����ټ������)
IF %P%==1 (SET A=��֪��ɱ���������)
IF %P%==2 (SET A=��������������)
IF %P%==3 (SET A=������������֪��ɱ���������)
IF %P%==4 (SET A=��˫��������������)
IF %P%==5 (SET A=��˫������������֪��ɱ���������)
IF %X%==0 (FOR /F "TOKENS=3" %%I IN ('VER') DO (TITLE Windows %%Iϵͳ����״̬��ϵͳ��%A%����ǰUAC״̬��%U%��%T%)) ELSE (FOR /F "TOKENS=4" %%I IN ('VER') DO (TITLE ^[Windows %%Iϵͳ����״̬��ϵͳ��%A%����ǰUAC״̬��%U%��%T%))
CLS
ECHO ��һ����������������
ECHO   0=�˳����
ECHO   1=У�����
ECHO   2=����ʾ��
ECHO   3=�����Ż�
ECHO   4=�ֶ���ɱ
ECHO   5=�Զ�ɨ��
ECHO   6=��ȫ״��
ECHO   7=�������
ECHO   8=��������
ECHO   9=�������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 1234567890
CLS
IF %ERRORLEVEL%==1 (GOTO CHECK)
IF %ERRORLEVEL%==3 (START /REALTIME SPEEDUP&START /REALTIME CLEAN&GOTO MAIN)
IF %ERRORLEVEL%==8 (START /REALTIME AntiVirus.bat&GOTO MAIN)
IF %ERRORLEVEL%==10 EXIT
GOTO %ERRORLEVEL%0

:20
ECHO ����ʾ�����
ECHO   0=���ص�һ����������������
ECHO   1=�겡�������̴���������
ECHO   2=�����ļ��з��ģ��ļ�����������
ECHO   3=�ļ����ܲ�����ϵͳ����������
ECHO   4=�����ļ����ģ���Ϊ���ص��ļ�����������
ECHO   5=����ģ�ⲡ������һ���Ĳ�����
ECHO ��ѡ��һ���Լ�����
CHOICE /C 123450
CLS
IF %ERRORLEVEL%==6 (GOTO MAIN)
GOTO 2%ERRORLEVEL%

:21
ECHO ˵����Virus1����������ע�����ɽ�����˲�����������ļ����ݶ�ʧ��
ECHO �Ƿ񱬷��ò�����
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO 20)
START /REALTIME /MIN Virus1.bat
CLS
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET TT=%%I)
ECHO Virus1���������ѱ�����������%TT:~0,1%����Զ��˳���
SLEEP %TT%000
EXIT

:22
ECHO ˵����������ʹ���ļ���������鲡�����棬�˲�������������ݶ�ʧ��
ECHO �Ƿ񱬷��ò�����
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO 20)
START /REALTIME /MIN Virus2.bat
CLS
ECHO Virus2���������ѱ������밴�������������塣
PAUSE>NUL
GOTO MAIN

:23
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO �����������ò�����������ɵ�һ��������ʧ������˾�Ų�����
ECHO �ٴξ��棺���ޱ��ݻ�ԭ���ߣ��˲����������������Իָ���
ECHO ����˵�����������ƻ�����δ�ձ������ļ��������󱾳��򽫻��˳����Ƿ������
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO 20)
CLS
START /REALTIME /MIN Virus3.bat
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET TT=%%I)
ECHO Virus1���������ѱ�����������%TT%����Զ��˳���
SLEEP %TT%000
EXIT

:24
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO ˵����������ʹ���ļ���������鲡�����棬�˲�������������ݶ�ʧ��
ECHO ע�⣺�����Virus2���ԣ��˲���������������
ECHO �Ƿ񱬷��ò�����
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO 20)
START /REALTIME /MIN Virus4.bat
CLS
ECHO Virus4���������ѱ������밴�������������塣
PAUSE>NUL
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO MAIN

:25
ECHO �밴����������˲�����������ע��ϵͳ���ɡ�
PAUSE>NUL
ECHO Set objShell=CreateObject("Wscript.Shell")>"%~DP0V5.VBS"
ECHO DO>>"%~DP0V5.VBS"
ECHO objShell.SendKeys "{F5}">>"%~DP0V5.VBS"
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO WSCRIPT.SLEEP %%I0 1>>"%~DP0V5.VBS")
ECHO LOOP>>"%~DP0V5.VBS"
IF EXIST "%~DP0V5.VBS" (GOTO 26)
ECHO ����ʧ�ܣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:26
START /I "" "%~DP0V5.VBS"
START /I /MAX "" NOTEPAD.EXE
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SLEEP %%I000)
DEL /A /F /Q "%~DP0V5.VBS"
EXIT

:40
ECHO �����Ҫ���ѽϳ���ʱ�䣬�Ƿ������
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
TITLE ����׼�����������Ժ�...
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
ECHO �޷���ȡϵͳ������·�����ѽ��ļ����浽��ϵͳ�̵ĸ�Ŀ¼�¡�
ECHO ���������ϵͳ���밴�������������塣
PAUSE>NUL
GOTO MAIN

:44
XCOPY "%COMSPEC:~0,-7%AntiVirus.txt" "%DESKTOPPATH%\" /A /H /R /V
ATTRIB +A -H +R -S "%DESKTOPPATH%\AntiVirus.txt"
IF /I NOT EXIST "%DESKTOPPATH%\AntiVirus.txt" (GOTO 45)
MSHTA VBSCRIPT:MSGBOX("�����ɹ��������ȷ�������������",64,"Win DOS��һ�����������")(WINDOW.CLOSE)
GOTO MAIN

:45
MSHTA VBSCRIPT:MSGBOX("����ʧ�ܣ�",16,"Win DOS��һ�����������")(WINDOW.CLOSE)
ECHO �Ƿ����ԣ�
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO 41) ELSE (GOTO MAIN)

:46
ECHO ԭ����ļ��Ѵ��ڣ��Ƿ񸲸ǣ�
ECHO 0=ȡ����� 1=���ļ��ƶ���%SYSTEMDRIVE%\�ټ�����ע���ļ���ϵͳ���صģ�
ECHO 2=ֱ�Ӹ��� 3=��λ���ļ���������Ҫ���ֶ���ʾϵͳ���ص��ļ���
CHOICE /C 1230
IF %ERRORLEVEL%==1 (GOTO 48)
IF %ERRORLEVEL%==2 (GOTO 49)
IF %ERRORLEVEL%==3 (EXPLORER,/E,/SELECT,"%COMSPEC:~0,-7%AntiVirus.txt")
GOTO MAIN

:47
CLS
ECHO Win DOS��һ������������ֶ���ɱ��챨��>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("�޷�������챨���ļ��������ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO CHECK)
ATTRIB +A +H +S -R "%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS��һ������������ֶ���ɱ-���ڻ�ȡϵͳʱ��
FOR /F "TOKENS=*" %%I IN ('VER') DO (ECHO ��ǰϵͳ������%%I>>"%COMSPEC:~0,-7%AntiVirus.txt")
IF %X%==0 (FOR /F "TOKENS=3" %%I IN ('VER') DO (TITLE Windows %%Iϵͳ����״̬��ϵͳ��%A%����ǰUAC״̬��%U%��%T%)) ELSE (FOR /F "TOKENS=4" %%I IN ('VER') DO (TITLE ^[Windows %%Iϵͳ����״̬��ϵͳ��%A%����ǰUAC״̬��%U%��%T%))>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO ��쿪ʼϵͳʱ�䣺%DATE%%TIME%>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS��һ������������ֶ���ɱ-�������ɽ�����Ϣ
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO ��ǰ���������Ϣ��>>"%COMSPEC:~0,-7%AntiVirus.txt"
TASKLIST>>"%COMSPEC:~0,-7%AntiVirus.txt"
TASKLIST /SVC>>"%COMSPEC:~0,-7%AntiVirus.txt"
TASKLIST /M>>"%COMSPEC:~0,-7%AntiVirus.txt"
TASKLIST /V>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("�޷�������챨�棬��ǰ���ȣ�������Ϣ�������ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS��һ������������ֶ���ɱ-���������ļ���Ϣ
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO ��ǰ�ļ���Ϣ��>>"%COMSPEC:~0,-7%AntiVirus.txt"
For /F "Skip=1" %%I IN ('WMIC LOGICALDISK GET NAME') DO (DIR /A /C /Q /S %%I&ATTRIB %%I\* /D /S)>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("�޷�������챨�棬��ǰ���ȣ��ļ���Ϣ�������ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS��һ������������ֶ���ɱ-��������Ŀ¼��Ϣ
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO ��ǰĿ¼��Ϣ��>>"%COMSPEC:~0,-7%AntiVirus.txt"
For /F "Skip=1" %%I IN ('WMIC LOGICALDISK GET NAME') DO (TREE %%I\ /F)>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("�޷�������챨�棬��ǰ���ȣ�Ŀ¼��Ϣ�������ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS��һ������������ֶ���ɱ-�������ɷ�����Ϣ
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO ������Ϣ��>>"%COMSPEC:~0,-7%AntiVirus.txt"
SC query state= all>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("�޷�������챨�棬��ǰ���ȣ�������Ϣ�������ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS��һ������������ֶ���ɱ-��������ע�������
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO ע������ݣ�>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKCR /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKCU /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKLM /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKU /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
REG QUERY HKCC /S>>"%COMSPEC:~0,-7%AntiVirus.txt"
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS��һ������������ֶ���ɱ-����д��ϵͳ����
ECHO ϵͳ������>>"%COMSPEC:~0,-7%AntiVirus.txt"
SET>>"%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("�޷�������챨�棬��ǰ���ȣ����������������ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
ECHO.>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS��һ������������ֶ���ɱ-��������ϵͳ��Ϣ
ECHO ϵͳ��Ϣ��>>"%COMSPEC:~0,-7%AntiVirus.txt"
SYSTEMINFO>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS��һ������������ֶ���ɱ-��������������Ϣ
ECHO ������Ϣ��>>"%COMSPEC:~0,-7%AntiVirus.txt"
IPCONFIG>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS��һ������������ֶ���ɱ-���������豸��Ϣ
ECHO �豸��Ϣ��>>"%COMSPEC:~0,-7%AntiVirus.txt"
MODE>>"%COMSPEC:~0,-7%AntiVirus.txt"
TITLE Win DOS��һ������������ֶ���ɱ-���ڻ�ȡϵͳʱ��
ECHO ������ϵͳʱ�䣺%DATE%%TIME%>>"%COMSPEC:~0,-7%AntiVirus.txt"
ATTRIB +A +H +R +S "%COMSPEC:~0,-7%AntiVirus.txt"
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("�޷�������챨�棬��ǰ���ȣ�ϵͳ��Ϣ�������ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^))
IF NOT EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (GOTO MAIN)
TITLE Win DOS��һ������������ֶ���ɱ-��챨���������
START /REALTIME NOTEPAD "%COMSPEC:~0,-7%AntiVirus.txt"
ECHO �Ƿ���Ҫ������챨�浽���棿
CHOICE /C YN
IF %ERRORLEVEL%==1 (CLS&GOTO 41)
GOTO MAIN

:48
XCOPY "%COMSPEC:~0,-7%AntiVirus.txt" %SYSTEMDRIVE%\ /H /R /V /Y
IF NOT EXIST %SYSTEMDRIVE%\AntiVirus.txt (MSHTA VBSCRIPT:MSGBOX("�޷��Ƴ�ԭ��챨�棬�����ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^)&GOTO MAIN)

:49
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G SYSTEM:F
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G ADMINISTRATORS:F
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G %USERNAME%:F
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G USERS:F
CACLS "%COMSPEC:~0,-7%AntiVirus.txt" /E /G EVERYONE:F
DEL /A /F /Q "%COMSPEC:~0,-7%AntiVirus.txt"
IF EXIST "%COMSPEC:~0,-7%AntiVirus.txt" (MSHTA VBSCRIPT:MSGBOX("�޷�ɾ��ԭ��챨�棬�����ȷ�������ط����������档",16,"��һ�����������"^)(WINDOW.CLOSE^)&GOTO MAIN)
GOTO 47

:50
ECHO ��ѡ��ɨ�跽ʽ��
ECHO   1=����ɨ��
ECHO   2=ȫ��ɨ��
ECHO   0=���������
CHOICE /C 120
GOTO 5%ERRORLEVEL%

:51
TITLE ���ڿ���ɨ�裬���Ժ�...
FOR /R %SYSTEMROOT%\ %%I IN (*) DO (@ECHO ����ɨ��ϵͳ�ؼ��ļ���"%%I"��)
TITLE ����ɨ��-ɨ�����
CLS
ECHO ����ɨ����ϣ��밴�������������塣
GOTO 53

:52
MSHTA VBSCRIPT:MSGBOX("������ʼȫ�̲�ɱ��������������ݺ󣬵����ȷ������",64,"��һ�����������")(WINDOW.CLOSE)
TITLE ����ȫ��ɨ�裬���Ժ�...
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
FOR /F "SKIP=1" %%A IN ('WMIC LOGICALDISK GET CAPTION') DO (CLS&ECHO ����׼��ɨ��%%A\*�����Ժ�...&FOR /F "DELIMS=" %%I IN ('DIR /A /B /S %%A') DO (ECHO ����ɨ�裺"%%I"))
ENDLOCAL
TITLE ȫ��ɨ��-ɨ�����
CLS
ECHO ȫ��ɨ����ϣ��밴�������������塣

:53
PAUSE>NUL
CLS
GOTO MAIN

:60
IF %X%==0 (FOR /F "TOKENS=3" %%I IN ('VER') DO (ECHO Windows %%Iϵͳ����״̬��ϵͳ��%A%����ǰUAC״̬��%U%��%T%)) ELSE (FOR /F "TOKENS=4" %%I IN ('VER') DO (ECHO ^[Windows %%Iϵͳ����״̬��ϵͳ��%A%����ǰUAC״̬��%U%��%T%))
ECHO ���������������塣
ECHO.
PAUSE>NUL
GOTO MAIN

:70
IF %P%==0 (GOTO 72)
ECHO �Ƿ���Ҫ̽���Ծ�е����棿
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO 71)
CLS
ECHO ϵͳUAC״̬��%U%��%T%
ECHO ϵͳ�����еķ����������У�
ECHO   Win DOS��һ����������ɱ����
IF %QH%==1 (ECHO   360ɱ������������)
IF %RTP%==1 (ECHO   ��Ѷ���Թܼ��������)
IF %K%==1 (ECHO   ��ɽ����30��������)
IF %RS%==1 (ECHO   ����ɱ������������)
IF %KB%==1 (ECHO   ����˹���������)
IF %WD%==1 (ECHO    Windows Defender)
IF %MP%==1 (ECHO   ΢��������������)
IF %HR%==1 (ECHO   ���ް�ȫ����)
ECHO �밴�������������塣
PAUSE>NUL
GOTO MAIN

:71
ECHO ���ڲ��ԣ����Ժ�...
TASKKILL /IM 360* /IM QQPC* /IM KXETRAY.EXE /IM RISING.EXE /IM MP* /F /T>NUL
TSKILL KXETRAY>NUL
CLS
ECHO ϵͳUAC״̬��%U%��%T%
ECHO ϵͳ�Ѱ�װ�ķ����������У�
ECHO   Win DOS��һ����������ɱ����
IF %QH%==1 (ECHO   360ɱ������������)
IF %RTP%==1 (ECHO   ��Ѷ���Թܼ��������)
IF %K%==1 (ECHO   ��ɽ����30��������)
IF %RS%==1 (ECHO   ����ɱ������������)
IF %KB%==1 (ECHO   ����˹���������)
IF %WD%==1 (ECHO    Windows Defender)
IF %MP%==1 (ECHO   ΢��������������)
IF %HR%==1 (ECHO   ���ް�ȫ����)
ECHO.
ECHO �������������洦�ڻ�Ծ״̬��
WMIC PROCESS GET NAME|FIND /I "ZhuDongFangYu.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   360ɱ������������)
WMIC PROCESS GET NAME|FIND /I "QQPCRTP.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   ��Ѷ���Թܼ��������)
WMIC PROCESS GET NAME|FIND /I "kxetray.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   ��ɽ����30��������)
WMIC PROCESS GET NAME|FIND /I "Rising.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   ����ɱ������������)
WMIC PROCESS GET NAME|FIND /I "avp.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   ����˹���������)
WMIC PROCESS GET NAME|FIND /I "WinDefender.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   Windows Defender)
WMIC PROCESS GET NAME|FIND /I "MPSVC2.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   ΢��������������)
WMIC PROCESS GET NAME|FIND /I "wsctrlsvc.exe">NUL
IF %ERRORLEVEL%==0 (ECHO   ���ް�ȫ����)
ECHO �밴�������������岢���¼��ϵͳ���ܱ���״̬��
PAUSE>NUL
GOTO CHECK

:72
ECHO ϵͳUAC״̬��%U%��%T%
ECHO ϵͳ�����еķ������������ҽ���Win DOS��һ����������ɱ���档
ECHO ���棺����ϵͳ�У�û�л�Ծ�ķ��������棬��ɱ���Ƚ��ᱻ���������
ECHO �밴�������������塣
PAUSE>NUL
GOTO MAIN

:90
ECHO ��������������
ECHO   0=���������
ECHO   1=��ɱsxs.exe
ECHO   2=����ӱ����򱬷��Ĳ���
IF %X%==0 (ECHO   3=Windows XPר�ö˿ڷ�ɱ����)
ECHO ��ѡ��һ���Լ�����
IF %X%==0 (CHOICE /C 1203) ELSE (CHOICE /C 120)
IF %ERRORLEVEL%==3 (GOTO MAIN)
CLS
GOTO 9%ERRORLEVEL%

:91
ECHO ���ڲ�ɱsxs.exe�����Ժ�...
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
ECHO sxs.exe��ɱ�ɹ��������밴�������������塣
PAUSE>NUL
GOTO MAIN

:92
TITLE �������Ļ�ϵĴ�����ʾ������ִ����������Ժ�...
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
ECHO �Ƿ����Virus2ר�������������Ҫ����һ��ʱ�䡣
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO 95)
GOTO 96

:93
CLS
ECHO �����޷���������ļ������������밲ȫģʽ���������в�ɱ��
ECHO ������ڰ�ȫģʽ�¿����˴��󣬽���������360ϵͳ��������в�ɱ��
PAUSE
GOTO MAIN

:94
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE һ����ɱľ��˿�
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
ECHO ��ֹLocation Service����ͷ�ֹ Dos ������������OK��
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
ECHO �ر�����Σ�ն˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20034" -f *+0:20034:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetBus Pro���ŵĶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1092" -f *+0:1092:TCP -n BLOCK -x>NUL
ECHO �ر����LoveGate���ŵĶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3996" -f *+0:3996:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4060" -f *+0:4060:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��RemoteAnything���ŵĶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4590" -f *+0:4590:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ICQTrojan���ŵĶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1080" -f *+0:1080:TCP -n BLOCK -x>NUL
ECHO ��ֹ���������ɨ�衭������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-113" -f *+0:113:TCP -n BLOCK -x>NUL
ECHO ��ֹAuthentication Service���񡭡�����OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-79" -f *+0:79:TCP -n BLOCK -x>NUL
ECHO ��ֹFingerɨ�衭������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-53" -f *+0:53:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53" -f *+0:53:TCP -n BLOCK -x>NUL
ECHO ��ֹ���򴫵ݣ�TCP������ƭDNS��UDP��������������ͨ�š�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-707" -f *+0:707:TCP -n BLOCK -x>NUL
ECHO �ر�nachi��没�������˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-808" -f *+0:808:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23" -f *+0:23:TCP -n BLOCK -x>NUL
ECHO �ر�Telnet ��ľ��Tiny Telnet Server�����˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-520" -f *+0:520:TCP -n BLOCK -x>NUL
ECHO �ر�Rip �˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����BackDoor��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO �ر������ڶ�2001��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Ripper��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Wincrash v2��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3389" -f *+0:3389:TCP -n BLOCK -x>NUL
ECHO �ر�Windows ��Զ�̹����նˣ�Զ�����棩�����˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4444" -f *+0:4444:TCP -n BLOCK -x>NUL
ECHO �ر�msblast������������˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4899" -f *+0:4899:TCP -n BLOCK -x>NUL
ECHO �ر�Զ�̿��������remote administrator)����˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5800" -f *+0:5800:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5900" -f *+0:5900:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8888" -f *+0:8888:TCP -n BLOCK -x>NUL
ECHO �ر�Զ�̿������VNC������Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6129" -f *+0:6129:TCP -n BLOCK -x>NUL
ECHO �ر�Dameware�����Ĭ�ϼ����˿ڣ��ɱ䣡����������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6267" -f *+0:6267:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Ů����Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-660" -f *+0:660:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��DeepThroat v1.0 - 3.1Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6671" -f *+0:6671:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��IndoctrinationĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6939" -f *+0:6939:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��PRIORITYĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����羫��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7511" -f *+0:7511:TCP -n BLOCK -x>NUL
ECHO �ر�ľ����������Ĭ�����Ӷ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7626" -f *+0:7626:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Ĭ�϶˿�(ע��ɱ䣡)��������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8011" -f *+0:8011:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WAY2.4Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9989" -f *+0:9989:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��InIkillerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-19191" -f *+0:19191:TCP -n BLOCK -x>NUL
ECHO �ر�ľ����ɫ����Ĭ�Ͽ��ŵ�telnet�˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1029" -f *+0:1029:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20168" -f *+0:20168:TCP -n BLOCK -x>NUL
ECHO �ر�lovegate ��������ŵ��������Ŷ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23444" -f *+0:23444:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����繫ţĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-27374" -f *+0:27374:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SUB7Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100" -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetSphereĬ�ϵķ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31337" -f *+0:31337:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BO2000Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-45576" -f *+0:45576:TCP -n BLOCK -x>NUL
ECHO �رմ�������Ŀ��ƶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SchwindlerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��TelecommandoĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31338" -f *+0:31338:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Back OrificeĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8102" -f *+0:8102:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��������͵Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2000" -f *+0:2000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ڶ�2000Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31339" -f *+0:31339:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetSpy DKĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ڶ�2001Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31666" -f *+0:31666:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BOWhackĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-34324" -f *+0:34324:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BigGluckĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����羫��3.0��netspy3.0Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40412" -f *+0:40412:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��The SpyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40421" -f *+0:40421:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters ParadiseĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8011" -f *+0:8011:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��wry����С�ӣ�����Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40422" -f *+0:40422:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters Paradise 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23444" -f *+0:23444:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����繫ţ��netbullĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40423" -f *+0:40423:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters Paradise 2.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23445" -f *+0:23445:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����繫ţ��netbullĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40426" -f *+0:40426:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters Paradise 3.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50505" -f *+0:50505:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sockets de TroieĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-27374" -f *+0:27374:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sub Seven 2.0+��77������ħ��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ForeĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53001" -f *+0:53001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Remote Windows ShutdownĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��TelecommandoĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-121" -f *+0:121:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BO jammerkillahVĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Satanz BackdoorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-65000" -f *+0:65000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��DevilĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SilencerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6400" -f *+0:6400:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��The tHingĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1600" -f *+0:1600:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Shivka-BurkaĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12346" -f *+0:12346:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetBus 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1807" -f *+0:1807:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SpySenderĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20034" -f *+0:20034:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetBus ProĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1981" -f *+0:1981:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ShockraveĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1243" -f *+0:1243:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SubSevenĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WebExĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100" -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetSphereĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1011" -f *+0:1011:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Doly TrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SilencerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1170" -f *+0:1170:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Psyber Stream ServerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20000" -f *+0:20000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��MilleniumĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1234" -f *+0:1234:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Ultors TrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-65000" -f *+0:65000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Devil 1.03Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��VooDoo DollĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1492" -f *+0:1492:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��FTP99CMPĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1170" -f *+0:1170:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Streaming Audio TrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BackDoorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30303" -f *+0:30303:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Socket23Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Trojan CowĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��GatecrasherĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��RipperĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��TelecommandoĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2115" -f *+0:2115:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BugsĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12076" -f *+0:12076:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��GjamerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2140" -f *+0:2140:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Deep ThroatĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4950" -f *+0:4950:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��IcqTrojenĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2140" -f *+0:2140:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��The InvasorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-16969" -f *+0:16969:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��PriotrityĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2801" -f *+0:2801:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Phineas PhuckerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��VodooĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30129" -f *+0:30129:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters ParadiseĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5742" -f *+0:5742:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WincrashĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3700" -f *+0:3700:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Portal of DoomĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Wincrash2Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4092" -f *+0:4092:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WinCrashĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1033" -f *+0:1033:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetspyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4590" -f *+0:4590:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ICQTrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1981" -f *+0:1981:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ShockRaveĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5000" -f *+0:5000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sockets de TroieĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Stealth SpyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5001" -f *+0:5001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sockets de Troie 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Pass RipperĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5321" -f *+0:5321:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��FirehotckerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Attack FTPĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5400" -f *+0:5400:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Blade RunnerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-21554" -f *+0:21554:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��GirlFriendĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5401" -f *+0:5401:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Blade Runner 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Fore SchwindlerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5402" -f *+0:5402:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Blade Runner 2.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-34324" -f *+0:34324:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Tiny Telnet ServerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5569" -f *+0:5569:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Robo-HackĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30999" -f *+0:30999:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��KuangĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6670" -f *+0:6670:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��DeepThroatĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11000" -f *+0:11000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Senna Spy TrojansĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6771" -f *+0:6771:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��DeepThroatĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23456" -f *+0:23456:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WhackJobĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��GateCrasherĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Phase0Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��PriorityĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5400" -f *+0:5400:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Blade RunnerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7000" -f *+0:7000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Remote GrabĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4950" -f *+0:4950:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��IcqTrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7300" -f *+0:7300:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9989" -f *+0:9989:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��InIkillerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7301" -f *+0:7301:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitor 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Portal Of DoomĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitor 2.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11223" -f *+0:11223:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Progenic TrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7307" -f *+0:7307:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitor 3.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-22222" -f *+0:22222:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Prosiak 0.47Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7308" -f *+0:7308:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitor 4.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53001" -f *+0:53001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Remote Windows ShutdownĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7789" -f *+0:7789:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ICKillerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5569" -f *+0:5569:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��RoboHackĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Portal of DoomĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -x>NUL
GPUPDATE>NUL
ECHO �������� IP ɸѡ������
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
ECHO IP ɸѡ�����óɹ���
ECHO ��׼��ɱִ����ϣ��Ƿ����ǿ����ɱ��
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SET TT=%%I)
ECHO %TT:~0,1%���޶������Զ�ִ��ǿ����ɱ��
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
ECHO �ر�����Σ�ն˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20034" -f *+0:20034:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetBus Pro���ŵĶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1092" -f *+0:1092:TCP -n BLOCK -x>NUL
ECHO �ر����LoveGate���ŵĶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3996" -f *+0:3996:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4060" -f *+0:4060:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��RemoteAnything���ŵĶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4590" -f *+0:4590:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ICQTrojan���ŵĶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1080" -f *+0:1080:TCP -n BLOCK -x>NUL
ECHO ��ֹ���������ɨ�衭������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-113" -f *+0:113:TCP -n BLOCK -x>NUL
ECHO ��ֹAuthentication Service���񡭡�����OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-79" -f *+0:79:TCP -n BLOCK -x>NUL
ECHO ��ֹFingerɨ�衭������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block UDP-53" -f *+0:53:UDP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53" -f *+0:53:TCP -n BLOCK -x>NUL
ECHO ��ֹ���򴫵ݣ�TCP������ƭDNS��UDP��������������ͨ�š�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-707" -f *+0:707:TCP -n BLOCK -x>NUL
ECHO �ر�nachi��没�������˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-808" -f *+0:808:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23" -f *+0:23:TCP -n BLOCK -x>NUL
ECHO �ر�Telnet ��ľ��Tiny Telnet Server�����˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-520" -f *+0:520:TCP -n BLOCK -x>NUL
ECHO �ر�Rip �˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����BackDoor��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO �ر������ڶ�2001��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Ripper��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Wincrash v2��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3389" -f *+0:3389:TCP -n BLOCK -x>NUL
ECHO �ر�Windows ��Զ�̹����նˣ�Զ�����棩�����˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4444" -f *+0:4444:TCP -n BLOCK -x>NUL
ECHO �ر�msblast������������˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4899" -f *+0:4899:TCP -n BLOCK -x>NUL
ECHO �ر�Զ�̿��������remote administrator)����˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5800" -f *+0:5800:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5900" -f *+0:5900:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8888" -f *+0:8888:TCP -n BLOCK -x>NUL
ECHO �ر�Զ�̿������VNC������Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6129" -f *+0:6129:TCP -n BLOCK -x>NUL
ECHO �ر�Dameware�����Ĭ�ϼ����˿ڣ��ɱ䣡����������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6267" -f *+0:6267:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Ů����Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-660" -f *+0:660:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��DeepThroat v1.0 - 3.1Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6671" -f *+0:6671:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��IndoctrinationĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6939" -f *+0:6939:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��PRIORITYĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����羫��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7511" -f *+0:7511:TCP -n BLOCK -x>NUL
ECHO �ر�ľ����������Ĭ�����Ӷ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7626" -f *+0:7626:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Ĭ�϶˿�(ע��ɱ䣡)��������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8011" -f *+0:8011:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WAY2.4Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9989" -f *+0:9989:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��InIkillerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-19191" -f *+0:19191:TCP -n BLOCK -x>NUL
ECHO �ر�ľ����ɫ����Ĭ�Ͽ��ŵ�telnet�˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1029" -f *+0:1029:TCP -n BLOCK -x>NUL
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20168" -f *+0:20168:TCP -n BLOCK -x>NUL
ECHO �ر�lovegate ��������ŵ��������Ŷ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23444" -f *+0:23444:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����繫ţĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-27374" -f *+0:27374:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SUB7Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100" -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetSphereĬ�ϵķ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31337" -f *+0:31337:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BO2000Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-45576" -f *+0:45576:TCP -n BLOCK -x>NUL
ECHO �رմ�������Ŀ��ƶ˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SchwindlerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��TelecommandoĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31338" -f *+0:31338:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Back OrificeĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8102" -f *+0:8102:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��������͵Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2000" -f *+0:2000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ڶ�2000Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31339" -f *+0:31339:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetSpy DKĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ڶ�2001Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-31666" -f *+0:31666:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BOWhackĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-34324" -f *+0:34324:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BigGluckĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����羫��3.0��netspy3.0Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40412" -f *+0:40412:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��The SpyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40421" -f *+0:40421:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters ParadiseĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8011" -f *+0:8011:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��wry����С�ӣ�����Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40422" -f *+0:40422:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters Paradise 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23444" -f *+0:23444:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����繫ţ��netbullĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40423" -f *+0:40423:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters Paradise 2.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23445" -f *+0:23445:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����繫ţ��netbullĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40426" -f *+0:40426:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters Paradise 3.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50505" -f *+0:50505:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sockets de TroieĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-27374" -f *+0:27374:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sub Seven 2.0+��77������ħ��Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ForeĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53001" -f *+0:53001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Remote Windows ShutdownĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��TelecommandoĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-121" -f *+0:121:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BO jammerkillahVĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Satanz BackdoorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-65000" -f *+0:65000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��DevilĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SilencerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6400" -f *+0:6400:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��The tHingĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1600" -f *+0:1600:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Shivka-BurkaĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12346" -f *+0:12346:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetBus 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1807" -f *+0:1807:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SpySenderĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20034" -f *+0:20034:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetBus ProĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1981" -f *+0:1981:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ShockraveĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1243" -f *+0:1243:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SubSevenĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WebExĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100" -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetSphereĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1011" -f *+0:1011:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Doly TrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SilencerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1170" -f *+0:1170:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Psyber Stream ServerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20000" -f *+0:20000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��MilleniumĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1234" -f *+0:1234:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Ultors TrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-65000" -f *+0:65000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Devil 1.03Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��VooDoo DollĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1492" -f *+0:1492:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��FTP99CMPĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1170" -f *+0:1170:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Streaming Audio TrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BackDoorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30303" -f *+0:30303:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Socket23Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2001" -f *+0:2001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Trojan CowĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��GatecrasherĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��RipperĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-61466" -f *+0:61466:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��TelecommandoĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2115" -f *+0:2115:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BugsĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12076" -f *+0:12076:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��GjamerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2140" -f *+0:2140:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Deep ThroatĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4950" -f *+0:4950:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��IcqTrojenĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2140" -f *+0:2140:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��The InvasorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-16969" -f *+0:16969:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��PriotrityĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2801" -f *+0:2801:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Phineas PhuckerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��VodooĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30129" -f *+0:30129:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters ParadiseĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5742" -f *+0:5742:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WincrashĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-3700" -f *+0:3700:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Portal of DoomĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Wincrash2Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4092" -f *+0:4092:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WinCrashĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1033" -f *+0:1033:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetspyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4590" -f *+0:4590:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ICQTrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1981" -f *+0:1981:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ShockRaveĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5000" -f *+0:5000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sockets de TroieĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Stealth SpyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5001" -f *+0:5001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sockets de Troie 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Pass RipperĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5321" -f *+0:5321:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��FirehotckerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Attack FTPĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5400" -f *+0:5400:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Blade RunnerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-21554" -f *+0:21554:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��GirlFriendĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5401" -f *+0:5401:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Blade Runner 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50766" -f *+0:50766:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Fore SchwindlerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5402" -f *+0:5402:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Blade Runner 2.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-34324" -f *+0:34324:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Tiny Telnet ServerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5569" -f *+0:5569:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Robo-HackĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30999" -f *+0:30999:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��KuangĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6670" -f *+0:6670:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��DeepThroatĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11000" -f *+0:11000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Senna Spy TrojansĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6771" -f *+0:6771:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��DeepThroatĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23456" -f *+0:23456:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��WhackJobĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��GateCrasherĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Phase0Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6969" -f *+0:6969:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��PriorityĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5400" -f *+0:5400:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Blade RunnerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7000" -f *+0:7000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Remote GrabĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4950" -f *+0:4950:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��IcqTrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7300" -f *+0:7300:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9989" -f *+0:9989:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��InIkillerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7301" -f *+0:7301:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitor 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Portal Of DoomĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7306" -f *+0:7306:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitor 2.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11223" -f *+0:11223:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Progenic TrojanĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7307" -f *+0:7307:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitor 3.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1999" -f *+0:1999:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BackDoorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5800" -f *+0:5800:TCP -n BLOCK -x>NUL
ECHO �ر�Զ�̿������VNCĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5900" -f *+0:5900:TCP -n BLOCK -x>NUL
ECHO �ر�Զ�̿������VNCĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-22222" -f *+0:22222:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Prosiak 0.47Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7626" -f *+0:7626:TCP -n BLOCK -x>NUL
ECHO �ر�ľ�����Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-4444" -f *+0:4444:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��msblastĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7308" -f *+0:7308:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitor 4.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6129" -f *+0:6129:TCP -n BLOCK -x>NUL
ECHO �ر�Զ�̿��������dameware nt utilities)Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2023" -f *+0:2023:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��RipperĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1245" -f *+0:1245:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��VooDoo DollĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-121" -f *+0:121:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��BO jammerkillahVĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-456" -f *+0:456:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Hackers ParadiseĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-555" -f *+0:555:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Stealth SpyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-666" -f *+0:666:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Satanz BackdoorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1001" -f *+0:1001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��SilencerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-1033" -f *+0:1033:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetspyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7000" -f *+0:7000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Remote GrabĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7300 " -f *+0:7300:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetMonitorĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23456 " -f *+0:23456:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Ugly FTPĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-23456 " -f *+0:23456:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Ugly FTPĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-30100 " -f *+0:30100:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��NetSphereĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Portal of DoomĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9899" -f *+0:9899:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��iNi-KillerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-50505" -f *+0:50505:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Sockets de TroieĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-6939" -f *+0:6939:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��IndoctrinationĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-11000" -f *+0:11000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Senna SpyĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12223" -f *+0:12223:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Hack?99 KeyLoggerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-12362" -f *+0:12362:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Whack-a-mole 1.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-20000" -f *+0:20000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��MilleniumĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2583" -f *+0:2583:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Wincrash v2Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-53001" -f *+0:53001:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Remote Windows ShutdownĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-7789" -f *+0:7789:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ICKillerĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-40426" -f *+0:40426:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Masters Paradise 3.xĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-5569" -f *+0:5569:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��RoboHackĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-8000" -f *+0:8000:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��huigeziĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9872" -f *+0:9872:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��Portal of DoomĬ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2005" -f *+0:2005:TCP -n BLOCK -x>NUL
ECHO �ر�ľ��ڶ�2005Ĭ�Ϸ���˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-2000" -f *+0:2000:TCP -n BLOCK -x>NUL
ECHO �رղʺ���1.2Ĭ�϶˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -r "Block TCP-9999" -f *+0:9999:TCP -n BLOCK -x>NUL
ECHO �ر�huigeziӳ��Ĭ�϶˿ڡ�������OK��
IPSECCMD -w REG -p "HFUT_SECU" -x>NUL
ECHO ǿ����ɱ��ϣ��밴������������������塣
PAUSE>NUL
TITLE Win DOS��һ�����������
CLS
GOTO 90

:95
CLS
ECHO ˵������������п��ܻ��д��ļ��е��������밴�յ������ڱ���ִ�в�����
ECHO       ���������л�ѯ���Ƿ���ֹ�����������Win DOS����������ĸ��Ϊ�оݡ�
ECHO       �����ѡ��N������������Virus2���棬���򽫻��˳�����
PAUSE
FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (START /REALTIME /I /WAIT "���������ϵͳ�Ҳ���ָ�����ļ������豸δ�������Ĵ�����ʾ����ر��ҡ�" CMD /Q /C "FOR /L %%i IN (0,1,10000000000) DO (RD /Q /S %%I\%%i..\)")
SET FG=

:96
CLS
TITLE Win DOS��һ�����������
ECHO ��������ɹ����밴�������������塣
PAUSE>NUL
GOTO MAIN