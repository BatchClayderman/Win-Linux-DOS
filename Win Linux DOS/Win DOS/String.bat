@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE �ı�������
SETLOCAL ENABLEDELAYEDEXPANSION
GOTO MAIN

:MAIN
CLS
ECHO �ı������������
ECHO ���棺���������봿�ı����������볬�ı��ַ���
ECHO.
ECHO   0=�˳�����
ECHO   1=���ȼ���
ECHO   2=�������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 120
IF %ERRORLEVEL%==3 EXIT
GOTO %ERRORLEVEL%0

:10
CLS
SET N=0
ECHO �����봿�ı���
SET /P S=
GOTO 11

:11
SET /A N=N+1
FOR /F %%I IN ("%N%") DO (IF NOT "!S:~%%I,1!"=="" (GOTO 11))
CLS
ECHO �ַ�����%S%���ĳ���Ϊ%N%���밴�������������塣
PAUSE>NUL
GOTO MAIN

:20
CLS
SET O=
ECHO �����봿�ı�:
SET /P S=
IF "%S%"=="" (GOTO 21)
SET T=%S%
GOTO 22

:21
CLS
ECHO �������˿��ı�������Ϊ�ա�
ECHO.
ECHO ���������������塣
PAUSE>NUL
GOTO MAIN

:22
SET O=%O%%T:~-1%
SET T=%T:~0,-1%
IF "%T%"=="" (GOTO 23)
GOTO 22

:23
CLS
ECHO ԭ�����£�
ECHO %S%
ECHO �������£�
ECHO %O%
ECHO �밴�������������塣 
PAUSE>NUL
GOTO MAIN