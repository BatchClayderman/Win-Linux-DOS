@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE Win DOS��װ����
COLOR E
CLS
ECHO ��װ�������ڼ�鰲װ�����������Ժ�...
IF NOT EXIST "%COMSPEC:~0,-7%find.exe" (CLS&ECHO ϵͳ�ļ�Find.exe��ʧ��Win DOS�޷�����ʹ�ã��밴������˳���&PAUSE>NUL&EXIT)
IF /I "%SYSTEMDRIVE%"=="X:" (TITLE Win DOS��װ����PEģʽ��&CLS&GOTO 1)
IF NOT EXIST "%COMSPEC:~0,-7%mshta.exe" (ECHO ϵͳ�ļ�mshta.exe��ʧ���޷�������װ���밴������˳���&PAUSE>NUL&EXIT)
IF NOT EXIST "%COMSPEC:~0,-7%reg.exe" (MSHTA VBSCRIPT:MSGBOX("ϵͳ�ļ�reg.exe��ʧ���޷�������װ��",16,"Win DOS��װ����"^)(WINDOW.CLOSE^)&EXIT)
IF NOT EXIST "%~DP0choice.exe" (IF NOT EXIST "%COMSPEC:~0,-7%choice.exe" (IF EXIST "%~DP0Win DOS\choice.exe" (XCOPY /H /K /V /Y "%~DP0Win DOS\choice.exe" "%~DP0"&ATTRIB +A +H +R +S "%~DP0choice.exe") ELSE (MSHTA VBSCRIPT:MSGBOX("Win DOS��װ�����Ҳ���choice.exe���޷�������װ��",16,"Win DOS��װ����"^)(WINDOW.CLOSE^)&EXIT)))
FOR /F %%I IN ('DIR /A-D /B /W /S "%~DP0Win DOS"^|FIND /V /C ""') DO (IF NOT %%I==50 (MSHTA VBSCRIPT:MSGBOX("Win DOS��װ�����ļ����������޷�������װ��",16,"Win DOS��װ����"^)(WINDOW.CLOSE^)&EXIT))
IF "%1"=="/YES" (ECHO �ɹ���>"%TEMP%\WinDOSSetup.tmp"&GOTO 1)
VER|FIND /I "XP">NUL
IF %ERRORLEVEL%==0 (GOTO 1)
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp")
IF EXIST "%TEMP%\WinDOSSetup.tmp" (CLS&ECHO ɾ������ʧ�ܣ�&GOTO 0)
ECHO ������Ȩ�����Ժ�...
MSHTA VBSCRIPT:CREATEOBJECT("shell.application").shellexecute("%~S0","/YES","","RUNAS",1)(WINDOW.CLOSE)
"%~DP0Win DOS\SLEEP" 500
IF EXIST "%TEMP%\WinDOSSetup.tmp" (DEL /A /F /Q "%TEMP%\WinDOSSetup.tmp"&EXIT)

:0
CLS
ECHO ��Ȩ�ȴ���ʱ���Ѿ�ʧ�ܣ��Ƿ��Լ����ڷǹ���ԱȨ���¼�����װ��
ECHO ������������ڰ�װ��ʹ��Win DOS���������ڱ�ϵͳ��ע��Win DOS��
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
TITLE Win DOS��װ���򣨾��棺�ǹ���Աģʽ��
CLS

