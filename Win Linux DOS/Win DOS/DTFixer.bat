@ECHO OFF
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ������ʱ��
SET MESS=0

:MAIN
CLS
ECHO ��ǰϵͳʱ�䣺%DATE% %TIME%��
ECHO   0=�˳�����
ECHO   1=�޸�������ʱ��
ECHO   2=�Զ�ͬ��
ECHO   3=��������ʱ��Ի���
ECHO ��ѡ��һ������Լ�����
CHOICE /C 1230
IF %ERRORLEVEL%==4 EXIT
CLS
IF %ERRORLEVEL%==3 (RUNDLL32 /D shell32.dll,Control_RunDLL timedate.cpl) ELSE (GOTO %ERRORLEVEL%)
ECHO ���û�е����Ի�����������ϵͳ��
PAUSE
GOTO MAIN

:1
CLS
IF NOT %MESS%==0 (ECHO %MESS%)
SET MESS=0
ECHO ˵�����˴��޸�������ʱ�佫���ƿ�ϵͳ�����ķ��ʻ��ƣ�ֱ�Ӵӵײ����д�롣
ECHO ��ǰϵͳʱ�䣺%DATE% %TIME%��
ECHO   Y=��  L=��  D=��
ECHO   H=ʱ  M=��  S=��
ECHO   1=���¼���������ʱ��
ECHO   0=���������
ECHO ��ѡ��һ���Լ�����
CHOICE /C YLDHMS10
CLS
IF %ERRORLEVEL%==8 (GOTO MAIN)
IF %ERRORLEVEL%==7 (GOTO 1)
SET /A F=%ERRORLEVEL%+2
GOTO %F%0

:2
CLS
W32TM /REGISTER
NET START "WINDOWS TIME"
W32TM /RESYNC
ECHO.
ECHO.
ECHO ���ʱ��̫������ȷ�������ͬ��ִ��ͬ�������������������塣
PAUSE>NUL
GOTO MAIN

:30
SET Y=
SET YC=0

:31
CLS
ECHO ����������B���ɷ�����һ����壬����M���ɷ�������壻
ECHO       ����Q�����������롣������λ����ϵͳ���Զ���ת��
ECHO �������꣺%Y%
CHOICE /C 1234567890BMQ>NUL
IF %ERRORLEVEL%==12 (GOTO MAIN)
IF %ERRORLEVEL%==11 (GOTO 1)
IF %ERRORLEVEL%==13 (GOTO 30)
IF %ERRORLEVEL%==10 (IF "%Y%"=="" (GOTO 31) ELSE (SET Y=%Y%0&SET /A YC+=1)) ELSE (SET Y=%Y%%ERRORLEVEL%&SET /A YC+=1)
IF %YC%==4 (GOTO 32) ELSE (GOTO 31)

:32
SET L=%DATE:~5,2%
SET D=%DATE:~8,2%
DATE %Y%-%L%-%D%
SET YY=%DATE:~0,4%
IF %YY%==%Y% (SET MESS=����޸ĳɹ���) ELSE (SET MESS=����޸�ʧ�ܣ�)
GOTO 10

:40
CLS
ECHO ����������B���ɷ�����һ����壬����M���ɷ�������塣
ECHO       ����0=10��  N=11��  D=12��
ECHO ��ѡ���£�
CHOICE /C 1234567890NDBM
IF %ERRORLEVEL%==14 (GOTO MAIN)
IF %ERRORLEVEL%==13 (GOTO 1)
SET L=%ERRORLEVEL%
IF %L% LSS 10 (SET L=0%L%)
SET Y=%DATE:~0,4%
SET D=%DATE:~8,2%
DATE %Y%-%L%-%D%
SET LL=%DATE:~5,2%
IF %LL%==%L% (SET MESS=�·��޸ĳɹ���) ELSE (SET MESS=�·��޸�ʧ�ܣ�)
GOTO 10

:50
CLS
ECHO ����������V���ɷ�����һ����壬����W���ɷ�������塣
ECHO       1-9�����ֶ�Ӧ�İ���     10������0
ECHO       A=11    B=12    C=13    D=14    E=15
ECHO       F=16    G=17    H=18    I=19    J=20
ECHO       K=21    L=22    M=23    N=24    O=25
ECHO       P=26    Q=27    R=28    S=29    T=30
ECHO       U=31    V=��һ�����    W=�����
ECHO ��ѡ���գ�
CHOICE /C 1234567890ABCDEFGHIJKLMNOPQRSTUVW
IF %ERRORLEVEL%==33 (GOTO MAIN)
IF %ERRORLEVEL%==32 (GOTO 1)
SET D=%ERRORLEVEL%
IF %D% LSS 10 (SET D=0%D%)
SET Y=%DATE:~0,4%
SET L=%DATE:~5,2%
DATE %Y%-%L%-%D%
SET DD=%DATE:~8,2%
IF %DD%==%D% (SET MESS=�պ��޸ĳɹ���) ELSE (SET MESS=�պ��޸�ʧ�ܣ�)
GOTO 10

