@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET B=0
SET L=0
SET O=��������
SET TREE=
COLOR E
SET T=
SET W=0
SET Z=
CLS
GOTO TASK

:TASK
TITLE %Z%%TREE%%O%
IF NOT %L%==0 (TITLE %Z%%TREE%%O%-������)
IF NOT %L%==0 (GOTO L)
SET Z=
IF %B%==0 (IF %W%==0 (TASKKILL /IM WMIC.EXE /F /T))
CLS
IF %W%==0 TASKLIST
IF %B%==1 (CLS&GOTO WMIC)
IF %B%==2 (SET B=4&TASKLIST)
IF %B%==3 CLS
IF %B%==4 (CLS&SET B=0)
ECHO ����Ϊ�ɹ�ִ�еĲ�����
ECHO   0=�˳�����
ECHO   1=ˢ�½����б���ϸ��Ϣģʽ�²���Ч��
IF %W%==0 (ECHO   2=�鿴������ϸ��Ϣ������һ�Σ�)
IF %W%==1 (ECHO   2=�鿴���̼�����Ϣ������һ�Σ�)
IF %W%==0 (ECHO   3=�鿴������ϸ��Ϣ��ֱ���������˳���)
IF %W%==1 (ECHO   3=�鿴���̼�����Ϣ��ֱ���������˳���)
IF "%T%"=="/T" (ECHO   4=ͣ�ý���������) ELSE (ECHO   4=���ý���������)
ECHO   5=ͨ��ӳ������%TREE%%O%
ECHO   6=ͨ�����̱�ʶ��%TREE%%O%
IF %O%==�رմ��� (ECHO   7=��������(��ǰ�������رմ��ڴ���) ELSE (ECHO   7=�����رմ��ڴ�����ǰ���������̣�)
ECHO   8=ʹ�ùŽ�����
ECHO   9=�����رջ������ʽ
ECHO ��ѡ��һ�������
CHOICE /C 1234567890
IF %ERRORLEVEL%==10 EXIT
IF %ERRORLEVEL%==1 (GOTO TASK)
IF %ERRORLEVEL%==2 (IF %W%==0 (SET B=1)&IF %W%==1 (SET B=2))
IF %ERRORLEVEL%==3 (IF %W%==1 (SET W=0&SET B=0&TASKKILL /IM WMIC.EXE /F /T&GOTO TASK) ELSE (SET W=1&GOTO WMIC))
IF %ERRORLEVEL%==4 (IF "%T%"=="/T" (SET TREE=&SET T=) ELSE (SET TREE=��������&SET T=/T)&GOTO TASK)
IF %ERRORLEVEL%==5 (SET Z=ͨ��ӳ������&GOTO I)
IF %ERRORLEVEL%==6 (SET Z=ͨ��PID&GOTO P)
IF %ERRORLEVEL%==7 (IF %O%==�رմ��� (SET O=��������) ELSE (SET O=�رմ���))
IF %ERRORLEVEL%==2 (TASKLIST&PAUSE&GOTO TASK)
IF %ERRORLEVEL%==7 (GOTO TASK)
GOTO %ERRORLEVEL%

:8
TITLE �Ž�����
ECHO ע�⣺���������Ϊ�����֣��������ֽ���ʶ��ΪPID��
ECHO ������ȥexe��������*ͨ������ã���PID��
SET /P P=
TSKILL "%P%"
PAUSE
TSKILL WMIC
GOTO TASK

:9
ECHO ����5-8���������ѡ�
CHOICE /C 5678
SET /A L=%ERRORLEVEL%+4
GOTO TASK

:I
TITLE %Z%%TREE%%O%
IF NOT %L%==0 (TITLE %Z%%TREE%%O%-������)
ECHO ���������ӳ�����ƣ�*ͨ������ã���
SET /P IMN=
SET IMN="%IMN%"
IF %O%==�رմ��� (TASKKILL /IM %IMN% %T%&GOTO TASK)
TASKKILL /IM %IMN% /F %T%
WMIC PROCESS GET NAME|FIND /I %IMN%
IF %ERRORLEVEL%==0 (SET NT=1&GOTO NT)
GOTO TASK

:L
CLS
IF %W%==0 TASKLIST
IF "%L%"=="5" (GOTO I)
IF "%L%"=="6" (GOTO P)
IF "%L%"=="7" (SET O=�رմ���&GOTO TASK)
IF "%L%"=="8" (GOTO 8)
IF "%L%"=="9" (GOTO 9)
GOTO TASK


:P
TITLE %Z%%TREE%%O%
IF NOT %L%==0 (TITLE %Z%%TREE%%O%-������)
ECHO ���������PID��
SET /P PID=
IF %O%==�رմ��� (TASKKILL /IM %PID% %T%&GOTO TASK)
TASKKILL /IM %PID% /F %T%
WMIC PROCESS GET PROCESSID|FIND "%PID%"
IF %ERRORLEVEL%==0 (SET NT=2&GOTO NT)
GOTO TASK

:NT
ECHO �������̽���ʧ�ܣ��Ƿ���Ҫǿ�ƽ�����
ECHO ��רҵ��Ա��ע�⣬�ý�����ʽδ�漰NT�����������������ܼ���������
ECHO ��������Ҫ���뵽������רҵ����������PC Hunter Standard����
CHOICE /C YN
IF %ERRORLEVEL%==1 (IF %NT%==2 (ntsd -c q -p %PID%) ELSE (ntsd -c q -pn %IMN%))
IF %B%==0 (IF %W%==0 (TASKKILL /IM WMIC.EXE /F /T))
GOTO TASK

:WMIC
TASKKILL /IM WMIC.EXE /F /T
CLS
START "�����·�����process���س�������ˢ�£����ٴ�����process���س���" WMIC
MSHTA VBSCRIPT:MSGBOX("���ڵ�������������process���س�������ˢ�£����ٴ�����process���س���",0,"��������")(WINDOW.CLOSE)
IF %B%==1 (SET B=4)
IF %B%==2 (SET B=3)
GOTO TASK