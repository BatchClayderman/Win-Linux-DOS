@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
SET E=0
SET V=0
GOTO MAIN

:MAIN
TITLE Ŀ¼�������
CLS
ECHO Ŀ¼������������
ECHO.
ECHO   0=�˳�����
ECHO   1=�鿴Ŀ¼
ECHO   2=ɢ��Ŀ¼
ECHO   3=�����ļ�
ECHO   4=׷��%SYSTEMDRIVE%\Folder.txtȫ��Ŀ¼��Ϣ
ECHO   5=׷��%SYSTEMDRIVE%\Folder.txtȫ���ļ���Ϣ
ECHO ��ѡ��һ���Լ�����
CHOICE /C 123450
IF %ERRORLEVEL%==1 (GOTO 1)
IF %ERRORLEVEL%==4 (GOTO 4)
IF %ERRORLEVEL%==5 (GOTO 5)
IF %ERRORLEVEL%==6 EXIT
SET /A M=%ERRORLEVEL%+5
GOTO V

:1
CLS
ECHO �鿴Ŀ¼���
ECHO.
ECHO   0=���������
ECHO   1=�������ļ��ṹ
ECHO   2=����Ŀ¼��ϸ��Ϣ
IF %V%==0 (ECHO   3=������־������׷���ı���%SYSTEMDRIVE%\Folder.txt�У�) ELSE (ECHO   3=ͣ����־)
ECHO ��ѡ��һ���Լ�����
CHOICE /C 1230
IF %ERRORLEVEL%==4 (GOTO MAIN)
IF %ERRORLEVEL%==3 (GOTO 3)
SET M=%ERRORLEVEL%
GOTO V

:V
CLS
IF %M%==1 (ECHO �����ļ��ṹ���)
IF %M%==2 (ECHO ����Ŀ¼��ϸ��Ϣ���)
IF %M%==7 (ECHO ɢ��Ŀ¼���)
IF %M%==8 (ECHO �����ļ����)
ECHO.
IF %E%==1 (ECHO ��������ļ���·�������ڻ��ʽ�������������룡)
ECHO ��ʽ��1��"C:\Documents and Settings\Administrator"��
ECHO       2��"D:\1"��
ECHO ��ʾ�����롰0���س��ɷ�������塣
ECHO ���棺1��·������һ��Ҫ����Ӣ��˫���ţ�·��ĩ�˲�Ҫ����\����
ECHO       2�����������ˣ���˵�����ĸ�ʽ���������������ã�
ECHO       3���������볬�ı��ַ������ñ������⣬��רҵ��Ա����Դ�����
ECHO �����·������ļ���ȫ·����
SET /P F=
IF %F%==0 (GOTO MAIN)
IF /I NOT EXIST %F% (SET E=1&GOTO V)
IF NOT ^%F:~0,1%==^" (SET E=1&GOTO V)
IF NOT ^%F:~-1%==^" (SET E=1&GOTO V)
CLS
IF %M%==1 (
	ATTRIB +A -H -R -S %SYSTEMDRIVE%\Folder.txt
	TREE /F %F%
	IF %V%==1 (TREE /F %F%>>%SYSTEMDRIVE%\Folder.txt)
	GOTO C
)
IF %M%==2 (
	ATTRIB +A -H -R -S %SYSTEMDRIVE%\Folder.txt
	DIR /A /ON /Q /S %F%
	IF %V%==1 (DIR /A /ON /Q /S %F%>>%SYSTEMDRIVE%\Folder.txt)
	GOTO C
)
GOTO %M%

:3
IF %V%==0 (SET V=1) ELSE (SET V=0)
GOTO 1

:4
ATTRIB +A -H -R -S "%SYSTEMDRIVE%\Folder.txt"
TITLE ���ڵ���ȫ��Ŀ¼��Ϣ�����Ժ�...
CLS
ECHO ȫ��Ŀ¼��Ϣ��>>%SYSTEMDRIVE%\Folder.txt
For /F "Skip=1" %%I IN ('WMIC LOGICALDISK GET NAME') DO (TREE %%I\ /F>>%SYSTEMDRIVE%\Folder.txt)
GOTO C

:5
ATTRIB +A -H -R -S %SYSTEMDRIVE%\Folder.txt
TITLE ���ڵ���ȫ���ļ���Ϣ�����Ժ�...
CLS
FOR /F "SKIP=1" %%I IN ('WMIC LOGICALDISK GET CAPTION') DO (DIR /A /ON /Q /S %%I>>%SYSTEMDRIVE%\Folder.txt)
GOTO C

:7
ECHO ���ڽ�ɢĿ¼%F%�µ����г����ļ������Ժ�...
CLS
FOR /R %F:~0,-1%\" %%I IN (*) DO (MOVE "%%I" %F%)
GOTO END

:8
ECHO ���������ļ���%F%�ڵĳ����ļ������Ժ�...
CLS
FOR /F "DELIMS=" %%I IN ('DIR /A-D /B %F%') DO (MD %F:~0,-1%\%%~XI\"&MOVE %F:~0,-1%\%%I" %F:~0,-1%\%%~XI")
GOTO END

:C
IF %V%==0 (PAUSE&GOTO MAIN)
CLS
ATTRIB +A -H +R +S "%SYSTEMDRIVE%\Folder.txt"
IF /I EXIST %SYSTEMDRIVE%\Folder.txt (ECHO �����ɹ�������&START /REALTIME NOTEPAD %SYSTEMDRIVE%\Folder.txt) ELSE (ECHO ׷���ı�ʧ�ܡ�)
PAUSE
GOTO MAIN

:END
CLS
ECHO �����ɹ��������밴�������������塣
PAUSE>NUL
GOTO MAIN