:1
COLOR E
SET MESS1=��װ�����ݷ�ʽ�ɹ���
SET MESS2=��װ��ʼ�˵���������ɹ���
SET MESS3=�ѳɹ�����ԭ���á�
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayName
SET SI=%ERRORLEVEL%
CLS
ECHO ��ӭʹ��Win DOS����л����Win DOS��һ��֧�֣�
ECHO �����ּ��Ϊ��������ܼ�����������ŵ������ṩһ������ƽ̨��
ECHO ʹ��˵����1���������ܽ��ܱ������е����������Ҫ������װ�������
ECHO           2�������������ǿ�Win DOS�Ŷӿ�����2017���Ѷ��ⷢ�У�
ECHO           3��2022�꣬�������Ը��������Ż��˸��������д��Linux�汾��
ECHO           4�������Բ鿴ÿ�������Դ���룬�����������и��ġ����У�
ECHO           5������Ҫ���д��븴�ƣ�������������漰����˾�����ݣ�
ECHO           6����Ҫж�ر�������뵽�����ѡ��0��������ж�س���
ECHO           7�����𽫰�װ����������в�ȷ�����Ĳ���ϵͳû�����⣻
ECHO           8�����ΪWindowsͨ�þ����棬ֻռ1MB�ڴ���������������
ECHO           9�����鰲װ������弤��Win DOS���鿴��ѧϰʹ�ð�����
ECHO           10���������ҵ��棬ף�����彡���������³ɡ��������⣡
ECHO.
ECHO ��ѡ��Win DOS��װĿ����̣�����ȡ����װ����ѡ��0����
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
ECHO �ɹ�ѡ���·���У�
ECHO   1="%D%\Win DOS"����װ�ڸ�Ŀ¼�£�
ECHO   2="%D%\Program Files\Win DOS"��32λ������װ��
ECHO   3="%D%\Program Files (x86)\Win DOS" ��64λ������װ��
ECHO   4="%COMSPEC:~0,-8%"����װ��ϵͳĿ¼�£�
ECHO ��ѡ��Win DOS��װĿ¼����������ѡ����̣���ѡ��0����
CHOICE /C 12340
IF %ERRORLEVEL%==1 (SET P=%D%)
IF %ERRORLEVEL%==2 (SET P=%D%\Program Files)
IF %ERRORLEVEL%==3 (SET Z=^"&SET P=%D%\Program Files (x86^))
IF %ERRORLEVEL%==4 (SET P=%COMSPEC:~0,-8%)
IF %ERRORLEVEL%==5 (GOTO 1)
IF "%P%\"=="%~DP0" (GOTO E)
ECHO ��װ���򽫻Ὣ���������ʽ��װ������Ϳ�ʼ�˵���
ECHO ������Բ���ϵͳ������Ϥ��������Ҫ����ɾ����
IF %SI%==0 (ECHO ��ע�⣺����ϵͳ���Ѱ�װWin DOS�����ý��ᱣ����)
ECHO Win DOS���ᰲװ��"%P%"��,�Ƿ�ȷ�ϣ�
CHOICE /C YNC /M "Y=������װ��N=������һ����C=�˳�����"
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
ECHO ���ڱ���ԭ���ò�ж��ԭ�ļ���������Ҫ�����ӣ����Ժ�...
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
ECHO ��װ�����ʼ����������Ҫ�����ӣ����Ժ�...
MD %P%
ECHO Win DOS�����ļ�����ɾ����>%PT%
IF /I NOT EXIST %PT% (
	ECHO ��ѡ���·�������ڻ��ѱ�����������������������ѡ��
	ECHO ����������Թ���Ա�Ự����������·��������Ч��
	PAUSE
	GOTO 1
)
DEL /A /F /Q /S %PA%
CLS
ECHO ���ڿ����ļ���������Ҫʮ�����ӣ����Ժ�...
XCOPY "%~DP0Win DOS\*" %PB% /H /K /R /V /Y>NUL
ATTRIB -A -H -R -S %PP%
ECHO ::%PP:~1,-1%>>%PP%
ATTRIB +A +H +R +S %PA% /D /S
ATTRIB +A +H +R +S %P% /D /S
IF %SI%==0 (DEL /A /F /Q %PC%)
IF %SI%==0 (IF EXIST %PC% (SET MESS3=ԭ���ñ���ʧ�ܣ��ѱ����á�))
IF %SI%==0 (ECHO %CFG%^%CG%>%PC%&ATTRIB +A +H +R +S %PC%)
FOR /F %%I IN ('DIR /A-D /B /W /S %P%^|FIND /V /C ""') DO (IF NOT %%I==50 (GOTO ERROR))
CLS
ECHO ����ע�������������Ҫ�����ӣ����Ժ�...
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayName /D "Win DOS" /F>NUL
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayIcon /D %PW% /F>NUL
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V Publisher /D "�ǿչ�˾Win DOS�Ŷ�" /F>NUL
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V UninstallString /D %PU% /F>NUL
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V InstallTime /D "%DATE% %TIME%" /F>NUL
CLS
ECHO ���ڰ�װ��ݷ�ʽ��������Ҫ�����ӣ����Ժ�...
DEL /A /F /Q "%SYSTEMDRIVE%\����Win DOS�����.bat"
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
DEL /A /F /Q "%DESKTOP%\����Win DOS�����.bat"
RD /Q /S "%MENU%\Win DOS"
ECHO START /REALTIME CMD.EXE /K %Z%%PW%%Z%>"%DESKTOP%\����Win DOS�����.bat"
ATTRIB +A -H +R +S "%DESKTOP%\����Win DOS�����.bat"
IF NOT EXIST "%DESKTOP%\����Win DOS�����.bat" (IF /I "%DESKTOP%"=="%SYSTEMDRIVE%" (SET MESS1=��װ����װ���̳��ִ��������ݷ�ʽδ�ܳɹ�������) ELSE (SET ��װ�����޷����������ݷ�ʽ��))
IF /I "%DESKTOP%"=="%SYSTEMDRIVE%" (SET MESS1=��װ�����޷���ȡϵͳ����·�����ѽ���ݷ�ʽ��װ����%SYSTEMDRIVE:~0,-1%�̡�)
MD "%MENU%\Win DOS\"
ECHO START /REALTIME CMD.EXE /K %Z%%PW%%Z%>"%MENU%\Win DOS\����Win DOS�����.bat"
ECHO START /REALTIME CMD.EXE /K %Z%%PS%%Z% /R>"%MENU%\Win DOS\����Win DOS����.bat"
XCOPY %PF% "%MENU%\Win DOS\" /C /H /R /V /Y>NUL
XCOPY %PV% "%MENU%\Win DOS\" /C /H /R /V /Y>NUL
XCOPY %PE% "%MENU%\Win DOS\" /C /H /R /V /Y>NUL
ATTRIB -A -H -R -S "%MENU%\Win DOS\*" /D /S>NUL
ATTRIB -A -H -R -S "%MENU%\Win DOS" /D /S>NUL
REN "%MENU%\Win DOS\FixCmd.reg" "�޸�Win DOS.reg">NUL
REN "%MENU%\Win DOS\ExpansionVerify.bat" �α�����.bat>NUL
ATTRIB +A -H +R +S "%MENU%\Win DOS\*" /D /S>NUL
ATTRIB +A -H +R +S "%MENU%\Win DOS" /D /S>NUL
ATTRIB +A +H +R +S "%MENU%\Win DOS\ExpansionEnsure.bat" /D /S>NUL
IF NOT EXIST "%MENU%\Win DOS\����Win DOS�����.bat" (GOTO L)
IF NOT EXIST "%MENU%\Win DOS\����Win DOS����.bat" (GOTO L)
IF NOT EXIST "%MENU%\Win DOS\�޸�Win DOS.reg" (GOTO L)
IF NOT EXIST "%MENU%\Win DOS\�α�����.bat" (GOTO L)
IF NOT EXIST "%MENU%\Win DOS\ExpansionEnsure.bat" (GOTO L)
IF "%MENU%"=="%SYSTEMDRIVE%" (SET MESS2=��װ�����޷���ȡϵͳ��ʼ�˵�·�����ѽ����������װ����%SYSTEMDRIVE:~0,-1%�̡�)

:6
CLS
ECHO %MESS1%
ECHO %MESS2%
IF %SI%==0 (ECHO %MESS3%)
ECHO ��װ�ɹ��������ڴˣ������ٴθ�л����Win DOS�Ĵ���֧�֣�
ECHO ף�����彡���������³ɡ��������⣡�밴������˳���װ����
PAUSE>NUL
EXIT

:E
CLS
ECHO ��ѡ��İ�װĿ¼�Ͱ�װ������Ŀ¼��ͬ���밴���������ѡ��
PAUSE>NUL
GOTO 1

:F
CLS
ECHO ������ʹ���Ѱ�װĿ¼�ļ���װ��������ʹ�ô����İ�װԴ��
ECHO �밴������˳�����
PAUSE>NUL
EXIT

:ERROR
COLOR CF
CLS
ECHO ����δ��ȷ��װ��������������ļ������Ժ�...
RD /D /S %P%
CLS
ECHO ��ȷ����װ������а�װȨ�޲����޷�����������ء�
ECHO ����ⲻ������һ�ο�����������������ϵͳ��
ECHO ����δ����ȷ��װ���Ƿ񷵻ص���װҳ�棿
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO 1)
CLS
MSHTA VBSCRIPT:MSGBOX("Win DOSδ��ȷ��װ�����Ժ���ɰ�װ��",16,"Win DOS��װ����")(WINDOW.CLOSE)
EXIT

:L
IF /I "%MENU%"=="%SYSTEMDRIVE%" (SET MESS2=��װ�����޷���װ��ʼ�˵���ݷ�ʽ��������Win DOS�����ע��Win DOS��&GOTO 6)
SET MESS2=��װ����װ���̳��ִ��󣬲��ֿ�ʼ�˵���ݷ�ʽδ�ܳɹ�������
GOTO 6

:PE
GOTO 1