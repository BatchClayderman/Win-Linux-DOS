@ECHO OFF
CHCP 936
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET V=0
SET X=0
SET N=1
IF EXIST "%COMSPEC:~0,-7%wbem\wmic.exe" (SET W=1) ELSE (SET W=0)
GOTO M

:M
TITLE ���̹���
CLS
ECHO ���̹��������
IF %W%==0 (ECHO ϵͳ�ļ�wmic.exe���ⶪʧ�����ֶ��鿴Ӳ����Ϣ�����в��㣬���½⣡) ELSE (WMIC LOGICALDISK GET CAPTION,VOLUMENAME)
ECHO   0=�˳�����
ECHO   1=������
ECHO   2=ת��ΪNTFS
ECHO   3=��ʽ������
ECHO   4=�޸ľ��
ECHO   5=��Ƭ����
ECHO ��ѡ��һ���Լ�����
CHOICE /C 123450
SET C=%ERRORLEVEL%
IF %C%==6 EXIT
GOTO MAIN

:MAIN
CLS
ECHO ����ѡ�����
IF %W%==0 (ECHO ϵͳ�ļ�wmic.exe���ⶪʧ�����ֶ��鿴Ӳ����Ϣ�����в��㣬���½⣡) ELSE (WMIC LOGICALDISK GET CAPTION,VOLUMENAME)
IF %C%==1 (ECHO ����Ҫ����ĸ����̣�)
IF %C%==2 (ECHO ����Ҫ���ĸ�����ת��ΪNTFS��ʽ��)
IF %C%==3 (ECHO ����Ҫ��ʽ���ĸ����̣�)
IF %C%==4 (ECHO ����Ҫ���ĸ����̽�����Ƭ����)
ECHO ������ѡ��0���ɷ�������塣
CHOICE /C 0CDEFGHIJKLMNOPQRSTUVWXYZ
IF %ERRORLEVEL%==1 (GOTO M)
IF %ERRORLEVEL%==2 (SET D=C)
IF %ERRORLEVEL%==3 (SET D=D)
IF %ERRORLEVEL%==4 (SET D=E)
IF %ERRORLEVEL%==5 (SET D=F)
IF %ERRORLEVEL%==6 (SET D=G)
IF %ERRORLEVEL%==7 (SET D=H)
IF %ERRORLEVEL%==8 (SET D=I)
IF %ERRORLEVEL%==9 (SET D=J)
IF %ERRORLEVEL%==10 (SET D=K)
IF %ERRORLEVEL%==11 (SET D=L)
IF %ERRORLEVEL%==12 (SET D=M)
IF %ERRORLEVEL%==13 (SET D=N)
IF %ERRORLEVEL%==14 (SET D=O)
IF %ERRORLEVEL%==15 (SET D=P)
IF %ERRORLEVEL%==16 (SET D=Q)
IF %ERRORLEVEL%==17 (SET D=R)
IF %ERRORLEVEL%==18 (SET D=S)
IF %ERRORLEVEL%==19 (SET D=T)
IF %ERRORLEVEL%==20 (SET D=U)
IF %ERRORLEVEL%==21 (SET D=V)
IF %ERRORLEVEL%==22 (SET D=W)
IF %ERRORLEVEL%==23 (SET D=X)
IF %ERRORLEVEL%==24 (SET D=Y)
IF %ERRORLEVEL%==25 (SET D=Z)
SET D=%D%:
ECHO %D%
CLS
GOTO %C%

:1
IF NOT EXIST "%COMSPEC:~0,-7%CHKDSK.EXE" (SET E=chkdsk.exe&GOTO E)
ECHO ���õ�ģʽ���£�
ECHO   0=����ѡ�����
ECHO   1=ֻ��ģʽ
ECHO   2=�޸�ģʽ
ECHO   3=ж��ģʽ���Ƽ�ʹ�ã�
ECHO   4=���벻ж��ģʽ
ECHO   5=ж������ģʽ
ECHO ��ѡ��һ��ģʽ���%D:~0,-1%�̣�
CHOICE /C 123450
IF %ERRORLEVEL%==1 (SET OP=)
IF %ERRORLEVEL%==2 (SET OP=/F)
IF %ERRORLEVEL%==3 (SET OP=/X)
IF %ERRORLEVEL%==4 (SET OP=/R)
IF %ERRORLEVEL%==5 (SET OP=/X /R)
IF %ERRORLEVEL%==6 (GOTO MAIN)
CLS
TITLE ���ڰ�Ҫ�������%D%�����Ժ�...
CHKDSK %OP% %D%
GOTO 7

