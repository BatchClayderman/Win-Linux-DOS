@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE Win DOS��������

:MAIN
CLS
ECHO Win DOS�������������
ECHO   1=Win DOS��װ����У����
ECHO   2=�����ȡ������Win DOS
ECHO   3=ע���ע��Win DOS
ECHO   4=����Win DOS��ݷ�ʽ
ECHO   5=ж��Win DOS
ECHO   6=��Win DOS����Ŀ¼
ECHO   0=����Win DOS������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 1234560
IF %ERRORLEVEL%==7 (START /REALTIME WELCOME&EXIT)
CLS
GOTO %ERRORLEVEL%

:1
TITLE Win DOS��װ����У����
ECHO ����������棬���Ժ�...
DEL /A /F /Q /S "%~DP0Output.txt"
IF NOT EXIST "%COMSPEC:~0,-7%find.exe" (ECHO ϵͳ�ļ�Find.exe��ʧ��ͳ�Ʋ��������ء�&PAUSE&GOTO MAIN)
CLS
ECHO Ŀ¼λ�ã�"%CD%"��
ECHO �ļ�λ�ã�"%~DP0*"��
ECHO Ӧ���ļ�������50��
FOR /F %%I IN ('DIR /A-D /B /W /S "%~DP0"^|FIND /V /C ""') DO (@ECHO ʵ���ļ�������%%I��&IF %%I==50  (ECHO ������ȷ��Win DOS��δ�������⡣) ELSE (ECHO �����ļ���������ȷ��))
ECHO ��У׼��װ�ļ����ݣ����������������塣
PAUSE>NUL
TITLE Win DOS��������
GOTO MAIN

:2
ECHO ��ѡ��һ���Լ�����
CHOICE /C YNRC /M "Y=���N=ȡ�����R=��ȼ��C=��������塣"
CLS
IF %ERRORLEVEL%==4 (GOTO MAIN)
IF %ERRORLEVEL%==3 (SET R=1) ELSE (SET R=0)
IF %ERRORLEVEL%==3 (GOTO 21)
GOTO 2%ERRORLEVEL%

:21
ECHO ���ڼ���Win DOS�����Ժ�...
XCOPY "%~DP0*.exe" "%COMSPEC:~0,-7%" /H /K /R /V
XCOPY "%~DP0systemrun.bat" "%COMSPEC:~0,-7%" /H /K /R /V /Y
XCOPY "%~DP0SysInfoMate.bat" "%COMSPEC:~0,-7%" /H /K /R /V /Y
XCOPY "%~DP0SetFile.bat" "%COMSPEC:~0,-7%" /H /K /R /V /Y
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%systemrun.bat"
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%SysInfoMate.bat"
ATTRIB +A -H +R +S "%COMSPEC:~0,-7%SetFile.bat"
IF %R%==0 (GOTO 23)
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (
	REG ADD "HKCR\Folder\shell\cmd" /VE /D "�Ӵ˴�����������ʾ��" /F
	REG ADD "HKCR\Folder\shell\cmd\command" /VE /D "%COMSPEC% /K COLOR %%I&CD /D %%1" /F
	REG ADD "HKCR\*\shell\cmd" /VE /D "�Ӵ˴�����������ʾ��" /F
	REG ADD "HKCR\*\shell\cmd\command" /VE /D "%COMSPEC% /K COLOR %%I&CD /D %%1" /F
)
REG ADD HKCR\*\shell\secret /VE /T Reg_SZ /D ���ܶ������� /F
REG ADD HKCR\*\shell\secret\command /VE /T Reg_SZ /D "SetFile.bat /secret \"%%1\"" /F
REG ADD HKCR\*\shell\secret /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\set /VE /T Reg_SZ /D ȫѡ�ļ����� /F
REG ADD HKCR\*\shell\set\command /VE /T Reg_SZ /D "SetFile.bat /set \"%%1\"" /F
REG ADD HKCR\*\shell\set /V NoWorkingDirectory /D "" /F
REG ADD HKCR\*\shell\show /VE /T Reg_SZ /D ȥ�������ļ����� /F
REG ADD HKCR\*\shell\show\command /VE /T Reg_SZ /D "SetFile.bat /show \"%%1\"" /F
REG ADD HKCR\*\shell\show /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\secret /VE /T Reg_SZ /D ���ܶ������� /F
REG ADD HKCR\Folder\shell\secret\command /VE /T Reg_SZ /D "SetFile.bat /secret \"%%1\"" /F
REG ADD HKCR\Folder\shell\secret /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\set /VE /T Reg_SZ /D ȫѡ���ļ����� /F
REG ADD HKCR\Folder\shell\set\command /VE /T Reg_SZ /D "SetFile.bat /set \"%%1\"" /F
REG ADD HKCR\Folder\shell\set /V NoWorkingDirectory /D "" /F
REG ADD HKCR\Folder\shell\show /VE /T Reg_SZ /D ȥ���������ļ����� /F
REG ADD HKCR\Folder\shell\show\command /VE /T Reg_SZ /D "SetFile.bat /show \"%%1\"" /F
REG ADD HKCR\Folder\shell\show /V NoWorkingDirectory /D "" /F
GOTO 23

