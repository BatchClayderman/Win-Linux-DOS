@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ������ʾ��������
CLS
IF /I "%SYSTEMDRIVE%"=="X:" (SET B=2&ECHO Windows PE��û�и���ѡ���ֱ������������ʾ����&GOTO 1)
SET B=0
GOTO MAIN

:MAIN
CLS
ECHO ������ʾ�������������
ECHO   0=�˳�����
ECHO   1=ֱ������
VER|FIND /I "XP">NUL
IF %ERRORLEVEL%==0 (ECHO   2=ϵͳ����&IF /I EXIST %COMSPEC:~0,-7%debug.exe (SET B=1)) ELSE (ECHO   2=����Ա����)
IF EXIST "%COMSPEC:~0,-7%command.com" (ECHO   3=�ű�����) ELSE (ECHO   3=����PowerShell)
IF %B%==1 (ECHO   4=ȫ������)
ECHO   F=����������ʾ��
ECHO   G=ͣ��������ʾ��
ECHO   H=�޸�������ʾ����ͬʱ������������ʾ����
ECHO ��ѡ��һ���Լ�����
IF %B%==1 (CHOICE /C 123FGH04) ELSE (CHOICE /C 123FGH0)
IF %ERRORLEVEL%==7 EXIT
CLS
GOTO %ERRORLEVEL%

:1
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (START /I /REALTIME %COMSPEC% /K COLOR %%I^&CD /D %COMSPEC:~0,-7%)
PAUSE
IF %B%==2 EXIT
GOTO MAIN

:2
VER|FIND /I "XP">NUL
IF NOT %ERRORLEVEL%==0 (GOTO 7)
SC START CMD
CLS
CHOICE /C YN /M "����ѵ���������ʾ������ѡ��Y��������ѡ��N����"
IF %ERRORLEVEL%==1 (GOTO MAIN)
SC DELETE CMD
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CMD" /F
SC DELETE CMD
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (SC CREATE CMD BINPATH^= "CMD /K START COLOR %%I" TYPE^= "OWN" TYPE^= "INTERACT")
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CMD" /V Description /D "�˷�����Win DOS������ͨ��SystemΪWindows XP���û���ϵͳȨ��������������ʾ����" /F
SC START CMD
ECHO �����û�е���������ʾ�������������Ժ����´򿪱���壬���������������塣
PAUSE>NUL
GOTO MAIN

:3
IF /I EXIST %COMSPEC:~0,-7%command.com (START /I /REALTIME COMMAND) ELSE (START /I /REALTIME POWERSHELL.EXE)
PAUSE
GOTO MAIN

:4
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System" /V DisableCMD /D 0 /T REG_DWORD /F
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I /WAIT CMD.EXE /C ECHO ���óɹ���^&PAUSE)
GOTO MAIN

:5
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO ͣ����ʾ����һ�����գ��Ƿ������
CHOICE /C YN /M "�˲�������ͣ�ýű���"
SET YN=%ERRORLEVEL%
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
IF %YN%==2 (SET YN=&GOTO MAIN)
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System" /V DisableCMD /D 2 /T REG_DWORD /F
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I /WAIT CMD.EXE)
SET YN=
GOTO MAIN

:6
REG IMPORT FIXCMD.REG
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL
GOTO MAIN

:7
CLS
ECHO ������Ȩ����������ʾ�������Ժ�...
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (MSHTA VBSCRIPT:CREATEOBJECT("shell.application"^).shellexecute("%COMSPEC%","/C START COLOR %%I^&CD /D %COMSPEC:~0,-8%","","RUNAS",1^)(WINDOW.CLOSE^))
CLS
PAUSE
GOTO MAIN

:8
ECHO EXIT|%COMSPEC% /K PROMPT E 100 B4 00 B0 12 CD 10 B0 03 CD 10 CD 20 $_g$_q$_|DEBUG>NUL
CD /D "%COMSPEC:~0,-8%"
CLS
%COMSPEC%
EXIT