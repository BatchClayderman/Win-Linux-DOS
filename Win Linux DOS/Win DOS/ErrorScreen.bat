@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE �ֶ�����
SET T=0
CLS
ECHO ��ȷ��Ҫʹϵͳ������
CHOICE /C YN
IF %ERRORLEVEL%==2 EXIT
GOTO Y

:T
SHUTDOWN /S /T 10 /C "��⵽����ϵͳδ�����������ں˼�����������Windows XPϵͳ���ܻ����Ϊǿ��������"
TASKKILL /FI "PID NE 1" /F
GOTO T

:Y
@WINLOGON.EXE
SET /A T+=1
IF %T%==10 (GOTO Y) ELSE (GOTO T)