:60
CLS
ECHO ����������P���ɷ�����һ����壬����Q���ɷ�������塣
ECHO       0-9�����ֶ�Ӧ�İ���     A=10    B=11    C=12
ECHO       D=13    E=14    F=15    G=16    H=17    I=18
ECHO       J=19    K=20    L=21    M=22    N=23
ECHO       P=��һ�����    Q=�����
ECHO ��ѡ��ʱ��
CHOICE /C 0123456789ABCDEFGHIJKLMNPQ
IF %ERRORLEVEL%==25 (GOTO MAIN)
IF %ERRORLEVEL%==24 (GOTO 1)
SET H=%ERRORLEVEL%
IF %H% LSS 10 (SET H=0%H%)
SET M=%TIME:~3,2%
TIME %H%:%M%
SET HH=%TIME:~0,2%
IF %HH%==%H% (SET MESS=Сʱ�޸ĳɹ���) ELSE (SET MESS=Сʱ�޸�ʧ�ܣ�)
SET HH=
GOTO 20

:70
CLS
ECHO ����������B���ɷ�����һ����壬����M���ɷ�������塣
ECHO ������֣���λ������������ɺ���Զ���ת��
CHOICE /C 123450BM>NUL
IF %ERRORLEVEL%==8 (GOTO MAIN)
IF %ERRORLEVEL%==7 (GOTO 1)
IF %ERRORLEVEL%==6 (SET M=0&GOTO 71)
SET M=%ERRORLEVEL%

:71
CHOICE /C 1234567890BM>NUL
IF %ERRORLEVEL%==12 (SET M=&GOTO MAIN)
IF %ERRORLEVEL%==11 (SET M=&GOTO 1)
IF %ERRORLEVEL%==10 (SET M=%M%0&GOTO 72)
SET M=%M%%ERRORLEVEL%

:72
SET H=%TIME:~0,2%
TIME %H%:%M%
SET MM=%TIME:~3,2%
IF %MM%==%M% (SET MESS=�����޸ĳɹ���) ELSE (SET MESS=�����޸�ʧ�ܣ�)
SET MM=
GOTO 20

:80
CLS
IF NOT EXIST "%COMSPEC:~0,-7%SLEEP.EXE" (IF NOT EXIST SLEEP.EXE (ECHO ��ʧsleep.exe���޷��������밴�����������һ����塣&ECHO ��Ҳ���Գ�����Win DOS�����ڶ�ҳ��ѡ��N���޸���&PAUSE>NUL&GOTO 1))
IF %TIME:~3,2%==59 (GOTO 83)
ECHO ����Ԥ�������Ժ�...
SET S=1
SET Z=1
SET A=%TIME:~9,2%
SET H=%TIME:~0,2%
SET M=%TIME:~3,2%
SET /A M+=1
SET /A S=60-S
CLS
ECHO ����ʱ�侫׼������ȴ�%S%�롣
SET B=%TIME:~9,2%
SET /A Z=B-A
IF %Z% LSS 0 (SET /A Z+=60)
IF %Z% LSS 10 (SET Z=0%Z%)
CLS
ECHO ˵�������ý���������ڶ�λ��һ˲��Ч��
ECHO ����������B���ɷ�����һ����壬����M���ɷ�������塣
ECHO �������루��λ������������ɺ���Զ���ת��
CHOICE /C 123450BM>NUL
IF %ERRORLEVEL%==8 (GOTO MAIN)
IF %ERRORLEVEL%==7 (GOTO 1)
IF %ERRORLEVEL%==6 (SET S=0&GOTO 81)
SET S=%ERRORLEVEL%

:81
CHOICE /C 1234567890BM>NUL
IF %ERRORLEVEL%==12 (SET S=&GOTO MAIN)
IF %ERRORLEVEL%==11 (SET S=&GOTO 1)
IF %ERRORLEVEL%==10 (SET S=%S%0&GOTO 82)
SET S=%S%%ERRORLEVEL%

:82
SET H=%TIME:~0,2%
SET M=%TIME:~3,2%
SET /A M+=1
SET /A S=60-S
CLS
ECHO ����ʱ�侫׼������ȴ�%S%�롣
IF %M%==60 (GOTO 83)
SLEEP %S%%Z%0
TIME %H%:%M%
SET S=
SET Z=
SET MESS=��ȷ����ɹ���
GOTO 20

:83
SET S=
ECHO ϵͳ�������㣬Ϊ��ֹ�������Ժ����ԡ�
PAUSE
GOTO 20

:10
SET Y=
SET L=
SET D=
SET YY=
SET YC=
GOTO 1

:20
SET H=
SET M=
GOTO 1