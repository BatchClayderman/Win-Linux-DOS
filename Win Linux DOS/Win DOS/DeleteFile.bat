@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ɾ���ļ����У�
GOTO MAIN

:MAIN
CLS
ECHO ɾ���ļ����У������
ECHO   0=�˳�����
ECHO   1=��׼ɾ��
ECHO   2=��Ȩ��ɾ��
ECHO   3=ж��ɾ��
ECHO   4=��ӡ���קɾ���������沢���ػ���վ
ECHO   5=ɾ�����桰��קɾ��������ԭ����վ
ECHO ��ѡ��һ���Լ�����
CHOICE /C 123450
IF %ERRORLEVEL%==6 EXIT
CLS
IF %ERRORLEVEL%==4 (GOTO 4)
IF %ERRORLEVEL%==5 (GOTO 7)
ECHO �������ļ����У�ȫ·�����ļ����У���ק���ˣ�
SET /P F=
CLS
GOTO %ERRORLEVEL%

:1
DEL /A /F /Q \\?\%F%
RD /Q /S \\?\%F%
CLS
IF /I EXIST %F% (ECHO Ŀ���ļ�%F%ɾ���ļ�ʧ�ܣ�) ELSE (ECHO Ŀ���ļ�%F%�ѱ��ɹ�ɾ����)
PAUSE
GOTO MAIN

:2
CACLS %F% /E /T /G SYSTEM:F
CACLS %F% /E /T /G ADMINISTRATORS:F
CACLS %F% /E /T /G %USERNAME%:F
CACLS %F% /E /T /G USERS:F
CACLS %F% /E /T /G EVERYONE:F
GOTO 1

:3
FOR /F "DELIMS=: TOKENS=1" %%I IN ('ECHO %F%') DO (SET D=^%%I)
SET D=%D:~-1%:
IF /I %D%==%SYSTEMDRIVE% (ECHO �޷�ǿ��ж��ϵͳ�̣���ѡ������ģʽ��&PAUSE&GOTO MAIN)
CHKDSK /X %D%
GOTO 2

:4
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET DESKTOP=%SYSTEMDRIVE%&GOTO 5)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET TOP=%%I)
SET DESKTOP=%DESK%:%TOP%
ECHO @ECHO OFF>"%DESKTOP%\��קɾ��.bat"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO COLOR %%I 1>>"%DESKTOP%\��קɾ��.bat")
ECHO DEL /A /F /Q /S \\?\%%1 1>>"%DESKTOP%\��קɾ��.bat"
ECHO RD /Q /S \\?\%%1 1>>"%DESKTOP%\��קɾ��.bat"
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (ECHO SLEEP %%I000 1>>"%DESKTOP%\��קɾ��.bat")
IF EXIST "%DESKTOP%\��קɾ��.bat" (REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V {645FF040-5081-101B-9F08-00AA002F954E} /D 1 /F) ELSE (GOTO 6)
ATTRIB +A +R +S -H "%DESKTOP%\��קɾ��.bat"
GOTO 8

:5
ECHO ��ȡ��������·��ʧ�ܣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:6
ECHO �����ļ�ʧ�ܣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:7
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"|FIND ":">NUL
IF NOT %ERRORLEVEL%==0 (SET DESKTOP=%SYSTEMDRIVE%&GOTO 5)
FOR /F "TOKENS=1 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET DESK=%%I)
SET DESK=%DESK:~-1%
FOR /F "TOKENS=2 DELIMS=:" %%I IN ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "COMMON DESKTOP"') DO (SET TOP=%%I)
SET DESKTOP=%DESK%:%TOP%
DEL /A /F /Q "%DESKTOP%\��קɾ��.bat"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V {645FF040-5081-101B-9F08-00AA002F954E} /D 0 /F

:8
CLS
ECHO �����ɹ�������������������棬�����������������塣
PAUSE>NUL
GOTO MAIN