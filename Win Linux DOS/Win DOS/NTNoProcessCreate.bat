@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ��ֹ��������
GOTO MAIN

:MAIN
CLS
ECHO ��ֹ�������������
ECHO   0=�˳�����
ECHO   1=��׼��ֹ
ECHO   2=ǿ�ƽ�ֹ
ECHO ��ѡ��һ���Լ�����
CHOICE /C 120
IF %ERRORLEVEL%==3 EXIT
CLS
GOTO %ERRORLEVEL%

:1
IF NOT EXIST "%COMSPEC:~0,-7%findstr.exe" (ECHO ����ȱ��ϵͳ�ļ�findstr.exe���޷��������밴������˳���&PAUSE>NUL&EXIT)
SETLOCAL ENABLEDELAYEDEXPANSION
SET F="%TEMP%\PID.txt"
IF EXIST %F% (DEL /A /F /Q %F%)
IF /I NOT EXIST %F% (GOTO 12)
CACLS %F% /E /T /G SYSTEM:F
CACLS %F% /E /T /G ADMINISTRATORS:F
CACLS %F% /E /T /G %USERNAME%:F
CACLS %F% /E /T /G USERS:F
CACLS %F% /E /T /G EVERYONE:F
DEL /A /F /Q %F%
IF EXIST %F% (GOTO 11) ELSE (GOTO 12)

:11
CLS
ECHO ԭ��PID��¼ɾ��ʧ�ܡ�
ECHO   1=ʹ��ԭ��PID���в���
ECHO   2=����
ECHO   3=���������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 123
IF %ERRORLEVEL%==1 (GOTO 12)
IF %ERRORLEVEL%==2 (GOTO 1)
IF %ERRORLEVEL%==3 (GOTO MAIN)

:12
FOR /F "SKIP=1 DELIMS= " %%I IN ('WMIC PROCESS GET PROCESSID') DO (ECHO P%%I)>>%F%
IF /I EXIST %F% (ATTRIB +A +H +R +S %F%) ELSE (GOTO 1)
TITLE ��׼��ֹ����������Ч�У��������밴�¡�Ctrl+C����
GOTO 13

:13
FOR /F "SKIP=1 DELIMS= " %%I IN ('WMIC PROCESS GET PROCESSID') DO (
	FINDSTR /X P%%I %F%>NUL
	IF !ERRORLEVEL!==1 (TASKKILL /PID %%I /F /T)
)
GOTO 13

:2
ECHO ��ע�⣬�˽�ֹ���ܽ�ֹ��Դ�������������̡�
ECHO ���⣬��ֹ����Ч������ϵͳ������Ч��
ECHO �밴��Y������������N�����������C�����ء�
CHOICE /C YNC
GOTO 2%ERRORLEVEL%

:21
CLS
ECHO ������ϵͳ��ӽ�ֹ�㣬���Ժ�...
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V RestrictRun /T REG_DWORD /D 1 /F
IF NOT %ERRORLEVEL%==0 (GOTO 24)
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\RestrictRun /V cmd.exe /D cmd.exe /F
IF NOT %ERRORLEVEL%==0 (GOTO 26)
GPUPDATE /FORCE
CLS
ECHO ��ֹ����ӳɹ����밴�������������塣
GOTO 23

:22
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V RestrictRun
IF NOT %ERRORLEVEL%==0 (GOTO 27)
CLS
ECHO ���ڽ�������Ժ�...
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V RestrictRun /F
IF NOT %ERRORLEVEL%==0 (GOTO 25)
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\RestrictRun /F
GPUPDATE /FORCE
CLS
ECHO ��ʾ��Ϊ����ϵͳ��������ֹ���cmd.exe����Ч��
ECHO ����ɹ����밴�������������塣

:23
PAUSE>NUL
GOTO MAIN

:24
CLS
ECHO ��ӽ�ֹ��ʧ�ܣ�������ɱ�������ֹ�˲������밴�������������塣
GOTO 23

:25
CLS
ECHO ���ʧ�ܣ��밴�������������塣
ECHO ������ϵͳ�����ԣ�����������ʧ�ܣ�����밲ȫģʽ�����
GOTO 23

:26
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /V RestrictRun
CLS
IF %ERRORLEVEL%==0 (ECHO �����޷����cmd.exe�ų�����ֹ���ѱ����ء�) ELSE (ECHO ע�⣺δ���cmd.exe���ų���)
ECHO �밴�������������塣
GOTO 23

:27
CLS
ECHO ����ϵͳû���γɽ�ֹ�㣬���������밴�������������塣
GOTO 23