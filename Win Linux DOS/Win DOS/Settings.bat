@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
TITLE Win DOS���ó���
IF /I "%1"=="/R" (GOTO RECOVER)
SET CK=0
SET SETALL=0
SET CHANGE=0
SET ALL1=��������
SET ALL2=����������ɫ����
SET ALL3=���վ�����ɫ����
SET ALL4=�Զ��������ɫ����
SET ALL5=��ͣʱ������
SET ALL6=���뱣������
CLS
IF EXIST "%COMSPEC:~0,-7%mshta.exe" (MSHTA VBSCRIPT:MSGBOX("��Win DOS������������ˣ�������Win DOS���á�",64,"Win DOS���ó���"^)(WINDOW.CLOSE^)) ELSE (ECHO ��Win DOS������������ˣ�������Win DOS���á�)
GOTO CLEAR1

:CLEAR1
SET ERR=0
CLS
ECHO ���ڼ��������ļ������Ժ�...
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X1=%%I)
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X2=%%I)
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X3=%%I)
FOR /F "TOKENS=4 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X4=%%I)
FOR /F "TOKENS=5 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X5=%%I)
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X6=%%I)
FOR /F "TOKENS=7 DELIMS=," %%I IN ('TYPE config.ini') DO (SET X7=%%I)
IF "%X1%"=="START /REALTIME" (SET Y1=1����ʵʱ���ȼ���������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /HIGH" (SET Y1=1���Ը����ȼ���������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /ABOVENORMAL" (SET Y1=1���Ը��ڱ�׼���ȼ���������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /NORMAL" (SET Y1=1���Ա�׼���ȼ���������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /BELOWNORMAL" (SET Y1=1���Ե��ڱ�׼���ȼ���������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /LOW" (SET Y1=1���Ե����ȼ���������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MAX /REALTIME" (SET Y1=1����ʵʱ���ȼ��������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MAX /HIGH" (SET Y1=1���Ը����ȼ��������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MAX /ABOVENORMAL" (SET Y1=1���Ը��ڱ�׼���ȼ��������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MAX /NORMAL" (SET Y1=1���Ա�׼���ȼ��������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MAX /BELOWNORMAL" (SET Y1=1���Ե��ڱ�׼���ȼ��������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MAX /LOW" (SET Y1=1���Ե����ȼ��������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MIN /REALTIME" (SET Y1=1����ʵʱ���ȼ���С������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MIN /HIGH" (SET Y1=1���Ը����ȼ���С������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MIN /ABOVENORMAL" (SET Y1=1���Ը��ڱ�׼���ȼ���С������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MIN /NORMAL" (SET Y1=1���Ա�׼���ȼ���С������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MIN /BELOWNORMAL" (SET Y1=1���Ե��ڱ�׼���ȼ���С������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /MIN /LOW" (SET Y1=1���Ե����ȼ���С������ж�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /REALTIME" (SET Y1=1����ʵʱ���ȼ��������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /HIGH" (SET Y1=1���Ը����ȼ��������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /ABOVENORMAL" (SET Y1=1���Ը��ڱ�׼���ȼ��������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /NORMAL" (SET Y1=1���Ա�׼���ȼ��������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /BELOWNORMAL" (SET Y1=1���Ե��ڱ�׼���ȼ��������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /LOW" (SET Y1=1���Ե����ȼ��������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /REALTIME" (SET Y1=1����ʵʱ���ȼ�������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /HIGH" (SET Y1=1���Ը����ȼ�������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /ABOVENORMAL" (SET Y1=1���Ը��ڱ�׼���ȼ�������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /NORMAL" (SET Y1=1���Ա�׼���ȼ�������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /BELOWNORMAL" (SET Y1=1���Ե��ڱ�׼���ȼ�������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MAX /LOW" (SET Y1=1���Ե����ȼ�������ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /REALTIME" (SET Y1=1����ʵʱ���ȼ���С�����ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /HIGH" (SET Y1=1���Ը����ȼ���С�����ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /ABOVENORMAL" (SET Y1=1���Ը��ڱ�׼���ȼ���С�����ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /NORMAL" (SET Y1=1���Ա�׼���ȼ���С�����ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /BELOWNORMAL" (SET Y1=1���Ե��ڱ�׼���ȼ���С�����ȴ�����&GOTO CLEAR2)
IF "%X1%"=="START /WAIT /MIN /LOW" (SET Y1=1���Ե����ȼ���С�����ȴ�����&GOTO CLEAR2)
SET ERR=1
GOTO CLEAR6

:CLEAR2
IF %X2:~0,1%==%X2:~1,1% (GOTO CLEAR6)
IF %X2:~0,1%==0 (SET T1=��ɫ)
IF %X2:~0,1%==1 (SET T1=��ɫ)
IF %X2:~0,1%==2 (SET T1=��ɫ)
IF %X2:~0,1%==3 (SET T1=����ɫ)
IF %X2:~0,1%==4 (SET T1=��ɫ)
IF %X2:~0,1%==5 (SET T1=��ɫ)
IF %X2:~0,1%==6 (SET T1=��ɫ)
IF %X2:~0,1%==7 (SET T1=��ɫ)
IF %X2:~0,1%==8 (SET T1=��ɫ)
IF %X2:~0,1%==9 (SET T1=����ɫ)
IF %X2:~0,1%==A (SET T1=����ɫ)
IF %X2:~0,1%==B (SET T1=��ǳ��ɫ)
IF %X2:~0,1%==C (SET T1=����ɫ)
IF %X2:~0,1%==D (SET T1=����ɫ)
IF %X2:~0,1%==E (SET T1=����ɫ)
IF %X2:~0,1%==F (SET T1=����ɫ)
IF %X2:~1,1%==0 (SET T2=��ɫ)
IF %X2:~1,1%==1 (SET T2=��ɫ)
IF %X2:~1,1%==2 (SET T2=��ɫ)
IF %X2:~1,1%==3 (SET T2=����ɫ)
IF %X2:~1,1%==4 (SET T2=��ɫ)
IF %X2:~1,1%==5 (SET T2=��ɫ)
IF %X2:~1,1%==6 (SET T2=��ɫ)
IF %X2:~1,1%==7 (SET T2=��ɫ)
IF %X2:~1,1%==8 (SET T2=��ɫ)
IF %X2:~1,1%==9 (SET T2=����ɫ)
IF %X2:~1,1%==A (SET T2=����ɫ)
IF %X2:~1,1%==B (SET T2=��ǳ��ɫ)
IF %X2:~1,1%==C (SET T2=����ɫ)
IF %X2:~1,1%==D (SET T2=����ɫ)
IF %X2:~1,1%==E (SET T2=����ɫ)
IF %X2:~1,1%==F (SET T2=����ɫ)
SET Y2=2������������ɫ����%T1%�ϲ���%T2%��������Ϊ%T1%������Ϊ%T2%
GOTO CLEAR3

:CLEAR3
IF %X3:~0,1%==%X3:~1,1% (GOTO CLEAR6)
IF %X3:~0,1%==0 (SET T1=��ɫ)
IF %X3:~0,1%==1 (SET T1=��ɫ)
IF %X3:~0,1%==2 (SET T1=��ɫ)
IF %X3:~0,1%==3 (SET T1=����ɫ)
IF %X3:~0,1%==4 (SET T1=��ɫ)
IF %X3:~0,1%==5 (SET T1=��ɫ)
IF %X3:~0,1%==6 (SET T1=��ɫ)
IF %X3:~0,1%==7 (SET T1=��ɫ)
IF %X3:~0,1%==8 (SET T1=��ɫ)
IF %X3:~0,1%==9 (SET T1=����ɫ)
IF %X3:~0,1%==A (SET T1=����ɫ)
IF %X3:~0,1%==B (SET T1=��ǳ��ɫ)
IF %X3:~0,1%==C (SET T1=����ɫ)
IF %X3:~0,1%==D (SET T1=����ɫ)
IF %X3:~0,1%==E (SET T1=����ɫ)
IF %X3:~0,1%==F (SET T1=����ɫ)
IF %X3:~1,1%==0 (SET T2=��ɫ)
IF %X3:~1,1%==1 (SET T2=��ɫ)
IF %X3:~1,1%==2 (SET T2=��ɫ)
IF %X3:~1,1%==3 (SET T2=����ɫ)
IF %X3:~1,1%==4 (SET T2=��ɫ)
IF %X3:~1,1%==5 (SET T2=��ɫ)
IF %X3:~1,1%==6 (SET T2=��ɫ)
IF %X3:~1,1%==7 (SET T2=��ɫ)
IF %X3:~1,1%==8 (SET T2=��ɫ)
IF %X3:~1,1%==9 (SET T2=����ɫ)
IF %X3:~1,1%==A (SET T2=����ɫ)
IF %X3:~1,1%==B (SET T2=��ǳ��ɫ)
IF %X3:~1,1%==C (SET T2=����ɫ)
IF %X3:~1,1%==D (SET T2=����ɫ)
IF %X3:~1,1%==E (SET T2=����ɫ)
IF %X3:~1,1%==F (SET T2=����ɫ)
SET Y3=3�����վ�����ɫ����%T1%�ϲ���%T2%��������Ϊ%T1%������Ϊ%T2%
GOTO CLEAR4

:CLEAR4
IF %X4:~0,1%==%X4:~1,1% (GOTO CLEAR6)
IF %X4:~0,1%==0 (SET T1=��ɫ)
IF %X4:~0,1%==1 (SET T1=��ɫ)
IF %X4:~0,1%==2 (SET T1=��ɫ)
IF %X4:~0,1%==3 (SET T1=����ɫ)
IF %X4:~0,1%==4 (SET T1=��ɫ)
IF %X4:~0,1%==5 (SET T1=��ɫ)
IF %X4:~0,1%==6 (SET T1=��ɫ)
IF %X4:~0,1%==7 (SET T1=��ɫ)
IF %X4:~0,1%==8 (SET T1=��ɫ)
IF %X4:~0,1%==9 (SET T1=����ɫ)
IF %X4:~0,1%==A (SET T1=����ɫ)
IF %X4:~0,1%==B (SET T1=��ǳ��ɫ)
IF %X4:~0,1%==C (SET T1=����ɫ)
IF %X4:~0,1%==D (SET T1=����ɫ)
IF %X4:~0,1%==E (SET T1=����ɫ)
IF %X4:~0,1%==F (SET T1=����ɫ)
IF %X4:~1,1%==0 (SET T2=��ɫ)
IF %X4:~1,1%==1 (SET T2=��ɫ)
IF %X4:~1,1%==2 (SET T2=��ɫ)
IF %X4:~1,1%==3 (SET T2=����ɫ)
IF %X4:~1,1%==4 (SET T2=��ɫ)
IF %X4:~1,1%==5 (SET T2=��ɫ)
IF %X4:~1,1%==6 (SET T2=��ɫ)
IF %X4:~1,1%==7 (SET T2=��ɫ)
IF %X4:~1,1%==8 (SET T2=��ɫ)
IF %X4:~1,1%==9 (SET T2=����ɫ)
IF %X4:~1,1%==A (SET T2=����ɫ)
IF %X4:~1,1%==B (SET T2=��ǳ��ɫ)
IF %X4:~1,1%==C (SET T2=����ɫ)
IF %X4:~1,1%==D (SET T2=����ɫ)
IF %X4:~1,1%==E (SET T2=����ɫ)
IF %X4:~1,1%==F (SET T2=����ɫ)
SET Y4=4���Զ��������ɫ����%T1%�ϲ���%T2%��������Ϊ%T1%������Ϊ%T2%
GOTO CLEAR5

:CLEAR5
IF NOT "%X5:~1,1%"=="" (GOTO CLEAR6)
IF "%X5%"=="0" (GOTO CLEAR6)
IF NOT "%X6:~1,1%"=="" (GOTO CLEAR6)
SET Y5=5����ͣʱ��Ϊ%X5%��
IF %X6%==1 (SET Y6=6�����뱣���Ѵ�) ELSE (SET Y6=6�����뱣���ѹر�)
GOTO CLEAR7

:CLEAR6
SET ERR=1
ECHO Win DOS���ñ�������ģ��Ƿ����ã�
CHOICE /C YN /T 10 /D Y /M "10���޶����󽫻��Զ����á�"
IF %ERRORLEVEL%==1 (GOTO RECOVER)
SET S1=START /REALTIME
SET S2=0E
SET S3=CF
SET S4=0A
SET S5=5
SET CHANGE=1
GOTO CLEAR8

:CLEAR7
IF /I %X2%==%X3% (GOTO CLEAR6)
IF /I %X2%==%X4% (GOTO CLEAR6)
IF /I %X3%==%X4% (GOTO CLEAR6)
IF /I "%1"=="/V" (GOTO V)
COLOR %X2%
IF %CHANGE%==0 (
	SET S1=%X1%
	SET S2=%X2%
	SET S3=%X3%
	SET S4=%X4%
	SET S5=%X5%
	SET S6=%X6%
	SET S7=%X7%
	SET CHANGE=1
)
IF NOT "%S1%"=="%X1%" (SET SETALL=1)
IF NOT %S2%==%X2% (SET SETALL=2)
IF NOT %S3%==%X3% (SET SETALL=3)
IF NOT %S4%==%X4% (SET SETALL=4)
IF NOT %S5%==%X5% (SET SETALL=5)
IF NOT %S6%==%X6% (SET SETALL=6)
IF "%S1%,%S2%,%S3%,%S4%,%S5%,%S6%,%S7%"=="%X1%,%X2%,%X3%,%X4%,%X5%,%X6%,%X7%" (SET SETALL=0)
CLS
ECHO Win DOS���ó��������
ECHO.
ECHO ��ǰ�ѱ����������Ϣ���£�
ECHO     %Y1%��
ECHO     %Y2%��
ECHO     %Y3%��
ECHO     %Y4%��
ECHO     %Y5%��
ECHO     %Y6%��
FOR /F "TOKENS=6 DELIMS=," %%I IN ('TYPE config.ini') DO (IF %%I==1 (IF %CK%==0 (GOTO C)))
GOTO MAIN

:CLEAR8
CLS
ECHO Win DOS���ó��������
ECHO.
ECHO ����������Ϣ�����á�
GOTO MAIN

:MAIN
ECHO.
ECHO �ɹ�ִ�е�ѡ�
ECHO     0=�˳�Win DOS���ó���
ECHO     1=��������
ECHO     2=����������ɫ����
ECHO     3=���վ�����ɫ����
ECHO     4=�Զ��������ɫ����
ECHO     5=��ͣʱ������
ECHO     6=���뱣������
ECHO     7=�鿴���ô���
ECHO     8=��������
IF NOT %SETALL%==0 (ECHO �����÷���������뱣�����ã���)
ECHO     9=��������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 1234567890
IF %ERRORLEVEL%==1 (GOTO SET11)
IF %ERRORLEVEL%==2 (GOTO SET21)
IF %ERRORLEVEL%==3 (GOTO SET31)
IF %ERRORLEVEL%==4 (GOTO SET41)
IF %ERRORLEVEL%==5 (GOTO SET5)
IF %ERRORLEVEL%==6 (GOTO SET61)
IF %ERRORLEVEL%==7 (GOTO SET7)
IF %ERRORLEVEL%==8 (GOTO SET8)
IF %ERRORLEVEL%==9 (GOTO SET10)
IF %ERRORLEVEL%==10 (GOTO SET0)

:SET0
IF %SETALL%==0 (START /REALTIME /I "" WELCOME.BAT&EXIT)
CALL SET YALL=%%ALL%SETALL%%%
CLS
ECHO ��ȷ�ϣ������ٱ����%YALL%����δ���档
ECHO �����ѱ������ȷ���������ò��˳�������
CHOICE /C YN
IF /I %ERRORLEVEL%==2 (GOTO A)
START /REALTIME /I "" WELCOME.BAT
EXIT

:SET11
CLS
IF %ERR%==0 (ECHO ��ǰ״̬��%Y1%��) ELSE (ECHO ����������Ϣ�����á�)
ECHO.
ECHO ��������-���ȼ��������
ECHO   0=���������
ECHO   1=ʵʱ��Ĭ��ֵ��
ECHO   2=��
ECHO   3=���ڱ�׼
ECHO   4=��׼
ECHO   5=���ڱ�׼
ECHO   6=��
ECHO ��ѡ��һ���������ȼ���
CHOICE /C 1234560
IF %ERRORLEVEL%==1 (SET S1=/REALTIME)
IF %ERRORLEVEL%==2 (SET S1=/HIGH)
IF %ERRORLEVEL%==3 (SET S1=/ABOVENORMAL)
IF %ERRORLEVEL%==4 (SET S1=/NORMAL)
IF %ERRORLEVEL%==5 (SET S1=/BELOWNORMAL)
IF %ERRORLEVEL%==6 (SET S1=/LOW)
IF %ERRORLEVEL%==7 (GOTO A)
GOTO SET12

:SET12
CLS
IF %ERR%==0 (ECHO ��ǰ״̬��%Y1%��) ELSE (ECHO ����������Ϣ�����á�)
ECHO.
ECHO ��������-��������������
ECHO   0=�������ȼ��������
ECHO   1=������
ECHO   2=������壨Ĭ��ֵ��
ECHO   3=��С�����
ECHO ��ѡ��һ��������壺
CHOICE /C 1230
IF %ERRORLEVEL%==1 (SET S1=/MAX %S1%)
IF %ERRORLEVEL%==3 (SET S1=/MIN %S1%)
IF %ERRORLEVEL%==4 (GOTO SET11)
GOTO SET13

:SET13
CLS
IF %ERR%==0 (ECHO ��ǰ״̬��%Y1%��) ELSE (ECHO ����������Ϣ�����á�)
ECHO.
ECHO ��������-�ȴ����������
ECHO   0=���������������
ECHO   1=���õȴ���
ECHO   2=ͣ�õȴ�����Ĭ��ֵ��
ECHO ��ѡ��һ���Լ�����
CHOICE /C 120
IF %ERRORLEVEL%==1 (SET S1=/WAIT %S1%)
IF %ERRORLEVEL%==3 (GOTO SET12)
GOTO SET14

:SET14
SET S1=START %S1%
CLS
ECHO �������û�����ϣ�
PAUSE
GOTO A

:SET21
IF %ERR%==0 (FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE config.ini') DO (COLOR %%I))
CLS
ECHO ����������ɫ�������
IF %ERR%==0 (ECHO ��ǰ״̬��%Y2%��) ELSE (ECHO ����������Ϣ�����á�)
ECHO.
ECHO ��ɫ�������£�
ECHO   0=��ɫ       8=��ɫ
ECHO   1=��ɫ       9=����ɫ
ECHO   2=��ɫ       A=����ɫ
ECHO   3=����ɫ     B=��ǳ��ɫ
ECHO   4=��ɫ       C=����ɫ
ECHO   5=��ɫ       D=����ɫ
ECHO   6=��ɫ       E=����ɫ
ECHO   7=��ɫ       F=����ɫ
ECHO ��ѡ�񱳾���ɫ�����롰Q����������塣
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (GOTO A)
IF %ERRORLEVEL%==10 (SET S2=0&GOTO SET22)
IF %ERRORLEVEL%==11 (SET S2=A&GOTO SET22)
IF %ERRORLEVEL%==12 (SET S2=B&GOTO SET22)
IF %ERRORLEVEL%==13 (SET S2=C&GOTO SET22)
IF %ERRORLEVEL%==14 (SET S2=D&GOTO SET22)
IF %ERRORLEVEL%==15 (SET S2=E&GOTO SET22)
IF %ERRORLEVEL%==16 (SET S2=F&GOTO SET22)
SET S2=%ERRORLEVEL%
GOTO SET22

:SET22
ECHO ��ѡ��������ɫ�����롰Q�����豳����ɫ��
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (SET S2=%X2%&GOTO SET21)
IF %ERRORLEVEL%==10 (SET T2=0&GOTO SET23)
IF %ERRORLEVEL%==11 (SET T2=A&GOTO SET23)
IF %ERRORLEVEL%==12 (SET T2=B&GOTO SET23)
IF %ERRORLEVEL%==13 (SET T2=C&GOTO SET23)
IF %ERRORLEVEL%==14 (SET T2=D&GOTO SET23)
IF %ERRORLEVEL%==15 (SET T2=E&GOTO SET23)
IF %ERRORLEVEL%==16 (SET T2=F&GOTO SET23)
SET T2=%ERRORLEVEL%
GOTO SET23

:SET23
IF %S2%==%T2% (SET S2=%X2%&SET GO=2&GOTO SET9)
SET S2=%S2%%T2%
COLOR %S2%
CLS
ECHO ����ѡ�����ɫ�統ǰ��Ļ��ɫ��ʾ���Ƿ�ȷ�ϣ�
CHOICE /C YN
IF %ERRORLEVEL%==2 (SET S2=%X2%&GOTO SET21)
CLS
ECHO ���������ɫ���û�����ϣ�
PAUSE
GOTO A

:SET31
IF %ERR%==0 (FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE config.ini') DO (COLOR %%I))
CLS
ECHO ���վ�����ɫ�������
IF %ERR%==0 (ECHO ��ǰ״̬��%Y3%��) ELSE (ECHO ����������Ϣ�����á�)
ECHO.
ECHO ��ɫ�������£�
ECHO   0=��ɫ       8=��ɫ
ECHO   1=��ɫ       9=����ɫ
ECHO   2=��ɫ       A=����ɫ
ECHO   3=����ɫ     B=��ǳ��ɫ
ECHO   4=��ɫ       C=����ɫ
ECHO   5=��ɫ       D=����ɫ
ECHO   6=��ɫ       E=����ɫ
ECHO   7=��ɫ       F=����ɫ
ECHO ��ѡ�񱳾���ɫ�����롰Q����������塣
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (GOTO A)
IF %ERRORLEVEL%==10 (SET S3=0&GOTO SET32)
IF %ERRORLEVEL%==11 (SET S3=A&GOTO SET32)
IF %ERRORLEVEL%==12 (SET S3=B&GOTO SET32)
IF %ERRORLEVEL%==13 (SET S3=C&GOTO SET32)
IF %ERRORLEVEL%==14 (SET S3=D&GOTO SET32)
IF %ERRORLEVEL%==15 (SET S3=E&GOTO SET32)
IF %ERRORLEVEL%==16 (SET S3=F&GOTO SET32)
SET S3=%ERRORLEVEL%
GOTO SET32

:SET32
ECHO ��ѡ��������ɫ�����롰Q�����豳����ɫ��
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (SET S3=%X2%&GOTO SET31)
IF %ERRORLEVEL%==10 (SET T3=0&GOTO SET33)
IF %ERRORLEVEL%==11 (SET T3=A&GOTO SET33)
IF %ERRORLEVEL%==12 (SET T3=B&GOTO SET33)
IF %ERRORLEVEL%==13 (SET T3=C&GOTO SET33)
IF %ERRORLEVEL%==14 (SET T3=D&GOTO SET33)
IF %ERRORLEVEL%==15 (SET T3=E&GOTO SET33)
IF %ERRORLEVEL%==16 (SET T3=F&GOTO SET33)
SET T3=%ERRORLEVEL%
GOTO SET33

:SET33
IF %S3%==%T3% (SET S3=%X2%&SET GO=3&GOTO SET9)
SET S3=%S3%%T3%
COLOR %S3%
CLS
ECHO ����ѡ�����ɫ�統ǰ��Ļ��ɫ��ʾ���Ƿ�ȷ�ϣ�
CHOICE /C YN
IF %ERRORLEVEL%==2 (SET S3=%X2%&GOTO SET31)
CLS
ECHO ���վ�����ɫ���û�����ϣ�
PAUSE
GOTO A

:SET41
IF %ERR%==0 (FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE config.ini') DO (COLOR %%I))
CLS
ECHO �Զ��������ɫ�������
IF %ERR%==0 (ECHO ��ǰ״̬��%Y4%��) ELSE (ECHO ����������Ϣ�����á�)
ECHO.
ECHO ��ɫ�������£�
ECHO   0=��ɫ       8=��ɫ
ECHO   1=��ɫ       9=����ɫ
ECHO   2=��ɫ       A=����ɫ
ECHO   3=����ɫ     B=��ǳ��ɫ
ECHO   4=��ɫ       C=����ɫ
ECHO   5=��ɫ       D=����ɫ
ECHO   6=��ɫ       E=����ɫ
ECHO   7=��ɫ       F=����ɫ
ECHO ��ѡ�񱳾���ɫ�����롰Q����������塣
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (GOTO A)
IF %ERRORLEVEL%==10 (SET S4=0&GOTO SET42)
IF %ERRORLEVEL%==11 (SET S4=A&GOTO SET42)
IF %ERRORLEVEL%==12 (SET S4=B&GOTO SET42)
IF %ERRORLEVEL%==13 (SET S4=C&GOTO SET42)
IF %ERRORLEVEL%==14 (SET S4=D&GOTO SET42)
IF %ERRORLEVEL%==15 (SET S4=E&GOTO SET42)
IF %ERRORLEVEL%==16 (SET S4=F&GOTO SET42)
SET S4=%ERRORLEVEL%
GOTO SET42

:SET42
ECHO ��ѡ��������ɫ�����롰Q�����豳����ɫ��
CHOICE /C 1234567890ABCDEFQ
IF %ERRORLEVEL%==17 (SET S4=%X2%&GOTO SET41)
IF %ERRORLEVEL%==10 (SET T4=0&GOTO SET43)
IF %ERRORLEVEL%==11 (SET T4=A&GOTO SET43)
IF %ERRORLEVEL%==12 (SET T4=B&GOTO SET43)
IF %ERRORLEVEL%==13 (SET T4=C&GOTO SET43)
IF %ERRORLEVEL%==14 (SET T4=D&GOTO SET43)
IF %ERRORLEVEL%==15 (SET T4=E&GOTO SET43)
IF %ERRORLEVEL%==16 (SET T4=F&GOTO SET43)
SET T4=%ERRORLEVEL%
GOTO SET43

:SET43
IF %S4%==%T4% (SET S4=%X2%&SET GO=2&GOTO SET9)
SET S4=%S4%%T4%
COLOR %S4%
CLS
ECHO ����ѡ�����ɫ�統ǰ��Ļ��ɫ��ʾ���Ƿ�ȷ�ϣ�
CHOICE /C YN
IF %ERRORLEVEL%==2 (SET S4=%X2%&GOTO SET41)
CLS
ECHO �Զ��������ɫ���û�����ϣ�
PAUSE
GOTO A

:SET5
CLS
ECHO ��ͣʱ���������
IF %ERR%==0 (ECHO ��ǰ״̬��%Y5%��) ELSE (ECHO ����������Ϣ�����á�)
ECHO.
ECHO 0=��������壬1-9Ϊ��Ч���֡�
ECHO ��ѡ��һ����Ч���֣�
CHOICE /C 1234567890
IF %ERRORLEVEL%==10 (GOTO A)
SET S5=%ERRORLEVEL%
IF NOT EXIST SLEEP.EXE (IF EXIST DEBUG.EXE (GOTO SET52) ELSE (GOTO SET53))

:SET51
ECHO ��ͣʱ�����û�����ϣ�
GOTO A

:SET52
ECHO ��ʧsleep.exe�����ڳ����޸������Ժ�...
IF NOT EXIST DEBUG.EXE (GOTO 53)
IF NOT %PROCESSOR_ARCHITECTURE:~-2%==64 (GOTO 53)
ECHO q | debug>nul
ECHO Bj@jzh`0X-`/PPPPPPa(DE(DM(DO(Dh(Ls(Lu(LX(LeZRR]EEEUYRX2Dx=>sleep.com
ECHO 0DxFP,0Xx.t0P,=XtGsB4o@$?PIyU WwX0GwUY Wv;ovBX2Gv0ExGIuht6>>sleep.com
ECHO T}{z~~@GwkBG@OEKcUt`~}@MqqBsy?seHB~_Phxr?@zAB`LrPEyoDt@Cj?>>sleep.com
ECHO pky_jN@QEKpEt@ij?jySjN@REKpEt@jj?jyGjN@SEKkjtlGuNw?p@pjirz>>sleep.com
ECHO LFvAURQ?OYLTQ@@?~QCoOL~RDU@?aU?@{QOq?@}IKuNWpe~FpeQFwH?Vkk>>sleep.com
ECHO _GSqoCvH{OjeOSeIQRmA@KnEFB?p??mcjNne~B?M??QhetLBgBPHexh@e=>>sleep.com
ECHO EsOgwTLbLK?sFU`?LDOD@@K@xO?SUudA?_FKJ@N?KD@?UA??O}HCQOQ??R>>sleep.com
ECHO _OQOL?CLA?CEU?_FU?UAQ?UBD?LOC?ORO?UOL?UOD?OOI?UgL?LOR@YUO?>>sleep.com
ECHO dsmSQswDOR[BQAQ?LUA?_L_oUNUScLOOuLOODUO?UOE@OwH?UOQ?DJTSDM>>sleep.com
ECHO QTqrK@kcmSULkPcLOOuLOOFUO?hwDTqOsTdbnTQrrDsdFTlnBTm`lThKcT>>sleep.com
ECHO @dmTkRQSoddTT~?K?OCOQp?o??Gds?wOw?PGAtaCHQvNntQv_w?A?it\EH>>sleep.com
ECHO {zpQpKGk?Jbs?FqokOH{T?jPvP@IQBDFAN?OHROL?Kj??pd~aN?OHROd?G>>sleep.com
ECHO Q??PGT~B??OC~?ipO?T?~U?p~cUo0x>>sleep.com
sleep.com>sleep.exe
IF EXIST sleep.exe (DEL /A /F /Q sleep.com)

:SET53
ECHO ���棺��ʧsleep.exe���޷��޸��������°�װWin DOS��
ECHO �밴�������������塣
PAUSE>NUL
GOTO A

:SET6
CLS
ECHO ���������������������룬�������������һ����塣
PAUSE>NUL
IF %GO%==MAIN (GOTO A)
GOTO %GO%

:SET61
CLS
ECHO ���뱣���������
IF %ERR%==0 (ECHO ��ǰ״̬��%Y6%��) ELSE (ECHO ����������Ϣ�����á�)
ECHO ���뱣��ʱ������������塢�鿴����������Լ�ж�ر�����
ECHO.
ECHO ���Ƿ�Ҫ�������룿
CHOICE /C CYN /M "Y=���ã�N=ͣ�ã�C=ȡ��"
IF %ERRORLEVEL%==1 (GOTO A)
GOTO SET6%ERRORLEVEL%

:SET62
CLS
IF %X6%==0 (GOTO SET65)
ECHO ���Ƿ���Ҫ�޸����룿�޸����뽫�Զ��������ã����μ��������롣
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO SET64)
GOTO A

:SET63
IF %X6%==1 (GOTO SET66) ELSE (SET S6=0&GOTO A)

:SET64
CLS
ECHO �����ڵ�������������ԭ���롣
START /WAIT /REALTIME /I "" password.bat /V
IF NOT EXIST "%TEMP%\V" (GOTO A)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (GOTO A))
DEL "%TEMP%\V" /A /F /Q
IF EXIST "%TEMP%\V" (SET GO=SET65&GOTO E)

:SET65
SET S6=1
CLS
SETLOCAL ENABLEDELAYEDEXPANSION
IF %X6%==0 (
	ECHO ���Ƿ���Ҫ�޸����룿�޸����뽫�Զ��������ã����μ��������롣
	CHOICE /C YN
	IF !ERRORLEVEL!==2 (GOTO A)
)
ENDLOCAL
CLS
DEL "%TEMP%\password.vbs" /A /F /Q
DEL "%TEMP%\password.txt" /A /F /Q
IF EXIST "%TEMP%\password.vbs" (GOTO SET67)
IF EXIST "%TEMP%\password.txt" (GOTO SET67)
ECHO a=inputbox("������֧�����֣�Ӣ�Ĵ�Сд�������Լ�����������š��붨���µ����룬ֱ�ӻس���ȡ�����뽫ʹ��ԭ���룺","Win DOS����¼�����") >"%TEMP%\password.vbs"
ECHO If Len(a)^>0 Then>>"%TEMP%\password.vbs"
ECHO Dim fso, File>>"%TEMP%\password.vbs"
ECHO Set fso=CreateObject("Scripting.FileSystemObject")>>"%TEMP%\password.vbs"
ECHO Set File=fso.CreateTextFile("%TEMP%\password.txt", True)>>"%TEMP%\password.vbs"
ECHO File.WriteLine(a)>>"%TEMP%\password.vbs"
ECHO File.Close>>"%TEMP%\password.vbs"
ECHO End If>>"%TEMP%\password.vbs"
IF EXIST "%TEMP%\password.vbs" (GOTO SET68) ELSE (GOTO SET67)

:SET66
CLS
ECHO ������ԭ���롣
START /WAIT /REALTIME /I "" password.bat /V
IF NOT EXIST "%TEMP%\V" (GOTO A)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (GOTO A))
SET S6=0
DEL "%TEMP%\V" /A /F /Q
IF EXIST "%TEMP%\V" (SET GO=A&GOTO E)
CLS
GOTO A

:SET67
CLS
ECHO ���������޷����������롣�Ƿ����ԣ�
ECHO ���������������鴰�ڣ��뽫��ر����ԡ�
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO SET65)
GOTO A

:SET68
CLS
ECHO ���ڵ��������ж��������롣
START /REALTIME /WAIT /I "" "%TEMP%\password.vbs"
IF NOT EXIST "%TEMP%\password.txt" (GOTO A)
FIND "," "%TEMP%\password.txt"
IF %ERRORLEVEL%==0 (ECHO ������������к��в�������ַ�������,�����밴��������¶��������롣&PAUSE>NUL&GOTO SET68)
TYPE "%TEMP%\password.txt"|FINDSTR /C:"""
IF %ERRORLEVEL%==0 (ECHO ������������к��в�������ַ�������^"�����밴��������¶��������롣&PAUSE>NUL&GOTO SET68)
FIND ">" "%TEMP%\password.txt"
IF %ERRORLEVEL%==0 (ECHO ������������к��в�������ַ�������^>�����밴��������¶��������롣&PAUSE>NUL&GOTO SET68)
FIND "<" "%TEMP%\password.txt"
IF %ERRORLEVEL%==0 (ECHO ������������к��в�������ַ�������^<�����밴��������¶��������롣&PAUSE>NUL&GOTO SET68)
FOR /F %%I IN ('TYPE "%TEMP%\password.txt"') DO (SET S7=%%I)
CLS
ECHO ��ȷ�����������룺
ECHO %S7%
PAUSE
GOTO SET8

:SET7
CLS
ECHO ����鿴���
ECHO.
ECHO Դ���룺
ECHO %X1%,^%X2%,^%X3%,^%X4%,^%X5%,^%X6%
ECHO �ѻ���Ĵ��룺
ECHO %S1%,^%S2%,^%S3%,^%S4%,^%S5%,^%S6%
ECHO �����ϣ�
ECHO.
IF %SETALL%==0 (
	ECHO ����δ�����
	PAUSE
	GOTO A
)
ECHO �����ѱ�����Ƿ񱣴�����
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO SET8)
GOTO A

:SET8
CLS
IF /I %S2%==%S3% (IF %S2%==%S4% (SET CS=�������������ɫ��&GOTO SET8S) ELSE (SET CS=����������ɫ�ͷ��վ�����ɫ&GOTO SET8S))
IF /I %S2%==%S4% (SET CS=����������ɫ���Զ��������ɫ&GOTO SET8S)
IF /I %S3%==%S4% (SET CS=���վ�����ɫ���Զ��������ɫ&GOTO SET8S)
SET ERR=0
ECHO ���ڳ��Ա������ã����Ժ�...
CACLS config.ini /E /G SYSTEM:F>NUL
CACLS config.ini /E /G ADMINISTRATORS:F>NUL
CACLS config.ini /E /G %USERNAME%:F>NUL
CACLS config.ini /E /G USERS:F>NUL
CACLS config.ini /E /G EVERYONE:F>NUL
DEL /A /F /Q config.ini>NUL
IF /I EXIST config.ini (CLS&ECHO ɾ��ԭ����ʧ�ܣ���ȷ����û�����ж�����ó���&SET ERR=1)
ECHO.%S1%,^%S2%,^%S3%,^%S4%,^%S5%,^%S6%,^%S7%>config.ini
ATTRIB +A +H +R +S config.ini
IF /I NOT EXIST config.ini (ECHO ��������ʧ�ܣ���ȷ��������������û�н�ֹ�����ļ���&SET ERR=1)
IF ERR==1 (GOTO SET8E)
SET SETALL=0
SET CHANGE=0
CLS
ECHO �������óɹ���
PAUSE
GOTO CLEAR1

:SET8E
ECHO ���̳��ִ����Ƿ����ԣ�
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO SET7)
GOTO CLEAR1

:SET8S
ECHO �����õ�%CS%��ͬ���밴������������á�
PAUSE>NUL
GOTO A

:SET9
CLS
ECHO ��ѡ������ɫ�ͱ�����ɫ��ͬ��������ѡ�񣬰������������һ����塣
PAUSE>NUL
GOTO SET%GO%1

:SET10
CLS
ECHO ȷ���������ã�
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO RECOVER)

:A
IF %ERR%==0 (GOTO CLEAR7) ELSE (GOTO CLEAR8)

:C
CLS
ECHO ���������뱣����������ԭ���롣
START /WAIT /REALTIME /I "" password.bat /V
IF NOT EXIST "%TEMP%\V" (ECHO ��ȡ���������������������밴������˳���&PAUSE>NUL&EXIT)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (ECHO ��ȡ���������������������밴������˳���&PAUSE>NUL&EXIT))
SET CK=1
DEL "%TEMP%\V" /A /F /Q
IF NOT EXIST "%TEMP%\V" (GOTO CLEAR7)
SET GO=CLEAR7

:E
CLS
ECHO �޷�ɾ�������ļ������ܻ����������������顣�Ƿ����ԣ�
CHOICE /C RG /M "R=���ԣ�G=���Դ��󣬼������С�"
IF %ERRORLEVEL%==2 (GOTO %GO%)
DEL /A /F /Q "%TEMP%\V"
IF EXIST "%TEMP%\V" (GOTO E)
GOTO %GO%

:RECOVER
CD /D "%~DP0"
CLS
START /WAIT /REALTIME /I "%~S0" /V
IF NOT EXIST "%TEMP%\V" (GOTO R)
CLS
ECHO ������ԭ���롣
START /WAIT /REALTIME /I "" password.bat /V
IF NOT EXIST "%TEMP%\V" (ECHO ��ȡ���������������������޷��������ã��밴������˳���&PAUSE>NUL&EXIT)
FOR /F %%I IN ('TYPE "%TEMP%\V"') DO (IF NOT "%%I"=="V" (ECHO ��ȡ���������������������޷��������ã��밴������˳���&PAUSE>NUL&EXIT))
DEL "%TEMP%\V" /A /F /Q
IF EXIST "%TEMP%\V" (SET GO=R&GOTO E)

:R
CLS
ECHO �����������ã����Ժ�...
CACLS config.ini /E /G SYSTEM:F
CACLS config.ini /E /G ADMINISTRATORS:F
CACLS config.ini /E /G %USERNAME%:F
CACLS config.ini /E /G USERS:F
CACLS config.ini /E /G EVERYONE:F
DEL /A /F /Q config.ini
IF /I EXIST config.ini (CLS&ECHO ɾ��ԭ����ʧ�ܣ���ȷ����û�����ж�����ó���&SET ERR=1)
ECHO START /REALTIME,^0E,CF,^0A,^5,^0,12345678>config.ini
ATTRIB +A +H +R +S config.ini
IF /I NOT EXIST config.ini (ECHO ��������ʧ�ܣ���ȷ��������������û�н�ֹ�����ļ���&SET ERR=1)
IF ERR==1 (GOTO SERR)
SET SETALL=0
SET CHANGE=0
CLS
ECHO ��ܰ��ʾ���������ú���Ҫ�������룬���ʼ����Ϊ12345678��
ECHO �������óɹ������������ú����������ʾ�����ñ�������ġ������������вα����ǡ�
PAUSE
IF /I "%1"=="/R" EXIT
GOTO CLEAR1

:SERR
ECHO �������ù����з������ش����Ƿ����ԣ�
CHOICE /C YN
IF %ERRORLEVEL%==1 (GOTO RECOVER)
IF /I "%1"=="/R" EXIT
GOTO CLEAR1

:V
DEL /A /F /Q "%TEMP%\V"
IF EXIST "%TEMP%\V" (SET GO=W&GOTO E)

:W
ECHO V>"%TEMP%\V"
EXIT