:22
ECHO ����ȡ��Win DOS����״̬�����Ժ�...
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
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:3
FOR /F %%I IN ('DIR /A-D /B /W /S "%~DP0"^|FIND /V /C ""') DO (IF NOT %%I==50 (MSHTA VBSCRIPT:MSGBOX("Win DOSδ��ȷ��װ���޷�ע��Win DOS��������ɰ�װ�ٽ���ע�ᡣ",16,"%T%"^)(WINDOW.CLOSE^)&GOTO MAIN))
ECHO ע���뷴ע��ѡ��
ECHO   1=����ע�ᣨ������д��װ�����Լ��ϴ�����ʱ�䣩
ECHO   2=��ע�ᣨ�������ע����Ϣ��
ECHO   3=�ض���ע�ᣨ�����û����ݣ�
ECHO   0=���������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 1230
IF %ERRORLEVEL%==4 (GOTO MAIN)
CLS
GOTO 3%ERRORLEVEL%

:31
CLS
ECHO ��������ע��Win DOS�����Ժ�...
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayName /D "Win DOS" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V DisplayIcon /D "%~DP0welcome.bat" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V Publisher /D "�ǿչ�˾Win DOS�Ŷ�" /F
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
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V Publisher /D "�ǿչ�˾Win DOS�Ŷ�" /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Win DOS" /V UninstallString /D "%~DP0Uninstall.bat" /F
PAUSE
GOTO MAIN

:4
SET Z="
SET "P=%~DP0"
SET "P=%P:~0,-9%"
SET MESS1=��װ�����ݷ�ʽ�ɹ���
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
ECHO ���ڰ�װ��ݷ�ʽ��������Ҫ�����ӣ����Ժ�...
DEL /A /F /Q "%SYSTEMDRIVE%\����Win DOS�����.bat"
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
IF NOT EXIST "%MENU%\Win DOS\����Win DOS�����.bat" (GOTO 43)
IF NOT EXIST "%MENU%\Win DOS\����Win DOS����.bat" (GOTO 43)
IF NOT EXIST "%MENU%\Win DOS\�޸�Win DOS.reg" (GOTO 43)
IF NOT EXIST "%MENU%\Win DOS\�α�����.bat" (GOTO 43)
IF NOT EXIST "%MENU%\Win DOS\ExpansionEnsure.bat" (GOTO 43)
IF "%MENU%"=="%SYSTEMDRIVE%" (SET MESS2=��װ�����޷���ȡϵͳ��ʼ�˵�·�����ѽ����������װ����%SYSTEMDRIVE:~0,-1%�̡�)

:43
IF /I "%MENU%"=="%SYSTEMDRIVE%" (SET MESS2=��װ�����޷���װ��ʼ�˵���ݷ�ʽ��������Win DOS�����ע��Win DOS��) ELSE (SET MESS2=��װ����װ���̳��ִ��󣬲��ֿ�ʼ�˵���ݷ�ʽδ�ܳɹ�������)
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