@ECHO OFF
CHCP 936
CD /D "%~DP0"
TITLE �ļ�����
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO MAIN

:MAIN
CLS
ECHO �������ļ�ȫ·�����ļ���ק���ˣ�
SET /P F=
IF EXIST %F% (GOTO RUN)
ECHO �ļ������ڣ����������롣
PAUSE
GOTO MAIN

:RUN
FOR %%I IN (%F%) DO (SET G="%%~FI.bat")
TAKEOWN /F %G%
ICACLS %G% /GRANT ADMINISTRATORS:F
DEL /A /F /Q %G%
ECHO @ECHO OFF>%G%
ECHO CD /D %F%>>%G%
ECHO GOTO %%ERRORLEVEL%%>>%G%
ECHO.>>%G%
ECHO :0>>%G%
ECHO CD /D %F%>>%G%
ECHO GOTO ^0>>%G%
ECHO.>>%G%
ECHO :1>>%G%
ECHO START /I /MIN PAUSE^>^>%F%>>%G%
ECHO GOTO ^1>>%G%
IF NOT EXIST %G% (ECHO ����ʧ�ܣ�&PAUSE&EXIT)
ATTRIB +A -H +R -S %G%
START /MIN /REALTIME CMD /C %G%
CLS
ECHO �ļ�%F%�Ѵ��ڱ���״̬������ֹͣ��������ɾ��%G%���ر��������ϵ�cmd���ڡ�
CHOICE /C YN /M "������ӱ����ļ���ѡ��Y�����˳�������ѡ��N����"
IF %ERRORLEVEL%==2 EXIT
GOTO MAIN