:2
CLS
IF NOT EXIST "%COMSPEC:~0,-7%CONVERT.EXE" (SET E=convert.exe&GOTO E)
ECHO �ɵ����Ĳ������£�
ECHO   0=����ѡ�����
IF %X%==0 (ECHO   1=����ж��ģʽ����ǰ�ѽ���ж��ģʽ��) ELSE (ECHO   1=����ж��ģʽ����ǰ������ж��ģʽ��)
IF %V%==0 (ECHO   2=������ϸģʽ����ǰ�ѽ�����ϸģʽ��) ELSE (ECHO   2=������ϸģʽ����ǰ��������ϸģʽ��)
IF %N%==0 (ECHO   3=���ù���ģʽ����ǰ�ѽ��ù���ģʽ��) ELSE (ECHO   3=���ù���ģʽ����ǰ�����ù���ģʽ��)
ECHO   4=ִ�в���
ECHO ��ѡ��һ���Խ�%D%ת��ΪNTFS��ʽ��
CHOICE /C 12340
IF %ERRORLEVEL%==1 (IF %X%==0 (SET X=1) ELSE (SET X=0))
IF %ERRORLEVEL%==2 (IF %V%==0 (SET V=1) ELSE (SET V=0))
IF %ERRORLEVEL%==3 (IF %N%==0 (SET N=1) ELSE (SET N=0))
IF %ERRORLEVEL%==4 (GOTO 6)
IF %ERRORLEVEL%==5 (GOTO MAIN)
GOTO 2

:3
IF NOT EXIST "%COMSPEC:~0,-7%FORMAT.COM" (SET E=format.com&GOTO E)
ECHO ����ѡ��%D%��
ECHO   0=����ѡ�����
ECHO   1=NTFS��������
ECHO   2=FAT
ECHO   3=FAT32
ECHO ��ѡ��һ���ļ�ϵͳ��
CHOICE /C 1230
IF %ERRORLEVEL%==1 (SET OP=NTFS)
IF %ERRORLEVEL%==2 (SET OP=FAT)
IF %ERRORLEVEL%==3 (SET OP=FAT32)
IF %ERRORLEVEL%==4 (GOTO MAIN)
ECHO �Ƿ���ٸ�ʽ����
CHOICE /C YN
IF %ERRORLEVEL%==1 (SET OP=%OP% /Q)
ECHO �Ƿ�ǿ�Ƹ�ʽ����
CHOICE /C YN
IF %ERRORLEVEL%==1 (SET OP=%OP% /X)
CLS
FOR /F "TOKENS=3 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
ECHO ���棺1�����򽫻��ʽ��%D:~0,-1%�̣��������ݽ���ʧ���޷��ָ���
ECHO       2����������ݶ�ʧ���������þ��ף�����˾�Ų�����
ECHO       3��רҵ��ʽ��Ӳ�̣��Ƽ�ʹ��DiskGeniusӲ�̷������ߣ�
ECHO       4�����ڰ�ȫ���ǣ����������ʽ���������ֶ������ꡣ
IF /I NOT %W%==0 (FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK WHERE CAPTION^="%D%" GET CAPTION,VOLUMENAME') DO (ECHO ϵͳ��⵽%D:~0,-1%�̵ľ��Ϊ��%%I����))
TITLE ���ڰ�Ҫ���ʽ��%D%�����Ժ�...
FORMAT /FS:%OP% %D%
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
GOTO 7

:4
IF NOT EXIST "%COMSPEC:~0,-7%LABEL.EXE" (SET E=label.exe&GOTO E)
IF %W%==1 (FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK WHERE CAPTION^="%D%" GET CAPTION,VOLUMENAME') DO (ECHO ϵͳ��⵽%D:~0,-1%�̵ľ��Ϊ��%%I����))
ECHO ������%D%�ľ�겢�س���
SET /P L=
LABEL %D% %L%
GOTO 7

:5
TITLE ���ڶ�%D%������Ƭ�������Ժ�...
CLS
DEFRAG /F %D%
GOTO 7

:6
TITLE ���ڽ�%D%ת��ΪNTFS��ʽ�����Ժ�...
CLS
IF %X%==0 (SET X=) ELSE (SET X= /X)
IF %V%==0 (SET V=) ELSE (SET V= /V)
IF %N%==0 (SET N=) ELSE (SET N= /NOSECURITY)
CONVERT %D%%X%%V%%N% /FS:NTFS
PAUSE
GOTO M

:7
ECHO ִ�в�����ϣ��밴�������������塣
PAUSE>NUL
GOTO M

:E
ECHO ��ʧϵͳ�ļ�%E%���޷�ʹ�ô˹��ܡ�
PAUSE
GOTO M