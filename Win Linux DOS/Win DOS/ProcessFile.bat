@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE �����ļ���λ��
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
GOTO A

:A
SET N=0
CLS
ECHO �����ļ���λ�������
ECHO ��ѡ����λ��ʽ:
ECHO   0=�˳�����
ECHO   1=ͨ��ӳ�����ƶ�λ
ECHO   2=ͨ��PID��λ
ECHO ��ѡ��һ�ַ�ʽ��
CHOICE /C 120
IF %ERRORLEVEL%==3 EXIT
GOTO %ERRORLEVEL%

:1
CLS
ECHO ������ӳ�����ƣ�
SET /P PROCESSNAME=
CLS
IF /I "%PROCESSNAME%"=="SYSTEM" (GOTO SYSTEM)
IF /I "%PROCESSNAME%"=="SYSTEM IDLE PROCESS" (GOTO IDLE)
ECHO ����%PROCESSNAME%��ӳ��·�����£�
FOR /F "Skip=1 delims=" %%i in ('WMIC PROCESS WHERE NAME^="%PROCESSNAME%" GET EXECUTABLEPATH') do (@ECHO %%i)
FOR /F "Skip=1 delims=" %%i in ('WMIC PROCESS WHERE NAME^="%PROCESSNAME%" GET EXECUTABLEPATH') do (
	SET /A N=N+1
	SET PATH!N!=%%i
)
GOTO O

:2
CLS
ECHO ������PID��
SET /P PROCESSID=
SET /A IDTEMP=%PROCESSID%*1
IF "PROCESSID"=="%IDTEMP%" (GOTO 3)
CLS
IF "%PROCESSID%"=="0" (GOTO IDLE)
IF "%PROCESSID%"=="4" (GOTO SYSTEM)
ECHO PIDΪ%PROCESSID%�Ľ���ӳ��·�����£�
FOR /F "Skip=1 delims=" %%i in ('WMIC PROCESS WHERE PROCESSID^="%PROCESSID%" GET EXECUTABLEPATH') do (@ECHO %%i)
FOR /F "Skip=1 delims=" %%i in ('WMIC PROCESS WHERE PROCESSID^="%PROCESSID%" GET EXECUTABLEPATH') do (
	SET N=1
	SET PATH1=%%i
)
GOTO O

:3
CLS
ECHO �����PID���밴�����������һ����塣
PAUSE>NUL
GOTO 2

:IDLE
ECHO ����System Idle ProcessΪϵͳ���н��̣���ӳ��·����
PAUSE
GOTO A

:O
IF %N%==0 (GOTO A)
ECHO �Ƿ������Ŀ¼��
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO Y)
GOTO Z

:SYSTEM
ECHO ����System��ӳ��·�����£�%SYSTEMROOT%��
SET N=1
SET PATH1=%SYSTEMROOT%
GOTO O

:Y
CALL EXPLORER.EXE /E,/SELECT,"%%PATH%N%%%"
SET /A N=N-1
IF %N%==0 (GOTO Z)
GOTO Y

:Z
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL
GOTO A