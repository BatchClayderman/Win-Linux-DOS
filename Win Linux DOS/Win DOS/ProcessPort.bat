@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ���̶˿ڲ�ѯ
SETLOCAL ENABLEDELAYEDEXPANSION
CLS
IF /I "%SYSTEMDRIVE%"=="X:" (ECHO Windows PE�´˹��������塣&PAUSE&EXIT)
CLS
ECHO %DATE% %TIME%	Win DOS���̶˿ڲ�ѯ
VER|FIND /I "XP">NUL
IF %ERRORLEVEL%==1 (GOTO B)
ECHO          �˿ں�           ��������       
ECHO TCPЭ��: 
FOR /F "USEBACKQ SKIP=4 TOKENS=2,5" %%I IN (`"NETSTAT -ano -p TCP"`) DO ( 
	CALL :A %%I TCP %%J 
	ECHO           !TCP_Port!           !TCP_Proc_Name!  
) 
ECHO UDPЭ��: 
FOR /F "USEBACKQ SKIP=4 TOKENS=2,4" %%I IN (`"NETSTAT -ano -p UDP"`) DO (  
	CALL :A %%I UDP %%J 
	ECHO           !UDP_Port!           !UDP_Proc_Name! 
) 
GOTO C

:B
FOR /F "SKIP=1" %%I IN ('WMIC PROCESS GET PROCESSID') DO (
	FOR /F "SKIP=1 TOKENS=*" %%J IN ('WMIC PROCESS WHERE PROCESSID^="%%I" GET NAME') DO (
		ECHO.
		ECHO.
		ECHO. %%J
		NETSTAT -ANO|FINDSTR /R /C:"[^%%I.]"|FINDSTR /R /C:" %%I$"|FINDSTR /I /C:"P"
	)
)
GOTO C

:C
ECHO.
ECHO.
ECHO ���ؽ��̶˿�̽����ϣ��밴������˳�����
PAUSE>NUL
ENDLOCAL
EXIT

:A
FOR /F "TOKENS=2 DELIMS=:" %%I IN ("%1") DO (SET %2_Port=%%I)
FOR /F "SKIP=2 USEBACKQ DELIMS=, TOKENS=1" %%I IN (`"Tasklist /FI "PID EQ %3" /FO CSV"`) DO (SET %2_Proc_Name=%%~I)