@ECHO OFF
CHCP 936>NUL
CD /D "%~DP0"
FOR /F "TOKENS=2 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (COLOR %%I)
TITLE ���������רҵ����
SET ERR=0
IF %PROCESSOR_ARCHITECTURE:~-1%==6 (SET W=32&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==4 (SET W=64&GOTO MAIN)
IF %PROCESSOR_ARCHITECTURE:~-1%==2 (SET W=32&SET ERR=1&GOTO MAIN)
GOTO A

:A
CLS
ECHO Win DOS�޷���ȡ���Ĳ���ϵͳλ�������ֶ�ѡ��
CHOICE /C 036 /M "�˳�������ѡ��0��32λϵͳ��ѡ��3��64λϵͳ��ѡ��6��"
IF %ERRORLEVEL%==1 EXIT
IF %ERRORLEVEL%==2 (SET W=32)
IF %ERRORLEVEL%==3 (SET W=64)
GOTO MAIN

:MAIN
CLS
ECHO ���������רҵ����-Windows %W%
IF %ERR%==1 (ECHO ����ϵͳ���ܷ����˲α䣬���������α����ǡ�)
ECHO.
ECHO �ɹ���ѡ�����£�
ECHO   0=�˳�
ECHO   1=Everything���ļ�����������
ECHO   2=360ϵͳ������
ECHO   3=PC Hunter Standard��Windows XP�½������systemrun��
ECHO   4=΢����������������Ƽ�32λ����ϵͳʹ�ã�
ECHO   5=DiskGenius
ECHO ��Ȩ����������רҵ������������˾�ṩ��������Win DOS������������ҵ��;��
ECHO ����˵��������Խ�󣬲�������Խ�ߣ����������רҵ��Ա���������������
ECHO ��ѡ��һ���Լ�����
CHOICE /C 123450
CLS
IF %ERRORLEVEL%==6 EXIT
GOTO %ERRORLEVEL%

:1
ECHO Everything
ECHO Ҫ����Everything����ֱ��ͨ��������������������ȡ��
ECHO ������Ҫ������ϵ���ű�������Ա�е�ͨѶ���ߣ����������������塣
PAUSE>NUL
GOTO MAIN

:2
ECHO 360ϵͳ������
IF %W%==64 (ECHO ����ϵͳΪ64λϵͳ���������޷��������ؽ��̱������Ƿ������) ELSE (ECHO ��������360ϵͳ�����䣬�Ƿ������)
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "https://www.360.cn/jijiuxiang/")
GOTO MAIN

:3
ECHO PC Hunter Standard
ECHO PC Hunter StandardĿǰ�Ѿ�������V1.6�汾�����°���΢��Ⱥ������
ECHO ������Ҫ������ϵ���ű�������Ա�е�ͨѶ���ߣ����������������塣
PAUSE>NUL
GOTO MAIN

:4
ECHO ���ڼ��ܵ�ͨ�������Ժ�...
TASKKILL /IM MP* /F /T
WMIC PROCESS GET NAME|FIND /I "MPSVC2.EXE">NUL
CLS
IF %ERRORLEVEL%==0 (CLS&ECHO �����������ڻ�Ծ״̬��ϵͳ��ȫ���밴�������������塣&PAUSE>NUL&GOTO MAIN)
SC START MPSVCSERVICE
WMIC PROCESS GET NAME|FIND /I "MPSVC2.EXE">NUL
IF %ERRORLEVEL%==0 (MSHTA VBSCRIPT:MSGBOX("���Ѱ�װ΢����������������������������Ǵ��ڻ�Ծ״̬��������������ϵͳ�������ȷ������������塣",64,"������רҵ����"^)(WINDOW.CLOSE^)&GOTO MAIN)
CLS
ECHO ΢�������������-�Ƚ��ĵ�������������������ҡ�863���ص�Ƽ���Ŀ)
ECHO �Ƽ����ɣ��������ķ��������ƣ�������2008�걱�����˻����簲ȫ�ܹ���ʦ��
ECHO �����������������������Ƿ������
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "https://www.depthsec.com.cn/index.php?m=&c=Product&a=personal")
GOTO MAIN

:5
ECHO DiskGenius
ECHO ��������DiskGenius�������Ƿ������
CHOICE /C YN
IF %ERRORLEVEL%==2 (GOTO MAIN)
FOR /F "TOKENS=1 DELIMS=," %%I IN ('TYPE CONFIG.INI') DO (%%I "" "https://www.diskgenius.cn/")
GOTO MAIN