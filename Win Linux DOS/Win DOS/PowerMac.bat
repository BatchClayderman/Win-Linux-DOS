@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ��Դ��ز���
GOTO MAIN

:MAIN
CLS
ECHO ��Դ��ز��������
ECHO   1=��ֹ�ػ�������    2=���������    3=����
ECHO   4=ע��    5=�ػ�    6=�󶨼����    7=ǿ������
ECHO   8=���ߣ��Զ��������ߣ� 9=�������Զ�ͣ�����ߣ�
ECHO   A=�޸ĵ�Դ�ƻ�         0=�˳�����
ECHO ����Ҫ Win DOS Ϊ����Щʲô����ѡ��һ���Լ�����
CHOICE /C 123456789A0
CLS
IF %ERRORLEVEL%==11 EXIT
GOTO %ERRORLEVEL%

:1
SHUTDOWN /A
PAUSE
GOTO MAIN

:2
RUNDLL32.EXE USER32.DLL,LockWorkStation
GOTO MAIN

:3
SET O=����
SET P=3
GOTO A

:30
SHUTDOWN /F /R /T %T% /C "%DATE% %TIME%���뱣����������ݣ�ϵͳ����%T%���%O%��"
GOTO MAIN

:4
LOGOFF
SHUTDOWN /L
EXIT

:5
SET O=�ػ�
SET P=5
GOTO A

:50
SHUTDOWN /F /S /T %T% /C "%DATE% %TIME%���뱣����������ݣ�ϵͳ����%T%���%O%��"
GOTO MAIN

:6
TSDISCON
GOTO MAIN

:7
SET O=ǿ������
SET P=7
GOTO A

:70
ECHO �����Ҫǿ��������
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
SHUTDOWN /F /R /T %T% /C "%DATE% %TIME%���뱣����������ݣ�ϵͳ����%T%���%O%��"
TASKKILL /IM SERVICES.EXE /F /T
TASKKILL /IM SYSTEM /F /T
GOTO MAIN

:8
POWERCFG /HIBERNATE ON
RUNDLL32 powrprof.dll,SetSuspendState
EXIT

:9
POWERCFG /HIBERNATE OFF
RUNDLL32 powrprof.dll,SetSuspendState
EXIT

:10
CLS
ECHO �޸ĵ�Դ�ƻ����
ECHO   0=���������
ECHO   1=�鿴��ǰ��Դ�ƻ�
ECHO   2=�ر���ʾ��ʱ������
ECHO   3=����ʱ������
ECHO   4=����ʱ������
ECHO   5=����ʱ������
ECHO   6=���û�ͣ������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 1234560
IF %ERRORLEVEL%==7 (GOTO MAIN)
SET P=A
CLS
GOTO 10%ERRORLEVEL%

:101
POWERCFG /L
POWERCFG /Q
ECHO ��ܰ��ʾ��Windows 10�����ϣ�ֱ�����ѡ�����֣��س��ɸ������ݣ�
ECHO           Windows 10���£��Ҽ���Ǻ�ѡ�����֣��س��ɸ������ݡ�
PAUSE
GOTO MAIN

:102
SET O=�޶����ر���ʾ��
SET D=monitor
GOTO A

:103
SET O=�޶����رմ��̶�д
SET D=disk
GOTO A

:104
SET O=�޶����Զ�����
SET D=standby
GOTO A

:105
SET O=�޶����Զ�����
SET D=hibernate
GOTO A

:A0
POWERCFG /X -%D%-timeout-ac %T%
SET D=
CLS
ECHO %O%�����޸���ϣ��밴���ⷵ���޸ĵ�Դ�ƻ���塣
PAUSE>NUL
GOTO 10

:106
CHOICE /C YNC "Y=���ã�N=ͣ�ã�C=�����޸ĵ�Դ�ƻ���塣"
IF %ERRORLEVEL%==1 (POWERCFG /HIBERNATE ON)
IF %ERRORLEVEL%==2 (POWERCFG /HIBERNATE OFF)
IF %ERRORLEVEL%==3 (GOTO 10)

:A
SET C=0
SET T=

:B
CLS
ECHO ֱ�Ӱ���Y��������Ϊ0s����������õ�Դ�ƻ�����λΪ���ӡ�
ECHO ����ʱ�䣺10����=600�룬1Сʱ=3600�룬1��=86400�롣
ECHO ����ʱ���ֵΪ864000�룬������%O%����ʱ��%T%[��/����]��
ECHO Y=ȷ�ϣ�E=��������壬B=�˸�Q=��ա�
CHOICE /C 1234567890YEBQ>NUL
IF %ERRORLEVEL%==11 (GOTO C)
IF %ERRORLEVEL%==12 (SET C=&SET T=&GOTO MAIN)
IF %ERRORLEVEL%==13 (IF NOT %C%==0 (SET T=%T:~0,-1%&SET /A C-=1))&GOTO B
IF %ERRORLEVEL%==14 (SET T=&SET C=0&GOTO B)
IF %C%==6 (GOTO B)
SET /A C+=1
IF %ERRORLEVEL%==10 (IF %C%==1 (SET C=0) ELSE (SET T=%T%0))&GOTO B
SET T=%T%%ERRORLEVEL%
GOTO B

:C
IF NOT DEFINED T (SET T=0)
IF %T% GTR 864000 (SET T=864000)
GOTO %P%0