@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ʵʱ�鿴������Ϣ
SET A=1
SET C=0
SET D=%SYSTEMDRIVE%
SET T=����
CLS
IF /I "%SYSTEMDRIVE%"=="X:" (ECHO Windows PE�´˹��������塣&PAUSE&EXIT)
ECHO �Ƿ�鿴��ϸ��Ϣ��
CHOICE /C YN
IF /I %ERRORLEVEL%==1 (
	START /REALTIME "�����·�����process���س��������Ҫˢ�£����ٴ�����process���س���" WMIC
	MSHTA VBSCRIPT:MSGBOX("���ڵ�������������process���س��������Ҫˢ�£����ٴ�����process���س���",0,"ʵʱ�鿴��ͨ������ϸ��Ϣ"^)(WINDOW.CLOSE^)
	EXIT
)
ECHO �Ƿ��Զ�ˢ�£�
CHOICE /C YN
IF %ERRORLEVEL%==2 (SET A=0)
ECHO �Ƿ����ɱ��浽%D:~0,-1%�̣�
CHOICE /C YN
IF %ERRORLEVEL%==1 (SET C=1)
CLS
GOTO M

:B
MSHTA VBSCRIPT:MSGBOX("�����ļ�ʧ�ܣ������ȷ�������ԣ�",0,"ʵʱ�鿴��ͨ����%T%��Ϣ-���ɱ���ʱ���ִ���")(WINDOW.CLOSE)
IF %C%==0 (GOTO T) ELSE (GOTO C)

:C
CACLS %D%\Normalprocess.txt /E /G SYSTEM:F
CACLS %D%\Normalprocess.txt /E /G ADMINISTRATORS:F
CACLS %D%\Normalprocess.txt /E /G %USERNAME%:F
CACLS %D%\Normalprocess.txt /E /G USERS:F
CACLS %D%\Normalprocess.txt /E /G EVERYONE:F
DEL /A /F /Q %D%\Normalprocess.txt
IF /I EXIST %D%\Normalprocess.txt (GOTO E)
IF %C%==1 (DATE /T>%D%\Normalprocess.txt)
ATTRIB +A +H +S -R %D%\Normalprocess.txt
IF %C%==1 (IF /I EXIST %D%\Normalprocess.txt (GOTO T) ELSE (GOTO B))
IF %C%==0 (GOTO T)

:D
CLS
MSHTA VBSCRIPT:MSGBOX("������ʵʱ������ͨ����%T%��Ϣ���밴���ڱ�����ʾִ�в�����",0,"ʵʱ�鿴��ͨ����%T%��Ϣ")(WINDOW.CLOSE)
GOTO C

:E
MSHTA VBSCRIPT:MSGBOX("ɾ��ԭ����ʱ���ִ��󣬵����ȷ�������ԣ�",0,"ʵʱ�鿴��ͨ����%T%��Ϣ")(WINDOW.CLOSE)
CACLS %D%\Normalprocess.txt /E /G SYSTEM:F
CACLS %D%\Normalprocess.txt /E /G ADMINISTRATORS:F
CACLS %D%\Normalprocess.txt /E /G %USERNAME%:F
CACLS %D%\Normalprocess.txt /E /G USERS:F
CACLS %D%\Normalprocess.txt /E /G EVERYONE:F
DEL /A /F /Q %D%\Normalprocess.txt
IF /I "%Y%"=="Y" (IF /I EXIST %D%\Normalprocess.txt (GOTO E) ELSE (GOTO C))

:M
ECHO ��ѡ��һ������ģʽ�Լ�����
ECHO   0=�˳�����
ECHO   1=�鿴�Ự���ڴ�
ECHO   2=�鿴����
ECHO   3=�鿴ģ��
ECHO   4=�鿴�Ự�����������Ϣ
ECHO ������ѡ����һ��ģʽ����ʾ����Ϣ�������ӳ�����ƺͽ��̱�ʶ����Ϣ����ѡ��һ���Լ�����
CHOICE /C 12340
IF %ERRORLEVEL%==1 (SET O=)
IF %ERRORLEVEL%==2 (SET O= /SVC&SET T=����)
IF %ERRORLEVEL%==3 (SET O= /M&SET T=ģ��)
IF %ERRORLEVEL%==4 (SET O= /V&SET T=����)
IF %ERRORLEVEL%==5 EXIT
GOTO D

:T
IF %A%==1 (TITLE ʵʱ�鿴��ͨ����%T%��Ϣ�������Ҫ��ͣ�밴��Ctrl+C�������Ҫֹͣ��رմ��ڡ�) ELSE (TITLE ʵʱ�鿴��ͨ����%T%��Ϣ���밴�����ˢ�£������Ҫֹͣ��رմ��ڡ�)
CLS
TASKLIST%O%
IF %C%==1 (ECHO.>>%D%\Normalprocess.txt)
IF %C%==1 (ECHO.>>%D%\Normalprocess.txt)
IF %C%==1 (TIME /T>>%D%\Normalprocess.txt)
IF %C%==1 (TASKLIST%O%>>%D%\Normalprocess.txt)
IF %A%==0 PAUSE
GOTO T