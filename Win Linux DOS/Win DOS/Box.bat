@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ϵͳ���ڵ�������
SET S=0
CLS
ECHO ���ڼ�����л���...
IF /I "%SYSTEMDRIVE%"=="X:" (ECHO Windows PE��֧�ִ˹��ܡ�&PAUSE&EXIT)
VER|FIND /I "XP"
SET SYS=%ERRORLEVEL%
GOTO MAIN

:MAIN
CLS
ECHO ϵͳ���ڵ������������
ECHO   0=�˳�����
ECHO   1=ֱ�ӵ���
ECHO   2=���������
IF %SYS%==0 (ECHO   3=�رյ����Ĺػ�����)
ECHO ��ѡ��һ��ѡ���Լ�����
IF %SYS%==0 (CHOICE /C 1203) ELSE (CHOICE /C 120)
IF %ERRORLEVEL%==3 EXIT
IF %ERRORLEVEL%==4 (SHUTDOWN /A&GOTO MAIN)
SET WAY=%ERRORLEVEL%
GOTO A

:A
CLS
ECHO �ɹ�ѡ��Ĵ����������£�
ECHO   0=����ȷ�����ڣ�Ĭ��ֵ��
ECHO   1=ȷ��ȡ������
ECHO   2=��ѡ���
ECHO   3=�Ƿ�ȡ������
ECHO   4=�Ƿ񴰿�
ECHO   5=����ȡ������
ECHO   6=���󴰿�
ECHO   7=ѯ�ʴ���
ECHO   8=��ʾ����
IF %SYS%==0 (ECHO   S=�ػ�����)
ECHO   Q=���������
ECHO ��ѡ��һ���Լ�����
IF %SYS%==0 (CHOICE /C 123456780QS) ELSE (CHOICE /C 123456780Q)
CLS
IF %ERRORLEVEL%==9 (SET KIND=0&GOTO C)
IF %ERRORLEVEL%==10 (GOTO MAIN)
IF %ERRORLEVEL%==11 (SET S=1&GOTO B)
IF %ERRORLEVEL%==6 (SET KIND=16&GOTO C)
IF %ERRORLEVEL%==7 (SET KIND=32&GOTO C)
IF %ERRORLEVEL%==8 (SET KIND=64&GOTO C)
SET KIND=%ERRORLEVEL%
GOTO C

:B
ECHO ����Windows XP���еĹ��ܣ��������۹⣬���������
ECHO ���������ݣ�
SET /P TEXT=
CLS
GOTO %WAY%

:C
ECHO �����봰�����ݣ�
SET /P TEXT=
ECHO �����봰�ڱ��⣺
SET /P TITLE=
CLS
GOTO %WAY%

:1
IF %S%==0 (GOTO 11) ELSE (GOTO 12)

:11
MSHTA VBSCRIPT:MSGBOX("%TEXT%",%KIND%,"%TITLE%")(WINDOW.CLOSE)
GOTO MAIN

:12
SHUTDOWN /A
SHUTDOWN /S /T 8640000 /C "%TEXT%"
GOTO MAIN

:2
ECHO ����ִ�д�������Ժ�...
GOTO 21

:21
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP|FIND /I ":">NUL
IF %ERRORLEVEL%==0 (GOTO 22) ELSE (GOTO 23)

:22
FOR /F "tokens=1 delims=:" %%i in ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') do (SET DESK=%%i)
SET DESK=%DESK:~-1%
FOR /F "tokens=2 delims=:" %%i in ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V DESKTOP') do (SET TOP=%%i)
SET DESKTOPPATH=%DESK%:%TOP%
GOTO 24

:23
IF %S%==0 (GOTO 231) ELSE (GOTO 232)

:231
IF /I EXIST "%SYSTEMDRIVE%\BoxLink.vbs" (GOTO 3)
ECHO MSGBOX "%TEXT%",%KIND%,"%TITLE%">"%SYSTEMDRIVE%\BoxLink.vbs"
ATTRIB +A -H +R -S "%SYSTEMDRIVE%\BoxLink.vbs"
IF /I EXIST "%SYSTEMDRIVE%\BoxLink.vbs" (GOTO 233) ELSE (GOTO 25)
GOTO MAIN
GOTO 233

:232
IF /I EXIST "%SYSTEMDRIVE%\BoxLink.bat" (GOTO 3)
ECHO SHUTDOWN /A>"%SYSTEMDRIVE%\BoxLink.bat"
ECHO SHUTDOWN /S /T 8640000 /C "%TEXT%">>"%SYSTEMDRIVE%\BoxLink.bat"
ATTRIB +A -H +R -S "%SYSTEMDRIVE%\BoxLink.bat"
IF /I EXIST "%SYSTEMDRIVE%\BoxLink.bat" (GOTO 233) ELSE (GOTO 25)
GOTO MAIN

:233
ECHO �޷���ȡϵͳ������·�����ѽ��ļ����浽��ϵͳ�̵ĸ�Ŀ¼�¡�
ECHO ��������ļ���Ϊ��BoxLink���������ա�
ECHO ���������ϵͳ���밴�������������塣
PAUSE>NUL
GOTO MAIN

:24
IF %S%==0 (GOTO 241) ELSE (GOTO 242)

:241
IF /I EXIST "%DESKTOPPATH%\BoxLink.vbs" (GOTO 3)
ECHO MSGBOX "%TEXT%",%KIND%,"%TITLE%">"%DESKTOPPATH%\BoxLink.vbs"
ATTRIB +A -H +R -S "%DESKTOPPATH%\BoxLink.vbs"
IF /I EXIST "%DESKTOPPATH%\BoxLink.vbs" (GOTO 243) ELSE (GOTO 25)
GOTO MAIN
GOTO 243

:242
IF /I EXIST "%DESKTOPPATH%\BoxLink.bat" (GOTO 3)
ECHO SHUTDOWN /A>"%DESKTOPPATH%\BoxLink.bat"
ECHO SHUTDOWN /S /T 8640000 /C "%TEXT%">>"%DESKTOPPATH%\BoxLink.bat"
ATTRIB +A -H +R -S "%DESKTOPPATH%\BoxLink.bat"
IF /I EXIST "%DESKTOPPATH%\BoxLink.bat" (GOTO 243) ELSE (GOTO 25)
GOTO MAIN

:243
ECHO ����ɹ������ļ���Ϊ��BoxLink���������ա��밴�������������塣
PAUSE>NUL
GOTO MAIN

:25
ECHO �����ļ�ʧ�ܣ��Ƿ����ԣ�
CHOICE /C YN
IF %ERRORLEVEL%==1 (CLS&GOTO 2) ELSE (GOTO MAIN)

:3
CLS
ECHO ��������Ƚ���һ�ݴ���ļ����浽�𴦣�Ȼ�������������
PAUSE>NUL
CLS
GOTO 2